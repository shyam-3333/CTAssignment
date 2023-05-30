/*
 *******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/11/2019   T01    Added New Line Item
*/
@isTest(SeeAlldata=true)
public class TestFetchmbadata2
{
    static testMethod void MethodName()
    {   
        List<RecordType> lstreco = [select name,id from RecordType where Sobjecttype='Account' and name='MBA'];
        Account acc =new Account();
        acc.RecordTypeId= lstreco[0].Id;
        acc.Name='kvpcorp';
        insert acc;
        Opportunity opp = new Opportunity();
        
        RecordType rtd = [select id,Name from RecordType where SobjectType='Opportunity' and Name='Allocated Record Type' Limit 1];
        opp.recordTypeId=rtd.id;
        opp.Name = 'Test';
        opp.AccountId = acc.Id;
        opp.Type = 'New Opportunity';
        opp.Region_Picklist__c='South';
        opp.Amount=5000000;
        opp.StageName = 'Quote Preparation';
        opp.CloseDate=System.today();
        opp.Reason__c='Project Shelved';
        insert opp;
        system.debug('opp values----------->'+opp);
        
       
        Quote q = new Quote();
        q.name= 'test';
        q.opportunityId = opp.id;
        q.SAP_Reference_Number__c='ABC11';
        insert q;     
       
        Fetchmbadata2 fetchObj = new Fetchmbadata2();
        
        fetchObj.fromdate=null;
        fetchObj.monthSelected='1';
        fetchObj.selectValue='ram';
        fetchObj.rounded1='ram';
        fetchObj.rounded2='ram';
        fetchObj.rounded3='ram';
        fetchObj.rounded4='ram';
        fetchObj.rounded5='ram';
        fetchObj.rounded6='ram';
        fetchObj.rounded7='ram';
        fetchObj.rounded8='ram';
        fetchObj.rounded9='ram';
        fetchObj.rounded10='ram';
        fetchObj.rounded11='ram';
        fetchObj.rounded12='ram';
        fetchObj.rounded13='ram';
        fetchobj.ExpTotanNumberOfProjectsWon351_700L=1.4;
        fetchobj.ExpTotanNumberOfProjectsWon10_50L=1.2;
        fetchobj.ExpTotanNumberOfProjectsWon51_150L=2.6;
        fetchobj.ExpTotanNumberOfProjectsWon151_350L=2.6;
        fetchobj.ExpTotanNumberOfProjectsWon351_700L=2.6;
        fetchobj.ExpTotanNumberOfProjectsWonGreaterThan700L=1.2;
           
        //fetchObj.Runreport();
        fetchObj.QuotesSubmitted=13.89;
        fetchObj.OrdersWon=2.3;
        opp.StageName = 'Await Customer Feedback(Quote Submitted)';
        opp.Reason__c='Lost on cost';
        opp.Customer_Type__c='New';
        opp.Project_Type__c ='Export';
        opp.StageName = 'Project Under Execution';
        opp.Amount=60000000;
        RecordType rtd1 = [select id,Name from RecordType where SobjectType='Opportunity' and Name='Quote Submitted Record Type' Limit 1];
        opp.recordTypeId=rtd1.id;
        update opp;
        
        RecordType rtd2 = [select id,Name from RecordType where SobjectType='Opportunity' and Name='Initial Record type' Limit 1];
        opp.recordTypeId=rtd2.id;
        opp.StageName = 'Project On Hold';
        opp.Customer_Type__c='Existing Customer';//<T01>
        update opp;
        Test.startTest(); 
        fetchObj.Runreport();
        opp.StageName = 'Revised Quote Submission';
        opp.Amount=70000000;
        update opp; 
        fetchObj.showReport();
        Fetchmbadata2 fetchObj1 = new Fetchmbadata2();
        fetchObj1.fromdate=null;
        fetchObj1.monthSelected='2';
        fetchObj1.Runreport();
        fetchObj1.showReport();
        
        Fetchmbadata2 fetchObj2 = new Fetchmbadata2();
        fetchObj2.fromdate=null;
        fetchObj2.monthSelected='3';
        fetchObj1.Runreport();
        fetchObj1.showReport();
        
        Fetchmbadata2 fetchObj3 = new Fetchmbadata2();
        fetchObj3.fromdate=null;
        fetchObj3.monthSelected='4';
        fetchObj3.Runreport();
        fetchObj3.showReport();
        
        Fetchmbadata2 fetchObj4 = new Fetchmbadata2();
        fetchObj4.fromdate=null;
        fetchObj4.monthSelected='5';
        fetchObj4.Runreport();
        fetchObj4.showReport();
        
        Fetchmbadata2 fetchObj5 = new Fetchmbadata2();
        fetchObj5.fromdate=null;
        fetchObj5.monthSelected='6';
        fetchObj5.Runreport();
        fetchObj5.showReport();
        
        Fetchmbadata2 fetchObj7 = new Fetchmbadata2();
        fetchObj7.fromdate=null;
        fetchObj7.monthSelected='10';
        fetchObj7.Runreport();
        fetchObj7.showReport();
        fetchObj7.changeDateRange();
        Test.stopTest();
     }
}