public class BD_Reports_ExistingAccounts1 
{
  
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
    
    public BD_Reports_ExistingAccounts1(BD_Reports_NewLead1 controller) {
        //Existing Accounts/Customers
        name = '';
        ExistingAccount = [Select t.Account.Id,t.createddate, t.Account.Name, t.Account.Industry, t.Account.Region_Picklist__c, t.Account.Product_Category__c,t.Account.Competitor_Info__c,
                           t.Account.Lead_Source__c, t.Account.BillingState, t.Account.BillingCity,t.Subject, t.ActivityDate,t.Description From Task t where  t.CreatedDate >= 2015-12-07T00:00:00Z AND 
                           t.CreatedDate <= 2015-12-12T23:59:59Z 
                           AND t.Account.RecordType.Name ='MBA' Order By t.CreatedDate DESC Limit 1];
        if(!ExistingAccount.isEmpty()){
            for(Task t : ExistingAccount){
                SetAccountId.add(t.AccountId);
            }
        }
        List<Contact> lstContact = [ Select Id,Name,AccountId from contact where AccountId IN : SetAccountId Order By CreatedDate ASC Limit 1];
        if(lstContact.size()>0){
            name = lstContact[0].Name; 
        }
        //Global Accounts/Customers
        ContactName = '';
        GlobalAccount = [Select t.Account.Id,t.createddate, t.Account.Name, t.Account.Industry, t.Account.Region_Picklist__c, t.Account.Product_Category__c,t.Account.Competitor_Info__c, 
                         t.Account.Lead_Source__c, t.Account.BillingState, t.Account.BillingCity,t.Subject, t.ActivityDate,t.Description From Task t where t.CreatedDate >= 2015-12-07T00:00:00Z AND 
                           t.CreatedDate <= 2015-12-12T23:59:59Z 
                         AND t.Account.RecordType.Name ='MBA' AND t.Account.BillingCountry !='INDIA' Order By t.CreatedDate DESC Limit 1];
        if(!GlobalAccount.isEmpty()){
            for(Task t : GlobalAccount){
                SetAccId.add(t.AccountId);
            }
        }
        List<Contact> lstCon = [ Select Id,Name,AccountId from contact where AccountId IN : SetAccId Order By CreatedDate ASC Limit 1];
        if(lstCon.size()>0){
            ContactName = lstCon[0].Name;  
        }  
        
        //New Opportunity
        ConName = '';
        NewOpportunity = [Select id,Account.Id,Name,Account.Industry,Type,RFQ_Received_Date_Date__c,Strategic_Importance__c,RFQ_Reference__c,Comments__c,AccountId,Account.Name,
                          Account.BillingCity,Account.BillingState,Region_Picklist__c,Account.Region_Picklist__c from Opportunity where CreatedDate >= 2015-12-07T00:00:00Z AND 
                           CreatedDate <= 2015-12-12T23:59:59Z  AND  Business_Division_Used__c='MBA' and (Recordtype.name='Allocated Record Type' or RecordType.name='Await Feedback Record Type' or Recordtype.name='Initial Record type' or RecordType.name='MBA')];
        system.debug('opportunity from sandbox='+NewOpportunity);
        if(!NewOpportunity.isEmpty()){
            for(Opportunity o : NewOpportunity){
                SetAcctId.add(o.AccountId);
            }
        }
        List<Contact> lstConta = [ Select Id,Name,AccountId from contact where AccountId IN : SetAcctId Order By CreatedDate ASC Limit 1];
        if(lstConta.size()>0){
            ConName = lstConta[0].Name; 
            
        } 
        
        // Investment Followup
        Con1Name = '';
        InvestmentFollow=[Select i.Region__c, i.Organisation_Name__c,i.Opportunity__r.AccountId, i.Opportunity__r.Id, i.Opportunity__r.Name, i.Name, i.Industry__c, i.CreatedDate, i.Comments__c, i.Amount__c, i.Activity_Date__c From Investments_Followup__c i
                          where  CreatedDate >= 2015-12-07T00:00:00Z AND 
                           CreatedDate <= 2015-12-12T23:59:59Z  AND i.Opportunity__r.RecordType.Name='MBA'];
        If(InvestmentFollow.isEmpty()){
            for(Investments_Followup__c ins :InvestmentFollow){
                SetAcct1Id.add(ins.Opportunity__r.AccountId);
            }
        }
        List<Contact> lstCon1 = [ Select Id,Name,AccountId from contact where AccountId IN : SetAcct1Id Order By CreatedDate ASC Limit 1];
        if(lstCon1.size()>0){
            Con1Name = lstCon1[0].Name; 
            
        } 
        
        // BD Activities
        BDActivities = [Select t.WhoId, t.WhatId, t.Subject, t.Id,t.Revised_Date__c, t.Description, t.CreatedDate,t.Completed_Date_del__c, t.ActivityDate,t.Owner.name From Task t  where  t.CreatedDate >= 2015-12-07T00:00:00Z AND 
                           t.CreatedDate <= 2015-12-12T23:59:59Z  AND  t.WhatId = null AND t.whoId = null];
    }
     public void SomeData()
    {
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void Duplicate()
    {
       
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
     public void Replicate()
    {
     
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void eplicate()
    {
        
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
      public void plicate()
    {
       
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
     public void licate()
    {
        
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void ete()
    {
       
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
      public void ate()
    {
      
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
     public void cate()
    {
        
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void Prest()
    {
         
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void Crest()
    {
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }

    
}