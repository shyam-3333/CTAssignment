global class SchedularAutomotive30Days implements Schedulable{ 
    global void execute(SchedulableContext ctx){
        list<string> toAddressList = new list<string>();
        list<string> finaltoAddressList = new list<string>();
        list<TO__c> customTOList= new list<TO__c>();
        list<User> userList = new list<User>();
        
        customTOList = [select Id, Name, To_Email__c from TO__c]; // custom setting object for TO email list
        
        for(TO__c eachTO: customTOList){
            toAddressList.add(eachTO.To_Email__c );
        }
        if(toAddressList.size() > 0){ 
            userList = [select Id, Name, Email from User where Email IN: toAddressList and IsActive = true];
        }
        for(TO__c eachTO: customTOList){
            if(userList.size() > 0 && userList[0].Email != eachTO.To_Email__c ){
                finaltoAddressList.add(eachTO.To_Email__c );
            }
        }
        if(userList.size() == 0){
            finaltoAddressList.addAll(toAddressList);
        }
        
        EmailTemplate emailTemplate = [Select id from EmailTemplate where name=:'Automotive30Days'];
        
        List<Messaging.SingleEmailMessage> emailSendList  = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        if(userList.size() > 0){
            email.setTargetObjectId(userList[0].Id);
        }  
        email.setToAddresses(finaltoAddressList);
        email.setTemplateId(emailTemplate.id); 
        email.setSaveAsActivity(false);
        emailSendList.add(email);
        
        try{  Messaging.sendEmail(emailSendList); } // sending mass email 
        catch(EmailException Ex){  
            system.debug('---------Error--------'+Ex.getMessage());
        }
    }
    
}