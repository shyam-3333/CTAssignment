@isTest 
private class TestVFAO_07  {
    static testMethod void myUnitTest() {
    RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA'];
    system.debug('$$$$$$$$'+rt);
    system.debug('@@@@@@@@@@@@'+rt.Name);
    system.assertequals(rt.Name,'MBA');
    Account acct = new Account();
        acct.Name = 'test';
        acct.Industry='Automotive';
        acct.Account_SAP_Id__c ='1234';
        acct.Financial_Stability_Risk__c = 'High';
        acct.Payment_Structure_Collection_Risk__c ='High';
        acct.Country_Specific_Statutory_Risk__c ='High'; 
        acct.Service_Availability_Risk_Other_Countrie__c='High';
        acct.Country_Specific_Statutory_Risk_Details__c ='ashu';
        acct.Financial_Stability_Risk_Details__c ='test1';
        acct.Payment_Structure_Collection_Risk_Detail__c = 'test2';
        acct.Service_Availability_Risk_Details__c ='asd';
        acct.recordTypeId =rt.Id;
        insert acct;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Costing';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 0;
        opp.Turnover1__c = 0;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        opp.Member1__c = null;
        opp.Member2__c = null; 
         opp.Opportunity_Lost_Date__c=  system.today(); 
         opp.Reason__c = 'Regret';
         opp.R1_Proposal_Submission_Ad__c= system.today(); 
        
         
        insert opp;
        
    //VFAO_07 controller = new VFAO_07();
    
        
     }  
     
    /* static testMethod void myUnitTest1() {
    RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA'];
    Account acct = new Account();
        acct.Name = 'test';
        acct.Industry='Automotive';
        acct.Account_SAP_Id__c ='1234';
        acct.Financial_Stability_Risk__c = 'High';
        acct.Payment_Structure_Collection_Risk__c ='High';
        acct.Country_Specific_Statutory_Risk__c ='High'; 
        acct.Service_Availability_Risk_Other_Countrie__c='High';
        acct.Country_Specific_Statutory_Risk_Details__c ='ashu';
        acct.Financial_Stability_Risk_Details__c ='test1';
        acct.Payment_Structure_Collection_Risk_Detail__c = 'test2';
        acct.Service_Availability_Risk_Details__c ='asd';
        acct.recordTypeId =rt.Id;
        insert acct;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Costing';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 0;
        opp.Turnover1__c = 0;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        opp.Member1__c = '';
        opp.Member2__c = ''; 
        opp.Opportunity_Lost_Date__c=  system.today(); 
        opp.Reason__c = 'Regret';
        opp.R1_Proposal_Submission_Ad__c= system.today(); 
        insert opp;
        
    VFAO7Days_07  controller = new VFAO7Days_07();
    VFAO7Days_06 obj = new VFAO7Days_06(controller);
        }
        
         static testMethod void myUnitTest2() {
    RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA'];
    Account acct = new Account();
        acct.Name = 'test';
        acct.Industry='Other';
        acct.Account_SAP_Id__c ='1234';
        acct.Financial_Stability_Risk__c = 'High';
        acct.Payment_Structure_Collection_Risk__c ='High';
        acct.Country_Specific_Statutory_Risk__c ='High'; 
        acct.Service_Availability_Risk_Other_Countrie__c='High';
        acct.Country_Specific_Statutory_Risk_Details__c ='ashu';
        acct.Financial_Stability_Risk_Details__c ='test1';
        acct.Payment_Structure_Collection_Risk_Detail__c = 'test2';
        acct.Service_Availability_Risk_Details__c ='asd';
        acct.recordTypeId =rt.Id;
        insert acct;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Costing';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 0;
        opp.Turnover1__c = 0;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        opp.Member1__c = '';
        opp.Member2__c = ''; 
         opp.Opportunity_Lost_Date__c=  system.today(); 
         opp.Reason__c = 'Regret';
         opp.R1_Proposal_Submission_Ad__c= system.today(); 
        insert opp;
        
    VFNA7Days_07 controller = new VFNA7Days_07();
    VFNA7Days_06 obj = new VFNA7Days_06(controller);
        }
        
         
         static testMethod void myUnitTest3() {
    RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA'];
    Account acct = new Account();
        acct.Name = 'test';
        acct.Industry='Other';
        acct.Account_SAP_Id__c ='1234';
        acct.Financial_Stability_Risk__c = 'High';
        acct.Payment_Structure_Collection_Risk__c ='High';
        acct.Country_Specific_Statutory_Risk__c ='High'; 
        acct.Service_Availability_Risk_Other_Countrie__c='High';
        acct.Country_Specific_Statutory_Risk_Details__c ='ashu';
        acct.Financial_Stability_Risk_Details__c ='test1';
        acct.Payment_Structure_Collection_Risk_Detail__c = 'test2';
        acct.Service_Availability_Risk_Details__c ='asd';
        acct.recordTypeId =rt.Id;
        insert acct;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Costing';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 0;
        opp.Turnover1__c = 0;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        opp.Member1__c = '';
        opp.Member2__c = ''; 
        opp.Opportunity_Lost_Date__c=  system.today(); 
        opp.Reason__c = 'Regret';
        opp.R1_Proposal_Submission_Ad__c= system.today(); 
        insert opp;
        
    VFNA_07 controller = new VFNA_07();
    VFNA_06 obj = new VFNA_06(controller);
        }*/
    }