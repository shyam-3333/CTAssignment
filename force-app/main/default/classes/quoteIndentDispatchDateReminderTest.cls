/*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)  11/28/2019   T01     Test class issue fixing
*********************************************************************/@isTest
public class quoteIndentDispatchDateReminderTest{
    
    @testSetup
    public static void setUpData(){
        Account a=new Account();
        a.Name='AccName';
        a.Delivery_Type__c='Export';
        a.Industry='Automotive';
        a.Company_Type__c='OEM';        
        insert a;
        
        Opportunity op=new Opportunity();
        op.Name='OpName';
        op.AccountId=a.Id;
        op.Type='New Opporttunity';
        op.Region_Picklist__c='North';
        op.StageName='Received PO/Order Won';
        op.Amount=1230;
        op.PO_No__c='';
        op.PO_Date__c=Date.newInstance(2018,12, 09);
        op.PO_Reference__c='19';
        op.closeDate=Date.newInstance(2018,12, 9);
        op.Stage_Change_Date__c= system.today().addDays(-14);
        insert op;
                       
        List<quote> insertQuote = New List<quote>();
        for(Integer i=1;i<11;i++){
            Quote q=new Quote();
            q.Name='QuoteName1'+i;
            q.Order_Type__c='Custom';
            q.OpportunityId = op.Id;
            
            insertQuote.add(q);
        }
        insert insertQuote;//<T01>
        insertQuote = New List<quote>();
        for(Integer i=1;i<11;i++){
            Quote q=new Quote();
            q.Name='QuoteName2'+i;
            q.Order_Type__c='Regular';
            q.OpportunityId = op.Id;
            insertQuote.add(q);
        }
        insert insertQuote;
        insertQuote = New List<quote>();
        for(Integer i=1;i<11;i++){
            Quote q=new Quote();
            q.Name='QuoteName3'+i;
            q.Order_Type__c='EGV';
            q.OpportunityId = op.Id;
            insertQuote.add(q);
        }
        insert insertQuote;
        insertQuote = New List<quote>();
    }
    
    static testMethod void testMethod1(){
        
        quoteIndentDispatchDateReminder obj = new quoteIndentDispatchDateReminder();

        Test.StartTest(); 
        List<quote> qouteList = [SELECT id,Indent_Dispatch_Date__c,Insti_ref__c,Order_Type__c,Account.Name,OpportunityId,Opportunity.Name,Opportunity_name__c,Opportunity.stageName,Opportunity.Stage_Change_Date__c,createddate from quote where Opportunity.stageName='Received PO/Order Won' AND Indent_Dispatch_Date__c=Null];
        DataBase.executeBatch(obj); 
        obj.execute(Null, qouteList);
   		        
        obj.custrecString ='test';
        obj.regularcount = 1;
        obj.custcount = 1;
        obj.regularrecString = 'test';
        Test.StopTest();
    }   
}