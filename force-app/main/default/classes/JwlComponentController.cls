public class JwlComponentController {
    
    /********************** This method is used to get picklist values **************************************/
    @Auraenabled
    public static List<String> getPickListValue(String fieldname)
    {
        List<String> returnList = new List<String>();
        returnList.add(JSON.serialize(getPickListValue('JWL_Component__c', fieldname)));
        system.debug(returnList);
        
        return returnList;
    }
    
    @Auraenabled
    public static List<QA_Email_ID_With_Name__c> getQAEmailIds()
    {
        List<QA_Email_ID_With_Name__c> qaEmailIdList = [ SELECT Id,Name, QA_Email_Id__c FROM QA_Email_ID_With_Name__c where QA_Email_Id__c != ''];
        return qaEmailIdList;
    }
    
    public static List<PickListClass> getPickListValue(string objectApiName,string pickListFieldApiName){
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
    
    /************************ This method is used to get JWL repsonse list of Jwl component ****************************/
    @Auraenabled
    public static list<JWL_Response__c> getJwlResponseList(JWL_Component__c jwl)
    {
        list<JWL_Response__c> jwlRespoList= [SELECT Id,isChecked__c,Jwellery_Test__c,Jwellery_Test__r.Name,Test_Name__c,JWL_Component__c,Dimension_Mannual_test__c,Specification_mannual_test__c,Observation__c,Conclusion__c FROM JWL_Response__c where JWL_Component__c =:jwl.Id ORDER BY Test_Name__c ASC ];
        return jwlRespoList;
    }
    
    /********************* This method is uset to get JWL_Vendor__c records ***********************************/
    @Auraenabled
    public static list<JWL_Vendor__c> getRelatedVendor(String vendorName)
    {
        list<JWL_Vendor__c> jwlVendorList = [SELECT id,Name FROM JWL_Vendor__c where Name like :vendorName+'%'  LIMIT 5];
        
        return jwlVendorList;
    }
    
    
    /*
    @Auraenabled
    public static list<User> getQAEmailIds(String searchQAEmailId)
    {
        list<User> userList = [SELECT id,Name,Email,Profile.Id FROM User where email like :searchQAEmailId+'%' AND Profile.Id ='00e2i000000Lw74AAC' And IsActive = true limit 5];
        system.debug(userList);
        return userList;
    } */
    
    /************************* THIS METHOD IS USED TO RETRIVE THE ALL JWL COMPONENTS FOR RESUBMISSION ***************************************/
    @Auraenabled
    public static list<JWL_Component__c> getResubJwlcompLst(String resubJwlCompRefNum)
    {
        list<JWL_Component__c> jwlResubCompList = [SELECT Additional_Emails__c,Submitted_By__c,Submitted_by_Name__c,Additional_Info__c,Collection__c,CreatedById,CreatedBy.Name,CreatedDate,CurrencyIsoCode,Document_Status__c,Final_Verdict__c,Id,IsDeleted,Karatage__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Location__c,Lot_no__c,Name,No_of_samples__c,OwnerId,Process__c,Product_Category__c,Product_Code__c,QA_User_Email_Id__c,Record_Status__c,Report_Reference_Number__c,Route_of_Manufacturing__c,Sample_Details__c,Sample_Submission_Date__c,Sample_Submission_time__c,Sample_Type__c,SystemModstamp,Test_Type__c,Vendor__c,Vendor__r.Name,Publish_Date__c,Lead_Time__c FROM JWL_Component__c where Report_Reference_Number__c LIKE :resubJwlCompRefNum+'%' AND Document_Status__c = 'Publish' LIMIT 5];
        
        return jwlResubCompList;
    }
    
    
    /************************ This method is used to Insert JWL_Component__c records ******************************/
    @Auraenabled
    public static JWL_Component__c insertJwlComponent(JWL_Component__c jwl, List<JWL_Test__c> testList,List<JWL_Response__c> JwlRespLst ,Boolean saveflag)
    {
        system.debug(jwl);
         system.debug('JwlResp --->' + JwlRespLst);	
        JWLRefNumberPrefix__c  refNum = [SELECT id, Name,ProductType__c,SequenceNo__c FROM JWLRefNumberPrefix__c where Name =: jwl.Product_Category__c LIMIT 1];
        
        Integer year =Integer.valueOf(system.now().format('YY'));
        Date d = System.today();
        Integer currentYear = d.year() - ((d.month() == 1 ||  d.month() == 2 || d.month() == 3) ? 1 : 0);
        String yr = String.valueOf(currentYear);
        yr = yr.substring(2,4);
        Integer value = Integer.valueOf(yr);
        
        
        system.debug(jwl.Report_Reference_Number__c);
        if(jwl != (new JWL_Component__c()) && jwl.Id == NULL)
        {
            if(jwl.Test_Type__c == 'New')
                jwl.Report_Reference_Number__c  = 'TCL/JEW/'+(string) refNum.ProductType__c + '/' + refNum.SequenceNo__c + '/' + string.valueOf(value) + '-' +  string.valueOf(value + 1);
            system.debug(jwl.Report_Reference_Number__c);
            if(jwl.No_of_samples__c == null)
                jwl.No_of_samples__c = 0;
            jwl.Record_Status__c = 'Active';
            jwl.Document_Status__c = 'Draft';
             if(system.today() > Date.newInstance(2023, 03, 30)){
              jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name_3 ;  
            }
            else if(System.today() > Date.newInstance(2022, 05, 22) ){
                jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name_2 ;
            }
            else if(System.today() < Date.newInstance(2022, 05, 22) ){
                jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name ;
            }
            insert jwl;
            JWLRefNumberPrefix__c refUpdate = new JWLRefNumberPrefix__c();
            refUpdate.id = refNum.id;
            Integer refNumSequenceVal = (Integer.valueOf(refNum.SequenceNo__c) +1);
            if(refNumSequenceVal < 10)
                refUpdate.SequenceNo__c = '000'+string.valueOf( refNumSequenceVal );
            else if(refNumSequenceVal >= 10 && refNumSequenceVal < 100)
                refUpdate.SequenceNo__c = '00'+string.valueOf( refNumSequenceVal );
            else if(refNumSequenceVal >= 100 && refNumSequenceVal < 1000)
                refUpdate.SequenceNo__c = '0'+string.valueOf( refNumSequenceVal );
            else if(refNumSequenceVal >= 1000 )
                refUpdate.SequenceNo__c = string.valueOf( refNumSequenceVal );
            
            system.debug('Ref Num -->' + refUpdate );
            if(refUpdate != null)
                update refUpdate; 
            
            
            List<JWL_Response__c> jwlRespList = new List<JWL_Response__c>();
            system.debug('testlist --> '+testList);
            if(testList.size() > 0)
            {
                
                Set<Id> sTestId = new Set<Id>();
                for(JWL_Test__c  test : testList)
                {
                    JWL_Response__c resp = new JWL_Response__c();
                    resp.JWL_Component__c = jwl.Id;
                    resp.Jwellery_Test__c = test.Id;
                    resp.Test_Name__c = test.Name;
                    resp.Dimension_Mannual_test__c = test.Dimensional_Parameters__c;
                    resp.Specification_mannual_test__c = test.Specification__c;
                    resp.isChecked__c = true;
                    jwlRespList.add(resp);
                    sTestId.add(test.Id);
                }
                for(JWL_Test__c  test : [SELECT Id,Name,Specification__c,Dimensional_Parameters__c,Active__c  FROM JWL_Test__c where Id !=:sTestId AND Name != 'Others'])
                {
                    JWL_Response__c resp = new JWL_Response__c();
                    resp.JWL_Component__c = jwl.Id;
                    resp.Jwellery_Test__c = test.Id;
                    resp.Test_Name__c = test.Name;
                    resp.Dimension_Mannual_test__c = test.Dimensional_Parameters__c;
                    resp.Specification_mannual_test__c = test.Specification__c;
                    resp.isChecked__c = false;
                    jwlRespList.add(resp);
                }
                 system.debug('JwlResp --->' + JwlRespLst);
                if(JwlRespLst.size() > 0){
                    for(JWL_Response__c jwlResp : JwlRespLst )
                    {
                        jwlResp.JWL_Component__c = jwl.Id;
                        jwlRespList.add(JwlResp);
                    }
                }
                if(jwlRespList.size() > 0){
                    system.debug('jwlRespList -->' + jwlRespList);
                    insert jwlRespList;
                }    
            }
            else if(JwlRespLst.size() > 0 ){
                for(JWL_Response__c jwlResp : JwlRespLst )
                {
                    jwlResp.JWL_Component__c = jwl.Id;
                    jwlRespList.add(JwlResp);
                }
                
                for(JWL_Test__c  test : [SELECT Id,Name,Specification__c,Dimensional_Parameters__c,Active__c  FROM JWL_Test__c where Active__c = true AND Name != 'Others'])
                {
                    JWL_Response__c resp = new JWL_Response__c();
                    resp.JWL_Component__c = jwl.Id;
                    resp.Jwellery_Test__c = test.Id;
                    resp.Test_Name__c = test.Name;
                    resp.Dimension_Mannual_test__c = test.Dimensional_Parameters__c;
                    resp.Specification_mannual_test__c = test.Specification__c;
                    resp.isChecked__c = false;
                    jwlRespList.add(resp);
                }
                
                if(jwlRespList.size() > 0){
                    insert jwlRespList;
                }
                
            }
            
        }
        else if(jwl.Id != NULL)
        {
            if(jwl.No_of_samples__c == null)
                jwl.No_of_samples__c = 0;
            update jwl;
            List<JWL_Response__c> jwlRespList = new List<JWL_Response__c>();
            List<JWL_Response__c> respList = [SELECT Id,If_Others__c,isChecked__c,Jwellery_Test__c,JWL_Component__c,Name,Test_Name__c FROM JWL_Response__c where JWL_Component__c =: jwl.id];
            Map<Id,JWL_Response__c> respMap = new Map<Id,JWL_Response__c>();
            
            for(JWL_Response__c  response: respList)
            {
                
                respMap.put(response.Jwellery_Test__c , response );
            }
            system.debug('testlist --> '+testList);
            if(testList.size() > 0)
            {
                Set<Id> sTestId = new Set<Id>();
                
                for(JWL_Test__c  test : testList)
                {
                    JWL_Response__c resp = new JWL_Response__c();
                    resp.Id = respMap.get(test.Id).Id;
                    resp.JWL_Component__c = jwl.Id;
                    resp.Jwellery_Test__c = test.Id;
                    resp.Test_Name__c = test.Name;
                    resp.Dimension_Mannual_test__c = test.Dimensional_Parameters__c;
                    resp.Specification_mannual_test__c = test.Specification__c;
                    resp.isChecked__c = true;
                    jwlRespList.add(resp);
                    sTestId.add(test.Id);
                    
                }
                for(JWL_Test__c  test : [SELECT Id,Name,Specification__c,Dimensional_Parameters__c,Active__c  FROM JWL_Test__c where Id !=:sTestId AND Name != 'Others' And Active__c = true ])
                {
                    system.debug('test-->'+test);
                    JWL_Response__c resp = new JWL_Response__c();
                    resp.Id = respMap.get(test.Id).Id;
                    resp.JWL_Component__c = jwl.Id;
                    resp.Jwellery_Test__c = test.Id;
                    resp.Test_Name__c = test.Name;
                    resp.Dimension_Mannual_test__c = test.Dimensional_Parameters__c;
                    resp.Specification_mannual_test__c = test.Specification__c;
                    resp.isChecked__c = false;
                    jwlRespList.add(resp);
                }
                 system.debug('JwlResp --->' + JwlRespLst);
                if(JwlRespLst.size() > 0 )
                {
                    Set<Id> sRespTestId = new Set<Id>();
                    for(JWL_Response__c res: JwlRespLst)
                    {
                        sRespTestId.add(res.Jwellery_Test__c);
                    }
                   	Map<String,JWL_Response__c> otherRespIdMap = new Map<String,JWL_Response__c>();
                    for(JWL_Response__c rsp :[SELECT Id,Test_Name__c,Jwellery_Test__r.Name,If_Others__c FROM JWL_Response__c where Jwellery_Test__c =:sRespTestId ])
                    {
                        otherRespIdMap.put(rsp.Test_Name__c ,rsp);
                    }
                    
                    Boolean otherFlag = true;
                    for(JWL_Response__c jwlResp : JwlRespLst )
                    {
                        if(jwlResp.Test_Name__c != 'Others')
                        {
                            if(otherRespIdMap.containskey(jwlResp.Test_Name__c))
                                jwlResp.Id = otherRespIdMap.get(jwlResp.Test_Name__c).Id;
                            jwlResp.JWL_Component__c = jwl.Id;
                            jwlRespList.add(JwlResp);
                        }
                        else{
                            otherFlag = false;
                        }
                    }
                    
                    if(jwlRespList.size() > 0){
                    system.debug('jwlRespList -->' + jwlRespList);
                    upsert jwlRespList;
                	}
                    
                    if( ! otherFlag )
                    {
                        List<JWL_Response__c> updateToUncheckRespoLst = new List<JWL_Response__c>();
                        for(JWL_Response__c jwlResp : otherRespIdMap.values() )
                        {
                            if(jwlResp.Test_Name__c != 'Others')
                            {
                                if(otherRespIdMap.containskey(jwlResp.Test_Name__c))
                                    jwlResp.Id = otherRespIdMap.get(jwlResp.Test_Name__c).Id;
                                jwlResp.JWL_Component__c = jwl.Id;
                                jwlResp.isChecked__c = false;
                                updateToUncheckRespoLst.add(JwlResp);
                            }
                        }
                        if(updateToUncheckRespoLst.size() > 0){
                            
                            update updateToUncheckRespoLst;
                        } 
                    }
                }
                   
            }
            else if(JwlRespLst.size() > 0 )
            {
                Map<String,JWL_Response__c> otherRespIdMap = new Map<String,JWL_Response__c>();
                for(JWL_Response__c rsp :[SELECT Id,Test_Name__c,Jwellery_Test__r.Name,If_Others__c FROM JWL_Response__c where Jwellery_Test__r.Name != 'Others' And If_Others__c != null ])
                {
                    otherRespIdMap.put(rsp.Test_Name__c ,rsp);
                }
                Boolean otherFlag = true;
                for(JWL_Response__c jwlResp : JwlRespLst )
                {
                    if(jwlResp.Test_Name__c != 'Others')
                    {
                        if(otherRespIdMap.containskey(jwlResp.Test_Name__c))
                            jwlResp.Id = otherRespIdMap.get(jwlResp.Test_Name__c).Id;
                        jwlResp.JWL_Component__c = jwl.Id;
                        jwlRespList.add(JwlResp);
                    }
                    else{
                        otherFlag = false;
                    }
                }
                
                for(JWL_Test__c  test : [SELECT Id,Name,Specification__c,Dimensional_Parameters__c,Active__c  FROM JWL_Test__c where Active__c = true AND Name != 'Others' And Active__c = true])
                {
                    JWL_Response__c resp = new JWL_Response__c();
                    resp.Id = respMap.get(test.Id).Id; 
                    resp.JWL_Component__c = jwl.Id;
                    resp.Jwellery_Test__c = test.Id;
                    resp.Test_Name__c = test.Name;
                    resp.Dimension_Mannual_test__c = test.Dimensional_Parameters__c;
                    resp.Specification_mannual_test__c = test.Specification__c;
                    resp.isChecked__c = false;
                    jwlRespList.add(resp);
                }
                
                if(jwlRespList.size() > 0){
                    upsert jwlRespList;
                }
                
                if( ! otherFlag )
                {
                    List<JWL_Response__c> updateToUncheckRespoLst = new List<JWL_Response__c>();
                    for(JWL_Response__c jwlResp : otherRespIdMap.values() )
                    {
                        if(jwlResp.Test_Name__c != 'Others')
                        {
                            if(otherRespIdMap.containskey(jwlResp.Test_Name__c))
                                jwlResp.Id = otherRespIdMap.get(jwlResp.Test_Name__c).Id;
                            jwlResp.JWL_Component__c = jwl.Id;
                            jwlResp.isChecked__c = false;
                            updateToUncheckRespoLst.add(JwlResp);
                        }
                    }
                    if(updateToUncheckRespoLst.size() > 0){
                        
                        update updateToUncheckRespoLst;
                    } 
                }
            }
            
        }
        if(saveflag)
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            list<string> toAddresses = new list<string> {jwl.QA_User_Email_Id__c,jwl.Submitted_By__c};
            List<String> ccAddresses = new List<String>();
            if( jwl.Additional_Emails__c != null)
            {
                system.debug('Additional Email-->'+jwl.Additional_Emails__c);
                list<string> AdditionalEmailLst = (jwl.Additional_Emails__c).split(',');
                if(AdditionalEmailLst.size() > 0){
                    ccAddresses.addAll(AdditionalEmailLst);
                }
            }
            system.debug('toaddress -->'+toAddresses);
            mail.setToAddresses(toAddresses);
            if( ccAddresses.size() > 0)
            	mail.setCcAddresses(ccAddresses);
         /*   
            EmailTemplate et=[SELECT id,Name, Subject, Body FROM EmailTemplate where Name='Submission notification of JEW product for Relaibility testing' limit 1];
            mail.setSubject(et.Subject);
            mail.setWhatId(jwl.Id);
            mail.setTemplateId(et.id);
            mail.setTargetObjectId();
          //  mail.setPlainTextBody(et.Body);*/
            mail.setSubject('Submission notification of JEW product for Relaibility testing ');
            mail.setPlainTextBody('Hi \n   JEW product  '+ jwl.Report_Reference_Number__c +' is submitted for relaibility testing. \n');
            Messaging.SendEmailResult[] results = Messaging.sendEmail( new Messaging.SingleEmailMessage[] { mail });
        }
        JWL_Component__c jwlRetun=[SELECT Additional_Emails__c,Submitted_By__c,Submitted_by_Name__c,Additional_Info__c,Collection__c,CreatedById,CreatedBy.Name,CreatedDate,CurrencyIsoCode,Document_Status__c,Final_Verdict__c,Id,IsDeleted,Karatage__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Location__c,Lot_no__c,Name,No_of_samples__c,OwnerId,Process__c,Product_Category__c,Product_Code__c,QA_User_Email_Id__c,Record_Status__c,Report_Reference_Number__c,Route_of_Manufacturing__c,Sample_Details__c,Sample_Submission_Date__c,Sample_Submission_time__c,Sample_Type__c,SystemModstamp,Test_Type__c,Vendor__c,Vendor__r.Name,Publish_Date__c,Lead_Time__c FROM JWL_Component__c where Id =: jwl.id];
        return jwlRetun;
    }
    
    @Auraenabled
    public static JWL_Component__c   updateResubJwlComponent(JWL_Component__c jwl, List<JWL_Response__c> jwlResponseList, boolean refNumIncrementflag)
    {
        system.debug(jwl);
        
        if(jwl.Test_Type__c == 'Resubmission'){
            if(refNumIncrementflag == true ){
                if((jwl.Report_Reference_Number__c).lastIndexOf('-')+3 == (jwl.Report_Reference_Number__c).length()  )
                {
                    jwl.Report_Reference_Number__c = jwl.Report_Reference_Number__c + 'R1';
                    System.debug('resub ref '+jwl.Report_Reference_Number__c );
                }
                else{
                    String str = jwl.Report_Reference_Number__c.mid((jwl.Report_Reference_Number__c).lastIndexOf('R')+1 ,(jwl.Report_Reference_Number__c).length() - (jwl.Report_Reference_Number__c).lastIndexOf('R')+1 );
                    Integer incrementRefNum = Integer.valueOf(str) + 1;
                    
                    jwl.Report_Reference_Number__c = ( jwl.Report_Reference_Number__c ).substring(0,(jwl.Report_Reference_Number__c).lastIndexOf('R')+1) + incrementRefNum;
                    System.debug('resub ref '+jwl.Report_Reference_Number__c );
                }
            }
            jwl.Document_Status__c ='Draft';
            if(jwl.No_of_samples__c == null)
                jwl.No_of_samples__c = 0;
            jwl.Record_Status__c = 'Obsolete';
             if(system.today() > Date.newInstance(2023, 03, 30)){
              jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name_3 ;  
            }
            else if(System.today() > Date.newInstance(2022, 05, 22)){
                jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name_2 ;
            }
            else if(System.today() < Date.newInstance(2022, 05, 22) ){
                jwl.Approver_Name__c = System.label.Qc_Jew_Approver_Name ;
            }
            update jwl;
            
            system.debug('jwlResponseList -->' + jwlResponseList);
            if(jwlResponseList.size() > 0)
            {
                update jwlResponseList;
            }
            if(refNumIncrementflag == true ){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {jwl.QA_User_Email_Id__c,jwl.Submitted_By__c};
            List<String> ccAddresses = new List<String>();
            if(jwl.Additional_Emails__c != null )
            {
                list<string> AdditionalEmailLst = (jwl.Additional_Emails__c).split(',');
                if(AdditionalEmailLst.size() > 0){
                    ccAddresses.addAll(AdditionalEmailLst);
                }
            }
            mail.setToAddresses(toAddresses);
            if( ccAddresses.size() > 0)
            	mail.setCcAddresses(ccAddresses);
            mail.setSubject('Submission notification of JEW product for Relaibility testing');
            mail.setPlainTextBody('Hi \n\n   JEW product '+ jwl.Report_Reference_Number__c +' is submitted for relaibility testing. \n');
            // Pass this email message to the built-in sendEmail method 
            // of the Messaging class
            Messaging.SendEmailResult[] results = Messaging.sendEmail(
                new Messaging.SingleEmailMessage[] { mail });
            }
        }        
        JWL_Component__c jwlRetun=[SELECT Additional_Emails__c,Submitted_By__c,Submitted_by_Name__c,Additional_Info__c,Collection__c,CreatedById,CreatedBy.Name,CreatedDate,CurrencyIsoCode,Document_Status__c,Final_Verdict__c,Id,IsDeleted,Karatage__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Location__c,Lot_no__c,Name,No_of_samples__c,OwnerId,Process__c,Product_Category__c,Product_Code__c,QA_User_Email_Id__c,Record_Status__c,Report_Reference_Number__c,Route_of_Manufacturing__c,Sample_Details__c,Sample_Submission_Date__c,Sample_Submission_time__c,Sample_Type__c,SystemModstamp,Test_Type__c,Vendor__c,Vendor__r.Name,Publish_Date__c,Lead_Time__c FROM JWL_Component__c where Id =: jwl.id LIMIT 1];
        return jwlRetun;
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
            system.debug('update...jwl.Image_1__c'+jwl.Image_2__c);
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
        ContentDocumentLink docLink = [ SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :recId order by Id desc LIMIT 1];
        
        //ContentVersion Id uniquely identifies the attachment
        ContentVersion version = [SELECT Id FROM ContentVersion WHERE ContentDocumentId = :docLink.ContentDocumentId];
        list<JWL_Component__c> updatelist= new list<JWL_Component__c>();
        JWL_Component__c jwlobj = new JWL_Component__c();
        //Update the Picture_Path field with the url of the image
        list<JWL_Component__c> complist = [SELECT Id,Image_3__c FROM JWL_Component__c WHERE Id =:recId];
        for(JWL_Component__c jwl:complist){
            jwl.Image_3__c=System.Label.JWLQCimage + version.Id;
            system.debug('update...jwl.Image_1__c'+jwl.Image_3__c);
            jwlobj = jwl;
            //updatelist.add(jwl);
        }
        
        if(jwlobj.Image_3__c != null){
            update jwlobj;
        }
        system.debug('update...'+updatelist);
        return jwlobj;
    }
}