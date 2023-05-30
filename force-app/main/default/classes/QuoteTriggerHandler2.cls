public class QuoteTriggerHandler2 {

    //This method is created to capture quote approval process 'Comment' into quote custom field 'Approval_Comment__c' and validate character limit.
    
    public static void updateComment(List<Quote> lstQuotes){
        List<Quote> Quotes = New List <Quote>();
        List<Id> Ids = New List <Id>();
        
        for (Quote l: lstQuotes){
            Ids.add(l.Id);
        }
        System.debug('Ids : '+Ids); // 0Q07i000000Bjd8CAC
        System.debug('Ids Size : '+Ids.size()); // 1
        
        List<ProcessInstance> instances = [select Id, TargetObjectId from ProcessInstance where TargetObjectId in :Ids order by CreatedDate desc Limit 1];
        //order by CreatedDate desc Limit 1 : This filter written to take latest approval record from history.
        System.debug('instances : '+instances); // 1 List
        System.debug('instances size : '+instances.size()); //1
        
        Map<Id,Id> QuoteProcessMap = new Map<Id,Id>();
        Ids = New List <Id>();
        if(!instances.isEmpty()){
            for(ProcessInstance pi:instances){
                QuoteProcessMap.put(pi.TargetObjectId,pi.Id);
                Ids.add(pi.Id);
            }
        }
        System.debug('QuoteProcessMap : '+QuoteProcessMap); //obj id = ProcessInstance id
        System.debug('QuoteProcessMap Size : '+QuoteProcessMap.size()); //1
        System.debug('Ids Size2 : '+Ids.size()); //2
        
        List<ProcessInstanceStep> instancesSteps = [select Comments,StepStatus,ProcessInstanceId from ProcessInstanceStep where ProcessInstanceId in :QuoteProcessMap.values() order by CreatedDate desc Limit 1];
        System.debug('instancesSteps Size : '+instancesSteps.size());
        
        Map<Id,String> QuoteProcessStepMap = new Map<Id,String>();
        for(ProcessInstanceStep pis:instancesSteps){
            QuoteProcessStepMap.put(pis.ProcessInstanceId,pis.Comments); 
        } 
        System.debug('QuoteProcessStepMap : '+QuoteProcessStepMap); //ProcessInstance id = Comment
        System.debug('QuoteProcessStepMap Size : '+QuoteProcessStepMap.size()); //1
        
        for (Quote l: lstQuotes){
            if (QuoteProcessStepMap.get(QuoteProcessMap.get(l.Id)) != ''){
                l.Approval_Comment__c = QuoteProcessStepMap.get(QuoteProcessMap.get(l.Id));
                System.debug('QuoteProcessStepMap.get(QuoteProcessMap.get(l.Id))  :  '+QuoteProcessStepMap.get(QuoteProcessMap.get(l.Id)));
                if(l.Approval_Comment__c != null && l.Approval_Comment__c.length() > 30){
                    l.addError('Comment exceeded 30 character limit');
                }
            }
        }        
    }
    
}