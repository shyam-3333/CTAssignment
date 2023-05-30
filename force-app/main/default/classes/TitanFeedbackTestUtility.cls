/*      
@Name                  TitanFeedbackTestUtility
@Author                Gauri
@Version               1.0
@CreatedDate           16/9/2022
@UsedBy                
@Description           Utility Class With Resusable methods to create test data
@Changes
UserId           | Author-Email                    | Date      | Comment
=================|====================================|===========|=========
|  |    |
*/

public class TitanFeedbackTestUtility {
    /* @Description Method to instantiate and populate/create the account record
@param	accountName DESCRIPTION: accepts string value to set the account name
@param	insertRecord	DESCRIPTION: accepts boolean value to determine whether the test record needs to be inserted or not
@return Account
*/
    public static Account createAccount(String accountName, Boolean insertRecord)
    {
        Account acc = new Account();
        acc.name = accountName;
        if(insertRecord)
        {
            insert acc;
        }
        return acc;
    }
    
    /* @Description Method to instantiate and populate/create the contact record
@param	lastName DESCRIPTION: accepts string value to set the contact's last name
@param	accountId DESCRIPTION: accepts Account record id to which the contact needs to be linked
@param	insertRecord	DESCRIPTION: accepts boolean value to determine whether the test record needs to be inserted or not
@return Contact
*/
    public static Contact createContact(String lastName, Id accountId, Boolean insertRecord)
    {
        Contact con=new Contact();
        con.FirstName='test';
        con.LastName=lastName;
        con.MobilePhone='1234567898';
        con.Email='test@gmail.com';
        con.Designation__c='test';
        con.AccountId=accountId;
        if(insertRecord)
        {
            insert con;
        }
        return con;
    }
    
    /* @Description Method to instantiate and populate/create the opportunity record
@param	opp DESCRIPTION: accepts opportunity record
@param	insertRecord	DESCRIPTION: accepts boolean value to determine whether the test record needs to be inserted or not
@return Opportunity
*/
    public static Opportunity createOpportunity(Opportunity opp, Boolean insertRecord)
    {
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('MBA').getRecordTypeId();
        opp.CloseDate = system.today();
        opp.StageName = 'Under-Study';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Amount=10000;
        opp.Type='Tools & Fixtures';
        if(insertRecord)
        {
            insert opp;
        }
        return opp;
    }
    
    /* @Description Method to generate random user name that makes username unique while inserting a user record
@return String
*/
    public static String generateRandomUserName() {
        return UserInfo.getOrganizationId() + System.currentTimeMillis() + '@test.com';
    }
    
    /* @Description Method to instantiate and populate/create the opportunity record
@param	userName DESCRIPTION: accepts string to set as username
@param	profileName	DESCRIPTION: accepts string (valid profile name) to set profile id
@return User
*/
    public static User createUser(String userName, String profileName) {
        return new User (
            ProfileID = [Select Id From Profile Where Name = :profileName].id,
            EmailEncodingKey = 'ISO-8859-1',
            LanguageLocaleKey = 'en_US',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            FirstName = 'first',
            LastName = 'last',
            Username = userName,
            Country = 'India',
            Alias = 'testusr',
            Email = 'testuser@test.org',
            IsActive = true
        );
    }
}