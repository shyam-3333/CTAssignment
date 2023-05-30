@istest
public class 
 {
    
    
    @istest
    public static void fieldUpdate_Test(){
        // Create test data
        Account acc1= New Account ();
        acc1.name='TestAccount';
        acc1.Recipient_Email_Address__c='abc@xyz.com';
        acc1.Customer_Primary_Contact__c='abc';
        
        Insert acc1;
        
        Account acc2= New Account ();
        acc2.name='TestAccount';
        acc2.Recipient_Email_Address__c='';
        
        Insert acc2;
        
        Contact con= New Contact();
        con.Lastname='TestContacts';
        con.Email='test@email.com';
        con.AccountId= acc1.Id;
        con.Primary_Contact__c=true;
        
        Insert con;
        
        // Call the method to be tested
        
        test.startTest();
        String errorMessage1 = EV_AddEmailAddressController.fieldUpdate(acc1.Id);
        
        String errorMessage2 = EV_AddEmailAddressController.fieldUpdate(acc2.Id);  
        test.stopTest();  
        
        // Perform assertions
        //System.assertEquals('Please enter recipient email address', errorMessage1 );
       //System.assertEquals(, errorMessage2);
            
            }
    @istest
    public static void sendVerificationTest(){
        
        // Create test data
        Account testAcc = new Account(Name = 'Test Account');
        Insert testAcc;
        
        String otherEmails1 = 'test1@abc.com, test2@xyz.com';
        
        String otherEmails2 = 'test1abc.com, test2@abc';
        
        // Call the method to be tested
        Test.startTest();
        Boolean result1 = EV_AddEmailAddressController.sendVerification(otherEmails1, testAcc.Id);
        
        Boolean result2 = EV_AddEmailAddressController.sendVerification(otherEmails2, testAcc.Id);
        Test.stopTest();
        
        // Perform assertions
        
        System.assertEquals(true, result1, 'Result should be true');
        System.assertEquals(false, result2, 'Result should be false');
    }
}