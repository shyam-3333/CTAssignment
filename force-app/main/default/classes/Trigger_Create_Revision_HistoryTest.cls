/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister) 	11/27/2019   T01   Test Class Failure Fix 
*/
@isTest
public class Trigger_Create_Revision_HistoryTest {
    public static testMethod void checkRevHostory(){
        
        TriggerStatus__c triggerStat = new TriggerStatus__c(); //insert custom setting data
        triggerStat.Name =  'OpportunityTrigger';
        triggerStat.Active__c = true;
        insert triggerStat;
        //checkRecursive cr = new
        
        checkRecursive.run=true;
        
       List<User> lstUser = new List<User>();//<T01>
        User u1 = new User();
        lstUser=[select Id from User  WHERE UserRole.Name like '%Electrical%' and Name='Arun Balasubramaniam S' limit 1];
        if(lstUser.size() > 0){
            u1 = lstUser.get(0);
        }else{
            u1= TestDataFactory.getElectricalRoleUser();
        }
        User u2 = new User();
        lstUser=[select Id from User  WHERE UserRole.Name like  '%Mechanical%' and Name='Kalidass S' limit 1];
        if(lstUser.size() > 0){
            u2 = lstUser.get(0); 
        }else{
            u2= TestDataFactory.getMechanicalRoleUser();
        }//</T01>
        User u = new User();
        // u = [select Id from User  limit 1];
        u.firstName = 'vinoth';
        u.LastName = 'kumar';
        u.Alias = 'vino';
        u.Email = 'vinoth.kumar@kvpcorp.com';
        u.Username = 'vinoth.kumar@abc.comabc';
        u.CommunityNickname = 'vin';
        u.UserRole =[select id from UserRole limit 1];	
        u.ProfileId = [select id from Profile limit 1].id;
        u.EmailEncodingKey = 'UTF-8';
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.LocaleSidKey = 'en_US';
        u.LanguageLocaleKey = 'en_US';
        u.CurrencyIsoCode = 'INR';
        insert u;
        
        RecordType rt = [select Id,name from RecordType where Name ='MBA' and SobjectType = 'Opportunity'];  
        RecordType rt1 = [select Id,name from RecordType where Name ='MBA Service' and SobjectType = 'Cost_Tracking__c']; 
        
        checkRecursive.run=true;
        Account acc = new Account();
        acc.name = 'Umesh Mor';
        acc.Type = 'Customer';
        acc.Ownership__c    =    'Public Ltd';
        //acc.CurrencyIsoCode = 'Indian Rupee';
        acc.Company_Presence__c = 'Domestic';
        acc.Strategic_Account__c = 'Yes';
        acc.Account_Priority__c = 'Very High';
        acc.Financial_Stability_Risk__c    =    'Yes';
        acc.Payment_Structure_Collection_Risk__c    =    'Yes';
        acc.Country_Specific_Statutory_Risk__c = 'Yes';
        acc.Service_Availability_Risk_Details__c    =    'None';
        acc.Service_Availability_Risk_Other_Countrie__c   = 'High';  
        acc.Industry = 'Automotive';
        acc.Lead_Source__c = 'Internet';
        insert acc;
        
        checkRecursive.run=true;
        Opportunity opp = new Opportunity();
        opp.Account = acc;
        opp.Name='CodeEnvision';
        opp.Total_Invoice_Value__c=2355;
        opp.TurnOver__c= 2566;
        opp.Revision_Number__c = 420;
        opp.Customer_Type__c = 'New';
        opp.Amount=9090;
        //opp.Business_Division_Used__c='MBA';
        opp.Project_Type__c ='Domestic';
        opp.Type='New Opportunity';
        
        opp.Expected_Machine_Dispatch_Date__c=System.Today();
        opp.CloseDate=System.Today();
        opp.Member1__c    =    u2.Id;
        opp.Member2__c    =    u1.Id;
        opp.StageName    =     'Under Negotiation';
        opp.recordTypeId    =    rt.Id;
        insert opp;
        checkRecursive.run=true;
        CurrencyType ct = new CurrencyType();
        ct = [Select IsoCode,ConversionRate from CurrencyType where IsoCode !='INR' limit 1];
        
        Cost_Tracking__c Costnew = new Cost_Tracking__c();
        costnew.Opportunity__c = opp.Id;
        costnew.Release_Version__c= 'release420';
        insert costnew;
        
        checkRecursive.run=true;
        system.debug('**************test*****************'+checkRecursive.run);
        opportunity opr1 = new opportunity();
        opr1.id = opp.id;
        opr1.StageName = 'Under Negotiation';
        update opr1;
        checkRecursive.run=true;
        system.debug('**************after opp test*****************'+checkRecursive.run);
        
        
    }
    
    public static testMethod void checkRevHostory2(){
        //checkRecursive cr = new
        
        TriggerStatus__c triggerStat = new TriggerStatus__c(); //insert custom setting data
        triggerStat.Name =  'OpportunityTrigger';
        triggerStat.Active__c = true;
        insert triggerStat;
        checkRecursive.run=true;
        
        List<User> lstUser = new List<User>();//<T01>
        User u1 = new User();
        lstUser=[select Id from User  WHERE UserRole.Name like '%Electrical%' and Name='Arun Balasubramaniam S' limit 1];
        if(lstUser.size() > 0){
            u1 = lstUser.get(0);
        }else{
            u1= TestDataFactory.getElectricalRoleUser();
        }
        User u2 = new User();
        lstUser=[select Id from User  WHERE UserRole.Name like  '%Mechanical%' and Name='Kalidass S' limit 1];
        if(lstUser.size() > 0){
            u2 = lstUser.get(0); 
        }else{
            u2= TestDataFactory.getMechanicalRoleUser();
        }//</T01>
        
        RecordType rt = [select Id,name from RecordType where Name ='MBA' and SobjectType = 'Opportunity'];  
        RecordType rt1 = [select Id,name from RecordType where Name ='MBA Service' and SobjectType = 'Cost_Tracking__c']; 
        
        checkRecursive.run=true;
        Account acc = new Account();
        acc.name = 'Umesh Mor';
        acc.Type = 'Customer';
        acc.Ownership__c    =    'Public Ltd';
        //acc.CurrencyIsoCode = 'Indian Rupee';
        acc.Company_Presence__c = 'Domestic';
        acc.Strategic_Account__c = 'Yes';
        acc.Account_Priority__c = 'Very High';
        acc.Financial_Stability_Risk__c    =    'Yes';
        acc.Payment_Structure_Collection_Risk__c    =    'Yes';
        acc.Country_Specific_Statutory_Risk__c = 'Yes';
        acc.Service_Availability_Risk_Details__c    =    'None';
        acc.Service_Availability_Risk_Other_Countrie__c   = 'High';  
        acc.Industry = 'Automotive';
        acc.Lead_Source__c = 'Internet';
        insert acc;
        
        checkRecursive.run=true;
        Opportunity opp = new Opportunity();
        opp.Account = acc;
        opp.Name='CodeEnvision';
        opp.Total_Invoice_Value__c=2355;
        opp.TurnOver__c= 2566;
        opp.Revision_Number__c = 420;
        opp.Customer_Type__c = 'New';
        opp.Amount=9090;
        //opp.Business_Division_Used__c='MBA';
        opp.Project_Type__c ='Domestic';
        opp.Type='New Opportunity';
        
        opp.Expected_Machine_Dispatch_Date__c=System.Today();
        opp.CloseDate=System.Today();
        opp.Member1__c    =    u2.Id;
        opp.Member2__c    =    u1.Id;
        opp.StageName    =     'Revised Quote Submission';
        opp.recordTypeId    =    rt.Id;
        insert opp;
        checkRecursive.run=true;
        CurrencyType ct = new CurrencyType();
        ct = [Select IsoCode,ConversionRate from CurrencyType where IsoCode !='INR' limit 1];
        
        Cost_Tracking__c Costnew = new Cost_Tracking__c();
        costnew.Opportunity__c = opp.Id;
        costnew.Release_Version__c= 'release420';
        insert costnew;
        
        checkRecursive.run=true;
        system.debug('**************test*****************'+checkRecursive.run);
        opportunity opr1 = new opportunity();
        opr1.id = opp.id;
        opr1.StageName = 'Under Negotiation';
        update opr1;
        checkRecursive.run=true;
        system.debug('**************after opp test*****************'+checkRecursive.run);
        opp.Reason__c = 'Lost on cost';
        opp.Temp_amount__c = 10000;
        opp.Region_Picklist__c = 'South';
        opp.Email__c = 'vinoth.kumar@kvpcorp.com';
        Opp.Regret_Remarks__c = 'Regret remarks';
        opp.StageName    =     'Opportunity Lost';
        update opp;
        
    }
    
}