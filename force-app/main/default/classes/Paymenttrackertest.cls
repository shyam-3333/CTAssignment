@isTest
public class Paymenttrackertest {
    
    public static testmethod void verifydata(){
        list<Payment_Tracker__c>tracklist = new list<Payment_Tracker__c>();
        new Paymenttrackeremailcontroller().loadDataExcel();
       /* Opportunity opp = new Opportunity();*/

        Test.StartTest();
        Paymenttracker sh1 = new Paymenttracker(); 
        sh1.sendmail();
        String sch = '0 0 23 * * ?';
        system.schedule('Test check', sch, sh1);
        Test.stopTest();
    }

}