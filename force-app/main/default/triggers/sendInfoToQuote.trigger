trigger sendInfoToQuote on Payment_Tracker__c (before insert,before update, after update)
{
    public static String quoteId;
    public static String paymentTrackerId;
    public static String approvalId;
    public static List<Payment_Tracker__c> payList;
    public static String status;
    public static String approvalStatus;
    
    
   if(Trigger.isBefore && Trigger.isInsert){
        //Map<Id,List<String>> mapList=new Map<Id,List<String>>(); 
      
        //List<Id> ptList=new List<Id>();
        List<Payment_Tracker__c> pt= Trigger.new;
        Map<String,Boolean> rtgs1Map=new Map<String,Boolean>();
       Map<String,Boolean> rtgs2Map=new Map<String,Boolean>();
       Map<String,Boolean> rtgs3Map=new Map<String,Boolean>();
        Set<String> ptSet=new Set<String>();
        for(Payment_Tracker__c px : pt){
            if(px.RTGS_No__c != null){
                ptSet.add(px.RTGS_No__c);
            }
            if(px.RTGS_No_UTR_2__c !=null){
                ptSet.add(px.RTGS_No_UTR_2__c);
            }
            if(px.RTGS_No_UTR_3__c !=null){
                ptSet.add(px.RTGS_No_UTR_3__c);
            }
            
           // ptSet.add(px.RTGS_No_UTR_3__c);
        }
        //List<String> combinationList=new List<String>();
        integer count=0;
        System.debug('====>'+pt);
       System.debug('SET Value '+ ptSet);
        for(Payment_Tracker__c p1 : [SELECT Id, RTGS_No_UTR_2__c, RTGS_No_UTR_3__c, RTGS_No__c, RTGS_Created_Date__c FROM Payment_Tracker__c WHERE Payment_Mode__c='RTGS' AND (RTGS_No__c IN:ptSet OR RTGS_No_UTR_2__c IN:ptSet OR RTGS_No_UTR_3__c IN:ptset) LIMIT 49999]){
            //ptList.add(p1.id);
            //for(integer i=0;i<pt.size();i++){
            
            if(!rtgs1Map.containsKey(p1.RTGS_No__c) && (p1.RTGS_No__c !=null || p1.RTGS_No__c !='')){
                rtgs1Map.put(p1.RTGS_No__c,true);
            }
            if(!rtgs2Map.containsKey(p1.RTGS_No_UTR_2__c) && (p1.RTGS_No_UTR_2__c !=null || p1.RTGS_No_UTR_2__c !='')){
                rtgs2Map.put(p1.RTGS_No_UTR_2__c,true);
            }
            if(!rtgs3Map.containsKey(p1.RTGS_No_UTR_3__c) &&(p1.RTGS_No_UTR_3__c !=null || p1.RTGS_No_UTR_3__c !='')){
                rtgs3Map.put(p1.RTGS_No_UTR_3__c,true);
            }
            
            
                
               // if(pt[i].RTGS_No__c == p1.RTGS_No__c || pt[i].RTGS_No__c == p1.RTGS_No_UTR_3__c || pt[i].RTGS_No__c == p1.RTGS_No_UTR_2__c || pt[i].RTGS_No_UTR_2__c == p1.RTGS_No__c || pt[i].RTGS_No_UTR_2__c == p1.RTGS_No_UTR_2__c || pt[i].RTGS_No_UTR_2__c == p1.RTGS_No_UTR_3__c || pt[i].RTGS_No_UTR_3__c == p1.RTGS_No__c || pt[i].RTGS_No_UTR_3__c == p1.RTGS_No_UTR_2__c || pt[i].RTGS_No_UTR_3__c == p1.RTGS_No_UTR_3__c){
           // pt[0].addError('Duplicate RTGS Number!! Please Give a unique RTGS number');
            //count++;
               // }
           // }
        }
       System.debug('Map 1'+rtgs1Map);
       System.debug('Map 2'+rtgs2Map);
       System.debug('Map 3'+rtgs3Map);
       for(Payment_Tracker__c px:pt){
           if(rtgs1Map.containsKey(px.RTGS_No__c) || rtgs1Map.containsKey(px.RTGS_No_UTR_2__c) || rtgs1Map.containsKey(px.RTGS_No_UTR_3__c)){
               px.addError('Duplicate RTGS Number!! Please Give a unique RTGS number');
           }
           if(rtgs2Map.containsKey(px.RTGS_No__c) || rtgs2Map.containsKey(px.RTGS_No_UTR_2__c) || rtgs2Map.containsKey(px.RTGS_No_UTR_3__c)){
               px.addError('Duplicate RTGS Number!! Please Give a unique RTGS number');
           }
           if(rtgs3Map.containsKey(px.RTGS_No__c) || rtgs3Map.containsKey(px.RTGS_No_UTR_2__c) || rtgs3Map.containsKey(px.RTGS_No_UTR_3__c)){
               px.addError('Duplicate RTGS Number!! Please Give a unique RTGS number');
           }
       }
        
        
        
    }
    
    
    
    if(Trigger.isBefore && Trigger.isUpdate){
        
        /*for(Payment_Tracker__c q1:Trigger.New){
            quoteId=(String)q1.Quote_Id__c;
            paymentTrackerId=(String)q1.Id;
            break;   
        }
        
        for(ProcessInstance pi : [SELECT CreatedById, CreatedDate,Id,IsDeleted,
                                  LastModifiedById,LastModifiedDate,ProcessDefinitionId,Status
                                  ,SystemModstamp,TargetObjectId, (SELECT ID,  StepStatus,
                                                                   Comments,TargetObjectId,ActorId,CreatedById,IsDeleted,IsPending,
                                                                   OriginalActorId,ProcessInstanceId,RemindersSent,CreatedDate 
                                                                   FROM StepsAndWorkitems ) FROM ProcessInstance
                                  where ProcessInstance.TargetObjectId =:paymentTrackerId ORDER BY CreatedDate DESC LIMIT 1]){
                                      System.debug('Status ==>'+pi.Status);
                                      System.debug('Status ==>'+pi.StepsAndWorkitems[0].StepStatus);
                                      if(pi.ProcessDefinitionId!=null){
                                          approvalId=pi.StepsAndWorkitems[0].ActorId;
                                          //approvalId='0057c000007pqIDAAY';
                                      }
                                      
                                  }
        
        for(Payment_Tracker__c q1:Trigger.New){
            
            if(q1.Quote_Id__c!=null){
                if(q1.Approval_Status__c == 'Pending'){
                    IndentGvExcelAttachmentController.attachPDFFromQuote(quoteId,q1.Id,approvalId);
                }
            }
            
        }*/
    }
    
    if(Trigger.isBefore && Trigger.isUpdate && CheckRecursive.runOnce()){
        List<Quote> QL = New List<Quote>();
        Set<String> quoteIds = new Set<String>();
        Set<String> paymentTrackerIds = new Set<String>();
        Map<Id,Payment_Tracker__c> oldMap = Trigger.oldMap;
        payList = Trigger.old;
        status=Trigger.old[0].Approval_Status__c;
        approvalStatus=Trigger.new[0].Approval_Status__c;
        set<id> OppId = new set<id>();
        for(Payment_Tracker__c q1:Trigger.New)
        {
            
            oppId.add(q1.Opportunity__c);
        }
        
        for(Payment_Tracker__c pt:Trigger.new)
        {
            For(Quote Q:[select id,Status,OpportunityId,Bank_Name__c,Cheque_Date__c,Cheque_No__c,Location_of_The_Bank__c,RTGS_No__c,
                         Advance_Received__c,Indent_Button_Clicked__c from Quote where opportunityId =:oppId AND Indent_Button_Clicked__c=true Order by CreatedDate desc limit 1 ])
            {
                if(PT.Opportunity__c== Q.opportunityId){
                    paymentTrackerIds.add(pt.Id);
                    quoteIds.add(Q.Id);
                    
                }
                
                
                
                if(PT.Opportunity__c== Q.opportunityId && PT.L1_Approved_Date__c!=null && PT.L2_Approved_Date__c!=null){
                    
                }
                
                if(PT.Opportunity__c== Q.opportunityId && pt.Payment_Type__c=='Advance')
                {
                    
                    Q.Bank_Name__c = PT.Bank_Name__c;
                    Q.Cheque_Date__c= PT.Cheque_Date__c;
                    Q.Cheque_No__c=PT.Cheque_No__c;
                    Q.Location_of_The_Bank__c= PT.Location_of_The_Bank__c;
                    Q.RTGS_No__c= PT.RTGS_No__c;
                    Q.Advance_Received__c= PT.Amount_Recieved__c;
                    
                    QL.add(Q);
                    
                }
                
            }
            
            
        }
        
        //*******************
        
        //*******************
        CheckValidation__c val=[select isChecked__c from CheckValidation__c];
        val.isChecked__c=false;
        update val;
        update QL;
        CheckValidation__c eval=[select isChecked__c from CheckValidation__c];
        eval.isChecked__c=true;
        update eval;
        Id jobId; 
        if (quoteIds.Size () > 0) jobId= System.enqueueJob(new GenerateIndentQueue (quoteIds,paymentTrackerIds,status)); 
        
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Payment_Tracker__c payment : Trigger.new){
            System.debug('payment.Approval_Status__c--> '+payment.Approval_Status__c);
        }
        
       
        
        
    }
}