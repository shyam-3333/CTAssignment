@isTest
public class BatchToUpdateProductForApprovalTest {

    static testMethod void testMethod1(){
        Account ac= new Account();
        ac.Name ='Test';
        insert ac;
        
        recordType RTO = [SELECT Id,Name FROM RecordType WHERE SobjectType='Opportunity' And name = 'Jewellery'];
        
        
        opportunity opp = new opportunity();
        opp.RecordTypeId =  RTO.ID;
        opp.Name = 'test';
        opp.StageName = 'Revised Quote';
        opp.AccountId = ac.Id;
        opp.type = 'New Opportunity';
        opp.Region_Picklist__c = 'North';
        opp.Amount = 456312;
        opp.CloseDate = System.today();
        insert opp;
        
        quote q1 = new quote();
        q1.RecordTypeId = '012a0000001RMK9';
        q1.Name = 'adadd';
        q1.OpportunityId = opp.id;
        q1.Order_Type__c = 'Regular';
        q1.Product_for_Approval__c = 'Gold Voucher';
        insert q1;
        database.executeBatch(new BatchToUpdateProductForApproval());
        
    }

}