/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/15/2019   T01	SOQL inside for loop

*/
trigger PecsaAttValidation on Account (before insert,before update,after update) {
    String accno;
    String errmsg='';
    
    List<String> mapfieldvalue = new List<String>();
    
    //<T01>
    List<String> fileNamesToQuery = new List<String>();
    List<Attachment> lstatt = new List<Attachment>();
    Map<Id,List<String>> mapAccToAttachment = new Map<Id,List<String>>();
    //<T01>
    
    if(trigger.isAfter && trigger.isUpdate){
        //AccountTriggerHandler.accountAfterUpdate(Trigger.new,Trigger.oldMap);
    }
    if(trigger.isbefore && trigger.isInsert){
        //AccountTriggerHandler.accountBeforeInsert(Trigger.new);
    }
    if((trigger.isbefore && trigger.isInsert) ||  (trigger.isbefore && trigger.isUpdate)){
        for(Account a : Trigger.New)
        {
            accno=a.id;
            if(a.LTA__c== true){
                mapfieldvalue.add('LTA');
                fileNamesToQuery.add('LTA%');//<T01> adding filenames to query it
            }
            
            if(a.MOU__c== true){
                mapfieldvalue.add('MOU');    
                fileNamesToQuery.add('MOU%');//<T01> adding filenames to query it
            }
            
            if(a.NDA__c== true){
                mapfieldvalue.add('NDA');
                fileNamesToQuery.add('NDA%');//<T01> adding filenames to query it
            }
            
            
            if(a.Bank_Guarantee__c== true){
                mapfieldvalue.add('Bank_Guarantee');
                fileNamesToQuery.add('Bank_Guarantee%');//<T01> adding filenames to query it
            }
            
            
            if(a.Indemnity_bond_chkbox__c== true){
                mapfieldvalue.add('Indemnity_bond');
                fileNamesToQuery.add('Indemnity_bond%');//<T01> adding filenames to query it
            }
            
            
            if(a.Insurance__c== true){
                mapfieldvalue.add('Insurance'); 
                fileNamesToQuery.add('Insurance%');//<T01> adding filenames to query it
            }
            
            
        }
        //<T01>
        lstatt=[select Id,name,ParentId from Attachment where ParentId =:Trigger.new and name like:fileNamesToQuery];
        List<String> tempList = new List<String>();
        for(Attachment attach:lstatt){
            tempList = new List<String>();
            if(mapAccToAttachment.containsKey(attach.ParentId)){
                mapAccToAttachment.get(attach.ParentId).add(attach.Name);
            }else{
                tempList.add(attach.Name);
                mapAccToAttachment.put(attach.ParentId, tempList);
            }
        }
        System.debug('Map MEssage : '+mapAccToAttachment);
        for(Account acc: Trigger.new){
            errmsg = '';
            
            if(acc.LTA__c== true){
                if(!attachmentCheck(mapAccToAttachment.get(acc.id),'LTA')){
                    errmsg=errmsg+'LTA'+' , '; 
                }
                System.debug('No erro here : '+errmsg);
            }
            
            if(acc.MOU__c== true){
                if(!attachmentCheck(mapAccToAttachment.get(acc.id),'MOU')){
                    errmsg=errmsg+'MOU'+' , '; 
                }
            }
            System.debug('NDA for '+acc.id+' '+acc.NDA__c);
            if(acc.NDA__c== true){
                if(!attachmentCheck(mapAccToAttachment.get(acc.id),'NDA')){
                    errmsg=errmsg+'NDA'+' , '; 
                }
            }
            
            if(acc.Bank_Guarantee__c== true){
                System.debug('bank guarenated: '+acc.id);
                if(!attachmentCheck(mapAccToAttachment.get(acc.id),'Bank_Guarantee')){
                    errmsg=errmsg+'Bank_Guarantee'+' , '; 
                }
                System.debug('Ban '+acc.id+' '+errmsg);
            }
            
            if(acc.Indemnity_bond_chkbox__c== true){
                
                if(!attachmentCheck(mapAccToAttachment.get(acc.id),'Indemnity_bond')){
                    errmsg=errmsg+'Indemnity_bond'+' , '; 
                }
            }
            
            if(acc.Insurance__c== true){
                if(!attachmentCheck(mapAccToAttachment.get(acc.id),'Insurance')){
                    errmsg=errmsg+'Insurance'+' , '; 
                }
            }
           	System.debug('Error MEssage : '+errmsg);
            
            if(errmsg.length()>0)
            {
                errmsg=errmsg.subString(0,errmsg.length()-2);
                acc.addError('Please upload '+errmsg+' documents');
            }
            
        }
        //</T01>
        /*
            for(Integer i=0;i<mapfieldvalue.size();i++)
            {
                String filename=mapfieldvalue.get(i)+'%';
                
                //commented below code to avoid inner for loop SOQL query and added new logic below commented lines
                List<Attachment> lstatt=[select Id,name,ParentId from Attachment where ParentId =:accno and name like:filename];
                // Follow all T01 tag for the logic to understand 
                if(lstatt.size()<=0)
                {
                System.debug('Please upload '+mapfieldvalue.get(i)+' attachment.');
                errmsg=errmsg+mapfieldvalue.get(i)+' , ';
            
            }
            
            
            }*/
        
    }
    //<T01>
    public static boolean attachmentCheck(List<String> fileNames,String keyName){
        boolean isPresent = false;
        if(fileNames == null){
            return false;//if account has no attachment , then fileNames will be null
        }
        for(String name:fileNames){
            isPresent = false;
            if(name.startswith(keyName)){
                isPresent = true;
                break;
            }
        }
        return isPresent;
    }   //</T01>
}