Public Class BD_Reports_ExistingAccounts{
    Public List<Task> ExistingAccount{get;set;}
    Public List<Task> GlobalAccount{get;set;}
    Public List<Task> BDActivities{get;set;}
    Public List<Opportunity> NewOpportunity{get;set;}
    Public List<Investments_Followup__c> InvestmentFollow{get;set;}
    Public String name{get;set;}
    Public String ContactName{get;set;}
    Public String ConName{get;set;}
    Public String Con1Name{get;set;}
    Set<Id> SetAccountId = new Set<Id>();
    Set<Id> SetAccId = new Set<Id>();
    Set<Id> SetAcctId = new Set<Id>();
    Set<Id> SetAcct1Id = new Set<Id>();
    public Map<id,contact> contactMap{get;set;}
    public set<String> Names{get;set;}
    public set<id> taskData{get;set;}
    public List<Task> TaskListData{get;set;}
    public List<Task> TaskForGlobalData{get;set;}
    public Map<id, Account> mapAcc{get;set;}
    public Map<id,Account> mapAccInvestment{get;set;}
    public Map<id,Investments_Followup__c> mapTask{get;set;}
    public set<id> InvestmentId{get;set;}
    public set<id> accountDataSet{get;set;}
    public List<Account> accountForExistingData{get;set;}
    public List<Account> accountForGlobalData{get;set;}
    public Map<id,Task> mapDataForAccount{get;set;}
    
    
    public BD_Reports_ExistingAccounts(BD_Reports_NewLead controller) 
    {
        //Existing Accounts/Customers
        
        TaskListData=new List<Task>();
        mapDataForAccount=new Map<id,Task>();
        accountDataSet=new set<id>();
        accountForExistingData=new List<Account>();
        accountForGlobalData=new List<Account>();
        TaskForGlobalData=new List<Task>();
        taskData=new set<id>();
        TaskListData=[select AccountId,subject,id from Task where createddate=LAST_N_DAYS:7 and status!='Completed' and AccountId!=null and subject!=null and Account.recordtype.name='MBA' and  Id!=null ];
        for(task T:TaskListData)
        {
            accountDataSet.add(t.AccountId);
            taskData.add(t.id);
            //mapDataForAccount.put(t.AccountId,t);
        }
        //accountForExistingData=[select id,name,industry,BillingCity,BillingState,(select AccountId,subject,ActivityDate from tasks where createddate=LAST_N_DAYS:7 and AccountId!=null and subject!=null and Account.recordtype.name='MBA' and id!=null limit 1), (select id,name from contacts order by createddate limit 1),Region__c,state__c,Product_Category__c,Lead_Source__c,Description from account where createddate!=today and recordType.name='MBA' and id in:accountDataSet ];
        
         accountForExistingData=[select id,name,industry,BillingCity,Competitor_Info__c,BillingState,BillingCountry,(select AccountId,subject,ActivityDate from tasks where createddate=LAST_N_DAYS:7 and AccountId!=null and subject!=null and Account.recordtype.name='MBA' and id!=null and id in:taskData order by createddate desc limit 1), (select id,name from contacts order by createddate desc limit 1),Region_Picklist__c,state__c,Product_Category__c,Lead_Source__c,Description from account where createddate!=today and createddate!=LAST_N_DAYS:7 and recordType.name='MBA' and id in:accountDataSet ];
        
        
        /*
        name = '';
        ExistingAccount = [Select t.Account.Id,t.createddate,t.Account.Competitor_Info__c, t.Account.Name, t.Account.Industry, t.Account.Region__c, t.Account.Product_Category__c, 
                           t.Account.Lead_Source__c, t.Account.BillingState, t.Account.BillingCity,t.Subject, t.ActivityDate,t.Description From Task t where t.createddate = LAST_N_DAYS:7
                           AND t.Account.RecordType.Name ='MBA' and t.Account.createddate!=today Order By t.CreatedDate DESC Limit 1];
        if(!ExistingAccount.isEmpty())
        {
            for(Task t : ExistingAccount){
                SetAccountId.add(t.AccountId);
            }
        }
        List<Contact> lstContact = [ Select Id,Name,AccountId from contact where AccountId IN : SetAccountId Order By CreatedDate ASC Limit 1];
        if(lstContact.size()>0){
            name = lstContact[0].Name; 
        }
        */
        
        
        //Global Accounts/Customers
       /* ContactName = '';
        GlobalAccount = [Select t.Account.Id,t.createddate, t.Account.Name, t.Account.Industry, t.Account.Region__c, t.Account.Product_Category__c,
                         t.Account.Lead_Source__c, t.Account.BillingState, t.Account.BillingCity,t.Subject, t.ActivityDate,t.Description,t.Account.Competitor_Info__c From Task t where t.createddate = LAST_N_DAYS:7
                         AND t.Account.RecordType.Name ='MBA' AND t.Account.BillingCountry !='INDIA' Order By t.CreatedDate DESC Limit 1];
        if(!GlobalAccount.isEmpty()){
            for(Task t : GlobalAccount){
                SetAccId.add(t.AccountId);
            }
        }
        List<Contact> lstCon = [ Select Id,Name,AccountId from contact where AccountId IN : SetAccId Order By CreatedDate ASC Limit 1];
        if(lstCon.size()>0){
            ContactName = lstCon[0].Name;  
        }  */
        
         accountForGlobalData=[select id,name,industry,BillingCity,BillingState,BillingCountry,(select AccountId,subject,ActivityDate from tasks where createddate=LAST_N_DAYS:7 order by createddate desc limit 1 ), (select id,name from contacts order by createddate desc limit 1),Region_Picklist__c,state__c,Product_Category__c,Lead_Source__c,Description,Competitor_Info__c from account where createddate!=today and createddate!=LAST_N_DAYS:7 and recordType.name='MBA' and billingCountry!=null and billingCountry!='India' and id in:accountDataSet ];
        
        
        //New Opportunity
        ConName = '';
        contactMap=new Map<id,contact>();
        /*
        NewOpportunity = [Select id,Account.Id,Name,Account.Industry,Type,RFQ_Received_Date_Date__c,Strategic_Importance__c,RFQ_Reference__c,Comments__c,AccountId,Account.Name,
                          Account.BillingCity,Account.BillingState,Region_Picklist__c,Account.Region__C from Opportunity where CreatedDate=Last_n_days:7 AND Business_Division_Used__c='MBA' and (Recordtype.name='Allocated Record Type' or RecordType.name='Await Feedback Record Type' or Recordtype.name='Initial Record type' or RecordType.name='MBA')];
        if(!NewOpportunity.isEmpty()){
            for(Opportunity o : NewOpportunity){
                SetAcctId.add(o.AccountId);
            }
        }
        List<Contact> lstConta = [ Select Id,Name,AccountId from contact where AccountId IN : SetAcctId Order By CreatedDate ASC Limit 1];
        if(lstConta.size()>0){
            ConName = lstConta[0].Name; 
            
        } */
        
        NewOpportunity = [Select id,Name,Account.Industry,Type,RFQ_Received_Date_Date__c,Strategic_Importance__c,RFQ_Reference__c,Comments__c,AccountId,Account.Name,
                          Account.BillingCity,Account.BillingState,Region_Picklist__c,Account.Region_Picklist__c from Opportunity where CreatedDate=LAST_N_DAYS:7 AND Business_Division_Used__c='MBA' and (Recordtype.name='Allocated Record Type' or RecordType.name='Await Feedback Record Type' or Recordtype.name='Initial Record type' or RecordType.name='MBA' or RecordType.name='Layout Record Type')];
System.debug('Opportunity size here='+NewOpportunity.size());  
if(!NewOpportunity.isEmpty()){
            for(Opportunity o : NewOpportunity){
                SetAcctId.add(o.AccountId);
            }
        }
System.debug('set Size here='+setAcctId.size());
       
     mapAcc = new Map<id,Account>([SELECT id, name,(select id,name,AccountId from contacts order by createddate asc limit 1) FROM Account WHERE Id IN : setAcctId]);
     
        // Investment Followup
        Con1Name = '';
        InvestmentFollow=[Select i.Region__c, i.Organisation_Name__c,Opportunity__r.AccountId,Opportunity__r.Account.name,Opportunity__r.Account.Region_Picklist__c, i.Opportunity__r.Id, i.Opportunity__r.Name, i.Name, i.Industry__c, i.CreatedDate, i.Comments__c, i.Amount__c, i.Activity_Date__c From Investments_Followup__c i
                          where CreatedDate=LAST_N_DAYS:7 AND (i.Opportunity__r.RecordType.Name='MBA' or i.Opportunity__r.RecordType.Name='Allocated Record Type' or i.Opportunity__r.RecordType.Name='Await Feedback Record Type' or i.Opportunity__r.RecordType.Name='Initial Record type' or i.Opportunity__r.RecordType.Name='Layout Record type' )  ];
        If(!InvestmentFollow.isEmpty())
        {
            for(Investments_Followup__c ins :InvestmentFollow)
            {
                SetAcct1Id.add(ins.Opportunity__r.AccountId);
               
            }
        }
       
        mapAccInvestment=new Map<id,Account>([SELECT id, name,(select id,name,AccountId from contacts order by createddate desc limit 1) FROM Account WHERE Id IN : setAcct1Id]);
                      
       /* List<Contact> lstCon1 = [ Select Id,Name,AccountId from contact where AccountId IN : SetAcct1Id Order By CreatedDate ASC Limit 1];
        if(lstCon1.size()>0){
            Con1Name = lstCon1[0].Name; 
            
        } */
        
        // BD Activities
        BDActivities = [Select t.WhoId, t.WhatId,t.what.name, t.Subject, t.Id,t.Revised_Date__c, t.Description, t.CreatedDate,t.Completed_Date_del__c, t.ActivityDate,t.Owner.name From Task t  where CreatedDate=LAST_N_DAYS:7 AND  (t.WhatId!= null or t.whoId!= null) AND (t.what.RecordType.name='MBA' or t.who.recordtype.name='MBA' )  order by createddate desc];
    }
}