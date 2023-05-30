@isTest
private class ContactMergeAnonymousUserEmailTest {
@isTest
    private static void ContactMerge(){
        SurveyTaker__c st =  new SurveyTaker__c();
        st.Email__c = 'vinoth@kvp.com';
        insert st;

        Account acc = new Account();
        acc.Name = 'accountName';
        acc.Delivery_Type__c = 'Domestic Supply';
        acc.Industry = 'Services';
        insert acc;
        
        contact Contact = new contact();
        contact.FirstName = 'vinoth';
        Contact.LastName = 'kumar';
        Contact.AccountId = acc.id;
        Contact.MobilePhone = '9784563210';
        Contact.Email = 'vinoth@kvp.com';
        insert Contact;
        
       ContactMergeAnonymousUserEmail.ContactMerge();
    }
    

}