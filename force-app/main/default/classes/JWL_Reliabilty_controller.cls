public class JWL_Reliabilty_controller {
    
    
    @Auraenabled
    public static List<QA_Email_ID_With_Name__c> getQAEmailIds()
    {
        List<QA_Email_ID_With_Name__c> qaEmailIdList = [ SELECT Id,Name, QA_Email_Id__c FROM QA_Email_ID_With_Name__c where QA_Email_Id__c != ''];
        return qaEmailIdList;
    }
    
    @AuraEnabled
    public static List<JWL_Component__c> fetchAccounts (string searchkeyword){
        String nameValue='%'+searchkeyword+'%';
        return [SELECT Id, Name,Report_Reference_Number__c,Vendor__r.Name,Vendor__c,Publish_Date__c FROM JWL_Component__c where Report_Reference_Number__c Like : searchkeyword  and Document_Status__c !='Publish' LIMIT 50 ];
    }
    @AuraEnabled
    public static list<JWL_Component__c> retriverecord(string recid){
        return [SELECT Id, Name,Report_Reference_Number__c,General_Observation__c,Additional_Info__c,createdbyfullname__c,CreatedBy.FirstName, CreatedBy.LastName,Document_Status__c,QA_User_Email_Id__c,Process__c,Sample_Details__c,Product_Category__c,Location__c,Lot_no__c,No_of_samples__c,Sample_Submission_Date__c,Sample_Submission_time__c,Submitted_By__c,Submitted_by_Name__c,Image_1__c,Image_2__c,Image_3__c,Route_of_Manufacturing__c,Collection__c,Record_Status__c,Product_Code__c,Sample_Type__c,Test_Type__c,Vendor__c,Additional_Emails__c,Karatage__c,Final_Verdict__c,Vendor__r.Name,Publish_Date__c,Lead_Time__c FROM JWL_Component__c where ID = : recid  ];   
    }
    @Auraenabled
    public static List<String> getPickListValue(string objectname,String fieldname)
    {
        List<String> returnList = new List<String>();
        returnList.add(JSON.serialize(getPickListValues(objectname, fieldname)));
        system.debug(returnList);
        
        return returnList;
    }
    
    public static List<PickListClass> getPickListValues(string objectApiName,string pickListFieldApiName){
        List<PickListClass> pickListValue=new List<PickListClass>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectApiName);//From the Object Api name retrieving the SObject
        Sobject objectName = targetType.newSObject();
        Schema.sObjectType sobjectType = objectName.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobjectDescribe = sobjectType.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> fieldMap = sobjectDescribe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> schemaPickListValues = fieldMap.get(pickListFieldApiName).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        pickListValue.add(new PickListClass('--None--',''));
        for (Schema.PicklistEntry var : schemaPickListValues) { 
            pickListValue.add(new PickListClass(var.getValue(),var.getValue()));
        }
        return pickListValue;
    }
    
    /************************ This method is used to get Test records from JWL_Test__c ****************************/
    @Auraenabled
    public static list<JWL_Test__c> getJwlTests()
    {
        list<JWL_Test__c> jwlTestList= [SELECT Id,Name,Specification__c,Dimensional_Parameters__c,Active__c  FROM JWL_Test__c where Active__c = true Order By Name ASC ];
        return jwlTestList;
    }
    @Auraenabled
    public static list<JWL_Response__c> getjwlreponsetestcases(string jwlcompid)
    {
        list<JWL_Response__c> jwlTestList= [SELECT Id,Name,JWL_Component__c,Dimension_Mannual_test__c,Specification_mannual_test__c,Jwellery_Test__r.Name,Jwellery_Test__c,Conclusion__c,isChecked__c,If_Others__c,Observation__c,Test_Name__c  FROM JWL_Response__c where JWL_Component__c =:jwlcompid ORDER By  Test_Name__c ASC  ];
        system.debug('reponselist with checkbox...'+jwlTestList);
        return jwlTestList;
    }
    
    /********************* This method is uset to get JWL_Vendor__c records ***********************************/
    @Auraenabled
    public static list<JWL_Vendor__c> getRelatedVendor(String vendorName)
    {
        list<JWL_Vendor__c> jwlVendorList = [SELECT id,Name FROM JWL_Vendor__c where Name like :vendorName+'%'  LIMIT 5];
        
        return jwlVendorList;
    }
    
    
    @Auraenabled
    public static void updateresponse(list<JWL_Component__c> componentlist,list<JWL_Response__c> responselist){
        if(!componentlist.isEmpty()){
            update componentlist;
        }
        system.debug(responselist.size());
        if(!responselist.isEmpty()){
            update responselist;
        }
    }
    @Auraenabled
    public static list<JWL_Response__c> responsewithtest(String jwlid){
        list<JWL_Response__c> jwlTestList= [SELECT Id,Name,JWL_Component__c,Conclusion__c,Jwellery_Test__r.Name,JWL_Component__r.Final_Verdict__c,Dimension_Mannual_test__c,Specification_mannual_test__c,Jwellery_Test__c,Jwellery_Test__r.Dimensional_Parameters__c,Jwellery_Test__r.Active__c,Jwellery_Test__r.Specification__c,isChecked__c,If_Others__c,Observation__c,Test_Name__c  FROM JWL_Response__c where JWL_Component__c =:jwlid and isChecked__c=True ORDER BY  Conclusion__c DESC  ];
        system.debug('returnlist.....'+jwlTestList);
        return jwlTestList; 
    }
    @Auraenabled
    public static list<JWL_Response__c> recorddetial(String jwlid){
        list<JWL_Response__c> jwlTestList= [SELECT Id,Name,JWL_Component__c,Conclusion__c,Jwellery_Test__r.Name,JWL_Component__r.Final_Verdict__c,Dimension_Mannual_test__c,Specification_mannual_test__c,Jwellery_Test__c,Jwellery_Test__r.Dimensional_Parameters__c,Jwellery_Test__r.Active__c,Jwellery_Test__r.Specification__c,isChecked__c,If_Others__c,Observation__c,Test_Name__c  FROM JWL_Response__c where JWL_Component__c =:jwlid and isChecked__c=True  and Conclusion__c!=null ];
        system.debug('returnlist.....'+jwlTestList);
        return jwlTestList; 
    }
    
    @Auraenabled
    public static void updatecheckbox( list<JWL_Response__c> responselist){
        if(!responselist.isEmpty()){
            update responselist;
            system.debug('responselist.........'+responselist);
        }
        
    }
    @Auraenabled
    public static void savefinalresponse(list<JWL_Component__c> componentlist,list<JWL_Response__c> responselist){
        if(!componentlist.isEmpty()){
            update componentlist;
        }
        for(JWL_Response__c respo : responselist){
            system.debug(respo);
        }
        //system.debug(responselist.size());
        if(!responselist.isEmpty()){
            update responselist;
        }
    }
    @Auraenabled
    public static list<JWL_Response__c> insertnewrow(list<JWL_Response__c> newrowlist,Id recid2){
        system.debug('coming manula test'+newrowlist);
        system.debug('recid2 :'+recid2);
        if(!newrowlist.isEmpty()){
            for(JWL_Response__c jwlRes : newrowlist){
                jwlRes.JWL_Component__c = recid2;
            }
            upsert newrowlist;
        }
        return newrowlist;
        //system.debug('coming manula test2222222222222222'+newrowlist);
        
    }
    
    @AuraEnabled
    public static JWL_Response__c deleteTestInRow( JWL_Response__c deleteRespo)
    {
        system.debug(deleteRespo);
        if(deleteRespo.Id != null)
            update deleteRespo;
        return deleteRespo;
    }
    
    @AuraEnabled
    public static JWL_Component__c updatePicturePath(String recId){ 
        system.debug('test...'+recId);
        
        //In lighting, the attachments are stored in content documents
        ContentDocumentLink docLink = [ SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :recId order by Id desc LIMIT 1];
        
        //ContentVersion Id uniquely identifies the attachment
        ContentVersion version = [SELECT Id FROM ContentVersion WHERE ContentDocumentId = :docLink.ContentDocumentId];
        list<JWL_Component__c> updatelist= new list<JWL_Component__c>();
        JWL_Component__c jwlobj = new JWL_Component__c();
        //Update the Picture_Path field with the url of the image
        list<JWL_Component__c> complist = [SELECT Id,Image_1__c FROM JWL_Component__c WHERE Id =:recId];
        for(JWL_Component__c jwl:complist){
            jwl.Image_1__c=System.Label.JWLQCimage + version.Id;
            system.debug('update...jwl.Image_1__c'+jwl.Image_1__c);
            jwlobj = jwl;
            //updatelist.add(jwl);
        }
        
        if(jwlobj.Image_1__c != null){
            update jwlobj;
        }
        system.debug('update...'+updatelist);
        return jwlobj;
    }
    @AuraEnabled
    public static JWL_Component__c updatePicturePath2(String recId){ 
        system.debug('test...'+recId);
        
        //In lighting, the attachments are stored in content documents
        ContentDocumentLink docLink = [ SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :recId order by Id desc LIMIT 1];
        
        //ContentVersion Id uniquely identifies the attachment
        ContentVersion version = [SELECT Id FROM ContentVersion WHERE ContentDocumentId = :docLink.ContentDocumentId];
        list<JWL_Component__c> updatelist= new list<JWL_Component__c>();
        JWL_Component__c jwlobj = new JWL_Component__c();
        //Update the Picture_Path field with the url of the image
        list<JWL_Component__c> complist = [SELECT Id,Image_2__c FROM JWL_Component__c WHERE Id =:recId];
        for(JWL_Component__c jwl:complist){
            jwl.Image_2__c=System.Label.JWLQCimage + version.Id;
            
            jwlobj = jwl;
            //updatelist.add(jwl);
        }
        
        if(jwlobj.Image_2__c != null){
            update jwlobj;
        }
        system.debug('update...'+updatelist);
        return jwlobj;
    }
    @AuraEnabled
    public static JWL_Component__c updatePicturePath3(String recId){ 
        system.debug('test...'+recId);
        
        //In lighting, the attachments are stored in content documents
        //if(recId)
        ContentDocumentLink docLink = [ SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :recId order by Id desc LIMIT 1];
        
        //ContentVersion Id uniquely identifies the attachment
        ContentVersion version = [SELECT Id FROM ContentVersion WHERE ContentDocumentId = :docLink.ContentDocumentId];
        list<JWL_Component__c> updatelist= new list<JWL_Component__c>();
        JWL_Component__c jwlobj = new JWL_Component__c();
        //Update the Picture_Path field with the url of the image
        list<JWL_Component__c> complist = [SELECT Id,Image_3__c FROM JWL_Component__c WHERE Id =:recId];
        for(JWL_Component__c jwl:complist){
            jwl.Image_3__c=System.Label.JWLQCimage + version.Id;
            system.debug('update...jwl.Image_3__c'+jwl.Image_3__c);
            jwlobj = jwl;
            //updatelist.add(jwl);
        }
        
        if(jwlobj.Image_3__c != null){
            update jwlobj;
        }
        system.debug('update...'+updatelist);
        return jwlobj;
    }
    @AuraEnabled
    public static list<JWL_Component__c> publish(list<JWL_Component__c> componentlist){
        list<JWL_Component__c> newlist= new list<JWL_Component__c>();
        system.debug('iddddd.......'+componentlist);
        
        for(JWL_Component__c jwl:componentlist){
            
            jwl.Document_Status__c='Publish';
           // jwl.validated__c='System.label.Qc_Jew_Approver_Name_3'
             if(system.today() > Date.newInstance(2023, 03, 28)){
              jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name_3 ;  
            }
            else if(system.today() > Date.newInstance(2022, 05, 22)){
              jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name_2 ;  
            }
            else if(system.today() < Date.newInstance(2022, 01, 22)){
                jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name ;
            }
            newlist.add(jwl);
            
        }
        if(!newlist.Isempty()){
            update newlist;
        }
        
        system.debug('newlist..............status'+newlist);
        return newlist;
    }
    
    @AuraEnabled
    public static list<JWL_Component__c> updatedocumentstatus(list<JWL_Component__c> componentlist){
        list<JWL_Component__c> newlist= new list<JWL_Component__c>();
        system.debug('iddddd.......'+componentlist);
        
        for(JWL_Component__c jwl:componentlist){
            
           // jwl.Document_Status__c='Publish';
           if(system.today() > Date.newInstance(2023, 03, 30)){
              jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name_3 ;  
            }
            else if(System.today() > Date.newInstance(2022, 05, 22)){
                jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name_2 ;
            }
            else if(System.today() < Date.newInstance(2022, 05, 22)){
                jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name ;
            }
            
            newlist.add(jwl);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            PageReference pref = page.JWL_ViewPDF; // Visualforce Page Name
            pref.getParameters().put('Id',jwl.Id);
            pref.setRedirect(true);
            Blob b;
            if(!Test.isRunningTest()){
                b = pref.getContent();
            }
            else{
                b = Blob.valueOf('Test Blob Content');
            }
            
            attach.setFileName(jwl.Report_Reference_Number__c+'.pdf');
            attach.setBody(b);
            String[] toAddresses = new String[] {jwl.QA_User_Email_Id__c,jwl.Submitted_By__c};
                List<String> ccAddresses = new List<String>();
            system.debug('addres...'+toAddresses);
            system.debug('addres...'+jwl.Additional_Emails__c);
            if(jwl.Additional_Emails__c != null )
            {
                list<string> AdditionalEmailLst = (jwl.Additional_Emails__c).split(',');
                if(AdditionalEmailLst.size() > 0){
                    ccAddresses.addAll(AdditionalEmailLst);
                }
            }
            system.debug('addresfianl'+toAddresses);
            
            if(toAddresses!=null){
                mail.setToAddresses(toAddresses);
                if( ccAddresses.size() > 0)
                    mail.setCcAddresses(ccAddresses);
            }
            mail.setSubject('Relaibility test report ');
            mail.setPlainTextBody('Hi \n   JEW product  '+ jwl.Report_Reference_Number__c +' is tested and report is attached for your reference .\n');
            mail.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
            Messaging.SendEmailResult[] results = Messaging.sendEmail( new Messaging.SingleEmailMessage[] { mail });
            
        }
        if(!newlist.Isempty()){
            update newlist;
        }
        
        system.debug('newlist..............status'+newlist);
        return newlist;
    }
    
}