global class UnallocatedprojectsAO implements Schedulable{ 
    global void execute(SchedulableContext ctx){
        list<string> toAddressList = new list<string>();
        list<string> finaltoAddressList = new list<string>();
        list<TO1__c> customTOList= new list<TO1__c>();
        list<User> userList = new list<User>();
        
        customTOList = [select Id, Name, To1_Email__c from TO1__c]; // custom setting object for TO email list
        
        for(TO1__c eachTO: customTOList){
            toAddressList.add(eachTO.To1_Email__c );
        }
        if(toAddressList.size() > 0){ 
            userList = [select Id, Name, Email from User where Email IN: toAddressList and IsActive = true];
        }
        for(TO1__c eachTO: customTOList){
            if(userList.size() > 0 && userList[0].Email != eachTO.To1_Email__c ){
                finaltoAddressList.add(eachTO.To1_Email__c );
            }
        }
        if(userList.size() == 0){
            finaltoAddressList.addAll(toAddressList);
        }
        
        EmailTemplate emailTemplate = [Select id from EmailTemplate where name=:'UnallocatedprojectsAO'];
        
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