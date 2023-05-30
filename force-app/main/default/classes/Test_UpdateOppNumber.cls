@isTest(seeAllData = true)
public class Test_UpdateOppNumber {

     Static testMethod void TestCreateOpp(){
     Test.startTest();
        //String oppPreviousNumber = '0000';
        String nextNum = '0001';
        String zeroes = '000';
        String autoNum = '';
        Integer digitsToBe = 4;
        
        List<RecordType> lstreco = [select name,id from RecordType where Sobjecttype='Account' and name = 'MBA'];
        Account acc =new Account();
        acc.RecordTypeId = lstreco[0].Id;
        acc.Name='TestAccount';
        insert acc;
        
        
        List<RecordType> lstropp = [select name,id from RecordType where Sobjecttype='Opportunity'];
        List<Opportunity> lstOpp = new List<Opportunity>();
        for(Integer i=0;i<10;i++){
        
            Opportunity opp = new Opportunity();
            lstropp[0].Name ='Allocated Record Type';
            opp.Name = 'Test';
            opp.AccountId = acc.Id;
            opp.Type = 'New Opportunity';
            opp.Region_Picklist__c='South';
            opp.Amount=100.00;
            opp.CloseDate=System.today();
            opp.StageName = 'Project On Hold';
            opp.Reason__c='Lost on cost';
            opp.Project_Type__c='Domestic';
            opp.Customer_Type__c='New';
            opp.Expected_Machine_Dispatch_Date__c = Date.today();
            //opp.Auto_Number__c = '0001';
            lstOpp.add(opp);
         }  
            insert lstOpp;
         List<Opportunity> oppPreviousNumberRec = [SELECT Id,Auto_Number__c  FROM Opportunity where Auto_Number__c != null and name='Test' Order By ID DESC LIMIT 1] ;
         //String oppPreviousNumber = oppPreviousNumberRec[0].Auto_Number__c;
        Test.stopTest();
        }

}