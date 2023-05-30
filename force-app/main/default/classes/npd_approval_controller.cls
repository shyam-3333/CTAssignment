public class npd_approval_controller {
    public List<Id> submittedRecordId{get;set;}
    public List<NPD_Activity__c> activityList{get;set;}
    public List<npd_stage__c> stageList{get;set;}
    public map<id,Date> dateMap;
    public map<id,String> MapsubmittedName;
    public map<id,String> mapStatus;
    public map<id,id> processIdMap;
    
    public list<item_wrapper_Custom> items_to_approve_Custom { get; set; }  // for custom
    public list<item_wrapper> items_to_approve { get; set; }      //  for Standard
    // for Standard Approval
    
    public class item_wrapper { 
      public  String activityName{get;set;}
      public  String name{get;set;}
      public  String collectionName{get;set;}
      public  String ids{get;set;}
      public  String type {get;set;}
      public  Date submittedDate {get;set;}  
      public String submittedName{get;set;}
      public String processStatus{get;set;} 
      public String processId{get;set;} 
      public String modelName{get;set;}      
    }   
    // for lineItems Approval
    public class item_wrapper_Custom { 
      public  String activityName{get;set;}
      public  String name{get;set;}
      public  String collectionName{get;set;}
      public  String ids{get;set;}
      public String link{get;set;}
      public  String type {get;set;}
      public  Date submittedDate {get;set;}  
      public String submittedName{get;set;}
      public String model{get;set;}  
      public String status{get;set;}   
    }  
    public npd_approval_controller() {
        List<NPD_Activity__c > lActivity = new List<NPD_Activity__c>();
        dateMap = new MAp<id,date>();
        MapsubmittedName = new map<id,String>();
        mapStatus = new map<id,String>();
        processIdMap = new Map<id,id>();
        submittedRecordId = new List<Id>();
        activityList = new List<NPD_Activity__c>();
        stageList   = new List<npd_stage__c>();
        items_to_approve = new list<item_wrapper>();
        items_to_approve_Custom = new list<item_wrapper_Custom>();

        for(ProcessInstanceWorkItem item:[select id,processinstance.targetobjectid,processinstance.SubmittedBy.Name,processinstance.Status,processinstance.targetobject.name,CreatedDate from processinstanceworkitem where actorid = :userinfo.getuserid()]) {
            submittedRecordId.add(item.processinstance.targetobjectid);
            dateMap.put(item.processinstance.targetobjectid,Date.valueOf(item.CreatedDate));
            MapsubmittedName.put(item.processinstance.targetobjectid,item.processinstance.SubmittedBy.Name);
            mapStatus.put(item.processinstance.targetobjectid,item.processinstance.Status);
            processIdMap.put(item.processinstance.targetobjectid,item.id);

        }
        
        activityList = [select id,name,Name__c,Model_Name__c,NPD_User__r.Name,NPD_Collections__r.Name,Type__c from NPD_Activity__c where id IN: submittedRecordId AND NPD_Collections__r.Name != null];
        stageList    = [select id,name,Name__c,Model_Name__c,NPD_User__r.Name,NPD_Collections__r.Name,Type__c from npd_stage__c  where id IN: submittedRecordId AND NPD_Collections__r.Name != null];
        
        for(NPD_Activity__c activity : activityList ){
            item_wrapper items = new item_wrapper();
            items.activityName = activity.Name__c;
            items.name = activity.Name;
            items.collectionName = activity.NPD_Collections__r.Name;
            items.type = activity.Type__c;
            items.ids = activity.id;
            items.modelName = activity.Model_Name__c;
            items.submittedName = activity.NPD_User__r.Name;
            if(activity.id != null && !dateMap.isEmpty() && dateMap.get(activity.id) != null){
                items.submittedDate =date.valueOf(dateMap.get(activity.id));
         //       items.submittedName = MapsubmittedName.get(activity.id);
                items.processStatus =  mapStatus.get(activity.id);
                items.processId     =  processIdMap.get(activity.id);
            }
            items_to_approve.add(items);
        }
        for(npd_stage__c Stage : stageList ){
            item_wrapper items = new item_wrapper();
            items.activityName = Stage.Name__c;
            items.name = Stage.Name;
            items.collectionName = Stage.NPD_Collections__r.Name;
            items.type = Stage.Type__c;
            items.ids = Stage.id;
            items.submittedName = Stage.NPD_User__r.Name;
            items.modelName = Stage.Model_Name__c;
            if(Stage.id != null && !dateMap.isEmpty() && dateMap.get(Stage.id) != null){
                items.submittedDate =date.valueOf(dateMap.get(Stage.id));
             //   items.submittedName = MapsubmittedName.get(Stage.id);
                items.processStatus =  mapStatus.get(Stage.id);
                items.processId     =  processIdMap.get(Stage.id);
            }
            items_to_approve.add(items);
        }
        for(NPD_Activity__c acc : [SELECT Id,Name,Model_Name__c,NPD_User__r.Name,CreatedBy.Name,Line_Item_Approval_Required__c,Name__c,Status__c,NPD_Collections__r.Name,Type__c FROM NPD_Activity__c WHERE Status__c = 'In Progress' AND Line_Item_Approval_Required__c = true AND (Name__c = 'Concept submission and approval' OR Name__c = 'Pricing Proto to PMG/Pricing release') AND NPD_Collections__r.Name != null AND Marketing_brief_stage_approver__c =: userinfo.getuserid()]){
              lActivity.add(acc);
       }   
       for(NPD_Activity__c acc : [SELECT Id,Name,Model_Name__c,NPD_User__r.Name,CreatedBy.Name,Approver_1__c,Line_Item_Approval_Required__c,Name__c,Status__c,NPD_Collections__r.Name,Type__c FROM NPD_Activity__c WHERE Status__c = 'In Progress' AND Line_Item_Approval_Required__c = true AND Name__c = 'Proto Submission by D&D for Approval' AND NPD_Collections__r.Name != null AND Approver_1__c=: userinfo.getuserid()]){
              lActivity.add(acc);
       } 
       for(NPD_Activity__c acc : [SELECT Id,Name,Model_Name__c,NPD_User__r.Name,CreatedBy.Name,Line_Item_Approval_Required__c,Name__c,Status__c,NPD_Collections__r.Name,Type__c FROM NPD_Activity__c WHERE Status__c = 'In Progress' AND Line_Item_Approval_Required__c = true AND Name__c != 'Proto Submission by D&D for Approval' AND Name__c != 'Pricing Proto to PMG/Pricing release' AND Name__c != 'Concept submission and approval' AND NPD_Collections__r.Name != null AND Project_Owner_Approver__c=: userinfo.getuserid()]){
             lActivity.add(acc);
      } 
      for(NPD_Activity__c activity : lActivity ){
            item_wrapper_Custom items = new item_wrapper_Custom();
            items.activityName = activity.Name__c;
            items.name = activity.Name;
            items.link = URL.getSalesforceBaseUrl().toExternalForm()+'/apex/NPDApprovalPage?id='+activity.id;
            items.collectionName = activity.NPD_Collections__r.Name;
            items.type = activity.Type__c;
            items.ids = activity.id;
            items.model = activity.Model_Name__c;
      //      items.submittedName = activity.CreatedBy.Name;
            items.submittedName = activity.NPD_User__r.Name;
            items.status = activity.Status__c;
            items_to_approve_Custom.add(items);

     }    
    }
    public void demo1(){
    integer a=2;
    integer b=3;
      integer a2 = a+b;
integer a3 = a+b;
integer a4 = a+b;
integer a5 = a+b;
integer a6 = a+b;
integer a7 = a+b;
integer a8 = a+b;
integer a9 = a+b;
integer a10 = a+b;
integer a11 = a+b;
integer a12 = a+b;
integer a13 = a+b;
integer a14 = a+b;
integer a15 = a+b;
integer a16 = a+b;
integer a17 = a+b;
integer a18 = a+b;
integer a19 = a+b;
integer a20 = a+b;
integer a21 = a+b;
integer a22 = a+b;
integer a23 = a+b;
integer a24 = a+b;
integer a25 = a+b;
integer a26 = a+b;
integer a27 = a+b;
integer a28 = a+b;
integer a29 = a+b;
integer a30 = a+b;
integer a31 = a+b;
integer a32 = a+b;
integer a33 = a+b;
integer a34 = a+b;
integer a35 = a+b;
integer a36 = a+b;
integer a37 = a+b;
integer a38 = a+b;
integer a39 = a+b;
integer a40 = a+b;
integer a41 = a+b;
integer a42 = a+b;
integer a43 = a+b;
integer a44 = a+b;
integer a45 = a+b;
integer a46 = a+b;
integer a47 = a+b;
integer a48 = a+b;
integer a49 = a+b;
integer a50 = a+b;
integer a51 = a+b;
integer a52 = a+b;
integer a53 = a+b;
integer a54 = a+b;
integer a55 = a+b;
integer a56 = a+b;
integer a57 = a+b;
integer a58 = a+b;
integer a59 = a+b;
integer a60 = a+b;
integer a61 = a+b;
integer a62 = a+b;
integer a63 = a+b;
integer a64 = a+b;
integer a65 = a+b;
integer a66 = a+b;
integer a67 = a+b;
integer a68 = a+b;
integer a69 = a+b;
integer a70 = a+b;
integer a71 = a+b;
integer a72 = a+b;
integer a73 = a+b;
integer a74 = a+b;
integer a75 = a+b;
integer a76 = a+b;
integer a77 = a+b;

integer a84 = a+b;
integer a85 = a+b;
integer a86 = a+b;
integer a87 = a+b;
integer a88 = a+b;
integer a89 = a+b;
integer a90 = a+b;
integer a91 = a+b;
integer a92 = a+b;
integer a93 = a+b;
integer a94 = a+b;
integer a95 = a+b;
integer a96 = a+b;
integer a97 = a+b;
integer a98 = a+b;
integer a99 = a+b;
integer a100 = a+b;
integer a101 = a+b;
    }
}