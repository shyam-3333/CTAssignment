/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/8/2019   TO1,T02,T03		T01- Global UserObject for Electrical User,T02 - Get electrical user created in TestDataFactory,T03-Assign member_2 of opportunity as created eletrical user
*/
@isTest 
private class TestVFAO7Days_01 {
    public static User objUser = null; //<TO1>
    public static User objUser1 = TestDataFactory.getMechanicalRoleUser();
     static testMethod void myUnitTest() {
         objUser=TestDataFactory.getElectricalRoleUser();//<T02>
     RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA' Limit 1];
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
        acct.recordtypeid =rt.Id;
        
        insert acct;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Order Won';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 100;
        opp.Turnover1__c = 50;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Member1__c = '00530000004B7s8AAC';
         //<T03>
         //
         if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        if(objUser!=null)
            opp.Member2__c =objUser.Id;
        //</T03>
        insert opp;

        Quote qt = new Quote();
        qt.Name = 'test1_R1';
        qt.OpportunityId = opp.ID;
        Insert qt;
        Quote qt1 = new Quote();
        qt1.Name = 'test12_R1';
        qt1.OpportunityId = opp.ID;
        Insert qt1;
        
        VFAO7Days_07 controller = new VFAO7Days_07();
        VFAO7Days_01 obj = new VFAO7Days_01(controller);
        
       
    }
     static testMethod void myUnitTest1() {
     RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA' Limit 1];
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
        acct.recordtypeid =rt.Id;
        
        insert acct;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Order Won';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 100;
        opp.Turnover1__c = 50;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Amount_In_Lakhs__c='100000';
        if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        //<T03>
        if(objUser!=null)
            opp.Member2__c =objUser.Id;
        //</T03>
        insert opp;
        
        Quote qt = new Quote();
        qt.Name = 'test1_R1';
        qt.OpportunityId = opp.ID;
        Insert qt;
        Quote qt1 = new Quote();
        qt1.Name = 'test12_R1';
        qt1.OpportunityId = opp.ID;
        Insert qt1;
        
        VFAO_07 controller = new VFAO_07();
        VF_01 obj = new VF_01(controller);
       VF_07 obj1 = new  VF_07();
        obj1.getaccounttotals2();
        //obj1.sortaccounttotals2();
    }
   static testMethod void myUnitTest2() {
     RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA' Limit 1];
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
        acct.recordtypeid =rt.Id;
        
        insert acct;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Order Won';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 100;
        opp.Turnover1__c = 50;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Member1__c = '00530000004B7s8AAC';
        if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        //<T03>
        if(objUser!=null)
            opp.Member2__c =objUser.Id;
        //</T03>
        insert opp;
        
        Quote qt = new Quote();
        qt.Name = 'test1_R1';
        qt.OpportunityId = opp.ID;
        Insert qt;
        Quote qt1 = new Quote();
        qt1.Name = 'test12_R1';
        qt1.OpportunityId = opp.ID;
        Insert qt1;
        
        VFNA7Days_07 controller = new VFNA7Days_07();
        VFNA7Days_01 obj = new VFNA7Days_01(controller);
        
       
    }
    static testMethod void myUnitTest3() {
     RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA' Limit 1];
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
        acct.recordtypeid =rt.Id;
        
        insert acct;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Order Won';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 100;
        opp.Turnover1__c = 50;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Member1__c = '00530000004B7s8AAC';
         //<T03>
         if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        if(objUser!=null)
            opp.Member2__c =objUser.Id;
        //</T03>
        insert opp;
        
        Quote qt = new Quote();
        qt.Name = 'test1_R1';
        qt.OpportunityId = opp.ID;
        Insert qt;
        Quote qt1 = new Quote();
        qt1.Name = 'test12_R1';
        qt1.OpportunityId = opp.ID;
        Insert qt1;
        
        VFNA_07 controller = new VFNA_07();
        VFNA_01 obj = new VFNA_01(controller);
        
       
    }
    
    static testMethod void myUnitTest_VF07() {
     RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA' Limit 1];
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
        acct.recordtypeid =rt.Id;
        
        insert acct;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Order Won';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 100;
        opp.Turnover1__c = 50;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        insert opp;
        
        Quote qt = new Quote();
        qt.Name = 'test1_R1';
        qt.OpportunityId = opp.ID;
        Insert qt;
        Quote qt1 = new Quote();
        qt1.Name = 'test12_R1';
        qt1.OpportunityId = opp.ID;
        Insert qt1;
       
        VF_07 obj1 = new  VF_07();
        obj1.getaccounttotals2();
        //obj1.sortaccounttotals2();
    }
 }