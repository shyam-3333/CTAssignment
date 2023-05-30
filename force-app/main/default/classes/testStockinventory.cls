/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			11/27/2019   T01   Test Class Failure Fix changed test.starttest() & test.stoptest() position
*/
@isTest(SeeAllData = true) 
private class testStockinventory
{
    
    public string selectedId = 'Regret';
    public static testMethod void stockInventoryTest()
    {
        RecordType CSDRid= [Select id,name,SobjectType from RecordType where name=:'PECSA' and SobjectType=: 'Project_Stage_History_New__c' limit 1];
        Account acct = new Account();
        acct.Name = 'test';
        //acct.RecordTypeId = CSDRid.id;
        insert acct;
        
        List<Quote_Items__c> listqli= new List<Quote_Items__c>();
         
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Quotation Submission';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();
        
        insert opp;
        
        Project_Stage_History_New__c psh = new Project_Stage_History_New__c();
        psh.RecordTypeId =CSDRid.id;
        psh.Opportunity__c = opp.Id;
        insert psh;
        test.startTest();
        Quote qt = new Quote();
        qt.Name = 'test';
        qt.OpportunityId = opp.Id;
        insert qt;
        
        
        
        Quote_Items__c qli = new Quote_Items__c();
        qli.Quote__c = qt.id;
        qli.Part_No__c = '1234';
        qli.Part_Description__c = 'test';
        qli.Part_Status__c = 'Regret';
        qli.Reasone_for_Regret_2__c = 'Capability';
        qli.Reasone_for_Regret__c = 'Capability';
        qli.Processing_Cost_pc__c = 1234;
        qli.Spl_Process_Cost_pc__c = 123;
        qli.Optional__c = FALSE;
        qli.Raw_Material_Grade__c = 'test';
        qli.Raw_Material_Specification__c = 'test';
        qli.One_Time_Dev_Cost_NRE__c = 1234;
        qli.Material_Cost_pc__c = 1234;
        qli.FAI_Cost_pc__c = 12;
        qli.BOI_Cost_pc__c = 123;
        qli.EAU_in_no_s__c = 12;
        qli.Batch_Quantity__c = 1;
        qli.CurrencyIsoCode = 'INR';
        qli.Currency_custom__c = 'INR';
        qli.Parity_Value__c = 34;
        qli.Remarks__c = 'test';
        insert qli;
        
         
        ApexPages.currentPage().getParameters().put('id', qt.id);
      //  ApexPages.currentPage().getParameters().put('id', qli.id);
       // ApexPages.currentPage().getParameters().put('recStatus', 'Regret');
        
         ApexPages.StandardController controller = new ApexPages.StandardController(qt); 
            Stockinventory st = new Stockinventory(controller);
            
        st.myactionfun();
        st.autoSave();
        st.dummycall();
        st.changeCityList();
        st.AddItemDetails();
        st.selectedId = 'Regret';
       // st.customeDelete();
        st.Save1();
        st.Save2();
        st.cancel();
      Test.stopTest();
        
    }
    
      public static testMethod void stockInventoryTest1(){
 
        Account acct = new Account();
        acct.Name = 'test';
        insert acct;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Quotation Submission';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();
        insert opp;
        
        Quote qt = new Quote();
        qt.Name = 'test';
        qt.OpportunityId = opp.Id;
        insert qt;
        
        Test.startTest();
        
        Quote_Items__c qli = new Quote_Items__c();
        qli.Quote__c = qt.id;
        qli.Part_No__c = '1234';
        qli.Part_Description__c = 'test';
        qli.Part_Status__c = 'LOst';
        qli.Reasone_for_Regret_2__c = 'Capability';
        qli.Reasone_for_Regret__c = 'Capability';
        qli.Processing_Cost_pc__c = 1234;
        qli.Spl_Process_Cost_pc__c = 123;
        qli.Optional__c = FALSE;
        qli.Raw_Material_Grade__c = 'test';
        qli.Raw_Material_Specification__c = 'test';
        qli.One_Time_Dev_Cost_NRE__c = 1234;
        qli.Material_Cost_pc__c = 1234;
        qli.FAI_Cost_pc__c = 12;
        qli.BOI_Cost_pc__c = 123;
        qli.EAU_in_no_s__c = 12;
        qli.Batch_Quantity__c = 1;
        qli.CurrencyIsoCode = 'INR';
        qli.Currency_custom__c = 'INR';
        qli.Parity_Value__c = 34;
        qli.Remarks__c = 'test';
        qli.Reasone_for_Lost__c = null;
       
        insert qli;
        
        
        ApexPages.currentPage().getParameters().put('id', qt.id);
        
        
         ApexPages.StandardController controller2 = new ApexPages.StandardController(qt); 
            Stockinventory st2 = new Stockinventory(controller2);
            st2.SRLI.add(qli);
            st2.Save1();
            st2.Save2();
            
         Test.stopTest();
    }
      public static testMethod void stockInventoryTest2(){
      
        Account acct = new Account();
        acct.Name = 'test';
        insert acct;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Quotation Submission';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();
        insert opp;
        
        Quote qt = new Quote();
        qt.Name = 'test';
        qt.OpportunityId = opp.Id;
        insert qt;
        
        
        Test.startTest();
        Quote_Items__c qli = new Quote_Items__c();
        qli.Quote__c = qt.id;
        qli.Part_No__c = '1234';
        qli.Part_Description__c = 'test';
        qli.Part_Status__c = 'Regret';
        qli.Reasone_for_Regret_2__c = null;
        qli.Reasone_for_Regret__c = null;
        qli.Processing_Cost_pc__c = 1234;
        qli.Spl_Process_Cost_pc__c = 123;
        qli.Optional__c = FALSE;
        qli.Raw_Material_Grade__c = 'test';
        qli.Raw_Material_Specification__c = 'test';
        qli.One_Time_Dev_Cost_NRE__c = 1234;
        qli.Material_Cost_pc__c = 1234;
        qli.FAI_Cost_pc__c = 12;
        qli.BOI_Cost_pc__c = 123;
        qli.EAU_in_no_s__c = 12;
        qli.Batch_Quantity__c = 1;
        qli.CurrencyIsoCode = 'INR';
        qli.Currency_custom__c = 'INR';
        qli.Parity_Value__c = 34;
        qli.Remarks__c = 'test';
        qli.Reasone_for_Lost__c = null;

        insert qli;
        
        
        ApexPages.currentPage().getParameters().put('id', qt.id);
        
        
         ApexPages.StandardController controller2 = new ApexPages.StandardController(qt); 
            Stockinventory st2 = new Stockinventory(controller2);
            st2.SRLI.add(qli);
            st2.Save1();
            st2.Save2();
            
        Test.stopTest();
            
    }
}