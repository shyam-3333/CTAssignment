@isTest
public class JWL_Reliabilty_controllerTest {
    
    @isTest
    public static void JWL_Reliabilty_controllerMethods()
    {
        JWL_Component__c jwl1 = new JWL_Component__c();
        jwl1.QA_User_Email_Id__c ='abc@gmail.com';
        insert jwl1;
        
        list<QA_Email_ID_With_Name__c> userlist=JWL_Reliabilty_controller.getQAEmailIds();
        
        list<JWL_Vendor__c> jwlVendorList = JwlComponentController.getRelatedVendor('str');
        
        List<JWL_Component__c> jwl= JWL_Reliabilty_controller.fetchAccounts ('TCL/JW/MS/0017/19-20');
        list<JWL_Component__c> jwl2= JWL_Reliabilty_controller.retriverecord(jwl1.Id);
        string str='Test_Type__c';
        string obj='JWL_Component__c';
        list<string> picklistvaluelist = JWL_Reliabilty_controller.getPickListValue(obj,str);
        list<JWL_Test__c> testlist= JWL_Reliabilty_controller.getJwlTests();
        list<JWL_Response__c> jss=JWL_Reliabilty_controller.getjwlreponsetestcases(jwl1.Id);
        list<JWL_Response__c>  jssres=JWL_Reliabilty_controller.responsewithtest(jwl1.Id);
        list<JWL_Response__c>  jssres2=JWL_Reliabilty_controller.recorddetial(jwl1.Id);
        
        
    }
    @isTest
    public static void JWL_Reliabilty_controllerMethod2()
    {
        JWL_Component__c jwl1 = new JWL_Component__c();
        jwl1.QA_User_Email_Id__c ='abc@gmail.com';
        insert jwl1;
        
        list<QA_Email_ID_With_Name__c> userlist=JWL_Reliabilty_controller.getQAEmailIds();
        
        List<JWL_Component__c> jwl= JWL_Reliabilty_controller.fetchAccounts ('TCL/JW/MS/0017/19-20');
        list<JWL_Component__c> jwl2= JWL_Reliabilty_controller.retriverecord(jwl1.Id);
        string str='Test_Type__c';
        string obj='JWL_Component__c';
        list<string> picklistvaluelist = JWL_Reliabilty_controller.getPickListValue(obj,str);
        list<JWL_Test__c> testlist= JWL_Reliabilty_controller.getJwlTests();
        list<JWL_Response__c> jss=JWL_Reliabilty_controller.getjwlreponsetestcases(jwl1.Id);
        list<JWL_Response__c>  jssres=JWL_Reliabilty_controller.responsewithtest(jwl1.Id);
        list<JWL_Response__c>  jssres2=JWL_Reliabilty_controller.recorddetial(jwl1.Id);
        
        
        
    }
    @isTest
    public static void JWL_Reliabilty_controllerMethod4()
    {
        JWL_Component__c jwl1 = new JWL_Component__c();
        jwl1.QA_User_Email_Id__c ='abc@gmail.com';
        insert jwl1;
        
        list<QA_Email_ID_With_Name__c> userlist=JWL_Reliabilty_controller.getQAEmailIds();
        
        List<JWL_Component__c> jwl= JWL_Reliabilty_controller.fetchAccounts ('TCL/JW/MS/0017/19-20');
        list<JWL_Component__c> jwl2= JWL_Reliabilty_controller.retriverecord(jwl1.Id);
        string str='Test_Type__c';
        string obj='JWL_Component__c';
        list<string> picklistvaluelist = JWL_Reliabilty_controller.getPickListValue(obj,str);
        list<JWL_Test__c> testlist= JWL_Reliabilty_controller.getJwlTests();
        list<JWL_Response__c> jss=JWL_Reliabilty_controller.getjwlreponsetestcases(jwl1.Id);
        list<JWL_Response__c>  jssres=JWL_Reliabilty_controller.responsewithtest(jwl1.Id);
        list<JWL_Response__c>  jssres2=JWL_Reliabilty_controller.recorddetial(jwl1.Id);
        
      
        
       /* ContentVersion contentVersion = new ContentVersion(
            Title = 'Penguins',
            PathOnClient = 'Penguins.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
        );
        insert contentVersion;    
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
        //create ContentDocumentLink  record 
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = jwl1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;*/
        
    }
    @isTest
    public static   void insertJwlComponent(){
        JWLRefNumberPrefix__c refNum = new JWLRefNumberPrefix__c();
        refNum.ProductType__c ='AK';
        refNum.SequenceNo__c = '0001';
        refNum.Name = 'Anklet' ;
        insert refNum; 
        
        JWL_Component__c jwl = new JWL_Component__c();
        jwl.QA_User_Email_Id__c ='abc@gmail.com';
        jwl.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl.Submitted_By__c ='abc@gmail.com';
        jwl.Test_Type__c = 'New' ;
        jwl.Product_Category__c = 'Anklet';
        jwl.Report_Reference_Number__c = '';
        insert jwl;
        
        List<JWL_Test__c> jwlTestLst = new List<JWL_Test__c>();
        JWL_Test__c jwlTest = new JWL_Test__c();
        jwlTest.Name = 'test1' ;
        jwlTest.Active__c = true;
        jwlTest.Specification__c ='specification test';
        jwlTest.Dimensional_Parameters__c = 'Dimension test';
        jwlTestLst.add(jwlTest);
        insert jwlTestLst;
        
        
        JWL_Test__c tests = new JWL_Test__c();
        tests.Name = 'test1' ;
        tests.Active__c = true;
        tests.Specification__c ='specification test';
        tests.Dimensional_Parameters__c = 'Dimension test';
        insert tests;
        list<JWL_Response__c> jwlResp22 = new list<JWL_Response__c>();
        JWL_Response__c jwlResp = new JWL_Response__c();
        jwlResp.JWL_Component__c = jwl.id;
        jwlResp.Jwellery_Test__c = tests.id;
        jwlResp.isChecked__c = true;
        jwlResp.Test_Name__c = tests.Name;
        jwlResp22.add(jwlResp);
        if(!jwlResp22.isEmpty()){
            insert jwlResp22;
        }
        
        list<JWL_Component__c>  jwlcmp22 = new list<JWL_Component__c>();
        JWL_Component__c jwlcmp = new JWL_Component__c();
        jwlcmp.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp.Submitted_By__c ='abc@gmail.com';
        jwlcmp.Test_Type__c = 'New' ;
        jwlcmp.Product_Category__c = 'Anklet';
        jwlcmp.Report_Reference_Number__c = '';
        jwlcmp22.add(jwlcmp);
        if(!jwlcmp22.isEmpty()){
            insert jwlcmp22;
        }
        
        
        JWL_Reliabilty_controller.updateresponse(jwlcmp22, jwlResp22);
        JWL_Reliabilty_controller.savefinalresponse(jwlcmp22, jwlResp22);
        try{
            list<JWL_Response__c> jssupsert=JWL_Reliabilty_controller.insertnewrow(jwlResp22,jwlResp.JWL_Component__c);
            list<JWL_Component__c> updateres=JWL_Reliabilty_controller.updatedocumentstatus(jwlcmp22);
        }catch(exception e){
            system.debug('excp.........'+e);
        }
        
        JWL_Reliabilty_controller.updatecheckbox(jwlResp22);
        
        
        
        jwl.Document_Status__c='Publish';
        update jwl;
        
        
        
        JWLRefNumberPrefix__c refNum1 = new JWLRefNumberPrefix__c();
        refNum1.id = refNum.id;
        refNum1.ProductType__c ='AK';
        refNum1.SequenceNo__c = '0010';
        refNum1.Name = 'Anklet' ;
        update refNum1; 
        
        JWL_Component__c jwl1 = new JWL_Component__c();
        jwl1.QA_User_Email_Id__c ='abc@gmail.com';
        jwl1.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl1.Submitted_By__c ='abc@gmail.com';
        jwl1.Test_Type__c = 'New' ;
        jwl1.Product_Category__c = 'Anklet';
        jwl1.Report_Reference_Number__c = '';
        insert jwl1;
        
        List<JWL_Test__c> jwlTestLst1 = new List<JWL_Test__c>();
        
        JWL_Test__c test1 = new JWL_Test__c();
        test1.Name = 'test1' ;
        test1.Active__c = true;
        test1.Specification__c ='specification test';
        test1.Dimensional_Parameters__c = 'Dimension test';
        insert test1;
        
        JWL_Response__c jwlResp1 = new JWL_Response__c();
        jwlResp1.JWL_Component__c = jwl1.id;
        jwlResp1.Jwellery_Test__c = test1.id;
        jwlResp1.isChecked__c = true;
        jwlResp1.Test_Name__c = test1.Name;
        
        JWL_Component__c jwlcmp1 = new JWL_Component__c();
        jwlcmp1.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp1.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp1.Submitted_By__c ='abc@gmail.com';
        jwlcmp1.Test_Type__c = 'New' ;
        jwlcmp1.Product_Category__c = 'Anklet';
        jwlcmp1.Report_Reference_Number__c = '';
        
        
        JWLRefNumberPrefix__c refNum2 = new JWLRefNumberPrefix__c();
        refNum2.id = refNum1.id;
        refNum2.ProductType__c ='AK';
        refNum2.SequenceNo__c = '0100';
        refNum2.Name = 'Anklet' ;
        update refNum2;
        
        JWL_Component__c jwl2 = new JWL_Component__c();
        jwl2.QA_User_Email_Id__c ='abc@gmail.com';
        jwl2.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl2.Submitted_By__c ='abc@gmail.com';
        jwl2.Test_Type__c = 'New' ;
        jwl2.Product_Category__c = 'Anklet';
        jwl2.Report_Reference_Number__c = '';
        insert jwl2;
        
        List<JWL_Test__c> jwlTestLst3 = new List<JWL_Test__c>();
        
        JWL_Test__c test2 = new JWL_Test__c();
        test2.Name = 'test1' ;
        test2.Active__c = true;
        test2.Specification__c ='specification test';
        test2.Dimensional_Parameters__c = 'Dimension test';
        insert test2;
        
        JWL_Response__c jwlResp2 = new JWL_Response__c();
        jwlResp2.JWL_Component__c = jwl2.id;
        jwlResp2.Jwellery_Test__c = test2.id;
        jwlResp2.isChecked__c = true;
        jwlResp2.Test_Name__c = test2.Name;
        
        JWL_Component__c jwlcmp2 = new JWL_Component__c();
        jwlcmp2.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp2.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp2.Submitted_By__c ='abc@gmail.com';
        jwlcmp2.Test_Type__c = 'New' ;
        jwlcmp2.Product_Category__c = 'Anklet';
        jwlcmp2.Report_Reference_Number__c = '';
        
        
        JWLRefNumberPrefix__c refNum3 = new JWLRefNumberPrefix__c();
        refNum3.id = refNum2.id;
        refNum3.ProductType__c ='AK';
        refNum3.SequenceNo__c = '1000';
        refNum3.Name = 'Anklet' ;
        update refNum3;
        
        
        JWL_Component__c jwl3 = new JWL_Component__c();
        jwl3.QA_User_Email_Id__c ='abc@gmail.com';
        jwl3.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl3.Submitted_By__c ='abc@gmail.com';
        jwl3.Test_Type__c = 'New' ;
        jwl3.Product_Category__c = 'Anklet';
        jwl3.Report_Reference_Number__c = '';
        
        insert jwl3;
        
        List<JWL_Test__c> jwlTestLst4 = new List<JWL_Test__c>();
        
        JWL_Test__c test3 = new JWL_Test__c();
        test3.Name = 'test1' ;
        test3.Active__c = true;
        test3.Specification__c ='specification test';
        test3.Dimensional_Parameters__c = 'Dimension test';
        insert test3;
        
        JWL_Response__c jwlResp3 = new JWL_Response__c();
        jwlResp3.JWL_Component__c = jwl3.id;
        jwlResp3.Jwellery_Test__c = test3.id;
        jwlResp3.isChecked__c = true;
        jwlResp3.Test_Name__c = test3.Name;
        
        
        JWL_Component__c jwlcmp3 = new JWL_Component__c();
        jwlcmp3.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp3.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp3.Submitted_By__c ='abc@gmail.com';
        jwlcmp3.Test_Type__c = 'New' ;
        jwlcmp3.Product_Category__c = 'Anklet';
        jwlcmp3.Report_Reference_Number__c = '';
        Insert new TriggerStatus__c(Name='RollUpNoOfFiles',Active__c=true);
        insert jwlcmp3;
        //jwlcmp3.Image_1__c='wertyuiosdfghjksfghjksdfghj';
        jwlcmp3.Document_Status__c='Publish';
        update jwlcmp3;
        Attachment attch = new Attachment();
        attch.Body = Blob.valueOf('Test Attachment');
        attch.ParentId = jwl3.Id;
        attch.Name = 'Test Attachment.pdf';
        attch.Description = 'Test Description';
        Insert attch;
        ContentVersion cv = new ContentVersion(Title = 'Test',VersionData = blob.valueof('Test Content Data'),IsMajorVersion = true,PathOnClient = 'test.pdf');
        
            insert cv;
            
            ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            
             ContentDocumentLink contentlink=new ContentDocumentLink();
             contentlink.LinkedEntityId=jwl3.Id;  
             contentlink.ContentDocumentId=documents[0].Id;
             contentlink.Visibility = 'AllUsers'; 
             insert contentlink;
        
        
        JWL_Component__c jwlcontent=JWL_Reliabilty_controller.updatePicturePath3 (jwl3.Id);
JWL_Component__c jwlcontent2=JWL_Reliabilty_controller.updatePicturePath (jwl3.Id);
JWL_Component__c jwlcontent3=JWL_Reliabilty_controller.updatePicturePath2 (jwl3.Id);
        
        
        
        jwlcmp3.Image_1__c='testtesttesttesttesttesttesttesttesttesttesttesttesttesttest';
        jwlcmp3.Image_2__c='https://login.salesforce.com/';
        jwlcmp3.Image_3__c='https://login.salesforce.com/';  
        update jwlcmp3;
        
        
    }
    @isTest
    public static   void method3(){
        JWLRefNumberPrefix__c refNum = new JWLRefNumberPrefix__c();
        refNum.ProductType__c ='AK';
        refNum.SequenceNo__c = '0001';
        refNum.Name = 'Anklet' ;
        insert refNum; 
        
        JWL_Component__c jwl = new JWL_Component__c();
        jwl.QA_User_Email_Id__c ='abc@gmail.com';
        jwl.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl.Submitted_By__c ='abc@gmail.com';
        jwl.Test_Type__c = 'New' ;
        jwl.Product_Category__c = 'Anklet';
        jwl.Report_Reference_Number__c = '';
        insert jwl;
        
        List<JWL_Test__c> jwlTestLst = new List<JWL_Test__c>();
        JWL_Test__c jwlTest = new JWL_Test__c();
        jwlTest.Name = 'test1' ;
        jwlTest.Active__c = true;
        jwlTest.Specification__c ='specification test';
        jwlTest.Dimensional_Parameters__c = 'Dimension test';
        jwlTestLst.add(jwlTest);
        insert jwlTestLst;
        
        
        JWL_Test__c tests = new JWL_Test__c();
        tests.Name = 'test1' ;
        tests.Active__c = true;
        tests.Specification__c ='specification test';
        tests.Dimensional_Parameters__c = 'Dimension test';
        insert tests;
        list<JWL_Response__c> jwlResp22 = new list<JWL_Response__c>();
        JWL_Response__c jwlResp = new JWL_Response__c();
        jwlResp.JWL_Component__c = jwl.id;
        jwlResp.Jwellery_Test__c = tests.id;
        jwlResp.isChecked__c = true;
        jwlResp.Test_Name__c = tests.Name;
        jwlResp22.add(jwlResp);
        if(!jwlResp22.isEmpty()){
            insert jwlResp22;
        }
        
        list<JWL_Component__c>  jwlcmp22 = new list<JWL_Component__c>();
        JWL_Component__c jwlcmp = new JWL_Component__c();
        jwlcmp.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp.Submitted_By__c ='abc@gmail.com';
        jwlcmp.Test_Type__c = 'New' ;
        jwlcmp.Product_Category__c = 'Anklet';
        jwlcmp.Report_Reference_Number__c = '';
        jwlcmp22.add(jwlcmp);
        if(!jwlcmp22.isEmpty()){
            insert jwlcmp22;
        }
        
        
        JWL_Reliabilty_controller.updateresponse(jwlcmp22, jwlResp22);
        JWL_Reliabilty_controller.savefinalresponse(jwlcmp22, jwlResp22);
        try{
            list<JWL_Response__c> jssupsert=JWL_Reliabilty_controller.insertnewrow(jwlResp22,jwlResp.JWL_Component__c);
            list<JWL_Component__c> updateres=JWL_Reliabilty_controller.updatedocumentstatus(jwlcmp22);
        }catch(exception e){
            system.debug('excp.........'+e);
        }
        
        JWL_Reliabilty_controller.updatecheckbox(jwlResp22);
        
        
        
        jwl.Document_Status__c='Publish';
        update jwl;
    }
}