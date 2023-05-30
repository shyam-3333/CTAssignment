public class Milestone_Trigger_Handler2 {
    
    public static void sendEmailWithAttachment(List<Milestone__c> milestoneList){
        Set<Id> ids = new Set<Id>();
        Map<Id,ContentDocumentLink> cdlMap = new Map<Id,ContentDocumentLink>();
        Map<Id,ContentDocument> cvMap = new Map<Id,ContentDocument>();
        Set<Id> projectId = new Set<Id>();
        Map<Id,String> mapOfProjectCollection = new Map<Id,String>();
        Map<Id,String> mapOfProjectBrand = new Map<Id,String>();
        Map<Id,String> mapOfProjectName = new Map<Id,String>();
        for(Milestone__c mi : milestoneList){
            if(mi.Id != null){
                ids.add(mi.Id);
            }
        }
        System.debug('ids : '+ids.size());
        //--------------------------------------------------------------------------------------------------------------------------------------------------------               
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        
        for (ContentDocumentLink cdl : [Select Id, ContentDocumentId from ContentDocumentLink where LinkedEntityId IN :ids]) { 
            cdlMap.put(cdl.ContentDocumentId,cdl);
        }        
        for (ContentDocument docs : [Select Id, FileType, Title, FileExtension from ContentDocument where Id= :cdlMap.keySet()]) {
            cvMap.put(docs.id,docs);
        }
        for (ContentVersion docVersion : [Select Id, VersionData,ContentDocumentId from ContentVersion where ContentDocumentId =:cdlMap.keySet()]) {
            
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            
            String fileName = cvMap.get(docVersion.ContentDocumentId)?.Title.Trim() + '.' + cvMap.get(docVersion.ContentDocumentId)?.FileExtension.Trim();
            efa.setFileName(fileName); //Title of the PDF
            efa.setBody(docVersion.VersionData); //Body of the PDF,need to do transfer into blob
            fileAttachments.add(efa);
        }
        //--------------------------------------------------------------------------------------------------------------------------------------------------------                               
        string brand = '';
        string collection = '';
        string project = '';
        string mailbody = '';
        String EmailIds = '';
        List <String> receiverList = new List < String > ();
        List <Project__c> projectList;
        
        for(Milestone__c mil : milestoneList){
            if(mil.Project__c != null){
                projectId.add(mil.Project__c);
            }
        }
        projectList = [Select Id, Brand__c, Collection_Name__c,Name from Project__c where Id IN: projectId];
        if(!projectList.isEmpty()){
            for(Project__c pro : projectList){
                if(pro.Brand__c == 'Titan'){
                    EmailIds = label.PDMS_Titan_Emails;
                }
                else if(pro.Brand__c == 'Sonata'){
                    EmailIds = label.PDMS_Sonata_Emails;
                }
                else if(pro.Brand__c == 'Fastrack'){
                    EmailIds = label.PDMS_Fastrack_Emails;
                }
                else EmailIds = 'sfdcadmin@titan.co.in ';
            } 
        }
        if (EmailIds != null) {
            if (EmailIds.contains(',')) {
                for (String str: EmailIds.split(',')) {
                    receiverList.add(str);
                }
            } else {
                receiverList.add(EmailIds);
            }
        }
        
        
        
        for(Project__c pro : projectList){
            mapOfProjectCollection.put(pro.Id,pro.Collection_Name__c); 
            mapOfProjectBrand.put(pro.Id,pro.Brand__c);
            mapOfProjectName.put(pro.Id,pro.Name);
        }
        
        for(Milestone__c mi2 : milestoneList)
        {            
            brand = mapOfProjectBrand.get(mi2.Project__c) != null?mapOfProjectBrand.get(mi2.Project__c) :'';
            collection = mapOfProjectCollection.get(mi2.Project__c) != null?mapOfProjectCollection.get(mi2.Project__c) :'';
            project = mapOfProjectName.get(mi2.Project__c) != null?mapOfProjectName.get(mi2.Project__c) :'';
            System.debug('Brand '+brand+' ----- Collection '+collection);
            mailbody = '<html><body>Hi Team,<br/><br/>Milestone Name : '+mi2.Name+' is completed today.<br/>Project Name : '+project+'<br/><br/>Thank You<br/><br/></body></html>';
            
            if(mi2.Status__c == 'Completed')
            {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //  String[] toAddresses = new String[]{'sfdcadmin@titan.co.in'};    //sfdcadmin@titan.co.in
                mail.setToAddresses(receiverList);
                mail.setSubject('Brand: '+brand+' | Collection: '+collection+' | Milestone: '+mi2.Name);
                // mail.Sethtmlbody('Text will come as it is'); 
                mail.Sethtmlbody(mailbody);
                mail.saveAsActivity = false;
                mail.setFileAttachments(fileAttachments);
                
                if(mail != Null){
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    System.debug('-----------------if--------------');
                }
                else{
                    System.debug('-----------------else--------------');
                }
            }       
        }
    }
}