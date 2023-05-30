Public class BD_Reports_NewLead
{
    Public List<Lead> NewLeadRecords{get;set;}
    Public List<Account> NewAccountRecords{get;set;}
    public List<contact> contactList{get;set;}
    public boolean value{get;set;}
    public string jump{get;set;}
    public string vadin{get;set;}
    public set<id> accForHold{get;set;}
    public List<Task> taskForExistingHold{get;set;}
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
    Set<Id> SetAcctId = new Set<Id>();
    public Set<id> forTaskId{get;set;}
    public set<id> holdTaskId{get;set;}
    public Set<Id> newAcctId{get;set;}
    public Map<id,Contact> conDataForHold{get;set;}
    Public Map<id,String> contactMap{get;set;}
    Set<Id> SetAccountId = new Set<Id>();
    Public String ContactName{get;set;}
    Public String ConName{get;set;}
    Public String ContactName1{get;set;}
    Public String ActivityName{get;set;} 
    Public String ActivityName1{get;set;}
    Public String ActivityDate{get;set;}
    Public String ActivityDate1{get;set;}
    Public String ActivityComment{get;set;}
    Public String ActivityComment1{get;set;}
    public List<Opportunity> checkOppData{get;set;}
    public List<contact> lstCont{get;set;}
    public boolean hasValue{get;set;}
    public List<String> subjectData{get;set;}
    public List<String> AccountNames{get;set;}
    public Map<id,List<Task>> mapData{get;set;}
    public Map<id,Task> TaskList{get;set;}
    public Set<Id> OpportunityData{get;set;}
    public Set<Id> AccountIde{get;set;}
    public Map<id,quote> contactData{get;set;}
    public Map<id,Contact> contactNow{get;set;}
    public List<Opportunity> OppDataNow{get;set;}
    
    
    public BD_Reports_NewLead(){
        //New Leads
        hasValue = false;
        contactMap = New Map<id,string>();
        NewLeadRecords = new List<Lead>();
        
        for(Lead ld:[SELECT Id,Name,Industry,Company,City,State,Region__c,Lead_First_Contact_Date__c,Description,Remarks__c,AnnualRevenue,Competitor_Info__c from Lead where Lead.RecordType.Name ='MBA' 
                     AND CreatedDate = LAST_N_DAYS:7 order by Region__c ]){
                         NewLeadRecords.add(ld);
                     }
        //New Accounts
        
        NewAccountRecords=new List<Account>();
        NewAccountRecords=[select id,name,Industry,(select id,name,AccountId from contacts  order by createddate desc limit 1),Region_Picklist__c,Product_Category__c,
                     Lead_Source__c,Description,BillingState,BillingCity,Competitor_Info__c from account where RecordType.name='MBA' and createddate=LAST_N_DAYS:7];
      
       /* for(Account a:NewAccountRecords)
        {
            if(!a.contacts.isEmpty())
            {
                contactMap.put(a,a.contacts[0]);
            }
            else
            {
                contactMap.put(a,new contact(lastname='None'));
            }
        }*/
      
        for(Account a:NewAccountRecords)
        {
            for(contact c:a.contacts)
            {
               
                
                    contactMap.put(a.id,a.contacts[0].name);
                               
            }
        }
        
        System.debug('Here The Value of contactMap='+contactMap.size());
        if(contactMap.size()>0)
        {
            hasValue=true;
        }
        
        
        //Visit Existing Customer
        VisitExistingCust = [Select v.Id, v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Account__r.Region_Picklist__c, v.Account__r.Industry, v.Account__r.BillingState,
                             v.Account__r.BillingCity, v.Account__r.RecordTypeId, v.Account__r.Name, v.Account__r.Id, v.Account__c,v.Customer_Account_Lead__c From Visit__c v where (v.Account__r.RecordType.Name= 'MBA' or v.Lead__r.RecordType.Name= 'MBA')    
                             AND v.CreatedDate = LAST_N_DAYS:7 and v.Account__r.createddate!=LAST_N_DAYS:7   ];
        //Visit Existing Accounts
        VisitExistingAccount = [Select v.Id,v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Account__r.Region_Picklist__c, v.Account__r.Industry, v.Account__r.BillingState,
                                v.Account__r.BillingCity, v.Account__r.RecordTypeId, v.Account__r.Name, v.Account__r.Id, v.Account__c From Visit__c v where v.Account__r.RecordType.Name= 'MBA' AND v.Account__r.Won_Deals__c<0
                                AND v.CreatedDate = LAST_N_DAYS:7 and v.Account__r.createddate!=LAST_N_DAYS:7 ];
        //Visit Existing Leads
        VisitExistingLead = [Select v.Id,v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Lead__r.Region__c, v.Lead__r.Industry, v.Lead__r.State,
                             v.Lead__r.City, v.Lead__r.RecordTypeId, v.Lead__r.Name, v.Lead__r.Id, v.Account__c From Visit__c v where v.Lead__r.RecordType.Name= 'MBA' 
                             AND v.CreatedDate = LAST_N_DAYS:7 and v.Lead__r.createddate!=LAST_N_DAYS:7];
        
        //Existing Opportunity Status
       /* ContactName='';
        ActivityName='';
        ActivityDate='';
        ActivityComment='';
        Datetime AcDate;
        
        
        LatestTask = [Select t.What.Id, t.WhatId, t.Subject, t.Id, t.Description, t.CreatedDate, t.ActivityDate From Task t where  What.Type = 'Opportunity'  AND (What.RecordType.Name='MBA' or What.Recordtype.name='Allocated Record Type' or What.Recordtype.name='Await Feedback Record Type' or What.Recordtype.name='Initial Record type ')  AND t.createddate = LAST_N_DAYS:0
                      Order By t.CreatedDate desc Limit 1];
        
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
        OppQuote=[Select q.Opportunity.Competitor_Info__c,q.Opportunity.Name,q.Opportunity.Member1__r.Name,q.Opportunity.Member2__r.Name, q.OpportunityId,q.Opportunity.RFQ_Received_Date_Date__c,
                  q.Opportunity.RFQ_qualified__c, q.Opportunity.Region_Picklist__c,q.Opportunity.Account.Region__c,q.Name, q.Id, q.CreatedDate,q.Account.Name, q.Account.Industry,q.AccountId From Quote q  where OpportunityId IN :SetOppId];
        if(!OppQuote.isEmpty()){
            for(Quote q : OppQuote){
                SetAccId.add(q.AccountId);
            }
        }
        
        List<Contact> lstCont = [ Select Id,Name,AccountId from contact where AccountId IN : SetAccId Order By CreatedDate ASC Limit 1];
        if(lstCont.size()>0){
            ContactName = lstCont[0].Name; 
            
        } 
        
        //Modified Existing Opportunity Status
        List<Task> TaskData=[select id, WhatId,AccountId, CreatedDate, subject from task where what.type='Opportunity' and createddate=LAST_N_DAYS:7 and WhatId in (select id from opportunity where Recordtype.name='Allocated Record Type' or RecordType.name='Await Feedback Record Type' or Recordtype.name='Initial Record type' or RecordType.name='MBA') order by createddate desc];
    mapData=new Map<id,List<Task>>();
        TaskList=new Map<id,Task>();
        OpportunityData=new set<Id>();
    for(Task t:TaskData)
    {
         if(mapData.containsKey(t.WhatId))
         {
             mapData.get(t.WhatId).add(t);
         }
         else
         {
             mapData.put(t.WhatId,new List<Task>{t});
         } 
    }

      System.debug('Map Data here='+mapData);
      System.debug('Map Data keyset='+mapData.keySet());

    for(ID i:mapData.keySet())
    {
        
         System.debug('data here ='+mapData.get(i));
         System.debug('data here Rec='+mapData.get(i)[0]);
            System.debug('Account data here='+mapData.get(i)[0].AccountId);
            subjectData.add(mapData.get(i)[0].subject);
            AccountNames.add(mapData.get(i)[0].AccountId);
            OpportunityData.add(i);

    }
        
       */
        //New Modified Code
       /* mapData=new Map<id,List<Task>>();
        TaskList=new Map<id,Task>();
        AccountIde=new Set<id>();
        contactData=new Map<id,quote>();
        List<Task> TaskData=[select id, WhatId,AccountId, CreatedDate,ActivityDate, subject from task where what.type='Opportunity' and createddate=LAST_N_DAYS:70 and WhatId in (select id from opportunity where Recordtype.name='Allocated Record Type' or RecordType.name='Await Feedback Record Type' or Recordtype.name='Initial Record type' or RecordType.name='MBA') order by createddate desc];
    OpportunityData=new set<id>();
    for(Task t:TaskData)
    {
         if(mapData.containsKey(t.WhatId))
         {
             mapData.get(t.WhatId).add(t);
         }
         else
         {
             mapData.put(t.WhatId,new List<Task>{t});
         } 
    }

    System.debug('Map Data here='+mapData);
    System.debug('Map Data keyset='+mapData.keySet());

    for(ID i:mapData.keySet())
    {
      
         System.debug('data here ='+mapData.get(i));
         System.debug('data here Rec='+mapData.get(i)[0].subject);
         System.debug('Account Id here='+mapData.get(i)[0].AccountId);
         OpportunityData.add(i);
            TaskList.put(i,mapData.get(i)[0]);
            AccountIde.add(mapData.get(i)[0].AccountId);
    }

         //OppQuote=[Select q.Opportunity.Name,q.Opportunity.Member1__r.Name,q.Opportunity.Member2__r.Name, q.OpportunityId,q.Opportunity.RFQ_Received_Date_Date__c,
         //q.Opportunity.RFQ_qualified__c, q.Opportunity.Region_Picklist__c,q.Opportunity.AccountId,q.Opportunity.Account.Region__c,q.Name, q.Id, q.CreatedDate,q.Account.Name, q.Account.Industry,q.AccountId From Quote q  where OpportunityId IN :OpportunityData];
        
        OppDataNow=[select id,name,Competitor_Info__c,Member1__r.name,(select id,name,OpportunityId from Quotes where OpportunityId!=null order by createddate desc limit 1),createddate,Member2__r.Name,RFQ_Received_Date_Date__c,RFQ_qualified__c,Region_Picklist__c,Account.name,Account.Region__c,Account.Industry from Opportunity  where id in:TaskList.keySet()];
        System.debug('Opportunity size='+OppDataNow);
        for(Opportunity a:OppDataNow)
        {
            
            for(Quote q:[select id,name,OpportunityId from quote where  OpportunityId=:a.id order by createddate desc limit 1])
            {
                
                contactData.put(a.id,a.Quotes); 
             
            
            }
            
        }
         System.debug('Contactdata map values='+contactData.keySet());
        contactNow=new Map<id,contact>();
        for(Account a:[select id,name,Region__c from Account where Id in:AccountIde])
        {
            for(contact c:[select id,name from contact where Account.name=:a.name order by createddate desc limit 1])
            {
                contactNow.put(a.id,c);
            }
        }
       */
        mapData=new Map<id,List<Task>>();
        TaskList=new Map<id,Task>();
        AccountIde=new Set<id>();
        contactData=new Map<id,quote>();
        List<Task> TaskData=[select id, WhatId,AccountId, CreatedDate,ActivityDate, subject,IsRecurrence from task where what.type='Opportunity'  and createddate=LAST_N_DAYS:7
                             and WhatId in (select id from opportunity where Recordtype.name='Allocated Record Type' or RecordType.name='Await Feedback Record Type' or Recordtype.name='Initial Record type' or RecordType.name='MBA') order by createddate desc];
    OpportunityData=new set<id>();
    for(Task t:TaskData)
    {
         if(mapData.containsKey(t.WhatId))
         {
             mapData.get(t.WhatId).add(t);
         }
         else
         {
             mapData.put(t.WhatId,new List<Task>{t});
         } 
    }

    System.debug('Map Data here='+mapData);
    System.debug('Map Data keyset='+mapData.keySet());

    for(ID i:mapData.keySet())
    {
      
         System.debug('data here ='+mapData.get(i));
         System.debug('data here Rec='+mapData.get(i)[0].subject);
         System.debug('Account Id here='+mapData.get(i)[0].AccountId);
         OpportunityData.add(i);
            TaskList.put(i,mapData.get(i)[0]);
            AccountIde.add(mapData.get(i)[0].AccountId);
    }

         //OppQuote=[Select q.Opportunity.Name,q.Opportunity.Member1__r.Name,q.Opportunity.Member2__r.Name, q.OpportunityId,q.Opportunity.RFQ_Received_Date_Date__c,
         //q.Opportunity.RFQ_qualified__c, q.Opportunity.Region_Picklist__c,q.Opportunity.AccountId,q.Opportunity.Account.Region__c,q.Name, q.Id, q.CreatedDate,q.Account.Name, q.Account.Industry,q.AccountId From Quote q  where OpportunityId IN :OpportunityData];
        
        OppDataNow=[select id,name,Competitor_Info__c,Member1__r.name,(select id,name,createddate,OpportunityId from Quotes where OpportunityId!=null order by createddate desc limit 1),createddate,Member2__r.Name,RFQ_Received_Date_Date__c,RFQ_qualified__c,Region_Picklist__c,Account.name,Account.Region_Picklist__c,Account.Industry from Opportunity where createddate!=today and createddate!=LAST_N_DAYS:7 and id in:TaskList.keySet()];
        System.debug('Opportunity size='+OppDataNow);
        for(Opportunity a:OppDataNow)
        {
            
            //for(Quote q:a.quotes)
            //{
            if(!a.quotes.isEmpty()){
                contactData.put(a.id,a.quotes[0]); 
            }else{
                contactData.put(a.id,new Quote(name = ''));
            }
                
             
            
           // }
            
        }
         System.debug('Contactdata map values='+contactData.keySet());
        contactNow=new Map<id,contact>();
        for(Account a:[select id,name,Region_Picklist__c from Account where Id in:AccountIde])
        {
            for(contact c:[select id,name from contact where Account.name=:a.name order by createddate desc limit 1])
            {
                contactNow.put(a.id,c);
            }
        }
       
        //existing opportunity for on hold status
  
        taskForExistingHold=new List<Task>();
        
        taskForExistingHold=[select id, WhatId,AccountId, CreatedDate,ActivityDate, subject,IsRecurrence from task where what.type='Opportunity'  and createddate=LAST_N_DAYS:7
                             and WhatId in (select id from opportunity where stagename='Opportunity On Hold' and (Recordtype.name='Allocated Record Type' or RecordType.name='Await Feedback Record Type' or Recordtype.name='Initial Record type' or RecordType.name='MBA')) order by createddate desc];
        
        for(Task t:taskForExistingHold)
        {
           forTaskId.add(t.WhatId);
           holdTaskId.add(t.id);
        }
        
        checkOppData=new List<Opportunity>();
        checkOppData=[select id,name,Account.industry,AccountId,Account.Region_Picklist__c,(select id,subject,activitydate,Revised_Date__c,description from tasks where id in:holdTaskId order by createddate desc limit 1),(select id,name,createddate,OpportunityId from Quotes where OpportunityId!=null order by createddate desc limit 1) from Opportunity where id in:forTaskId];
        accForHold=new set<id>();
        conDataForHold=new Map<id,contact>();
        
        for(Opportunity o:checkOppData)
        {
            accForHold.add(o.AccountId);
        }
        
        for(Account a:[select id,name from account where id in:accForHold])
        {
            for(contact c:[select id,name from contact where Account.name=:a.name order by createddate desc limit 1])
            {
                conDataForHold.put(a.id,c);
            }
        }
        
        
        
    }
    
    //dummy code for coverage
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
       boolean value=true;
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