Public Class BD_Reports_ExistingAccounts_Clone{
    public map<string,Integer> ExistingAccountCount{get; set;}
    public map<string,Integer> InvestmentFollowCount{get; set;}
    public map<string,Integer> NewOpportunityCount{get; set;}
    public map<string,Integer> GlobalAccountCount{get;set;}
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
    
    public BD_Reports_ExistingAccounts_Clone(BD_Reports_NewLead_CLONE controller) {
        //Existing Accounts/Customers
        name = '';
        
        ExistingAccount       = new List<Task>();
        ExistingAccountCount  = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0, 'AutomotiveE' => 0, 'AutomotiveH' => 0,'ElectricS' => 0, 'ElectricW' => 0,'ElectricN' => 0,'ElectricE' => 0,'ElectricH' => 0,'FmcgS' => 0, 'FmcgW' => 0,'FmcgN' => 0,'FmcgE' => 0,'FmcgH' => 0,'MedicS' => 0, 'MedicW' => 0,'MedicN' => 0,'MedicE' => 0,'MedicH' => 0,'GenEngS' => 0, 'GenEngW' => 0,'GenEngN' => 0,'GenEngE' => 0,'GenEngH' => 0,'InterProS' => 0, 'InterProW' => 0,'InterProN' => 0,'InterProE' => 0,'InterProH' => 0,'SolarS' => 0, 'SolarW' => 0,'SolarN' => 0,'SolarE' => 0,'SolarH' => 0,'OtherS' => 0, 'OtherW' => 0,'OtherN' => 0,'OtherE' => 0,'OtherH' => 0};
        InvestmentFollowCount = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0,'AutomotiveE' => 0,'AutomotiveH' => 0,'NonAutoS' => 0, 'NonAutoW' => 0,'NonAutoN' => 0,'NonAutoE' => 0,'NonAutoH' => 0};
        NewOpportunityCount   = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0,'AutomotiveE' => 0,'AutomotiveH' => 0,'NonAutoS' => 0, 'NonAutoW' => 0,'NonAutoN' => 0,'NonAutoE' => 0,'NonAutoH' => 0};
        GlobalAccountCount    = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0,'AutomotiveE' => 0,'AutomotiveH' => 0,'NonAutoS' => 0, 'NonAutoW' => 0,'NonAutoN' => 0,'NonAutoE' => 0,'NonAutoH' => 0};
        BD_Reports_NewLead_CLONE obj = new BD_Reports_NewLead_CLONE();
        
        for(Task tsk: [Select t.Account.Id,t.createddate,t.Account.Competitor_Info__c, t.Account.Name, t.Account.Industry, t.Account.Region_Picklist__c, t.Account.Product_Category__c,
                           t.Account.Lead_Source__c, t.Account.BillingState, t.Account.BillingCity,t.Subject, t.ActivityDate,t.Description From Task t where t.createddate = LAST_N_DAYS:7
                           AND t.Account.RecordType.Name ='MBA' Order By t.CreatedDate DESC Limit 1]){
                           
                           ExistingAccount.add(tsk);
                           
                       if(tsk.Account.Industry == IntegrationConstants.Lead_Industry_Automotive){
                         
                            ExistingAccountCount.putall(obj.createCountMap(tsk.Account.Industry,tsk.Account.Region_Picklist__c,ExistingAccountCount));     
                             
                        } 
                        
                        else if(tsk.Account.Industry == IntegrationConstants.Lead_Industry_Elec){
                        
                            ExistingAccountCount.putall(obj.createCountMap('Electric',tsk.Account.Region_Picklist__c,ExistingAccountCount)); 
                            
                        }
                        
                        else if(tsk.Account.Industry == IntegrationConstants.Lead_Industry_FMCG){
                        
                            ExistingAccountCount.putall(obj.createCountMap('Fmcg',tsk.Account.Region_Picklist__c,ExistingAccountCount));
                                
                        }
                        
                        else if(tsk.Account.Industry == IntegrationConstants.Lead_Industry_Medic){
                        
                            ExistingAccountCount.putall(obj.createCountMap('Medic',tsk.Account.Region_Picklist__c,ExistingAccountCount));
                                
                        } 
                        
                        else if(tsk.Account.Industry == IntegrationConstants.Lead_Industry_GenEng){
                         
                            ExistingAccountCount.putall(obj.createCountMap('GenEng',tsk.Account.Region_Picklist__c,ExistingAccountCount));     
                             
                        } 
                        
                        else if(tsk.Account.Industry == IntegrationConstants.Lead_Industry_InterPro){
                         
                            ExistingAccountCount.putall(obj.createCountMap('InterPro',tsk.Account.Region_Picklist__c,ExistingAccountCount));     
                             
                        } 
                        
                         else if(tsk.Account.Industry == IntegrationConstants.Lead_Industry_Solar){
                         
                            ExistingAccountCount.putall(obj.createCountMap('Solar',tsk.Account.Region_Picklist__c,ExistingAccountCount));     
                             
                        }
                        
                        
                        else{
                        
                            ExistingAccountCount.putall(obj.createCountMap('Other',tsk.Account.Region_Picklist__c,ExistingAccountCount));
                            
                        }
                         
                        
                         
                     }
         ExistingAccountCount.putall(obj.countMapTotal(ExistingAccountCount));
         
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
        GlobalAccount = new List<Task>();
        for(Task tsk:[Select t.Account.Id,t.createddate, t.Account.Name, t.Account.Industry, t.Account.Region_Picklist__c, t.Account.Product_Category__c,
                         t.Account.Lead_Source__c, t.Account.BillingState, t.Account.BillingCity,t.Subject, t.ActivityDate,t.Description,t.Account.Competitor_Info__c From Task t where t.createddate = LAST_N_DAYS:7
                         AND t.Account.RecordType.Name ='MBA' AND t.Account.BillingCountry !='INDIA' Order By t.CreatedDate DESC Limit 1]){
                         
                             GlobalAccount.add(tsk);
                             
                       if(tsk.Account.Industry == IntegrationConstants.Lead_Industry_Automotive){
                         
                            GlobalAccountCount.putall(obj.createCountMap(tsk.Account.Industry,tsk.Account.Region_Picklist__c,GlobalAccountCount));     
                             
                        } 
                        
                       
                            
                        else if(!string.isblank(tsk.Account.Industry)){
                        
                            GlobalAccountCount.putall(obj.createCountMap('NonAuto',tsk.Account.Region_Picklist__c,GlobalAccountCount)); 
                            
                        }
                            
                    }                             
                 GlobalAccountCount.putall(obj.countMapTotalUpdate(GlobalAccountCount));        
                       
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
        NewOpportunity = new List<Opportunity>();
        for(Opportunity opp:[Select id,Account.Id,Name,Account.Industry,Type,RFQ_Received_Date_Date__c,Strategic_Importance__c,RFQ_Reference__c,Comments__c,AccountId,Account.Name,
                          Account.BillingCity,Account.BillingState,Account.Region_Picklist__c,Region_Picklist__c from Opportunity where CreatedDate=Last_n_days:7 AND (Recordtype.name='Allocated Record Type' or RecordType.name='Await Feedback Record Type' or Recordtype.name='Initial Record type' or RecordType.name='MBA')])
                             {
                          
                                  NewOpportunity.add(opp);
                                  
                       if(opp.Account.Industry == IntegrationConstants.Lead_Industry_Automotive){
                         
                            NewOpportunityCount.putall(obj.createCountMap('Automotive',opp.Account.Region_Picklist__c,NewOpportunityCount ));     
                             
                        } 
                        
                        else if(!string.isblank(opp.Account.Industry)){
                        
                            NewOpportunityCount.putall(obj.createCountMap('NonAuto',opp.Account.Region_Picklist__c,NewOpportunityCount )); 
                            
                        }
                        
                       
                   }
        NewOpportunityCount .putall(obj.countMapTotalUpdate(NewOpportunityCount )); 
 
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
        InvestmentFollow = new List<Investments_Followup__c>();
        for(Investments_Followup__c invest:[Select i.Region__c, i.Organisation_Name__c,i.Opportunity__r.AccountId, i.Opportunity__r.Id, i.Opportunity__r.Name, i.Name, i.Industry__c, i.CreatedDate, i.Comments__c, i.Amount__c, i.Activity_Date__c From Investments_Followup__c i
                          where CreatedDate=Last_n_days:7 AND (i.Opportunity__r.RecordType.Name='MBA' or i.Opportunity__r.RecordType.Name='Allocated Record Type' or i.Opportunity__r.RecordType.Name='Await Feedback Record Type' or i.Opportunity__r.RecordType.Name='Initial Record type' )]){
                          
                                  InvestmentFollow.add(invest);
                                  
                        if(invest.Industry__c== IntegrationConstants.Lead_Industry_Automotive){
                         
                            InvestmentFollowCount.putall(obj.createCountMap(invest.Industry__c,invest.Region__c,InvestmentFollowCount));     
                             
                        } 
                        
                        else{ //if(!string.isblank(invest.Industry__c))
                        
                            InvestmentFollowCount.putall(obj.createCountMap('NonAuto',invest.Region__c,InvestmentFollowCount)); 
                            
                        }
                        
                       
                   }
        InvestmentFollowCount.putall(obj.countMapTotalUpdate(InvestmentFollowCount)); 
        
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
        BDActivities = [Select t.WhoId, t.WhatId, t.Subject, t.Id,t.Revised_Date__c, t.Description, t.CreatedDate,t.Completed_Date_del__c, t.ActivityDate From Task t  where CreatedDate=Last_n_days:7 AND  t.WhatId = null AND t.whoId = null];
    }
}