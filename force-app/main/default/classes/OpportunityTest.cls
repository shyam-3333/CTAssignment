/*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)  11/8/2019   T01     Test class issue fixing
*/
@isTest

private class OpportunityTest{

    static testMethod void OpportunityTestMethod() {

         Map<String,Schema.RecordTypeinfo> rec = Opportunity.SobjectType.getDescribe().getRecordTypeInfosByName();
         List<Opportunity> opplist = new List<Opportunity>();

         Profile p = [Select Id from Profile where Name LIKE '%Team member%' limit 1];
    
          User u = [Select ID from User Where ProfileID =: p.ID AND Alias != 'prakash' AND isActive = true limit 1];
        //  User u1 = [Select ID from User Where ProfileID =: p.ID AND Alias != 'prakash' AND ID !=: u.Id  AND isActive = true limit 1];
		User objUser = TestDataFactory.getMechanicalRoleUser();//<T01>
        User objUser1 = TestDataFactory.getElectricalRoleUser();//<T01>
         Account a = new Account(Name = 'Test Account for Test');
         insert a;
 
         Opportunity o = new Opportunity();
         o.Name = 'Test for Opp Test Method';
         o.RecordTypeId = rec.get('Initial Record type').getRecordTypeId();
         o.AccountID = a.ID;
         o.Type = 'AMC';
         o.StageName = 'Preliminary Opportunity';
         o.CloseDate = System.Today() + 10;
          o.Member1__c = objUser.Id;
          o.Member2__c = objUser1.Id;
         opplist.add(o);   
         
         Opportunity o1 = new Opportunity();
         o1.Name = 'Test 2 for Opp Test Method ';
         o1.RecordTypeId = rec.get('Initial Record type').getRecordTypeId();
         o1.AccountID = a.ID;
         o1.Type = 'New';
         o1.StageName = 'Preliminary Opportunity';
         o1.CloseDate = System.Today() + 10;
         opplist.add(o1);
         
         Opportunity o2 = new Opportunity();
         o2.Name = 'Test 3 for Opp Test Method ';
         o2.RecordTypeId = rec.get('PECSA').getRecordTypeId();
         o2.AccountID = a.ID;
         o2.StageName = 'Preliminary Opportunity';
         o2.CloseDate = System.Today() + 10;
         opplist.add(o2);
         
         insert opplist;
         
         opplist.clear();
         
         Opportunity o10 = new Opportunity(ID = o1.ID);
         o10.OwnerID = u.ID;
         opplist.add(o10);
         
         update opplist;
         
         opplist.clear();
         
         Opportunity o3 = new Opportunity(ID = o.ID);
         o3.StageName = 'Quote Preparation';
         opplist.add(o3);
         
         Opportunity o4 = new Opportunity(ID = o1.ID);
         o4.StageName = 'Await Customer Feedback(Quote Submitted)';
         opplist.add(o4);
         
         Opportunity o8 = new Opportunity(ID = o2.ID);
         o8.OwnerID = u.ID;
        
         o8.RFQ_Received_Date_Date__c=System.today();
         o8.RFQ_Close_Date__c=System.today();
          opplist.add(o8);
         update opplist;
         
         opplist.clear();
         
         Opportunity o6 = new Opportunity(ID = o1.ID);
         o6.StageName = 'Revised Quote Submission';
         opplist.add(o6);
         
         Opportunity o7 = new Opportunity(ID = o.ID);
         o7.StageName = 'Reciept of PO/Submission of OA-ClosedWon';
         opplist.add(o7);

         update opplist;
         
         opplist.clear();
         
         Opportunity o9 = new Opportunity(ID = o.ID);
         o9.RecordTypeID = rec.get('MBA').getRecordTypeId();
         o9.OwnerID = u.ID;
         opplist.add(o9);
         
         update opplist;
        
		//<T01>
		 Task objTask = new Task();
         objTask.Subject = 'Test Subject';
         objTask.WhatID = o.ID;
         insert objTask; 
		//</T01>        
         
         Task t = [select ID from Task where WhatID  =: o.ID limit 1];
         t.Status = 'Completed';
         update t;
         
        oppCheckRecursive opp = new oppCheckRecursive();
        opp.dummyclass();
    }
}