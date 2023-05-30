global class quoteIndentDispatchDateReminder implements Database.Batchable <sObject>,Database.stateful {
    
    global String custrecString;
    global String regularrecString;
    global string egvrecString;
    global decimal custcount;
    global decimal regularcount; 
    global decimal egvcount;
    global string query; 
    //global Boolean isTestClass = false;
    global quoteIndentDispatchDateReminder(){
        custrecString = Null;
        regularrecString = Null;
        egvrecString = Null;
        custcount = 1;
        regularcount = 1;
        egvcount =1;
    } 
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //query = 'SELECT id,Indent_Dispatch_Date__c,Insti_ref__c,Order_Type__c,Account.Name,Opportunity.Name,Opportunity.stageName from quote where Opportunity.stageName=\'Received PO/Order Won\' AND Indent_Dispatch_Date__c=Null AND (createddate<=:system.today()-4 OR createddate<=:system.today()-14)';
        return database.getQueryLocator([SELECT id,Indent_Dispatch_Date__c,Insti_ref__c,Order_Type__c,Account.Name,OpportunityId,Opportunity.Name,Opportunity_name__c,Opportunity.stageName,Opportunity.Stage_Change_Date__c,createddate from quote where Opportunity.stageName='Received PO/Order Won' AND Indent_Dispatch_Date__c=Null AND (Opportunity.Stage_Change_Date__c<=:system.today().addDays(-1) OR Opportunity.Stage_Change_Date__c<=:system.today().addDays(-14))]);
    }    
    global void execute(Database.BatchableContext bc, List<quote> records){
        //system.debug('value ='+records);
        for(quote Instance :records){
            if(Instance.Order_Type__c == 'Custom' && Instance.Opportunity.Stage_Change_Date__c<=system.today().addDays(-1) ){
                if(custrecString == Null ){
                    custrecString=string.valueOf(custcount)+'.Insti Ref No: '+Instance.Insti_ref__c+', Customer Name: '+Instance.Account.Name+', Opportunity Name: '+Instance.Opportunity.Name;
                }else if(custrecString != Null ){
                    custrecString=custrecString+'\n'+string.valueOf(custcount)+'.Insti Ref No: '+Instance.Insti_ref__c+', Customer Name: '+Instance.Account.Name+', Opportunity Name: '+Instance.Opportunity.Name;
                }
                custcount++;
            }else if(Instance.Order_Type__c == 'Regular' && Instance.Opportunity.Stage_Change_Date__c<=system.today().addDays(-14) ){
                if(regularrecString == Null ){
                    regularrecString=string.valueOf(regularcount)+'.Insti Ref No: '+Instance.Insti_ref__c+', Customer Name: '+Instance.Account.Name+', Opportunity Name: '+Instance.Opportunity.Name;
                }else if(regularrecString != Null ){
                    regularrecString=regularrecString+'\n'+string.valueOf(regularcount)+'.Insti Ref No: '+Instance.Insti_ref__c+', Customer Name: '+Instance.Account.Name+', Opportunity Name: '+Instance.Opportunity.Name;
                }
                regularcount++;
            }
            else{
                if(Instance.Order_Type__c=='EGV' && Instance.Opportunity.Stage_Change_Date__c<=system.today().addDays(-5)){
                    if(egvrecString == Null){
                       egvrecString=string.valueOf(egvcount)+'.Insti Ref No: '+Instance.Insti_ref__c+', Customer Name: '+Instance.Account.Name+', Opportunity Name: '+Instance.Opportunity.Name; 
                    }
                    else if(egvrecString != Null){
                        egvrecString=egvrecString+ '\n' + string.valueOf(egvcount)+'.Insti Ref No: '+Instance.Insti_ref__c+', Customer Name: '+Instance.Account.Name+', Opportunity Name: '+Instance.Opportunity.Name;
                    }
                    egvcount++;
                }
            }
        }      		
    }    
    
    global void finish(Database.BatchableContext bc){
        string firstLine = 'Dear,';
        string lastLine='Regards';
        
        if(custrecString!=null ){
            Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
            String[] sendingTo = new String[]{'antarjyami@titan.co.in','balab@titan.co.in'};
            semail.setToAddresses(sendingTo);
            semail.setSubject('Remider Indent Dispatch Date Not Update for Custom Order type');
            semail.setPlainTextBody(firstLine+'\n\n'+'This are the records which Indent Dispatch Date not updated within time periods.'+'\n'+custrecString+'\n\n'+lastLine+',\nAdmin User');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        }
        if(regularrecString!=null ){
            Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
            String[] sendingTo = new String[]{'antarjyami@titan.co.in','balab@titan.co.in'};
            semail.setToAddresses(sendingTo);
            semail.setSubject('Remider Indent Dispatch Date Not Update for Regular Order type');
            semail.setPlainTextBody(firstLine+'\n\n'+'This are the records which Indent Dispatch Date not updated within time periods.'+'\n'+regularrecString+'\n\n'+lastLine+',\nAdmin User');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        }
 		if(egvrecString!=null ){
            Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
            String[] sendingTo = new String[]{'antarjyami@titan.co.in','balab@titan.co.in'};
            semail.setToAddresses(sendingTo);
            semail.setSubject('Remider Indent Dispatch Date Not Update for EGV Order type');
            semail.setPlainTextBody(firstLine+'\n\n'+'This are the records which Indent Dispatch Date not updated within time periods.'+'\n'+egvrecString+'\n\n'+lastLine+',\nAdmin User');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        }                
    }    
}