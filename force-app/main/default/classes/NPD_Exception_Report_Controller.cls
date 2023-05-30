public class NPD_Exception_Report_Controller{

        public transient  map<String,List<String>> emailpredecessorToSuccessor;
        public transient  map<id,List<NPD_Activity__c>> activityforPredessor;
        public transient map<id,List<NPD_Activity__c>> activityforSuccessor;
        public transient map<id,List<NPD_Activity__c>>  predessorToSuccessor{get;set;}
        public transient  map<id,NPD_Activity__c> activityforPredessordisplay{get;set;}
        public String FunName  = null;
        
        public NPD_Exception_Report_Controller(){
            FunName = apexpages.currentpage().getparameters().get('functionName');
            succssorActivityMap();
            
        }

        public void succssorActivityMap(){
        
            predessorToSuccessor = new map<id,List<NPD_Activity__c>>();
            emailpredecessorToSuccessor = new Map<String,List<String>>();
            activityforPredessor = new Map<id,List<NPD_Activity__c>>();
            activityforSuccessor = new Map<id,List<NPD_Activity__c>>();
            activityforPredessordisplay = new map<id,NPD_Activity__c>();
            list<String> emailName  = new List<String>();
           
            List<NPD_Activity__c> accsuccAct;
            List<NPD_Email__c> emailList = [select id,Name,
             NPD_Activity__c,
             NPD_Project_Items__r.Project_Template__r.Name,
             NPD_Project_Items__c,parentActName__c,Act_Name__c,
             Source__c, Type__c FROM NPD_Email__c where Type__c=: 'Successor' AND NPD_Project_Items__r.Project_Template__r.Name = : 'Regular'];
             
             for(NPD_Email__c email : emailList){
                 emailName.add(email.Act_Name__c);
                          System.debug('emailpredecessorToSuccessor'+email.Act_Name__c);

                 if(!emailpredecessorToSuccessor.isEmpty() && emailpredecessorToSuccessor.get(email.parentActName__c) != null && emailpredecessorToSuccessor.containsKey(email.parentActName__c)){
                      emailpredecessorToSuccessor.get(email.parentActName__c).add(email.Act_Name__c);
                 }
                 else{
                     emailpredecessorToSuccessor.put(email.parentActName__c,new List<String>{email.Act_Name__c});
                 }
             
             }
             //System.debug('emailpredecessorToSuccessor'+emailName);
            //System.debug('----------------emailpredecessorToSuccessor----------------'+emailpredecessorToSuccessor.values());
              List<NPD_Activity__c> lPredecessorACtivity = [select id,User_Name__c,Brand1__c, collection_Name__c,NPD_User__r.Name,NPD_User__r.UserID__c,Planned_Lead_Time__c,NPD_Collections__c,NPD_Collections__r.Name,Status__c,Type__c ,Model_Name__c,NPD_Project_Name__c,Function_Name__c,Name,Name__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where Status__c = 'Completed' AND Actual_End_Date__c != null and Name__c in: emailpredecessorToSuccessor.keyset() AND NPD_Project_Name__c != null AND NPD_Collections__r.Name != null AND Active__c = True];
             
            //System.debug('--------------------lPredecessorACtivity-----------------'+lPredecessorACtivity);
            
            for(NPD_Activity__c activity : lPredecessorACtivity){
                 activityforPredessordisplay.put(activity.id,activity);
                if(!activityforPredessor.isEmpty() && activityforPredessor.containsKey(activity.NPD_Project_Name__c) && activityforPredessor.get(activity.NPD_Project_Name__c) != null){
                activityforPredessor.get(activity.NPD_Project_Name__c).add(activity);
                }else{
                activityforPredessor.put(activity.NPD_Project_Name__c,new List<NPD_Activity__c>{activity});
                }
             }
            //System.debug('--------------------activityforPredessor-----------------'+activityforPredessor.values());
            
             List<NPD_Activity__c> lSuccessorACtivity = [select id,User_Name__c,Brand1__c, collection_Name__c,NPD_User__r.Name,NPD_User__r.UserID__c,Planned_Lead_Time__c,Status__c,NPD_Collections__c,NPD_Collections__r.Name,Type__c,Model_Name__c,NPD_Project_Name__c,Function_Name__c,Name,Name__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where (Status__c = 'In Progress' OR Status__c = 'Not Started' Or Name__c = 'New Movement Certification') and Name__c in:emailName AND NPD_Project_Name__c != null  AND NPD_Collections__r.Name != null AND Active__c = True AND Function_Name__c =: FunName];
            //System.debug('--------------------lSuccessorACtivity-----------------'+lSuccessorACtivity); 
            for(NPD_Activity__c activity : lSuccessorACtivity){
                 System.debug('activity.Name__c'+activity.Name__c);
                if(!activityforSuccessor.isEmpty() && activityforSuccessor.containsKey(activity.NPD_Project_Name__c) && activityforSuccessor.get(activity.NPD_Project_Name__c) != null){
                activityforSuccessor.get(activity.NPD_Project_Name__c).add(activity);
                }else{
                activityforSuccessor.put(activity.NPD_Project_Name__c,new List<NPD_Activity__c>{activity});
                }
             }
            //System.debug('--------------------activityforSuccessor-----------------'+activityforSuccessor.values()); 
             
           for(id projectId : activityforPredessor.keyset()){
               for(NPD_Activity__c predActivity : activityforPredessor.get(projectId)){
                  for(String PredActName : emailpredecessorToSuccessor.get(predActivity.Name__c)){
                      if(activityforSuccessor.get(projectId) != null){
                          for(NPD_Activity__c succACtivity : activityforSuccessor.get(projectId)){
                             if(succACtivity.Name__c == PredActName && succACtivity.Planned_Lead_Time__c != null && predActivity.Actual_End_Date__c.addDays(integer.valueOf(succACtivity.Planned_Lead_Time__c)) < System.today()){
                                  if(!predessorToSuccessor.isEmpty() && predessorToSuccessor.get(predActivity.id) != null){
                                    predessorToSuccessor.get(predActivity.id).add(succACtivity);
                                    //SYstem.debug('inside if');
                                 }
                                  else{
                                        predessorToSuccessor.put(predActivity.id,new List<NPD_Activity__c>{succACtivity });
                                        //system.debug('inside else');
                                 }
                                 
                             }
                          }
                      }
                  }   
               }  
           }
           System.debug('predessorToSuccessor'+predessorToSuccessor.keyset().size());
           for(id ids : predessorToSuccessor.keyset()){
                                  System.debug('parent activity id'+ids);
               for(NPD_Activity__c activity : predessorToSuccessor.get(ids)){
                   System.debug('activity name'+activity.Name__c);
               }
           }
        }
       
    }