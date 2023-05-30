/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/27/2019   	T01		T01 - Test Class fix 
*/
@isTest 
public class RFQStudyRecordTypeChange_Test{
    public static testmethod void chechTest()
    {
        Test.StartTest();
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
        acc.Delivery_Type__c = 'Export';
        acc.Company_Type__c = 'OEM';
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
        
        Test.stopTest(); 
        
        RecordType rt2 = [select Id,name from RecordType where Name ='RFQ Record Type' and SobjectType = 'Opportunity'];  
        Opportunity opp2 =new Opportunity();
        opp2.Id= opp.Id;
        opp2.Account = acc;
        opp2.Name='CodeEnvision';
        opp2.Customer_Type__c = 'New';
        opp2.Amount=9090;
        opp2.Project_Type__c ='Domestic';
        opp2.Type='New Opportunity';
        opp2.Expected_Machine_Dispatch_Date__c=System.Today();
        opp2.CloseDate=System.Today();
        opp2.Member1__c    =    u2.Id;
        opp2.Member2__c    =    u1.Id;
        opp2.StageName    =     'RFQ Study';
        opp2.recordTypeId    =    rt2.Id;
        //opp2.RFQ_Reference__c = 'Web';
        opp2.RFQ_Received_Visit_Date__c = System.Today();
        opp2.Feasibility__c = 'Yes';
        opp2.Comments_and_Remarks__c = '';
        opp2.Feasibility_Reasons__c = 'Similar Machine Existing at Cutomer';
        opp2.New_Technology_Experience__c='Low';
        //opp2.Quote_Submitted_Date_Page__c = '';
        opp2.Quote_Type__c = 'Budgetary Quote';
        opp2.Customer_Product_Risk__c= 'Low';
        opp2.Process_Risk__c='Low';
        opp2.Design_Cycle_Time_Risk__c = 'Low';
        opp2.Manufacturability_Risk__c='Low';
        opp2.Lower_Lead_Time_Risk__c = 'Low';
        opp2.Repeat_Possibilities_Same_Account__c='Low';
        opp2.Similar_Project_from_Other_Account__c='Low';
        
        update opp2;
        
        RecordType rt3 = [select Id,name from RecordType where Name ='HidingSubmitButtonBasedOnStageName' and SobjectType = 'Opportunity'];  
        Opportunity opp3 =new Opportunity();
        opp3.Id= opp2.Id;
        opp3.Account = acc;
        opp3.Name='CodeEnvision';
        opp3.Customer_Type__c = 'New';
        opp3.Amount=9090;
        opp3.Project_Type__c ='Domestic';
        opp3.Type='New Opportunity';
        opp3.Expected_Machine_Dispatch_Date__c=System.Today();
        opp3.CloseDate=System.Today();
        opp3.Member1__c    =    u2.Id;
        opp3.Member2__c    =    u1.Id;
        opp3.StageName    =     'Await Customer Feedback(Quote Submitted)';
        opp3.recordTypeId    =    rt3.Id;
        //opp2.RFQ_Reference__c = 'Web';
        opp3.RFQ_Received_Visit_Date__c = System.Today();
        opp3.Feasibility__c = 'Yes';
        opp3.Comments_and_Remarks__c = '';
        opp3.Feasibility_Reasons__c = 'Similar Machine Existing at Cutomer';
        opp3.New_Technology_Experience__c='Low';
        //opp2.Quote_Submitted_Date_Page__c = '';
        opp3.Quote_Type__c = 'Budgetary Quote';
        opp3.Customer_Product_Risk__c= 'Low';
        opp3.Process_Risk__c='Low';
        opp3.Design_Cycle_Time_Risk__c = 'Low';
        opp3.Manufacturability_Risk__c='Low';
        opp3.Lower_Lead_Time_Risk__c = 'Low';
        opp3.Repeat_Possibilities_Same_Account__c='Low';
        opp3.Similar_Project_from_Other_Account__c='Low';
        
        update opp3;
        
        
        
    }
    
}