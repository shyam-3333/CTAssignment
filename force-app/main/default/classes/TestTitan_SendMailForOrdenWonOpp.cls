@isTest
public class TestTitan_SendMailForOrdenWonOpp {

    static testMethod void TestTitan_SendMailForOrdenWonOpp() {
    
        Test.startTest();
        
        List<RecordType> lstreco = [select name,id from RecordType where Sobjecttype='Account' and name = 'MBA'];
        Account acc =new Account();
        acc.RecordTypeId= lstreco[0].Id;
        acc.Name='TestAccount';
        acc.Account_SAP_Id__c = '1234567';
        acc.Financial_Stability_Risk__c = 'High';
        acc.Financial_Stability_Risk_Details__c = 'Test';
        acc.Payment_Structure_Collection_Risk__c = 'High';
        acc.Payment_Structure_Collection_Risk_Detail__c = 'Test';
        acc.Country_Specific_Statutory_Risk__c  = 'High';
        acc.Country_Specific_Statutory_Risk_Details__c = 'Test';
        acc.Service_Availability_Risk_Other_Countrie__c = 'High';
        acc.Service_Availability_Risk_Details__c = 'Test';
      
        insert acc;
      
        List<RecordType> lstropp = [select name,id from RecordType where Sobjecttype='Opportunity'];
        Opportunity opp = new Opportunity();
        lstropp[0].Name ='MBA';
        opp.Name = 'Test';
        opp.AccountId = acc.Id;
        opp.Type = 'New Opportunity';
        opp.Region_Picklist__c='South';
        opp.Amount=100.00;
        opp.CloseDate=System.today();
        opp.StageName = 'Order won';
        opp.Reason__c='Lost on cost';
        opp.Project_Type__c='Domestic';
        opp.Customer_Type__c='New';
        opp.Expected_Machine_Dispatch_Date__c = Date.today();
        opp.Titan_OrderWonDate__c = Date.today().adddays(-3);
        
        
        insert opp;
        
        String  strUserEmail ='mohammad.naved@kvpcorp.com';
        String strOpportunityName = opp.name;
        String strOpportunityTrackId =opp.Opportunity_ID__c ; 
        string strEmail;
        strEmail = 'ABC';
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          
        List<String> sendTo = new List<String>();
        
        sendTo.add('aamir.khan@kvpcorp.com');
        
        mail.setToAddresses(sendTo);
        system.debug('@@@Opp Id:'+opp.id);
        //mail.setTargetObjectId(Opp.Id);
         
        mail.setReplyTo('aamir@kvpcorp.com');
        mail.setSenderDisplayName('KVP Business');
          
        mail.setSubject('URGENT BUSINESS PROPOSAL');
        String body = 'Dear ';
        
        List<String> ccTo = new List<String>();
        ccTo.add('aamir.khan@kvpcorp.com');
        mail.setCcAddresses(ccTo);
         
        mail.setHtmlBody(body);
        mails.add(mail);
          
       
        
        Titan_SendMailForOrdenWonOpp obj = new Titan_SendMailForOrdenWonOpp ();
        Database.executeBatch(obj);
        
        Messaging.sendEmail(mails);
        Test.stopTest();
        
    }
        
}