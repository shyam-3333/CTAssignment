@isTest

private class TaskTest{

    static testMethod void TaskTestMethod() {
         
         Account a = new Account(Name = 'Test for Task Account');
         insert a;
         
         Contact c = new Contact(AccountID = a.ID,LastName = 'Test for Task Contact');
         insert c;
         
         Task t = new Task();
         t.Subject = 'Email: Customer Satisfaction Survey';
         t.Status = 'Completed';
         t.WhoID = c.ID;
         insert t; 
    }
}