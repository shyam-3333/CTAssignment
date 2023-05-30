/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/27/2019   	T01		T01 - Test Class fix 
*/
@isTest
public class RevisionHistory{
    public static testMethod void checkRevHostory(){
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
        
        
        Opportunity opp = new Opportunity();
        opp.Account = acc;
        opp.Name='CodeEnvision';
        opp.Customer_Type__c = 'New';
        opp.Amount=9090;
        //opp.Business_Division_Used__c='MBA';
        opp.Project_Type__c ='Domestic';
        opp.Type='New Opportunity';
        opp.Expected_Machine_Dispatch_Date__c=System.Today();
        opp.CloseDate=System.Today();
        opp.Member1__c    =    u2.Id;
        opp.Member2__c    =    u1.Id;
        opp.StageName    =     'Preliminary Opportunity';
        opp.recordTypeId    =    rt.Id;
        insert opp;
        
        
        opportunity opr1 = new opportunity();
        opr1.id = opp.id;
        opr1.StageName = 'Under Negotiation';
        update opr1; 
        
    }
    public static testMethod void testingMethod2(){
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
        
        
        Opportunity opp = new Opportunity();
        opp.Account = acc;
        opp.Name='CodeEnvision';
        opp.Customer_Type__c = 'New';
        opp.Amount=9090;
        //opp.Business_Division_Used__c='MBA';
        opp.Project_Type__c ='Domestic';
        opp.Type='New Opportunity';
        opp.Expected_Machine_Dispatch_Date__c=System.Today();
        opp.CloseDate=System.Today();
        opp.Member1__c    =    u2.Id;
        opp.Member2__c    =    u1.Id;
        opp.StageName    =     'Preliminary Opportunity';
        opp.recordTypeId    =    rt.Id;
        insert opp;
        
        
        opportunity opr1 = new opportunity();
        opr1.id = opp.id;
        opr1.StageName = 'Revised Quote Submission';
        update opr1; 
        
    }
    
    public static testMethod void testingMethod3(){
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
        
        
        Opportunity opp = new Opportunity();
        opp.Account = acc;
        opp.Name='CodeEnvision';
        opp.Customer_Type__c = 'New';
        opp.Amount=9090;
        //  opp.Business_Division_Used__c='MBA Services';
        opp.Project_Type__c ='Domestic';
        opp.Type='New Opportunity';
        opp.Expected_Machine_Dispatch_Date__c=System.Today();
        opp.CloseDate=System.Today();
        opp.Member1__c    =    u2.Id;
        opp.Member2__c    =    u1.Id;
        opp.StageName    =     'Preliminary Opportunity';
        opp.recordTypeId    =    rt.Id;
        insert opp;
        
        
        opportunity opr1 = new opportunity();
        opr1.id = opp.id;
        opr1.StageName = 'Re quote';
        opr1.Type='Tools & Fixtures';
        update opr1; 
        
    }
    
}