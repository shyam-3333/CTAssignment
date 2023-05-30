@isTest
public class JwlComponentControllerTest {

    @isTest
    public static void JwlComponentControllerTestMethod()
    {
        JWL_Component__c jwl1 = new JWL_Component__c();
        jwl1.QA_User_Email_Id__c ='abc@gmail.com';
        insert jwl1;
        list<QA_Email_ID_With_Name__c> userlist=JwlComponentController.getQAEmailIds();
        string str='Test_Type__c';
        list<string> picklistvaluelist = JwlComponentController.getPickListValue(str);
        
        list<JWL_Test__c> jwlTestList=JwlComponentController.getJwlTests();
         
        
        list<JWL_Response__c> jwlRespoList = JwlComponentController.getJwlResponseList(jwl1);
        
        list<JWL_Vendor__c> jwlVendorList = JwlComponentController.getRelatedVendor('str');
         list<JWL_Component__c> jwlResubCompList = JwlComponentController.getResubJwlcompLst('str');
         
    }
   
        
    public static testMethod  void insertJwlComponentAtNewTypeTestMethod()
    {

        JWLRefNumberPrefix__c refNum = new JWLRefNumberPrefix__c();
        refNum.ProductType__c ='AK';
        refNum.SequenceNo__c = '0001';
        refNum.Name = 'Anklet' ;
        insert refNum; 
      list<QA_Email_ID_With_Name__c> userlist=JwlComponentController.getQAEmailIds();
        JWL_Component__c jwl = new JWL_Component__c();
        jwl.QA_User_Email_Id__c ='abc@gmail.com';
        jwl.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl.Submitted_By__c ='abc@gmail.com';
        jwl.Test_Type__c = 'New' ;
        jwl.Product_Category__c = 'Anklet';
        jwl.Report_Reference_Number__c = '';
        jwl.No_of_samples__c =0;
        insert jwl;
        
        List<JWL_Test__c> jwlTestLst = new List<JWL_Test__c>();
        JWL_Test__c jwlTest = new JWL_Test__c();
        jwlTest.Name = 'test1' ;
        jwlTest.Active__c = true;
        jwlTest.Specification__c ='specification test';
        jwlTest.Dimensional_Parameters__c = 'Dimension test';
        jwlTestLst.add(jwlTest);
        insert jwlTestLst;
        
        list<QA_Email_ID_With_Name__c>listemail  = new list <QA_Email_ID_With_Name__c>();
        QA_Email_ID_With_Name__c mailqa = new QA_Email_ID_With_Name__c();
        mailqa.Name = 'abd';
        mailqa.QA_Email_Id__c='abs@gmail.com';
        listemail.add(mailqa);
        insert listemail;
        
        JWL_Test__c tests = new JWL_Test__c();
        tests.Name = 'test1' ;
        tests.Active__c = true;
        tests.Specification__c ='specification test';
        tests.Dimensional_Parameters__c = 'Dimension test';
        insert tests;
        
        List<JWL_Response__c> respolst =new List<JWL_Response__c>();
        JWL_Response__c jwlResp = new JWL_Response__c();
        jwlResp.JWL_Component__c = jwl.id;
        jwlResp.Jwellery_Test__c = tests.id;
        jwlResp.isChecked__c = true;
        jwlResp.Test_Name__c = tests.Name;
        respolst.add(jwlResp);
        
        JWL_Component__c jwlcmp = new JWL_Component__c();
        jwlcmp.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp.Submitted_By__c ='abc@gmail.com';
        jwlcmp.Test_Type__c = 'New' ;
        jwlcmp.Product_Category__c = 'Anklet';
        jwlcmp.Report_Reference_Number__c = '';
        
        JWL_Component__c jwlRetun = JwlComponentController.insertJwlComponent(jwlcmp, jwlTestLst, respolst ,true);
        
        JWLRefNumberPrefix__c refNum1 = new JWLRefNumberPrefix__c();
        refNum1.id = refNum.id;
        refNum1.ProductType__c ='AK';
        refNum1.SequenceNo__c = '0010';
        refNum1.Name = 'Anklet' ;
        update refNum1; 
        
          list<QA_Email_ID_With_Name__c>listemail1  = new list <QA_Email_ID_With_Name__c>();
        QA_Email_ID_With_Name__c mailqa1 = new QA_Email_ID_With_Name__c();
        mailqa1.Name = 'abd';
        mailqa1.QA_Email_Id__c='abs@gmail.com';
        listemail.add(mailqa1);
        insert listemail1;
        JWL_Component__c jwl1 = new JWL_Component__c();
        jwl1.QA_User_Email_Id__c ='abc@gmail.com';
        jwl1.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl1.Submitted_By__c ='abc@gmail.com';
        jwl1.Test_Type__c = 'New' ;
        jwl1.Product_Category__c = 'Anklet';
        jwl1.Report_Reference_Number__c = '';
        jwl1.No_of_samples__c =0;
        insert jwl1;
        
        List<JWL_Test__c> jwlTestLst1 = new List<JWL_Test__c>();
        
        JWL_Test__c test1 = new JWL_Test__c();
        test1.Name = 'test1' ;
        test1.Active__c = true;
        test1.Specification__c ='specification test';
        test1.Dimensional_Parameters__c = 'Dimension test';
        insert test1;
        
        List<JWL_Response__c> respolst2 =new List<JWL_Response__c>();
        JWL_Response__c jwlResp1 = new JWL_Response__c();
        jwlResp1.JWL_Component__c = jwl1.id;
        jwlResp1.Jwellery_Test__c = test1.id;
        jwlResp1.isChecked__c = true;
        jwlResp1.Test_Name__c = test1.Name;
        respolst2.add(jwlResp1);
        
        JWL_Component__c jwlcmp1 = new JWL_Component__c();
        jwlcmp1.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp1.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp1.Submitted_By__c ='abc@gmail.com';
        jwlcmp1.Test_Type__c = 'New' ;
        jwlcmp1.Product_Category__c = 'Anklet';
        jwlcmp1.Report_Reference_Number__c = '';
        jwlcmp1.No_of_samples__c =0;
        JWL_Component__c jwlRetun1 = JwlComponentController.insertJwlComponent(jwlcmp1, jwlTestLst1, respolst2,true);
        
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
        jwl2.No_of_samples__c =0;
        insert jwl2;
        
        List<JWL_Test__c> jwlTestLst3 = new List<JWL_Test__c>();
        
        JWL_Test__c test2 = new JWL_Test__c();
        test2.Name = 'test1' ;
        test2.Active__c = true;
        test2.Specification__c ='specification test';
        test2.Dimensional_Parameters__c = 'Dimension test';
        insert test2;
        
        List<JWL_Response__c> respolst3 =new List<JWL_Response__c>();
        JWL_Response__c jwlResp2 = new JWL_Response__c();
        jwlResp2.JWL_Component__c = jwl2.id;
        jwlResp2.Jwellery_Test__c = test2.id;
        jwlResp2.isChecked__c = true;
        jwlResp2.Test_Name__c = test2.Name;
        respolst3.add(jwlResp2);
        
        JWL_Component__c jwlcmp2 = new JWL_Component__c();
        jwlcmp2.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp2.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp2.Submitted_By__c ='abc@gmail.com';
        jwlcmp2.Test_Type__c = 'New' ;
        jwlcmp2.Product_Category__c = 'Anklet';
        jwlcmp2.Report_Reference_Number__c = '';
        jwlcmp2.No_of_samples__c =0;
        JWL_Component__c jwlRetun2 = JwlComponentController.insertJwlComponent(jwlcmp2, jwlTestLst3, respolst3,true);
        
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
        jwl3.No_of_samples__c =0;
        insert jwl3;
        
         JWL_Component__c jwl4 = new JWL_Component__c();
        jwl4.QA_User_Email_Id__c ='abc@gmail.com';
        jwl4.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl4.Submitted_By__c ='abc@gmail.com';
        jwl4.Test_Type__c = 'New' ;
        jwl4.Product_Category__c = 'Anklet';
        jwl4.Report_Reference_Number__c = '';
        jwl4.No_of_samples__c = 0;
        insert jwl4;
        
        List<JWL_Test__c> jwlTestLst4 = new List<JWL_Test__c>();
        
        JWL_Test__c test3 = new JWL_Test__c();
        test3.Name = 'Others' ;
        test3.Active__c = true;
        test3.Specification__c ='specification test';
        test3.Dimensional_Parameters__c = 'Dimension test';
        jwlTestLst4.add(test3);
        insert test3;
        
        List<JWL_Response__c> respolst4 =new List<JWL_Response__c>();
        JWL_Response__c jwlResp3 = new JWL_Response__c();
        jwlResp3.JWL_Component__c = jwl3.id;
        jwlResp3.Jwellery_Test__c = test3.id;
        jwlResp3.isChecked__c = true;
        jwlResp3.Test_Name__c = test3.Name;
        respolst4.add(jwlResp3);


        JWL_Component__c jwlcmp3 = new JWL_Component__c();
        jwlcmp3.QA_User_Email_Id__c ='abc@gmail.com';
        jwlcmp3.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwlcmp3.Submitted_By__c ='abc@gmail.com';
        jwlcmp3.Test_Type__c = 'New' ;
        jwlcmp3.Product_Category__c = 'Anklet';
        jwlcmp3.Report_Reference_Number__c = '';
        jwlcmp3.No_of_samples__c =0;
        Insert new TriggerStatus__c(Name='RollUpNoOfFiles',Active__c=true);
        jwlRetun2 = JwlComponentController.insertJwlComponent(jwlcmp3, jwlTestLst4, respolst4,true);
        jwlRetun2 = JwlComponentController.insertJwlComponent(jwlcmp3, jwlTestLst4, respolst4,true);
        
        
        Attachment attch = new Attachment();
        attch.Body = Blob.valueOf('Test Attachment');
        attch.ParentId = jwlRetun2.Id;
        attch.Name = 'Test Attachment.pdf';
        attch.Description = 'Test Description';
        Insert attch;
        ContentVersion cv = new ContentVersion(Title = 'Test',VersionData = blob.valueof('Test Content Data'),IsMajorVersion = true,PathOnClient = 'test.pdf');
        
            insert cv;
            
            ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            
             ContentDocumentLink contentlink=new ContentDocumentLink();
             contentlink.LinkedEntityId=jwlRetun2.Id;  
             contentlink.ContentDocumentId=documents[0].Id;
             contentlink.Visibility = 'AllUsers'; 
             insert contentlink;
        
        
        JWL_Component__c jwlcontent=JwlComponentController.updatePicturePath3 (jwlRetun2.Id);
JWL_Component__c jwlcontent2=JwlComponentController.updatePicturePath (jwlRetun2.Id);
JWL_Component__c jwlcontent3=JwlComponentController.updatePicturePath2 (jwlRetun2.Id);
        
        
        
        jwlcmp3.Image_1__c='testtesttesttesttesttesttesttesttesttesttesttesttesttesttest';
        jwlcmp3.Image_2__c='https://login.salesforce.com/';
        jwlcmp3.Image_3__c='https://login.salesforce.com/';  
        update jwlcmp3;
        
    /***********************************************************************************************************  
        Test.startTest();
        JWL_Component__c jwl4 = new JWL_Component__c();
        jwl4.QA_User_Email_Id__c ='abc@gmail.com';
        jwl4.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl4.Submitted_By__c ='abc@gmail.com';
        jwl4.Test_Type__c = 'New' ;
        jwl4.Product_Category__c = 'Anklet';
        jwl4.Report_Reference_Number__c = '';
        insert jwl4;
        
        List<JWL_Test__c> jwlTestLst5 = new List<JWL_Test__c>();
        JWL_Test__c test4 = new JWL_Test__c();
        test4.Name = 'test1' ;
        test4.Active__c = true;
        test4.Specification__c ='specification test';
        test4.Dimensional_Parameters__c = 'Dimension test';
        jwlTestLst5.add(test4);
        insert jwlTestLst5;
        
        JWL_Test__c test5 = new JWL_Test__c();
        test5.Name = 'test1' ;
        test5.Active__c = true;
        test5.Specification__c ='specification test';
        test5.Dimensional_Parameters__c = 'Dimension test';
        insert test5;
        
        JWL_Response__c jwlResp5 = new JWL_Response__c();
        jwlResp5.JWL_Component__c = jwl4.id;
        jwlResp5.Jwellery_Test__c = test5.id;
        jwlResp5.isChecked__c = true;
        jwlResp5.Test_Name__c = test5.Name;
        insert jwlResp5;
        
        List<JWL_Response__c> jwlRespoLst = new List<JWL_Response__c>();
        for(JWL_Test__c tests1 : jwlTestLst5 )
        {
            JWL_Response__c jwlResp4 = new JWL_Response__c();
            jwlResp4.JWL_Component__c = jwl4.id;
            jwlResp4.Jwellery_Test__c = tests1.id;
            jwlResp4.isChecked__c = true;
            jwlResp4.Test_Name__c = tests1.Name;
            jwlRespoLst.add(jwlResp4);
        }
        insert jwlRespoLst;
        
        
        JWL_Test__c test6 = new JWL_Test__c();
        test6.Name = 'test1' ;
        test6.Active__c = true;
        test6.Specification__c ='specification test';
        test6.Dimensional_Parameters__c = 'Dimension test';
        insert test6;
        
        JWL_Response__c jwlResp6 = new JWL_Response__c();
        jwlResp6.JWL_Component__c = jwl4.id;
        jwlResp6.Jwellery_Test__c = test6.id;
        jwlResp6.isChecked__c = true;
        jwlResp6.Test_Name__c = test6.Name;
        jwlRetun2 = JwlComponentController.insertJwlComponent(jwl4, jwlTestLst5, jwlResp6,true);
        
        List<JWL_Test__c> jwlTestLst6 = new List<JWL_Test__c>();
        JWL_Response__c jwlResp7 = new JWL_Response__c();
        jwlResp7.JWL_Component__c = jwl4.id;
        jwlResp7.Jwellery_Test__c = test6.id;
        jwlResp7.isChecked__c = true;
        jwlResp7.Test_Name__c = test6.Name;
        insert jwlResp7;
        jwlRetun2 = JwlComponentController.insertJwlComponent(jwl4, jwlTestLst6, jwlResp7,true);
        Test.stopTest();
*/
    }
    
    @isTest
    public static void updateJwlComponentAtResubmissionTestMethod()
    {
        JWL_Component__c jwl = new JWL_Component__c();
        jwl.QA_User_Email_Id__c ='abc@gmail.com';
        jwl.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl.Submitted_By__c ='abc@gmail.com';
        jwl.Test_Type__c = 'Resubmission' ;
        jwl.Product_Category__c = 'Anklet';
        jwl.Report_Reference_Number__c = 'AK/0001/19-20';
        jwl.No_of_samples__c =0;
        insert jwl;
         list<QA_Email_ID_With_Name__c> userlist=JWL_Reliabilty_controller.getQAEmailIds();
        List<JWL_Test__c> jwlTestLst5 = new List<JWL_Test__c>();
        JWL_Test__c test4 = new JWL_Test__c();
        test4.Name = 'test1' ;
        test4.Active__c = true;
        test4.Specification__c ='specification test';
        test4.Dimensional_Parameters__c = 'Dimension test';
        jwlTestLst5.add(test4);
        insert jwlTestLst5;
        
        List<JWL_Response__c> jwlRespoLst = new List<JWL_Response__c>();
        for(JWL_Test__c tests : jwlTestLst5 )
        {
            JWL_Response__c jwlResp4 = new JWL_Response__c();
            jwlResp4.JWL_Component__c = jwl.id;
            jwlResp4.Jwellery_Test__c = tests.id;
            jwlResp4.isChecked__c = true;
            jwlResp4.Test_Name__c = tests.Name;
            jwlRespoLst.add(jwlResp4);
        }
        insert jwlRespoLst;
        
        JWL_Component__c jwlRetun = JwlComponentController.updateResubJwlComponent(jwl, jwlRespoLst, true);
        
        /***************************************************************************************************/
        
        JWL_Component__c jwl1 = new JWL_Component__c();
        jwl1.QA_User_Email_Id__c ='abc@gmail.com';
        jwl1.Additional_Emails__c ='m@gmail.com,h@gmail.com';
        jwl1.Submitted_By__c ='abc@gmail.com';
        jwl1.Test_Type__c = 'Resubmission' ;
        jwl1.Product_Category__c = 'Anklet';
        jwl1.Report_Reference_Number__c = 'AK/0001/19-20R1';
        jwl1.No_of_samples__c =0;
        insert jwl1;
        
        List<JWL_Test__c> jwlTestLst = new List<JWL_Test__c>();
        JWL_Test__c test = new JWL_Test__c();
        test.Name = 'test1' ;
        test.Active__c = true;
        test.Specification__c ='specification test';
        test.Dimensional_Parameters__c = 'Dimension test';
        jwlTestLst.add(test);
        insert jwlTestLst;
        
        List<JWL_Response__c> jwlRespoLst1 = new List<JWL_Response__c>();
        for(JWL_Test__c tests : jwlTestLst )
        {
            JWL_Response__c jwlResp4 = new JWL_Response__c();
            jwlResp4.JWL_Component__c = jwl1.id;
            jwlResp4.Jwellery_Test__c = tests.id;
            jwlResp4.isChecked__c = true;
            jwlResp4.Test_Name__c = tests.Name;
            jwlRespoLst1.add(jwlResp4);
        }
        insert jwlRespoLst1;
        
         jwlRetun = JwlComponentController.updateResubJwlComponent(jwl1, jwlRespoLst1, true);
    }
}