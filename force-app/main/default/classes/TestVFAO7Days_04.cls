/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/8/2019   TO1,T02,T03		T01- Global UserObject for Electrical User,T02 - Get electrical user created in TestDataFactory,T03-Assign member_2 of opportunity as created eletrical user
*/
@isTest 
private class TestVFAO7Days_04  {
    public static User objUser = null;//<T01>
    public static User objUser1 =TestDataFactory.getMechanicalRoleUser();//<T01>
    static testMethod void myUnitTest() {
        objUser=TestDataFactory.getElectricalRoleUser();//<T02>
        //User objUser1 =TestDataFactory.getMechanicalRoleUser();//<T01>
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
        opp.Basic_Price__c  = 0;
        opp.Turnover1__c = 0;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Member1__c = '00530000004B7s8AAC';
        //<TO3>
        if(objUser!=null){
            opp.Member2__c =objUser.Id;}
         if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        //</TO3>
        
        opp.Opportunity_Lost_Date__c=  system.today(); 
        opp.Reason__c = 'Regret';
        insert opp;
        
        VFAO7Days_07 controller = new VFAO7Days_07();
        VFAO7Days_04 obj = new  VFAO7Days_04(controller);
        
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
        opp.Basic_Price__c  = 0;
        opp.Turnover1__c = 0;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Member1__c = '00530000004B7s8AAC';
        //<TO3>
        if(objUser!=null)
            opp.Member2__c =objUser.Id;
         if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        //</TO3>
        opp.Opportunity_Lost_Date__c=  system.today(); 
        opp.Reason__c = 'Regret';
        insert opp;
        
        VFAO_07 controller = new VFAO_07();
        VFAO_04 obj = new VFAO_04(controller);
    }
    
    static testMethod void myUnitTest2() {
        RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA' Limit 1];
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
        acct.recordtypeid =rt.Id;
        insert acct;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Order Won';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 0;
        opp.Turnover1__c = 0;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Member1__c = '00530000004B7s8AAC';
        //<TO3>
        if(objUser!=null)
            opp.Member2__c =objUser.Id;
         if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        //</TO3>
        opp.Opportunity_Lost_Date__c=  system.today(); 
        opp.Reason__c = 'Regret';
        insert opp;
        
        VFNA7Days_07 controller = new VFNA7Days_07();
        VFNA7Days_04 obj = new VFNA7Days_04(controller);
    }
    
    
    static testMethod void myUnitTest3() {
        RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA' Limit 1];
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
        acct.recordtypeid =rt.Id;
        insert acct;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Order Won';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 0;
        opp.Turnover1__c = 0;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Member1__c = '00530000004B7s8AAC';
        //<TO3>
        if(objUser!=null)
            opp.Member2__c =objUser.Id;
         if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        //</TO3>
        opp.Opportunity_Lost_Date__c=  system.today(); 
        opp.Reason__c = 'Regret';
        insert opp;
        
        VFNA_07 controller = new VFNA_07();
        VFNA_04 obj = new VFNA_04(controller);
    }
}