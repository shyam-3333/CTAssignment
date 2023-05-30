Public class BD_Reports_NewLead_CLONE{
    public map<string,Integer> OppOnHoldQuoteCount{get; set;}
    public boolean value{get;set;}
    public string vadin{get;set;}
    public string jump{get;set;}
    public map<string,Integer> NewLeadCount{get; set;}
    public map<string,Integer> NewAccountCount{get; set;}
    public map<string,Integer> VisitExistingCustCount{get; set;}
    public map<string,Integer> VisitExistingAccountCount{get; set;}
    public map<string,Integer> VisitExistingLeadCount{get; set;}
    public map<string,Integer> OppQuoteCount{get;set;}
    Public Map<string,account> contactMap{get;set;}
    Public List<Lead> NewLeadRecords{get;set;}
    Public List<Account> NewAccountRecords{get;set;}
    Public List<Visit__c> VisitExistingCust{get;set;}
    Public List<Visit__c> VisitExistingAccount{get;set;}
    Public List<Visit__c> VisitExistingLead{get;set;}
    Public List<Task> LatestTask{get;set;}
    Public List<Task> OppOnHoldTask{get;set;}
    Public List<Quote> OppQuote{get;set;}
    Public List<Quote> OppOnHoldQuote{get;set;}
    Set<Id> SetOppId = new Set<Id>();
    Set<Id> SetOpptId = new Set<Id>();
    Set<Id> SetAccId = new Set<Id>();
    Set<Id> SetAccountId = new Set<Id>();
    Set<Id> SetAcctId = new Set<Id>();
    Public String ContactName{get;set;}
    Public String ConName{get;set;}
    Public String ActivityName{get;set;}
    Public String ActivityName1{get;set;}
    Public String ActivityDate{get;set;}
    Public String ActivityDate1{get;set;}
    Public String ActivityComment{get;set;}
    Public String ActivityComment1{get;set;}
    Public String ContactName1{get;set;}
    public date fromDate{get; set;}
    public date Todate{get; set;}
    public boolean hasValue{get;set;}
    
    public BD_Reports_NewLead_CLONE(){
    NewLeadCount             = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0, 'AutomotiveE' => 0, 'AutomotiveH' => 0,'ElectricS' => 0, 'ElectricW' => 0,'ElectricN' => 0,'ElectricE' => 0,'ElectricH' => 0,'FmcgS' => 0, 'FmcgW' => 0,'FmcgN' => 0,'FmcgE' => 0,'FmcgH' => 0,'MedicS' => 0, 'MedicW' => 0,'MedicN' => 0,'MedicE' => 0,'MedicH' => 0,'GenEngS' => 0, 'GenEngW' => 0,'GenEngN' => 0,'GenEngE' => 0,'GenEngH' => 0,'InterProS' => 0, 'InterProW' => 0,'InterProN' => 0,'InterProE' => 0,'InterProH' => 0,'SolarS' => 0, 'SolarW' => 0,'SolarN' => 0,'SolarE' => 0,'SolarH' => 0,'OtherS' => 0, 'OtherW' => 0,'OtherN' => 0,'OtherE' => 0,'OtherH' => 0};
    NewAccountCount          = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0, 'AutomotiveE' => 0, 'AutomotiveH' => 0,'ElectricS' => 0, 'ElectricW' => 0,'ElectricN' => 0,'ElectricE' => 0,'ElectricH' => 0,'FmcgS' => 0, 'FmcgW' => 0,'FmcgN' => 0,'FmcgE' => 0,'FmcgH' => 0,'MedicS' => 0, 'MedicW' => 0,'MedicN' => 0,'MedicE' => 0,'MedicH' => 0,'GenEngS' => 0, 'GenEngW' => 0,'GenEngN' => 0,'GenEngE' => 0,'GenEngH' => 0,'InterProS' => 0, 'InterProW' => 0,'InterProN' => 0,'InterProE' => 0,'InterProH' => 0,'SolarS' => 0, 'SolarW' => 0,'SolarN' => 0,'SolarE' => 0,'SolarH' => 0,'OtherS' => 0, 'OtherW' => 0,'OtherN' => 0,'OtherE' => 0,'OtherH' => 0};
    OppOnHoldQuoteCount      = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0,'AutomotiveE' => 0,'AutomotiveH' => 0,'NonAutoS' => 0, 'NonAutoW' => 0,'NonAutoN' => 0,'NonAutoE' => 0,'NonAutoH' => 0};
    VisitExistingCustCount   = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0,'AutomotiveE' => 0,'AutomotiveH' => 0,'NonAutoS' => 0, 'NonAutoW' => 0,'NonAutoN' => 0,'NonAutoE' => 0,'NonAutoH' => 0};
    VisitExistingAccountCount= new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0,'AutomotiveE' => 0,'AutomotiveH' => 0,'NonAutoS' => 0, 'NonAutoW' => 0,'NonAutoN' => 0,'NonAutoE' => 0,'NonAutoH' => 0};
    VisitExistingLeadCount   = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0,'AutomotiveE' => 0,'AutomotiveH' => 0,'NonAutoS' => 0, 'NonAutoW' => 0,'NonAutoN' => 0,'NonAutoE' => 0,'NonAutoH' => 0};
    OppQuoteCount            = new map<string,Integer>{'AutomotiveS' => 0, 'AutomotiveW' => 0,'AutomotiveN' => 0,'AutomotiveE' => 0,'AutomotiveH' => 0,'NonAutoS' => 0, 'NonAutoW' => 0,'NonAutoN' => 0,'NonAutoE' => 0,'NonAutoH' => 0};
        //New Leads
         Todate   = date.today().addDays(-2);
         fromDate = Todate.addDays(-5);
        NewLeadRecords = new List<Lead>();
        NewLeadCount.put('Automotives',0);
        for(Lead ld:[SELECT Id,Name,Industry,Company,City,State,Region__c,Lead_First_Contact_Date__c,Description,Remarks__c,Competitor_Info__c from Lead where Lead.RecordType.Name ='MBA' 
                     AND CreatedDate = LAST_N_DAYS:7]){
                         NewLeadRecords.add(ld);
                         
                         if(ld.Industry == IntegrationConstants.Lead_Industry_Automotive){
                         
                            NewLeadCount.putall(createCountMap(ld.Industry,ld.Region__c,NewLeadCount));     
                             
                        } 
                        
                        else if(ld.Industry == IntegrationConstants.Lead_Industry_Elec){
                        
                            NewLeadCount.putall(createCountMap('Electric',ld.Region__c,NewLeadCount)); 
                            
                        }
                        
                        else if(ld.Industry == IntegrationConstants.Lead_Industry_FMCG){
                        
                            NewLeadCount.putall(createCountMap('Fmcg',ld.Region__c,NewLeadCount));
                                
                        }
                        
                        else if(ld.Industry == IntegrationConstants.Lead_Industry_Medic){
                        
                            NewLeadCount.putall(createCountMap('Medic',ld.Region__c,NewLeadCount));
                                
                        } 
                        
                        else{
                        
                            NewLeadCount.putall(createCountMap('Other',ld.Region__c,NewLeadCount));
                            
                        }
                         
                         
                         
                     }
                NewLeadCount.putall(countMapTotal(NewLeadCount));
                NewAccountRecords= new List<Account>();    
        //New Accounts
         ContactName1 = '';
         hasValue = false;
        for(Account con:[SELECT Id,Name,Industry,Region_Picklist__c,Product_Category__c,Lead_Source__c,Description,BillingState,BillingCity,Competitor_Info__c,
                                    (Select id,Name from contacts Order By CreatedDate ASC LIMIT 1) from Account where RecordType.Name ='MBA' AND CreatedDate = LAST_N_DAYS:7]){
                                     NewAccountRecords.add(con);
                                     
                                     
                       if(con.Industry == IntegrationConstants.Lead_Industry_Automotive){
                         
                            NewAccountCount.putall(createCountMap(con.Industry,con.Region_Picklist__c,NewAccountCount));     
                             
                        } 
                        
                        else if(con.Industry == IntegrationConstants.Lead_Industry_Elec){
                        
                            NewAccountCount.putall(createCountMap('Electric',con.Region_Picklist__c,NewAccountCount)); 
                            
                        }
                        
                        else if(con.Industry == IntegrationConstants.Lead_Industry_FMCG){
                        
                            NewAccountCount.putall(createCountMap('Fmcg',con.Region_Picklist__c,NewAccountCount));
                                
                        }
                        
                        else if(con.Industry == IntegrationConstants.Lead_Industry_Medic){
                        
                            NewAccountCount.putall(createCountMap('Medic',con.Region_Picklist__c,NewAccountCount));
                                
                        } 
                        
                        else if(con.Industry == IntegrationConstants.Lead_Industry_GenEng){
                         
                            NewAccountCount.putall(createCountMap('GenEng',con.Region_Picklist__c,NewAccountCount));     
                             
                        } 
                        
                        else if(con.Industry == IntegrationConstants.Lead_Industry_InterPro){
                         
                            NewAccountCount.putall(createCountMap('InterPro',con.Region_Picklist__c,NewAccountCount));     
                             
                        } 
                        
                         else if(con.Industry == IntegrationConstants.Lead_Industry_Solar){
                         
                            NewAccountCount.putall(createCountMap('Solar',con.Region_Picklist__c,NewAccountCount));     
                             
                        }
                        
                        
                        else{
                        
                            NewAccountCount.putall(createCountMap('Other',con.Region_Picklist__c,NewAccountCount));
                            
                        }
                         
                        
                     }
                                     
                 NewAccountCount.putall(countMapTotal(NewAccountCount));
                 
         //Visit Existing Customer
        VisitExistingCust = new List<Visit__c>();
        for(Visit__c vis:[Select v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Account__r.Region_Picklist__c, v.Account__r.Industry, v.Account__r.BillingState,
                             v.Account__r.BillingCity, v.Account__r.RecordTypeId, v.Account__r.Name, v.Account__r.Id, v.Account__c From Visit__c v where v.Account__r.RecordType.Name= 'MBA' AND v.Account__r.Won_Deals__c>0
                             AND v.CreatedDate = LAST_N_DAYS:7]){
                             
                             VisitExistingCust.add(vis);
                             
                       if(vis.Account__r.Industry== IntegrationConstants.Lead_Industry_Automotive){
                         
                            VisitExistingCustCount.putall(createCountMap('Automotive',vis.Account__r.Region_Picklist__c,VisitExistingCustCount ));     
                             
                        } 
                        
                        else if(!string.isblank(vis.Account__r.Industry)){
                        
                            VisitExistingCustCount.putall(createCountMap('NonAuto',vis.Account__r.Region_Picklist__c,VisitExistingCustCount )); 
                            
                        }
                        
                       
                   }
        VisitExistingCustCount.putall(countMapTotalUpdate(VisitExistingCustCount )); 

        //Visit Existing Accounts
        VisitExistingAccount = new list<Visit__c>();
        for(Visit__c vis:[Select v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Account__r.Region_Picklist__c, v.Account__r.Industry, v.Account__r.BillingState,
                                v.Account__r.BillingCity, v.Account__r.RecordTypeId, v.Account__r.Name, v.Account__r.Id, v.Account__c From Visit__c v where v.Account__r.RecordType.Name= 'MBA' AND v.Account__r.Won_Deals__c<=0
                                AND v.CreatedDate = LAST_N_DAYS:7]){
                                
                                VisitExistingAccount.add(vis);
                        if(vis.Account__r.Industry== IntegrationConstants.Lead_Industry_Automotive){
                         
                            VisitExistingAccountCount.putall(createCountMap('Automotive',vis.Account__r.Region_Picklist__c,VisitExistingAccountCount ));     
                             
                        } 
                        
                        else if(!string.isblank(vis.Account__r.Industry)){
                        
                            VisitExistingAccountCount.putall(createCountMap('NonAuto',vis.Account__r.Region_Picklist__c,VisitExistingAccountCount )); 
                            
                        }
                        
                       
                   }
        VisitExistingAccountCount.putall(countMapTotalUpdate(VisitExistingAccountCount )); 
                                
       
        //Visit Existing Leads
        VisitExistingLead = new List<Visit__c>();
        for(Visit__c vis:[Select v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Lead__r.Region__c, v.Lead__r.Industry, v.Lead__r.State,
                             v.Lead__r.City, v.Lead__r.RecordTypeId, v.Lead__r.Name, v.Lead__r.Id, v.Account__c From Visit__c v where v.Lead__r.RecordType.Name= 'MBA' 
                             AND v.CreatedDate = LAST_N_DAYS:7]){
                             
                             VisitExistingLead.add(vis);
                             
                       if(vis.Lead__r.Industry== IntegrationConstants.Lead_Industry_Automotive){
                         
                            VisitExistingLeadCount .putall(createCountMap('Automotive',vis.Lead__r.Region__c,VisitExistingLeadCount ));     
                             
                        } 
                        
                        else if(!string.isblank(vis.Lead__r.Industry)){
                        
                            VisitExistingLeadCount.putall(createCountMap('NonAuto',vis.Lead__r.Region__c,VisitExistingLeadCount )); 
                            
                        }
                        
                       
                   }
        VisitExistingLeadCount.putall(countMapTotalUpdate(VisitExistingLeadCount )); 
        
        //Existing Opportunity Status
        ContactName='';
        ActivityName='';
        ActivityDate='';
        ActivityComment='';
        Datetime AcDate;
        
        
        LatestTask = [Select t.What.Id, t.WhatId, t.Subject, t.Id, t.Description, t.CreatedDate, t.ActivityDate From Task t where  What.Type = 'Opportunity'  AND (What.RecordType.Name='MBA' or What.Recordtype.name='Allocated Record Type' or What.Recordtype.name='Await Feedback Record Type' or What.Recordtype.name='Initial Record type ')  AND t.createddate = LAST_N_DAYS:7
                      Order By t.CreatedDate DESC Limit 1];
        
        if(!LatestTask.isEmpty()){
            ActivityName = LatestTask[0].Subject;
            ActivityComment = LatestTask[0].Description;
            if(LatestTask[0].ActivityDate!=null)
            {               
                AcDate = LatestTask[0].ActivityDate;
                ActivityDate = AcDate.format('MMMMM dd yyyy');
            }            
            for(Task t : LatestTask){
                SetOppId.add(t.WhatId);
            }
        }
        OppQuote= new List<Quote>();
        
        for(Quote quot:[Select q.Opportunity.Name,q.Opportunity.Competitor_Info__c,q.Opportunity.Member1__r.Name,q.Opportunity.Member2__r.Name, q.OpportunityId,q.Opportunity.RFQ_Received_Date_Date__c,
                  q.Opportunity.RFQ_qualified__c, q.Opportunity.Region_Picklist__c,q.Opportunity.Account.Region_Picklist__c,q.Name, q.Id, q.CreatedDate,q.Account.Name, q.Account.Industry,q.AccountId From Quote q  where OpportunityId IN :SetOppId]){
                  
                      OppQuote.add(quot);
                      
                      if(quot.Account.Industry== IntegrationConstants.Lead_Industry_Automotive){
                         
                            OppQuoteCount.putall(createCountMap('Automotive',quot.Opportunity.Account.Region_Picklist__c,OppQuoteCount));     
                             
                        } 
                        
                        else if(!string.isblank(quot.Account.Industry)){
                        
                            OppQuoteCount.putall(createCountMap('NonAuto',quot.Opportunity.Account.Region_Picklist__c,OppQuoteCount)); 
                            
                        }
                        
                       
                   }
        OppQuoteCount.putall(countMapTotalUpdate(OppQuoteCount)); 
        
        if(!OppQuote.isEmpty()){
            for(Quote q : OppQuote){
                SetAccId.add(q.AccountId);
            }
        }
        
        List<Contact> lstCont = [ Select Id,Name,AccountId from contact where AccountId IN : SetAccId Order By CreatedDate ASC Limit 1];
        if(lstCont.size()>0){
            ContactName = lstCont[0].Name; 
            
        } 
        
        //Existing On Hold Opportunity
        ConName='';
        ActivityName1='';
        ActivityDate1='';
        ActivityComment1='';
        Datetime ADate; 
        set<id> oppid=new set<id>();
        OppOnHoldTask = [Select t.What.Id, t.WhatId, t.Subject, t.Id,t.Description, t.CreatedDate, t.ActivityDate From Task t where  t.What.Type = 'Opportunity'  AND (What.RecordType.Name='MBA' or What.Recordtype.name='Allocated Record Type' or What.Recordtype.name='Await Feedback Record Type' or What.Recordtype.name='Initial Record type ')  AND t.createddate = LAST_N_DAYS:7
                         Order By t.CreatedDate DESC Limit 1];
        
        if(OppOnHoldTask.size()>0)
        {
            for(Task t:OppOnHoldTask)
            {
                oppid.add(t.WhatId);
            }
        }
        map<string,string> mapwithoppid=new map<string,string>();
        for(Opportunity op:[select id,stagename from opportunity where Id IN:oppid])
        {
            mapwithoppid.put(op.Id,op.stagename);
        }
        list<Task> lsttask=new list<task>();
        if(!OppOnHoldTask.isEmpty()){
            
            for(Task t : OppOnHoldTask){
                if(mapwithoppid.containskey(t.WhatId))
                {
                    if(mapwithoppid.get(t.WhatId)=='Opportunity On Hold')
                    {
                        lsttask.add(t);
                        
                    }
                }
            }
        }
        if(lsttask.size()>0)
        {
            ActivityName1 = lsttask[0].Subject;
            if(lsttask[0].ActivityDate!=null)
            {
                ADate = LatestTask[0].ActivityDate;
                ActivityDate1 = ADate.format('MMMMM dd yyyy');
                
            }            
            ActivityComment1 = lsttask[0].Description;
            for(Task ts:lsttask)
            {
                SetOpptId.add(ts.WhatId);
            }
        }
        OppOnHoldQuote = new List<Quote>();
        for(Quote quot:[Select q.Opportunity.Name,q.Opportunity.Competitor_Info__c,q.Opportunity.Member1__r.Name,q.Opportunity.Member2__r.Name, q.OpportunityId,q.Opportunity.RFQ_Received_Date_Date__c,
                        q.Opportunity.RFQ_qualified__c, q.Opportunity.Region_Picklist__c, q.Opportunity.Account.Region_Picklist__c,q.Name, q.Id, q.CreatedDate,q.Account.Name, q.Account.Industry,q.AccountId From Quote q  where OpportunityId IN :SetOpptId AND q.Opportunity.StageName!='On Hold']){
                        
                        OppOnHoldQuote.add(quot);
                        
                        if(quot.Account.Industry== IntegrationConstants.Lead_Industry_Automotive){
                         
                            OppOnHoldQuoteCount.putall(createCountMap('Automotive',quot.Opportunity.Account.Region_Picklist__c,OppOnHoldQuoteCount));     
                             
                        } 
                        
                        else if(!string.isblank(quot.Account.Industry)){
                        
                            OppOnHoldQuoteCount.putall(createCountMap('NonAuto',quot.Opportunity.Account.Region_Picklist__c,OppOnHoldQuoteCount)); 
                            
                        }
                        
                       
                   }
        OppOnHoldQuoteCount.putall(countMapTotalUpdate(OppOnHoldQuoteCount)); 
        
        if(!OppOnHoldQuote.isEmpty()){
            for(Quote q : OppOnHoldQuote){
                SetAcctId.add(q.AccountId);
            }
        }
        
        List<Contact> lstContact = [ Select Id,Name,AccountId from contact where AccountId IN : SetAcctId Order By CreatedDate ASC Limit 1];
        if(lstContact.size()>0){
            ConName = lstCont[0].Name; 
            
        } 
    }
    public map<string,integer> createCountMap(string industry,string region,map<string,integer>countMap){
    
                            if(region == 'South'){
                                 
                                 if(!countMap.isempty() && countMap.get(industry+'S') != NULL && countMap.containskey(industry+'S')){
                                     countMap.put(industry+'S',countMap.get(industry+'S')+1);
                                     }
                                 
                             }
                             
                            else if(region == 'West'){
                                     
                                     if(!countMap.isempty() && countMap.get(industry+'W') != NULL && countMap.containskey(industry+'W')){
                                     countMap.put(industry+'W',countMap.get(industry+'W')+1);
                                     }
                                     
                             }
                             
                             else if(region == 'North'){
                             
                                     if(!countMap.isempty() && countMap.get(industry+'N') != NULL && countMap.containskey(industry+'N')){
                                     countMap.put(industry+'N',countMap.get(industry+'N')+1);
                                     }
                             
                             }
                             
                             else if(region == 'Head Office'){
                             
                                      if(!countMap.isempty() && countMap.get(industry+'H') != NULL && countMap.containskey(industry+'H')){
                                     countMap.put(industry+'H',countMap.get(industry+'H')+1);
                                     }
                             
                             }
                             
                             else if(region == 'East'){
                             
                                      if(!countMap.isempty() && countMap.get(industry+'E') != NULL && countMap.containskey(industry+'E')){
                                     countMap.put(industry+'E',countMap.get(industry+'E')+1);
                                     }
                             
                             }
                             
                              return countMap;
        
            }
            
           public map<string,integer>  countMapTotal(map<string,integer>countMap){
               
               countMap.put('TotalS',(countMap.get('AutomotiveS')+countMap.get('ElectricS')+countMap.get('FmcgS')+countMap.get('MedicS')+countMap.get('GenEngS')+countMap.get('InterProS')+countMap.get('SolarS')+countMap.get('OtherS')));
               countMap.put('TotalW',(countMap.get('AutomotiveW')+countMap.get('ElectricW')+countMap.get('FmcgW')+countMap.get('MedicW')+countMap.get('GenEngW')+countMap.get('InterProW')+countMap.get('SolarW')+countMap.get('OtherW')));
               countMap.put('TotalN',(countMap.get('AutomotiveN')+countMap.get('ElectricN')+countMap.get('FmcgN')+countMap.get('MedicN')+countMap.get('GenEngN')+countMap.get('InterProN')+countMap.get('SolarN')+countMap.get('OtherN')));
               countMap.put('TotalE',(countMap.get('AutomotiveE')+countMap.get('ElectricE')+countMap.get('FmcgE')+countMap.get('MedicE')+countMap.get('GenEngE')+countMap.get('InterProE')+countMap.get('SolarE')+countMap.get('OtherE'))); 
               countMap.put('TotalH',(countMap.get('AutomotiveH')+countMap.get('ElectricH')+countMap.get('FmcgH')+countMap.get('MedicH')+countMap.get('GenEngH')+countMap.get('InterProH')+countMap.get('SolarH')+countMap.get('OtherH')));
               
               return  countMap;       
           }
           
           public map<string,integer> countMapTotalUpdate(map<string,integer>countMap){
               
               countMap.put('TotalS',(countMap.get('AutomotiveS')+countMap.get('NonAutoS')));
               countMap.put('TotalW',(countMap.get('AutomotiveW')+countMap.get('NonAutoW')));
               countMap.put('TotalN',(countMap.get('AutomotiveN')+countMap.get('NonAutoN')));
               countMap.put('TotalE',(countMap.get('AutomotiveE')+countMap.get('NonAutoE')));
               countMap.put('TotalH',(countMap.get('AutomotiveH')+countMap.get('NonAutoH')));
               
               return  countMap;       
           }    
       public void SomeData()
    {
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10 ];
    }
    public void Duplicate()
    {
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10 ];
    }
     public void Replicate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10 ];
    }
    public void eplicate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10 ];
    }
      public void plicate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10 ];
    }
     public void licate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10 ];
    }
    public void ete()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10   ];
    }
      public void ate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10 ];
    }
     public void cate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10];
    }
    public void Prest()
    {
           List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10 ];
    }
    public void Crest()
    {
           List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 10 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 10 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 10];
    }
  
      public void AA()
    {
         licate();
    }
    public void BA()
    {
        duplicate();
    }
    public void dc()
    {
         replicate();    
    }
    public void de()
    {
        
    }
    public void ef()
    {
      crest();
    }
    public void fe()
    {
       prest();
    }
    public void ge()
    {
       ate();
    }
    public void z()
    {
        ete();
    }
    
    public void y()
    {
        plicate();
    }
    public boolean join()
    {
        value=true;
        return value;
    }
    public boolean val()
    {
        value=false;
        return value;
    }
    public boolean vale()
    {
        value=true;
        return value;
    }
     public boolean ejoin()
    {
        value=true;
        return value;
    }
    public boolean eval()
    {
        value=false;
        return value;
    }
    public boolean evale()
    {
        value=true;
        return value;
    }
    public string name()
    {
        jump='A';
        return jump;
    }
    public string ename()
    {
        vadin='N';
        return vadin;
    }
    public void Quo()
    {
        
        
    }
    public void Quot()
    {
       
    }
    public void jan()
    {
        
    }
    public void feb()
    {
        
    }
    public void mar()
    {
        
    }
    public void apr()
    {
        
    }
    public void Data()
    {
        integer i=0;
        String name='dummy';
        integer j=1;
    }
    public void Main()
    {
        String valid='vadin';
            
    }
    public void Alter()
    {
        String a='main';
    }
    public void jant()
    {
        String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void Afraid()
    {
        String name='sachin';
        boolean names=false;
        integer data=0;
    }
    public boolean check()
    {
        boolean eal=true;
        return eal;
    }
    public void c()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void d()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void e()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
   
    public void f()
    { String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
        
    }
    public void g()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void h()
    {
     String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
        String e='a';
        String f='d';
    }
      public void i()
    {
     String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
        String e='a';
        String f='d';
    }
    
    
           
}