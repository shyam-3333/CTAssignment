public class ReadyReckenor {
    
    @Auraenabled
    public static List<contentDocument> retrieveAttachment(Id readyReckenorId)
    {
        //this method is for retriving the attachment id which are associated to the ready reckenor object
        
        List<ContentDocumentLink> cdls = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:readyReckenorId];
        Set<Id> documentIds = new Set<Id>();
        List<contentDocument> ContentDocument =new List<contentDocument>();
        if(cdls.size()>0){
            for (ContentDocumentLink cdl : cdls) {
                documentIds.add(cdl.ContentDocumentId);
            }
            ContentDocument = [SELECT Description,FileExtension,FileType,Id,ParentId,PublishStatus,Title FROM ContentDocument where (id in :documentIds) and(FileExtension ='doc' OR FileExtension ='docx' OR FileExtension = 'pdf' OR FileExtension = 'pptx')];
        }
        return  ContentDocument;
    }
    
    @AuraEnabled
    public static List<Contact> getContacts() {
        
        return [SELECT Id, name, email FROM Contact ORDER BY createdDate ASC];
    }    
    @AuraEnabled
    public static List<Contact> findByName(String searchKey) {
        // this metod is used for searching the contact from the contact text box ready reckenor.
        
        String name =  '%'+ searchKey + '%';
        return [SELECT id, name, email FROM Contact WHERE name LIKE :name];
    }
    @AuraEnabled
    public static List<Contact> searchContacts(List<Contact> searchKey) {
        // this metod is used for searching the contact from the contact text box ready reckenor.
        return searchKey;
    }
    
    @AuraEnabled
    public static void sendEmailApex(Id readyReckenorId,List<String> toAddress, List<String> ccAddress, String subject, String body, List<String> files,String Email) {
        list<String> contactList= new List<String>();
        Messaging.reserveSingleEmailCapacity(1);
        // with the help of id retrieve the email related to that id and passed to Messaging for sending email 
        // while used email is used to send the the mail to contact which is not present in the org.
        List<Contact> contactEmail=[select email from Contact where id in :toAddress];
        List<OrgWideEmailAddress> lstEmailAddress=[select Id from OrgWideEmailAddress WHERE Address='sfdcadmin@titan.co.in'];
        
        if(Email != null)
        {
            contactList.add(Email);
        }
        if(contactEmail != null && contactEmail.size()>0){
            for(Contact con:contactEmail)
            {
                contactList.add(con.Email);  
            }   
        }
        System.debug('contactEmail'+contactEmail);
                System.debug('toAddress'+toAddress);

        List<Id> messageAsAttachment =new List<Id>();
        List<String> documentSend = new List<String>();
         for (ContentVersion document: fetchContentVersion(files)) {
            messageAsAttachment.add(document.id);
            documentSend.add(document.Title);
        }
        messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
        mail.setToAddresses(contactList);
        mail.setCcAddresses(ccAddress);
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        mail.setReplyTo(UserInfo.getUserEmail());
        mail.setEntityAttachments(messageAsAttachment);
        if(!test.isRunningTest()){
            Messaging.sendEmail(new List<messaging.SingleEmailMessage> {mail});
            
        }
        
        //to have the track of email to whom the attachment is send in Activity,we have created the task with contact name 
        //and mentioned them in description.  
        List<Task> tasks =new List<Task>();
        for(String conId : toAddress){
            Task ts = new  Task();
            ts.Subject = 'Ready Reckoners';
            ts.TaskSubtype = 'Email';
            ts.ActivityDate = Date.today();
            ts.Description =  'Document name : '+documentSend+' is shared';
            ts.WhatID =  readyReckenorId;
            ts.whoId = conId;
            ts.RecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Ready Reckoner').getRecordTypeId();
            
            ts.Status = 'Completed';
            tasks.add(ts);
        }
        if(Email != null)
        {
            Task ts = new Task();
            ts.Subject = 'Ready Reckoners';
            ts.TaskSubtype = 'Email';
            ts.ActivityDate = Date.today();
            ts.Description =  'Document name : '+ documentSend+' is shared with ' + Email;
            ts.WhatID =  readyReckenorId;
            ts.Status = 'Completed';
            ts.RecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Ready Reckoner').getRecordTypeId();
            
            tasks.add(ts);
        }
        
        insert tasks;
    }
    
    public static List<ContentVersion> fetchContentVersion(Id[] contentDocumentIds) {
        // this method is used to get the latest version of the content document as this is required for sending the attachment.
    
        List<ContentVersion> documents = new List<ContentVersion>{};
            documents.addAll([
                SELECT Id, Title, FileType, VersionData, isLatest, ContentDocumentId
                FROM ContentVersion
                WHERE isLatest = true AND ContentDocumentId IN :contentDocumentIds
            ]);
        return documents;
    }
    
    
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName, List<sObject> ExcludeitemsList) {
        String searchKey = '%' + searchKeyWord + '%';
        List < sObject > returnList = new List < sObject > ();
        
        List<string> lstExcludeitems = new List<string>();
        for(sObject item : ExcludeitemsList ){
            lstExcludeitems.add(item.id);
        }
        
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  
        String sQuery =  'select id, Email,Name from ' +ObjectName + ' where Name LIKE: searchKey AND Id NOT IN : lstExcludeitems order by createdDate DESC limit 5';
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
    
}