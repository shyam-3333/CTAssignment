/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  12/03/2019   	T01
*/
@istest
private class temp_opp_test
{
    @istest public static void testmeth1()
    {
        
        //Profile p = [Select Id from Profile where Name LIKE '%Team member%' limit 1];
        
        //User u = [Select ID from User Where ProfileID =: p.ID AND Alias != 'prakash' AND isActive = true limit 1];
        //User u1 = [Select ID from User Where ProfileID =: p.ID AND Alias != 'prakash' AND ID !=: u.Id  AND isActive = true limit 1];
        
        Account a = new Account(Name = 'Test Account for Test');
        insert a;
        User objUser = TestDataFactory.getMechanicalRoleUser();//<T01>
        User objUser1 = TestDataFactory.getElectricalRoleUser();//<T01>
        Opportunity o = new Opportunity();
        o.Name = 'Test for Opp Test Method';
        //  o.RecordTypeId = rec.get('Initial Record type').getRecordTypeId();
        o.AccountID = a.ID;
        o.Type = 'AMC';
        o.StageName = 'Preliminary Opportunity';
        o.CloseDate = System.Today() + 10;
        o.Member1__c = objUser.Id;
        o.Member2__c = objUser1.Id;
        insert o;
        
        
    }
    
    
}