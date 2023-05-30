trigger RTWMasterTrigger on RTW_Multiplier_Master__c (before insert) {
    
    for(RTW_Multiplier_Master__c rmm : Trigger.new){
        if(rmm.craft__c=='Default' || rmm.fabric__c=='Default'){
            rmm.precedence__c = 2;
        }
        else rmm.precedence__c = 1;
        
    }
    
}