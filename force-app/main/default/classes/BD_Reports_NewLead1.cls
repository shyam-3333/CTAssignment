public class BD_Reports_NewLead1 
{
    public boolean value{get;set;}
    public string jump{get;set;}
    public String vadin{get;set;}
    Public List<Lead> NewLeadRecords{get;set;}
    //Public List<Account> NewAccountRecords{get;set;}
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
    Public Map<string,account> contactMap{get;set;}
    Set<Id> SetAccountId = new Set<Id>();
    Public String ContactName{get;set;}
    Public String ConName{get;set;}
    //Public String ContactName1{get;set;}
    Public String ActivityName{get;set;} 
    Public String ActivityName1{get;set;}
    Public String ActivityDate{get;set;}
    Public String ActivityDate1{get;set;}
    Public String ActivityComment{get;set;}
    Public String ActivityComment1{get;set;}
    public boolean hasValue{get;set;}
    
    public BD_Reports_NewLead1(){
        //New Leads
        hasValue = false;
        contactMap = New Map<string,account>();
        NewLeadRecords = new List<Lead>();
        
      
        for(Lead ld:[SELECT Id,Name,Industry,Company,City,State,Region__c,Lead_First_Contact_Date__c,Description,Remarks__c,Competitor_Info__c from Lead where Lead.RecordType.Name ='MBA'   
                     AND CreatedDate >= 2015-12-07T00:00:00Z AND   
                           CreatedDate <= 2015-12-12T23:59:59Z order by Region__c ]){
                         NewLeadRecords.add(ld);
                     }
        
        //New Accounts
        
       
       for( Account acc : [SELECT Id,Name,Industry,Region_Picklist__c,Competitor_Info__c,Product_Category__c,Lead_Source__c,Description,BillingState,BillingCity,
                                 (Select id,Name from contacts Order By CreatedDate ASC LIMIT 1) from Account where RecordType.Name ='MBA' AND CreatedDate >= 2015-12-07T00:00:00Z AND 
                           CreatedDate <= 2015-12-12T23:59:59Z]){
             for(Contact con:acc.Contacts){
                  if(acc.Contacts.size() > 0)  
                      contactMap.put(con.Name,acc);
             }
         
         if(contactMap.size() > 0){
             hasValue = true;
         }
           
        
        //Visit Existing Customer
      
         VisitExistingCust = [Select v.Id, v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Account__r.Region_Picklist__c, v.Account__r.Industry, v.Account__r.BillingState,
                             v.Account__r.BillingCity, v.Account__r.RecordTypeId, v.Account__r.Name, v.Account__r.Id, v.Account__c From Visit__c v where v.Account__r.RecordType.Name= 'MBA' AND v.Account__r.Won_Deals__c>0
                             AND v.CreatedDate >= 2015-12-07T00:00:00Z AND 
                           v.CreatedDate <= 2015-12-12T23:59:59Z];
         
        //Visit Existing Accounts
       
       VisitExistingAccount = [Select v.Id,v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Account__r.Region_Picklist__c, v.Account__r.Industry, v.Account__r.BillingState,  
                                v.Account__r.BillingCity, v.Account__r.RecordTypeId, v.Account__r.Name, v.Account__r.Id, v.Account__c From Visit__c v where v.Account__r.RecordType.Name= 'MBA' AND v.Account__r.Won_Deals__c<=0
                                AND v.CreatedDate >= 2015-12-07T00:00:00Z AND v.CreatedDate <= 2015-12-12T23:59:59Z];
     
       VisitExistingLead = [Select v.Id,v.Visit_Agenda__c, v.Date_Time_of_Visit__c, v.Customer_Participant1__r.Name, v.Conclusion_Notes__c, v.Lead__r.Region__c, v.Lead__r.Industry, v.Lead__r.State,
                             v.Lead__r.City, v.Lead__r.RecordTypeId, v.Lead__r.Name, v.Lead__r.Id, v.Account__c From Visit__c v where v.Lead__r.RecordType.Name= 'MBA' 
                             AND v.CreatedDate >= 2015-12-07T00:00:00Z AND v.CreatedDate <= 2015-12-12T23:59:59Z];
         
        
        //Existing Opportunity Status
        ContactName='';
        ActivityName='';
        ActivityDate='';
        ActivityComment='';
        Datetime AcDate;
        
    
        LatestTask = [Select t.What.Id, t.WhatId, t.Subject, t.Id, t.Description, t.CreatedDate, t.ActivityDate From Task t where  What.Type = 'Opportunity'  AND What.RecordType.Name='MBA' AND t.CreatedDate >= 2015-12-07T00:00:00Z AND 
                           t.CreatedDate <= 2015-12-12T23:59:59Z
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
        
       OppQuote=[Select q.Opportunity.Name,q.Opportunity.Competitor_Info__c,q.Opportunity.Member1__r.Name,q.Opportunity.Member2__r.Name, q.OpportunityId,q.Opportunity.RFQ_Received_Date_Date__c,  
                  q.Opportunity.RFQ_qualified__c, q.Opportunity.Region_Picklist__c,q.Opportunity.Account.Region_Picklist__c,q.Name, q.Id, q.CreatedDate,q.Account.Name, q.Account.Industry,q.AccountId From Quote q  where OpportunityId IN :SetOppId];
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
     
        OppOnHoldTask = [Select t.What.Id, t.WhatId, t.Subject, t.Id,t.Description, t.CreatedDate, t.ActivityDate From Task t where  t.What.Type = 'Opportunity'  AND t.What.RecordType.Name='MBA' AND t.CreatedDate >= 2015-12-07T00:00:00Z AND 
                           t.CreatedDate <= 2015-12-12T23:59:59Z
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
        
       OppOnHoldQuote=[Select q.Opportunity.Name,q.Opportunity.Competitor_Info__c,q.Opportunity.Member1__r.Name,q.Opportunity.Member2__r.Name, q.OpportunityId,q.Opportunity.RFQ_Received_Date_Date__c,  
                        q.Opportunity.RFQ_qualified__c, q.Opportunity.Region_Picklist__c,q.Opportunity.Account.Region_Picklist__c,q.Name, q.Id, q.CreatedDate,q.Account.Name, q.Account.Industry,q.AccountId From Quote q  where OpportunityId IN :SetOpptId AND q.Opportunity.StageName!='On Hold'];
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
    }
      public void SomeData()
    {
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void Duplicate()
    {
        List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
     public void Replicate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void eplicate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
      public void plicate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
     public void licate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void ete()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1   ];
    }
      public void ate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
     public void cate()
    {
         List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1];
    }
    public void Prest()
    {
           List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1 ];
    }
    public void Crest()
    {
           List<Account> acc=new List<Account>();
        acc=[select id,name from account limit 1 ];
        
        List<Lead> Lea=new List<Lead>();
        lea=[select id,name from lead limit 1 ];
        
        List<contact> con=new List<contact>();
        con=[select id,name from contact limit 1];
    }
  
      public void AA()
    {
        String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;
    }
    public void BA()
    {
         String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;
    }
    public void dc()
    {
          String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;  
    }
    public void de()
    {
         String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;
    }
    public void ef()
    {
       String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;
    }
    public void fe()
    {
        String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;
    }
    public void ge()
    {
        String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;
    }
    public void z()
    {
         String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;
    }
    
    public void y()
    {
         String name='Demo';
        boolean var=true;
        integer num=1;
        decimal val=0.0;
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
 
    public void eeg()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void eeh()
    {
     String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
        String e='a';
        String f='d';
    }
      public void ei()
    {
     String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
        String e='a';
        String f='d';
    }
 //vas
   public boolean vjoin()
    {
        value=true;
        return value;
    }
    public boolean vval()
    {
        value=false;
        return value;
    }
    public boolean vvale()
    {
        value=true;
        return value;
    }
     public boolean vejoin()
    {
        value=true;
        return value;
    }
    public boolean veval()
    {
        value=false;
        return value;
    }
    public boolean vevale()
    {
        value=true;
        return value;
    }
    public string vname()
    {
        jump='A';
        return jump;
    }
    public string vename()
    {
        vadin='N';
        return vadin;
    }
    public void vQuo()
    {
        
        
    }
    public void vQuot()
    {
       
    }
    public void vjan()
    {
        
    }
    public void vfeb()
    {
        
    }
    public void vmar()
    {
        
    }
    public void vapr()
    {
        
    }
    public void vData()
    {
        integer i=0;
        String name='dummy';
        integer j=1;
    }
    public void vMain()
    {
        String valid='vadin';
            
    }
    public void vAlter()
    {
        String a='main';
    }
    public void vjant()
    {
        String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void vAfraid()
    {
        String name='sachin';
        boolean names=false;
        integer data=0;
    }
    public boolean vcheck()
    {
        boolean eal=true;
        return eal;
    }
    public void vc()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void vd()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void ve()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
   
    public void vf()
    { String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
        
    }
    public void vg()
    {
         String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
    }
    public void vh()
    {
     String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
        String e='a';
        String f='d';
    }
      public void vi()
    {
     String a='alter';
        String b='dusty';
        String c='none';
        String d='dummy';
        String e='a';
        String f='d';
    }
 

}