public class BDActivitiesCustomizationClass
{
        public List<selectoption> forObjects{get;set;}
        public List<selectoption> forRecords{get;set;}
        public Map<String,integer> ForReport{get;set;}
        public List<wrapperForReport> wrapForReport{get;set;}
        public String js{get;set;}
        public String cat{get;set;}
        public User userData{get;set;}
        public Map<string,Schema.SObjectType> objType{get;set;}
        public List<Task> TaskList{get;set;}
        public List<Task> insertTask{get;set;}
        public List<Task> deleteTask{get;set;}
        public List<Task> QueryForTask{get;set;}
        public List<wrapper> wrapperForTask{get;set;} 
        public List<Task> DataForReport{get;set;}
        public Wrapper wrap{get;set;}
        public Id selectedId{get;set;}
        public Set<id> taskId{get;set;}
        public String selectedObject{get;set;}
        public string selectedRecord{get;set;}
        public Account selectedAcc{get;set;}
        public String StrQuery{get;set;}
        public String searchName{get;set;}
        public Map<Id,Account> accMap {get;set;}
        
     
        public integer rowIndex{get;set;}
        public List<sObject> sobjectType{get;set;}
        public List<integer> intValue{Get;set;}
        public List<String> alsoTask{get;set;}
        Public String strTemp;
        public boolean editSection {get;set;}
        public static boolean flag;
        public class wrapper
        {
                public Task taskWrapper{get;set;}
                public boolean check{get;set;}
                public boolean isEdit{get;set;}
                public integer rowNum{get;set;}
                
                
               
        }
        public class wrapperForReport
        {
            public string Reportname{get;set;}
            public string type{Get;set;}
            public List<integer> forValue{Get;set;}
            
            public WrapperForReport()
            {
               Reportname=null;
               type=null;
               forValue=new List<integer>();
            }
        }
   
       public BDActivitiesCustomizationClass()
       {
               TaskList=new List<Task>();
               ForReport=new Map<String,integer>(); 
               insertTask=new List<Task>();
               wrapperForTask=new List<wrapper>();
               TaskId=new Set<id>();
               wrapForReport=new List<WrapperForReport>();
               deleteTask=new List<Task>();
               alsoTask=new List<String>();
                DataForReport=new List<Task>();
               QueryForTask=new List<Task>();
               forObjects=new List<selectoption>();
               forRecords=new List<selectoption>();
               sobjectType=new List<sObject>();
               intValue=new List<integer>();
               accMap = new Map<Id,Account>(); 
                
              // selectedAcc = new Account();
               //objType=Schema.getGlobalDescribe();    
               forRecords.add(new selectoption('None','None'));
               forObjects.add(new selectoption('None','None'));
               //forObjects.add(new selectoption('Account','Account'));
               forObjects.add(new selectoption('Contact','Contact'));
               forObjects.add(new selectoption('Opportunity','Opportunity'));
               //forObjects.add(new selectoption('Lead','Lead'));
               UserData=[select id,name from user where id=:UserInfo.getUserId()];
              
               
              QueryForTask=[select OwnerId,WhatId,What.name,What.type,who.type,Who.name,WhoId,subject,description,ActivityDate,AccountID,Account.Name,Account.Region_Picklist__c,Region__c,Grouping__c,Activities__c,priority,status,description__c,Remarks__c,Account__r.Name,Account__c,Account__r.Region_Picklist__c from Task where createdDate=LAST_N_Days:7  and createdbyId=:UserInfo.getUserId() order by createddate desc];
              
            for(integer i=0;i<QueryForTask.size();i++)
              {
                    wrap=new Wrapper();
                 
                  if(QueryForTask[i].description != null){
                      String temp = QueryForTask[i].description;
                      
                      if(temp.contains('Link to original email: https://mail.google.com/mail/u')){
                          String[] splittedByLines=temp.split('\n', 2);
                          System.debug('splittedByLines'+splittedByLines[0]);
                          Task t = QueryForTask[i];
                          t.Description=splittedByLines[0];
                          wrap.TaskWrapper = t;
 
                      }else{
                          wrap.TaskWrapper=QueryForTask[i];
                          
                      }
                  }else{
                      wrap.TaskWrapper=QueryForTask[i];
                      
                  }
                    wrap.isEdit=false;
                    wrap.check=false;
                   
                    wrap.rowNum=wrapperForTask.size();
                    wrapperForTask.add(wrap);
              }
          
          
       }
       public void refreshName(){
              searchName = '';
              forRecords.clear();
       }
       public void createActivity()
       {
               for(integer i=0;i<1;i++)
               {
                   Task t=new Task();
                   TaskList.add(t);
               }
       }
     public pagereference editmethid(){
     if(wrapperForTask.size()>rowIndex){
         wrapperForTask[rowIndex].isEdit = true;
     }
     return null;
 }
     public pagereference cancelmethid(){
     if(wrapperForTask.size()>rowIndex){
         wrapperForTask[rowIndex].isEdit= false;
        }
     return null;
 }
 
      public pagereference savemethid(){
     if(wrapperForTask.size()>rowIndex){
         update wrapperForTask[rowIndex].TaskWrapper;   
         wrapperForTask[rowIndex].isEdit = false;
         
         }
     return null;
 }
       

       
      public void getRecordId(){
          system.debug('==whethere it is going ==');
          system.debug('==selectedRecord=='+selectedRecord);
          if(selectedRecord.length()>0){
              strTemp= selectedRecord;
          }
           system.debug('==strTemp=='+strTemp);
          
      }
      public pageReference saveTask()
      {
          pageReference pr=null;
          
             system.debug(Logginglevel.INFO,'==this method is working or not?? ==');
             System.debug('coming here');
          
          if( selectedRecord != '' && selectedObject != '' )
        {
            System.debug(selectedRecord+'<--->'+selectedObject);
            string str ='Select Id,Name,Account.Region_Picklist__c,Account.Name,AccountId From '+ selectedObject +' where Id =: selectedRecord  Limit 1' ;
            System.debug(str);
            List<sObject> sobjList = Database.query(str);
            
            for( sObject s : sobjList)
            {
                Map<String,Object> sObjMap = (Map<String,Object>)json.deserializeUntyped(json.serialize(s));
                Map<String,object> aobjn= (Map<String,Object>) sObjMap.get('Account');
                system.debug(s+'sss--->'+ sObjMap.get('Id') +' -->' + aobjn);
                selectedAcc = new Account();
                selectedAcc.Id = (Id)aobjn.get('Id');
                selectedAcc.Name = (String)aobjn.get('Name') ;
                selectedAcc.Region_Picklist__c =(String) aobjn.get('Region_Picklist__c') ;
                accMap.put((Id)sObjMap.get('Id'),selectedAcc);
            }
        }
              for(integer i=0;i<TaskList.size();i++)
              {
               
                 System.debug(Logginglevel.INFO,'---------insertTask.size()------'+TaskList.size());

                 System.debug('Holding Information=for save Method');
                 // Holding Account set of information 
                 Task t1=new Task();
                  
                 //t1.Subject=TaskList[i].subject; 
                 system.debug('selectedRecord===>'+selectedRecord);
                 System.debug('Subject here='+t1.subject); 
                 t1.ActivityDate=TaskList[i].ActivityDate;
                 t1.Grouping__c=TaskList[i].Grouping__c;
                 t1.Activities__c=TaskList[i].Activities__c;
                 t1.subject=TaskList[i].Activities__c;
                  System.debug(selectedAcc);
                  if( !accMap.isEmpty() && accMap.containsKey((Id)selectedRecord) )
                    t1.Account__c = accMap.get((Id)selectedRecord).Id;
                 if(selectedRecord.contains('00Q'))
                 {
                   t1.WhoId=selectedRecord;
                 
                 }
                 else if(selectedRecord.contains('003'))
                 {
                     t1.WhoId=selectedRecord;
                     
                    
                 }
                 else
                 {
                     t1.WhatId=selectedRecord;
                    
                 }
                  
                 System.debug(Logginglevel.INFO ,'Lead Task='+t1.WhatId);
                 t1.Priority=TaskList[i].priority;
             
                 t1.Status=TaskList[i].status;
                
                 t1.Description__c=TaskList[i].Description__c;
                 t1.Remarks__c=TaskList[i].Remarks__c;
                 t1.Description=TaskList[i].Description;
                 
                  insertTask.add(t1);
                  
                  System.debug(Logginglevel.INFO,'---------insertTask.size()------'+insertTask.size());
              }
              if(!insertTask.isEmpty())
              {
                  //insertTask.sort();
                  insert insertTask;
                  system.debug('list of insertTask'+insertTask);
                for(Task k:insertTask)
                  {
                      taskId.add(k.id);
                  }
                  
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.info,'Record saved successfully'));
              }
             pr=new PageReference('/apex/BDActivityCustomizationPage');
             pr.setRedirect(true);
             return pr;
            
      }
     public PageReference cancelRow()
    {
        if(TaskList.size()>-1)
        {
        TaskList.remove(TaskList.size()-1);
        }
       return null;
    }
    
      public pageReference DeleteActivity()
      {
                 pageReference pr=null;   
          
                 for(wrapper p:wrapperForTask)
                  {
                      if(p.check==true)
                      {
                          deleteTask.add(new Task(id=p.taskWrapper.id));
                      }
                  }
                  if(!deleteTask.isEmpty())
                  {
                      delete deleteTask;
                      ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Deleted Successfully'));
                  }
                   
                   pr=new PageReference('/apex/BDActivityCustomizationPage');
                   pr.setRedirect(true);
                   return pr;
                  
      }
     
    public void selectedObjectRecord()
     {
            
         System.debug('Coming to this method now'+searchName);
         String searchString = '%' + searchName + '%';
         sObjectType.clear();
         forRecords.clear();
         //System.debug('coming here'); 
         System.debug('valid error is='+selectedObject);
         if(selectedObject != 'None'){
         
         forRecords.add(new selectoption('None','None'));
         if(selectedObject.equalsIgnoreCase('Lead'))
         {
              StrQuery='select id,name from '+selectedObject+' where RecordType.name=\'MBA\' '+'and isConverted='+'false'+' and name like '+' : '+' searchString '+' order by name,createddate desc limit 950';

         }
         else if(selectedObject.equalsIgnoreCase('contact'))
         {
               StrQuery='select id,name,Account.Name,AccountId from '+selectedObject+' where (Account.RecordType.name=\'MBA\' OR Account.RecordType.name=\'Prospect_MBA\' OR Account.RecordType.name=\'Suspect_MBA\' OR Account.RecordType.name=\'Consultant_MBA\' )'+'and AccountId!=null'+' and name like '+' : '+' searchString '+' order by name,createddate desc limit 950';

         }
         else if(selectedObject.equalsIgnoreCase('Opportunity'))
         {
                
              StrQuery='select id,name,Account.Name,AccountId from '+selectedObject+' where RecordType.name=\'MBA\''+' and name like '+' : '+' searchString '+' order by name,createddate';           
         }
         else if(selectedObject.equalsIgnoreCase('Account'))
         {
            StrQuery='select id,name from '+selectedObject+' where (RecordType.name=\'MBA\' OR RecordType.name=\'Prospect_MBA\' OR RecordType.name=\'Suspect_MBA\' OR RecordType.name=\'Consultant_MBA\') And name like '+' : '+' searchString '+' order by name,createddate desc limit 950';           
         
         }
             system.debug( StrQuery );
            sObjectType=Database.Query(StrQuery);         
            for(sObject s:sObjectType)
            {
                //FileId=s.id;
                String strId=s.id;
                String strName =(String)s.get('Name');
                system.debug('****strId ***' + strId);
                system.debug('****strName ***' + strName);
                forRecords.add(new selectoption(strId,strName));
                system.debug('****forRecords ***' + forRecords);
            }
    }
        else{
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Please select object name')); 
        }
            
     }
   /* public void getMyReport()
    {
      
        
        for(AggregateResult sr: [select count(id) s ,Activities__c e from task w where createddate=LAST_N_DAYS:30 and CreatedById=:UserData.id group by Activities__c])
        {
              integer count=(integer)sr.get('s');
              String value=(String)sr.get('e');
              ForReport.put(value,count);
              
              alsoTask.add(value);
            System.debug('asloaskt='+alsoTask.size());
              
              
            
            
        }
        for(String t:ForReport.keySet())
        {
            intValue.add(ForReport.get(t));
        }
        
        wrapperForReport t=new WrapperForReport();
        t.reportname='Total';
        t.type='bar';
        t.forValue=intValue;
        wrapForReport.add(t);
        
         js=JSON.serializePretty(wrapForReport);
         cat=JSON.serializePretty(alsoTask);
        System.debug('js====>'+js);
        System.debug('cat=====>'+cat);
        
    }*/
    
    
 
    public void selectAccounts() 
    {
        
        if( selectedRecord != '' && selectedObject != '' )
        {
            System.debug(selectedRecord+'<--->'+selectedObject);
            string str ='Select Id,Name,Account.Region_Picklist__c,Account.Name,AccountId From '+ selectedObject +' where Id =: selectedRecord  Limit 1' ;
            System.debug(str);
            List<sObject> sobjList = Database.query(str);
            
            for( sObject s : sobjList)
            {
                Map<String,Object> sObjMap = (Map<String,Object>)json.deserializeUntyped(json.serialize(s));
                Map<String,object> aobjn= (Map<String,Object>) sObjMap.get('Account');
                system.debug(s+'sss--->'+ sObjMap.get('Id') +' -->' + aobjn);
                selectedAcc = new Account();
                selectedAcc.Id = (Id)aobjn.get('Id');
                selectedAcc.Name = (String)aobjn.get('Name') ;
                selectedAcc.Region_Picklist__c =(String) aobjn.get('Region_Picklist__c') ;
                accMap.put((Id)sObjMap.get('Id'),selectedAcc);
            }
        }  
    }
}