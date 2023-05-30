@isTest
public class TestBDActivitiesCustomizationClass
{
    static testMethod void MethodName()
    {
        List<Task> tList1 = new List<task>();
        List<Task> tList2 = new List<task>();
        List<Task> tList3 = new List<task>();
        List<Task> tList4 = new List<task>();


        Profile objProfile = [Select Id, Name from Profile where name like 'System%' limit 1];

        User objeUser = [Select Id, ProfileId from User where Profile.name=:objprofile.name and User.isActive=true limit 1 ];
        
        RecordType AccType=[select id,name from recordtype where sobjecttype='Account' and name='MBA' limit 1 ];
        
        
        RecordType OppType=[select id,name from recordtype where sobjecttype='Opportunity' and name='MBA' limit 1 ];
        
        
        RecordType LeadType=[select id,name from recordtype where sobjecttype='Lead' and name='MBA' limit 1 ];
        
        Account a=new Account();
        a.name='Industry';
        a.BillingPostalCode ='560102';
        a.RecordTypeId=AccType.id;
        insert a;
        
        Lead l=new Lead();
        l.Salutation = 'Mr';
        l.lastname='Test';
        l.Lead_First_Contact_Date__c = System.today();
        l.Status='Open';
        l.Company='Testing';
        l.Ownership__c='Public Ltd';
        l.email='test@gmail.com';
        l.Industry='Automotive';
        l.isConverted=false;
        l.City = 'bangalore';
        l.State = 'Karnataka' ;
        l.RecordTypeId = LeadType.Id;
       // insert l;
        
        Task tnew=new Task();
        tList4.add(tnew);
        for(Integer I = 0; i<tList4.size(); i++){
        Task k=new Task();
        k.WhatId=a.id;
        k.Subject='Presentation';
        k.OwnerId=objeUser.id;
        k.Status='In Progress';
        k.Priority='Normal';
        k.Description = 'Link to original email: https://mail.google.com/mail/u/0/1#all/17660075cca6e12b';
        tList1.add(k);
        insert tList1;
        }
        
        
        contact t=new contact();
        t.lastname='Contacted';
        t.AccountId = a.id;
        insert t;
        
        Task tk=new Task();
        tk.WhoId=t.id;
        tk.Subject='Presentation';
        tk.OwnerId=objeUser.id;
        tk.Status='In Progress';
        tk.Priority='Normal';
        tList2.add(tk);
        insert tList2;
        
        
        Opportunity o=new opportunity();
        o.name='Test';
        o.AccountId=a.id;
        o.RecordTypeId=OppType.id;
        o.StageName='Preliminary Opportunity';
        o.Project_Type__c='New Opportunity';
        o.closeDate=System.today();
        insert o;
        
        Task ot=new Task();
        ot.whatId=o.id;
        ot.OwnerId=objeUser.id;
        ot.subject='Tet opp';
        ot.Status='In Progress';
        ot.Priority='High';
       tList3.add(ot);
        insert tList3;
        
       
        BDActivitiesCustomizationClass v=new BDActivitiesCustomizationClass();
           BDActivitiesCustomizationClass.wrapper wr=new  BDActivitiesCustomizationClass.wrapper();
            BDActivitiesCustomizationClass.wrapperForReport ws=new BDActivitiesCustomizationClass.wrapperForReport();
          
        
        v.selectedRecord=o.id;
        v.selectedObject='Opportunity';
         v.saveTask();
      //   v.getrecord();
        v.createActivity();
        v.getRecordId();
        v.rowIndex=0;
        wr.isEdit=true;
        
        v.selectedObject = 'Lead';
        v.selectedObjectRecord();
        
        v.selectedObject = 'Account';
        v.selectedObjectRecord();
        
        v.selectedObject = 'Opportunity';
        v.selectedObjectRecord();
        
        v.selectedObject = 'Contact';
        v.selectedObjectRecord();
        v.selectAccounts();
        
         v.selectedObject = 'None';
        v.selectedObjectRecord();
        
        
        v.cancelRow();
        PageReference p=Page.BDActivityCustomizationPage;
        p.getParameters().put('id',ot.id);
        v.editmethid();
        v.cancelmethid();
        v.refreshName();
        wr.isEdit=false;
        PageReference pc=Page.BDActivityCustomizationPage;
        pc.getParameters().put('id',tk.id);        
        v.savemethid();
        v.DeleteActivity();
      
    }
}