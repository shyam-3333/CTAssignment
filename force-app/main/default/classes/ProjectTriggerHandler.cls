public class ProjectTriggerHandler {
    
    public void createMillstones(list<Project__c> newList){
        list<Milestone__c> milList = new list<Milestone__c>();
        for(Project__c pro : newList){
            Milestone__c mil1 = new Milestone__c();
            mil1.Name = 'Marketing Brief Release';
            mil1.Serial_Number__c = 1;
            mil1.Status__c = 'Active';
            mil1.Project__c = pro.Id;
            mil1.Start_date__c = system.today();
            milList.add(mil1);
            
            Milestone__c mil2 = new Milestone__c();
            mil2.Serial_Number__c = 2;
            mil2.Project__c = pro.Id;
            mil2.Name = 'Acceptance of Marketing Brief';
            milList.add(mil2);
            
            Milestone__c mil3 = new Milestone__c();
            mil3.Serial_Number__c = 3;
            mil3.Project__c = pro.Id;
            mil3.Name = 'Final concept presentation by DEC to Brand';
            milList.add(mil3);
            
            Milestone__c mil4 = new Milestone__c();
            mil4.Serial_Number__c = 4;
            mil4.Project__c = pro.Id;
            mil4.Name = 'Completion of technical drawing of the concept';
            milList.add(mil4);
            
            Milestone__c mil5 = new Milestone__c();
            mil5.Serial_Number__c = 5;
            mil5.Project__c = pro.Id;
            mil5.Name = 'Approval of ISCM briefing';
            milList.add(mil5);
        }
        if(milList.Size() > 0){
            insert milList;
        }
    }
    public void sendEmail(list<project__c> newList){
        List < Messaging.SingleEmailMessage > emailList = new List < Messaging.SingleEmailMessage > ();
        String mailbody = '';
        String EmailIds = '';
        List <String> receiverList = new List <String> ();
        Set<Id> ownerId = new Set<Id>();
        List <User> usr = new List <User> ();
        String ownerName = '';
        
        for(Project__c pro : newList){
            ownerId.add(pro.OwnerId);
            if(pro.Brand__c == 'Titan'){
                 EmailIds = label.PDMS_Titan_Emails;
            }
            else if(pro.Brand__c == 'Sonata'){
                 EmailIds = label.PDMS_Sonata_Emails;
            }
            else if(pro.Brand__c == 'Fastrack'){
                 EmailIds = label.PDMS_Fastrack_Emails;
            }
            else EmailIds = 'sfdcadmin@titan.co.in ';
        } 
        if (EmailIds != null) {
            if (EmailIds.contains(',')) {
                for (String str: EmailIds.split(',')) {
                    receiverList.add(str);
                }
            } else {
                receiverList.add(EmailIds);
            }
        }
        if(!ownerId.isEmpty()){
            usr = [Select id, Name from User where Id IN: ownerId];
        }
        if(!usr.isEmpty()){
            for(User u : usr){
            ownerName =  u.Name;
            }
        }
        for(Project__c pro : newList)
        {            
            mailbody = '<html><body>Hi Team,<br/><br/>A new Project : '+pro.Name+' is created by '+ownerName+'.<br/><br/>Thank You</body></html>';
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(receiverList);
            mail.setSubject('New Project : '+pro.Name+' is created');
            mail.Sethtmlbody(mailbody);
            
            if(mail != Null){
                emailList.add(mail);
                System.debug('-----------------if--------------');
            }
            else{
                System.debug('-----------------else--------------');
            }                 
        }
        Messaging.sendEmail(emailList);
    }
}