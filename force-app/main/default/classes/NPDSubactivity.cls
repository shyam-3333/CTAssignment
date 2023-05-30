public with sharing class NPDSubactivity{
    
    public static void NPDSubactivity(list<NPD_Activity__c>lstSubActivity){
        list<NPD_Activity__c>lstSubactivityUpdate= new list<NPD_Activity__c>();
        list<NPD_Activity__c>lstSubactivityUpdate1= new list<NPD_Activity__c>();
        
        map<id,List<NPD_Activity__c>> lstSubAct= new map<id,List<NPD_Activity__c>>();
        
        Map<Id, NPD_Activity__c> mapii = new Map<Id, NPD_Activity__c>();
         Map<Id, NPD_Activity__c> mapii2 = new Map<Id, NPD_Activity__c>();
        
        list<NPD_Activity__c>lstResult= new list<NPD_Activity__c>();
        NPD_Activity__c obj=new NPD_Activity__c();
        set<id> ids=new set<id>();
       
        
        for(NPD_Activity__c act:[select id,Actual_End_Date__c,Approval_Status__c,Approval_Required__c,NPD_Activity__c from NPD_Activity__c where NPD_Activity__c IN:lstSubActivity AND Active__c=:true]){
            if(lstSubAct.containskey(act.NPD_Activity__c)){
                lstSubAct.get(act.NPD_Activity__c).add(act);
            }
            else{
                lstSubAct.put(act.NPD_Activity__c,new  List <NPD_Activity__c> { act });
            }
        }
        
        for(NPD_Activity__c actt:lstSubActivity){
            system.debug('*******accttID***'+actt.id);
            system.debug('*******List for id*****'+lstSubAct.get(actt.id));
            if(lstSubAct.get(actt.id) != NULL){
            for(NPD_Activity__c act:lstSubAct.get(actt.id)){
                system.debug('************HII*********');
                if(act.Approval_Required__c == TRUE && act.Approval_Status__c != 'Approved'){  
                        system.debug('************HII*********');
                        //actt.Status__c = 'In Progress';
                        //actt.Actual_End_Date__c=NULL;
                       // actt.addError('Activity Cannot be completed as Sub-activity under this has not been Approved Yet');
                }
                
            }
           }
            
        }      
        system.debug('+++++lstSubActivity+++'+lstSubActivity);//Activity
       
        system.debug('+++++lstResultsubact+++'+lstSubAct);//Istofsubact
           
    }   
    

    public static void sendNotificationMail(set<NPD_Activity__c>SetIds){
        map<string,id> templateMap = new map<string,id>();
        map<id,set<id>> ActToSucessorOwner = new map<id,set<id>>();
        list<NPD_Activity__c>lstSubActivity = new list <NPD_Activity__c>([SELECT id,Type__c,OwnerID,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.Name__c,NPD_Stage__r.NPD_Stage__r.Name__c,Successor__c,Status__c FROM NPD_Activity__c WHERE ID IN:SetIds]);
        ActToSucessorOwner = collectMailIDs(lstSubActivity);
        for(emailTemplate email: [SELECT ID,DeveloperName FROM emailTemplate WHERE DeveloperName = 'Sub_Activity_Completed_Email_Template' OR DeveloperName = 'Sub_Activity_Completed_Markting_Stg_Ema' OR DeveloperName = 'Activity_Completed_Email_Template' OR DeveloperName = 'Activity_Completed_Marketing_Stage_Email']){
            
            if(email.DeveloperName == 'Sub_Activity_Completed_Email_Template')
                templateMap.put('Sub-Activity-Complete',email.id);
            
            if(email.DeveloperName == 'Sub_Activity_Completed_Markting_Stg_Ema')
                templateMap.put('Sub-Activity-Complete-Market',email.id);
            
            if(email.DeveloperName == 'Activity_Completed_Email_Template')
                templateMap.put('Activity-Complete',email.id);
            
            if(email.DeveloperName == 'Activity_Completed_Marketing_Stage_Email')
                templateMap.put('Activity-Complete-Market',email.id);
        } 
    
      
     List<Messaging.SingleEmailMessage> previewEmails = new List<Messaging.SingleEmailMessage>();
     
     
    for(NPD_Activity__c act:lstSubActivity){
        if(!ActToSucessorOwner.isEmpty() &&  ActToSucessorOwner.containsKey(act.id) && ActToSucessorOwner.get(act.id) != NULL){
        for(id SucessorID:ActToSucessorOwner.get(act.id)){
          Messaging.SingleEmailMessage firstPreviewEmail = new Messaging.SingleEmailMessage();
          firstPreviewEmail.setUseSignature(false);
          firstPreviewEmail.setSaveAsActivity(false);
        
          if(act.Status__c == 'Complete' && act.Type__c == 'Activity' ){
            firstPreviewEmail.setTemplateId(templateMap.get('Activity-Complete'));
          }
          if(act.Status__c == 'Complete' && act.Type__c == 'Sub-Activity' ){
            firstPreviewEmail.setTemplateId(templateMap.get('Sub-Activity-Complete'));
          }
        
          if(act.Status__c == 'Complete' && act.Type__c == 'Sub-Activity' && act.NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.Name__c =='Marketing Brief/Concept'){
            firstPreviewEmail.setTemplateId(templateMap.get('Sub_Activity_Completed_Markting_Stg_Ema'));
          }
        
         if(act.Status__c == 'Complete' && act.Type__c == 'Activity' && act.NPD_Stage__r.NPD_Stage__r.Name__c =='Marketing Brief/Concept'){
            firstPreviewEmail.setTemplateId(templateMap.get('Activity-Complete-Market'));
          }
       
          firstPreviewEmail.setTargetObjectId(SucessorID);
          firstPreviewEmail.setWhatId(act.id);
          previewEmails.add(firstPreviewEmail);
       
        }
     }
   }
            try {
                if(!previewEmails.isEmpty() )
                 Messaging.sendEmail(previewEmails);
            }
            catch(exception e){
                system.debug('*****Exception Occured****'+e);
            }        
        
    }
    Public static map<id,set<id>> collectMailIDs(list<NPD_Activity__c> lstSubActivity){ 
        List<string> successors = new List<string>();
        map<id,set<id>> idToUserID = new map<id,set<id>>();
        Map <string,id> suceessorToOwner = new Map <string,id>();
        for(NPD_Activity__c actt:lstSubActivity){
            if(!string.isblank(actt.Successor__c)){
            for(string sucess:actt.Successor__c.split(','))
                if(!string.isblank(sucess))
                    successors.add(sucess);
        }
        }
        for(NPD_Activity__c acts:[SELECT id,OwnerID,SerialNo__c FROM NPD_Activity__c WHERE SerialNo__c IN:successors LIMIT 49000]){
            suceessorToOwner.put(acts.SerialNo__c,acts.OwnerID);
        }
        for(NPD_Activity__c activ:lstSubActivity){
            if(!string.isblank(activ.Successor__c)){
            for(string stg:activ.Successor__c.split(',')){
                if(!string.isblank(stg)){
                 if(idToUserID.containsKey(activ.id) && idToUserID.get(activ.id) != NULL){
                        idToUserID.get(activ.id).add(suceessorToOwner.get(stg));  
                }
                    else{
                        idToUserID.put(activ.id,new set<id>{suceessorToOwner.get(stg)});
                    }
                }
            }
        }
      }
        return idToUserID;
    } 
}