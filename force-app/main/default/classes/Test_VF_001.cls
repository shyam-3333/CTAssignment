/*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)  11/8/2019   T01,T02     T01 - Get created Electrical Role User , T02- Assign Electrical role user to member_c
*/
@isTest
public class Test_VF_001{
@isTest public static void VF_001Test()
    {
        User objUser =TestDataFactory.getElectricalRoleUser();//<T01>
        User objUser1 =TestDataFactory.getMechanicalRoleUser();//<T01>
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
        opp.Basic_Price__c  = 100;
        opp.Turnover1__c = 50;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        //opp.Member1__c = '00530000004B7s8AAC';
        //<T02>
        if(objUser!=null)
            opp.Member2__c =objUser.Id;
        if(objUser1!=null)
            opp.Member1__c =objUser1.Id;
        //</T02>
        insert opp;
        
        VF_001 obj = new VF_001();
        obj.getaccounttotals();
        
    }
    
}