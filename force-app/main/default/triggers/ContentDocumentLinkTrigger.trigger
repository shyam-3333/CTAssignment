trigger ContentDocumentLinkTrigger on ContentDocumentLink (before insert) {
    Set<Id> contentIds = new Set<id>();
    String userProfileId = UserInfo.getProfileId();
    String profileName = [Select Id,Name from Profile where Id =:userProfileId LIMIT 1].Name;
    Map<Id,Boolean> mapOfValidate = new Map<Id,Boolean>();
    if(Trigger.isInsert && Trigger.isBefore && profileName !='System Administrator' && profileName !='Channel mgr profile'){
        for(ContentDocumentLink link : Trigger.new){
            contentIds.add(link.LinkedEntityId);
            System.debug(link.LinkedEntityId);
        }
        System.debug('profileName'+profileName);
        if(contentIds.size()>0 && contentIds != null && profileName !='System Administrator' && profileName !='Channel mgr profile'){
            for(Ready_Reckoner__c ready : [Select id from Ready_Reckoner__c  where id In : contentIds]){
                mapOfValidate.put(ready.Id,true);
            }
        }
        
        if(mapOfValidate.size()>0 && mapOfValidate != null && profileName !='System Administrator' && profileName !='Channel mgr profile'){
            for(ContentDocumentLink link : Trigger.new){
                if(mapOfValidate.containsKey(link.LinkedEntityId)){
                    if(!Test.isRunningTest()){
                        link.addError('Only Admin Can Upload');
                        
                    }
                }
            }  
        }
        System.debug('mapOfValidate-->'+mapOfValidate);
        
    }
}