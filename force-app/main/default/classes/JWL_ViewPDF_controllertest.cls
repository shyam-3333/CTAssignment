@isTest 
public class JWL_ViewPDF_controllertest 
{
    static testMethod void testMethod1() 
    {
       
        JWLRefNumberPrefix__c refNum = new JWLRefNumberPrefix__c();
        refNum.ProductType__c ='AK';
        refNum.SequenceNo__c = '0001';
        refNum.Name = 'Anklet' ;
        insert refNum; 
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Jewellery QA']; 
        
        User usr = new User();
        usr.LastName = 'Muthu';
        usr.Email = 'abc@gmail.com';
        usr.EmailEncodingKey ='UTF-8';
        usr.ProfileId = p.id;
        usr.IsActive = true;
        usr.Username = 'titan@jwl.com';
        usr.Alias = 'Muttu';
        usr.LanguageLocaleKey = 'en_US';
        usr.TimeZoneSidKey = 'America/Los_Angeles';
        usr.LocaleSidKey ='en_US';
        
        
        QA_Email_ID_With_Name__c qaEmail = new QA_Email_ID_With_Name__c();
        qaEmail.Name = 'MuttuRaj';
        qaEmail.QA_Email_Id__c = 'MuttuRaj@gmail.com';
        insert qaEmail;
        
        JWL_Component__c jwl = new JWL_Component__c();
        jwl.QA_User_Email_Id__c ='MuttuRaj@gmail.com';
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
        

            Test.setCurrentPageReference(new PageReference('Page.JWL_ViewPDF'));
            System.currentPageReference().getParameters().put('id', jwl.id);

            //ApexPages.StandardController sc = new ApexPages.StandardController();
            JWL_ViewPDF_controller testAccPlan = new JWL_ViewPDF_controller(new ApexPages.StandardController(jwl));
            list<JWL_Response__c> jss=testAccPlan.getjwlresponsetable();
            
           

       
    }
}