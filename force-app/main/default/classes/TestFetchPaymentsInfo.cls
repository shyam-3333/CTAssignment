@isTest(seeAllData=true)
private class TestFetchPaymentsInfo {

    static testMethod void myUnitTest() {
    
    Account ac = new Account();
    ac.Name = 'Kvpcorp';
    ac.Industry='Information Technology';
    ac.Region_Picklist__c='North';
    insert ac;
    
    Standard_Terms_of_Titan__c  stt = new Standard_Terms_of_Titan__c ();
    stt.Name='Rajesh';    
    insert stt;
    
    
    opportunity op=new opportunity();
    op.StageName='Order Closed';
    op.Amount=1234;
    op.StageName='Proforma Invoice';
    op.Name='KvpCorp';
    op.CloseDate=system.Today();
    insert op;
    
   
    Quote qt=new Quote();
    qt.Name='qt1';
    qt.OpportunityId=op.Id;
    qt.Bank_Name__c='AXIS';
    qt.Cheque_Date__c=system.Today();
    qt.Cheque_No__c='A12345';
    qt.Location_of_The_Bank__c='Bangalore';
    qt.RTGS_No__c='A12345';
    qt.Advance_Received__c=0;
    insert qt;
    
    Payment_Tracker__c pt=new Payment_Tracker__c();
    pt.Payment_Type__c='Advance';
    pt.Opportunity__c=op.Id;
    pt.Payment_Mode__c='Cheque';
    pt.Bank_Name__c='City Bank';
    pt.Cheque_Date__c=system.Today();
    pt.Cheque_No__c='A12';
    pt.Location_of_The_Bank__c='Karnataka';
    pt.RTGS_No__c='A12';
    pt.Amount_Recieved__c=0;
    Insert pt;
    
    Payment_Tracker__c pt1=[select Bank_Name__c,Payment_Type__c,Cheque_Date__c,Cheque_No__c,Amount_Recieved__c,Location_of_The_Bank__c,RTGS_No__c from Payment_Tracker__c where Opportunity__c=:op.Id  Limit 1];
   
        
    Quote qt1=[select Bank_Name__c,Cheque_Date__c,Cheque_No__c,Location_of_The_Bank__c,RTGS_No__c,Advance_Received__c from Quote where OpportunityId=:op.Id];
    qt1.Bank_Name__c=pt1.Bank_Name__c;
    qt1.Cheque_Date__c=pt1.Cheque_Date__c;
    qt1.Cheque_No__c=pt1.Cheque_No__c;
    qt1.Location_of_The_Bank__c=pt1.Location_of_The_Bank__c;
    qt1.RTGS_No__c=pt1.RTGS_No__c;
   qt1.Advance_Received__c=pt1.Amount_Recieved__c;
    update qt1;
        
       
    }
}