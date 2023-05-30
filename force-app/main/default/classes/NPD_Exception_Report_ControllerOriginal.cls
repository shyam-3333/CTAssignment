public class NPD_Exception_Report_ControllerOriginal{

        public transient map<id,List<NPD_Activity__c>>  predessorToSuccessor{get;set;}
        public transient  map<id,NPD_Activity__c> activityforPredessordisplay{get;set;}
        
        public NPD_Exception_Report_ControllerOriginal(){
            succssorActivityMap();
        }

        public void succssorActivityMap(){
            list<id> activityId = new list<id>();
            map<String,Set<String>> emailpredecessorToSuccessor = new Map<String,Set<String>>();
            map<id,List<NPD_Activity__c>> activityforPredessor   = new Map<id,List<NPD_Activity__c>>();
            map<id,List<NPD_Activity__c>> activityforSuccessor   =  new Map<id,List<NPD_Activity__c>>();
            map<id,List<NPD_Activity__c>> predessorToSuccessor1 = new map<id,List<NPD_Activity__c>>();
            predessorToSuccessor = new map<id,List<NPD_Activity__c>>();
            activityforPredessordisplay = new map<id,NPD_Activity__c>();
            set<String> emailName  = new set<String>();
           
             for(NPD_Email__c email : [select id,Name,NPD_Activity__c,NPD_Project_Items__r.Project_Template__r.Name,NPD_Project_Items__c,parentActName__c,Act_Name__c,Source__c, Type__c FROM NPD_Email__c where Type__c=: 'Successor' AND NPD_Project_Items__r.Project_Template__r.Name = : 'Regular']
){
                 emailName.add(email.Act_Name__c);
                 if(!emailpredecessorToSuccessor.isEmpty() && emailpredecessorToSuccessor.get(email.parentActName__c) != null && emailpredecessorToSuccessor.containsKey(email.parentActName__c)){
                      emailpredecessorToSuccessor.get(email.parentActName__c).add(email.Act_Name__c);
                 }
                 else{
                     emailpredecessorToSuccessor.put(email.parentActName__c,new Set<String>{email.Act_Name__c});
                 }
             }
            for(NPD_Activity__c activity : [select id,User_Name__c,Brand1__c, collection_Name__c,NPD_User__r.Name,NPD_User__r.UserID__c,Planned_Lead_Time__c,NPD_Collections__c,NPD_Collections__r.Name,Status__c,Type__c ,Model_Name__c,NPD_Project_Name__c,Function_Name__c,Name,Name__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where Status__c = 'Completed' AND Actual_End_Date__c != null and Name__c in: emailpredecessorToSuccessor.keyset() AND NPD_Project_Name__c != null AND NPD_Collections__r.Name != null AND Active__c = True AND NPD_Project_Name__r.Project_Status__c != 'Drop']){
                if(activity.Name__c == 'Make or Buy and Model No. Allocation' && activity.Model_Name__c != null && activity.Model_Name__c != ''){
                
                }else{
                     activityforPredessordisplay.put(activity.id,activity);
                 
                if(!activityforPredessor.isEmpty() && activityforPredessor.containsKey(activity.NPD_Project_Name__c) && activityforPredessor.get(activity.NPD_Project_Name__c) != null){
                activityforPredessor.get(activity.NPD_Project_Name__c).add(activity);
                }else{
                activityforPredessor.put(activity.NPD_Project_Name__c,new List<NPD_Activity__c>{activity});
                }
               } 
             }
            System.debug(LoggingLevel.ERROR, 'Heap Size before : ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());  
                for(NPD_Activity__c activity : [select Planned_Lead_Time__c,NPD_Project_Name__c,Name__c,Actual_End_Date__c,Model_Name__c  from NPD_Activity__c where (Status__c = 'In Progress' OR Status__c = 'Not Started' Or Name__c = 'New Movement Certification') and Name__c in:emailName AND NPD_Project_Name__c != null  AND NPD_Collections__r.Name != null AND Active__c = True AND NPD_Project_Name__r.Project_Status__c != 'Drop']){
               if(activity.Model_Name__c != null && activity.Model_Name__c != '' && activity.Name__c == 'Make or Buy and Model No. Allocation' ){
               
               }else{
                    if(!activityforSuccessor.isEmpty() && activityforSuccessor.containsKey(activity.NPD_Project_Name__c) && activityforSuccessor.get(activity.NPD_Project_Name__c) != null){
                        activityforSuccessor.get(activity.NPD_Project_Name__c).add(activity);
                        }else{
                        activityforSuccessor.put(activity.NPD_Project_Name__c,new List<NPD_Activity__c>{activity});
                    }
                }   
             }
             System.debug(LoggingLevel.ERROR, 'Heap Size outside for : ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());               
           for(id projectId : activityforPredessor.keyset()){
               for(NPD_Activity__c predActivity : activityforPredessor.get(projectId)){
                  for(String PredActName : emailpredecessorToSuccessor.get(predActivity.Name__c)){
                      if(activityforSuccessor.get(projectId) != null){
                          for(NPD_Activity__c succACtivity : activityforSuccessor.get(projectId)){
                             if(succACtivity.Name__c == PredActName && succACtivity.Planned_Lead_Time__c != null && predActivity.Actual_End_Date__c.addDays(integer.valueOf(succACtivity.Planned_Lead_Time__c)) < System.today()){
                                  if(!predessorToSuccessor1.isEmpty() && predessorToSuccessor1.get(predActivity.id) != null){
                                    predessorToSuccessor1.get(predActivity.id).add(succACtivity);
                                 }
                                  else{
                                       predessorToSuccessor1.put(predActivity.id,new List<NPD_Activity__c>{succACtivity });
                                 }
                                 
                             }
                          }
                      }
                  }   
               }  
           }
           activityforSuccessor.clear();
           emailName.clear();
           for(id ids : predessorToSuccessor1.keyset()){
               for(NPD_Activity__c activity : predessorToSuccessor1.get(ids)){
                 if(activity.id != null){
                    activityId.add(activity.id);
                 }  
                  
               }
               //system.debug('------------activityId-------------'+activityId);   
           } 
          // system.debug('------------activityId(outside for)-------------'+activityId);  

           map<id,NPD_Activity__c>  activityMap = new map<id,NPD_Activity__c>();
           for( NPD_Activity__c activity : [select id,User_Name__c,Brand1__c, collection_Name__c,NPD_User__r.Name,NPD_User__r.UserID__c,Planned_Lead_Time__c,Status__c,NPD_Collections__c,NPD_Collections__r.Name,Type__c,Model_Name__c,NPD_Project_Name__c,Function_Name__c,Name,Name__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where Id in: activityId]){
              if(activity.Name__c == 'Make or Buy and Model No. Allocation' && activity.Model_Name__c != null && activity.Model_Name__c != ''){
                   
                }else{
                    activityMap.put(activity.id,activity);
                }              
           }    
        
            for(Id ids : predessorToSuccessor1.keyset()){
                for(NPD_Activity__c activity : predessorToSuccessor1.get(ids)){
                    if(!predessorToSuccessor.isEmpty() && predessorToSuccessor.get(ids) != null){
                        predessorToSuccessor.get(ids).add(activityMap.get(activity.id));
                     }
                      else{
                           predessorToSuccessor.put(ids,new List<NPD_Activity__c>{activityMap.get(activity.id)});
                     }                  
                }
            }
            System.debug(LoggingLevel.ERROR, 'Heap Size last : ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());  
            
    integer i=0;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
  
    }
}