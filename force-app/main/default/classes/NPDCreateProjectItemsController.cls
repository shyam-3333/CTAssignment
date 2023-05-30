/*********************************************************************
   Name         : NPDCreateProjectItemsController
   Description  : This class is used to create project items
   Created By   : Manjula@KVP
   Created Date : 01/04/2015
   
   REVISION HISTORY
   ================
   
   Date          By                  Description
   ---------------------------------------------------------------
    
   
*********************************************************************/


global class NPDCreateProjectItemsController {
    public string strType{get;set;}    
     Public String complexType {get; set;}
     Public String ActivityName {get; set;}
    public Decimal numLeadTime {get;set;}
    public String strLeadTime {get; set;}
    public String strComCat {get; set;}
    public String strCheklistName{get;set;}
    public String strCopyTableName{get; set;}
    public String strPIRecName{get;set;}   
    public String strComplexity{get;set;}
    public String  strPageMsg{get;set;}    
    public String strActionId{get;set;}
    public string strName{get;set;}
    public String strEvent{get;set;}
    public String strParentTypeId {get;set;}
    public Decimal strPosition {get;set;}
    public String strItemType{get;set;}
    public boolean displayPopup {get; set;}
    public boolean pageMsg {get;set;}   
    public Id templateId{get;set;}    
    public List<Id> stageList{get;set;}
    public List<Id> subStageList{get;set;}
    public List<Id> activityList{get;set;}
    public List<Id> subActivityList{get;set;}
    public set<id> substageset {get;set;}
    public set<id> activityset {get;set;}
    public set<id> subActivityset {get;set;}  
    public NPD_Project_Items__c PitemNewRec{get;set;}
    
    public List<checkListWrapper> checkListWrapperList {get; set;} 
    public List<projectItemWrapper> projectItemWrapperList{get;set;}         
    public List<NPD_Project_Items__c> projectItemList{get;set;}
    public map<id,List<NPD_Project_Items__c>>mapSubStage_StageId {get;set;}
    public map<id,List<NPD_Project_Items__c>>mapActivty_SubStageId {get;set;}
    public map<id,List<NPD_Project_Items__c>>mapSubActivity_ActivityId {get;set;}
    public map<id,List<NPD_Project_Items__c>>mapStage_StageId {get;set;}    
    public List<String> checkListColumnFieldsList {get;set;} 
    public List<NPD_Complexity__c> complexityList{get;set;}  
    
    public List<complexWrapper> ComplexWrapperList{get; set;}
    
    NPD_UtilityController utility;
    
    //Constructor
    public NPDCreateProjectItemsController()
    {       
        displayPopUp = false;
        pageMsg = false;
        
        //Get id of the template        
        templateId =  apexpages.currentpage().getparameters().get('templateId');       
        checkListColumnFieldsList = new List<String>();        
        PitemNewRec = new NPD_Project_Items__c(); 
        
        //calling a method to dispaly check list fields as field labels of NPD_Checklist Object s   
        allChecklistFields();
       
        projectItemsCreation();
        utility = new NPD_UtilityController();
        
        //Parameters used to dispaly successor items for the project item
        if(apexpages.currentpage().getparameters().get('ItemId') != null)
        strActionId =  apexpages.currentpage().getparameters().get('ItemId');
        if(apexpages.currentpage().getparameters().get('position') != null)      
        strPosition =  Decimal.valueOf(apexpages.currentpage().getparameters().get('position'));
        if(apexpages.currentpage().getparameters().get('parentId') != null)    
        strParentTypeId =  apexpages.currentpage().getparameters().get('parentId');
        if(apexpages.currentpage().getparameters().get('itemName') != null)    
        strName =  apexpages.currentpage().getparameters().get('itemName');
        
        //Method to display successor items
        allProjectItems(strActionId,strPosition,strParentTypeId,strName,templateId); 
    }    
    
    //Method to display all Project items from the database
    public void projectItemsCreation(){   
       
        mapSubStage_StageId= new map<id,List<NPD_Project_Items__c>>();
        mapActivty_SubStageId =new map<id,List<NPD_Project_Items__c>>();
        mapSubActivity_ActivityId= new map<id,List<NPD_Project_Items__c>>();
        mapStage_StageId= new map<id,List<NPD_Project_Items__c>>();
        templateId = apexpages.currentpage().getparameters().get('templateId');  
        for(NPD_Project_Items__c n:[Select n.id,n.Name,n.Titan_Sr_No__c,n.Titan_SNo_Predecessor__c,n.Position__c,n.Predecessor__r.Name,n.Title__c ,n.Predecessor__c,n.Total_Lead_Time__c, n.Complexity__c ,n.Department__c,n.Department__r.Name,n.Parent_Id__c,n.Parent_Id__r.name, n.Lead_Time__c, n.Item_Type__c, n.Days_to_Complete__c From NPD_Project_Items__c n where Project_Template__c =:templateId  order by Position__c ASC ])
        {   
            if(n.Item_Type__c=='Stage'){
                if(mapStage_StageId.containsKey(n.Id)){                   
                    mapStage_StageId.get(n.id).add(n);                       
                }
                else{                                                        
                    mapStage_StageId.put(n.id,new List<NPD_Project_Items__c> {n});   
                }
            }             
            if(n.Item_Type__c=='Sub-stage'){
                if(mapSubStage_StageId.containsKey(n.parent_id__c)){
                    mapSubStage_StageId.get(n.parent_id__c).add(n);
                }
                else{                   
                    mapSubStage_StageId.put(n.parent_id__c,new List<NPD_Project_Items__c> {n});   
                }
            }
            if(n.Item_Type__c=='Activity'){
                if(mapActivty_SubStageId.containsKey(n.parent_id__c)){
                    mapActivty_SubStageId.get(n.parent_id__c).add(n);
                }
                else{                                             
                    mapActivty_SubStageId.put(n.parent_id__c,new List<NPD_Project_Items__c> {n});   
                }
            }
            if(n.Item_Type__c=='Sub-Activity'){
                if(mapSubActivity_ActivityId.containsKey(n.parent_id__c)){
                    mapSubActivity_ActivityId.get(n.parent_id__c).add(n);
                }
                else{                         
                    mapSubActivity_ActivityId.put(n.parent_id__c,new List<NPD_Project_Items__c> {n});   
                }  
            }           
        } 
        
        //Call the nethod to dispaly all project items based on position in sorting order    
        positionSort();
    }   
   
    //Method to delete particular item and it will call trigger then it will delete all child records also
    public void DeleteRow(){ 
        NPD_Project_Items__c deleteItem = [Select Id from NPD_Project_Items__c where id =: strActionId];
        delete deleteItem;        
        projectItemsCreation();
    }
    
    //Method to edit the project item
    public void EditRec(){ 
        strPageMsg ='';
        showPopup();
            if(strEvent=='create'){                 
                    PitemNewRec= new NPD_Project_Items__c ();
                    PitemNewRec.Active__c = true;                 
            }            
            if(strEvent=='edit'){
                PitemNewRec = [ SELECT  Id,Complexity__c,Department__c,Position__c,Item_Type__c,Project_Template__c,Parent_Id__c,Active__c,    
                                       Successor_Item_Alerts__c,Checklist_Columns__c,Titan_Sr_No__c,Title__c,Predecessor__c,
                                       Approval_Req__c,Email_on_Completion__c,Attachment_Req__c,Columns_to_Copy__c,Complexity_Type__c,Complexity_Category__c,                      
                                       Days_to_Complete__c,Lead_Time__c 
                                FROM NPD_Project_Items__c 
                                WHERE id =: strActionId]; 
            }
            
        }
    
    //Method to save the Project items
    public void stageSave(){
       
        List<NPD_Project_Items__c> itemList = [Select Id,Item_Type__c from  NPD_Project_Items__c where Item_Type__c =: strName and Parent_id__c =: strActionId and Project_Template__c =:templateId ];
        List<NPD_Project_Items__c> StageList1 = [Select Id,Item_Type__c from  NPD_Project_Items__c where Item_Type__c =: 'Stage'  and Project_Template__c =:templateId ];
        List<NPD_Project_Items__c> subStageList = [Select Id,Item_Type__c from  NPD_Project_Items__c where Item_Type__c =: 'Sub-stage' and Parent_id__c =: strParentTypeId and Project_Template__c =:templateId ];
        List<NPD_Project_Items__c> activityList = [Select Id,Item_Type__c from  NPD_Project_Items__c where Item_Type__c =: 'Activity' and Parent_id__c =: strParentTypeId and Project_Template__c =:templateId ];
        NPD_Project_Items__c predecessorRec ;
        system.debug('==itemList=='+itemList.size());
        if(itemList.size()>0){     
                        
                                    
            predecessorRec = [select id,Titan_Sr_No__c,Titan_SNo_Predecessor__c,Position__c from NPD_Project_Items__c where  Item_Type__c =: strName and Project_Template__c =:templateId and Parent_id__c =: strActionId and  Position__c =:itemList.size()  ];
                system.debug('==predecessorRec=='+predecessorRec);
        }        
        try{ 
                if(strEvent == 'create')
                {                
                    pageMsg = false;
                    strPageMsg ='';
                    PitemNewRec.Item_Type__c = strName ;
                    PitemNewRec.Project_Template__c = templateId;
                    if(strActionId!= null && strActionId!='' )
                        PitemNewRec.Parent_Id__c = strActionId; 
                        system.debug('itemList-----------------'+itemList);
                    if(itemList.size() == 0){
                        system.debug('iffffffffffffffff');
                        try{ 
                            PitemNewRec.Position__c =1;               
                            insert PitemNewRec; 
                            
                            //calling the method from utility class to get sub stage titan reference number
                            if(PitemNewRec.item_Type__c == 'Sub-stage')                                            
                            utility.generateSerialNo(StageList1,'Titan_Sr_No__c','Titan_Sr_No__c' ,'NPD_Project_Items__c','NPD_Project_Items__r','SubStage');                        
                            
                            //calling the method from utility class to get activity titan reference number
                           // if(PitemNewRec.item_Type__c == 'Activity' )
                           // utility.generateSerialNo(subStageList,'Titan_Sr_No__c','Titan_Sr_No__c' ,'NPD_Project_Items__c','NPD_Project_Items__r','Activity');
                            
                            //calling the method from utility class to get Sub activity titan reference number
                          //  if(PitemNewRec.item_Type__c == 'Sub-Activity')
                          //  utility.generateSerialNo(activityList,'Titan_Sr_No__c','Titan_Sr_No__c' ,'NPD_Project_Items__c','NPD_Project_Items__r','Sub-Activity');
                        }
                        catch(Exception e){
                            apexpages.addMessages(e);
                            
                            //Message to display Titan sr No duplication
                            if(e.getMessage().contains('DUPLICATE_VALUE, duplicate value found: Titan_Sr_No__c')){
                                strPageMsg= 'Duplicate value found: Titan_Sr_No__c';
                            }
                            pageMsg = true;
                        } 
                    }     
                    else if(itemList.size() > 0){
                        system.debug('esleeeeeeeeeeeeeeeeeeeeeeeeeeee');
                        PitemNewRec.Item_Type__c = strName ;
                        PitemNewRec.Project_Template__c = templateId; 
                        PitemNewRec.Predecessor__c = predecessorRec.id;                        
                        PitemNewRec.Titan_SNo_Predecessor__c = predecessorRec.Titan_Sr_No__c; 
                        try{
                            pageMsg = false;
                            PitemNewRec.Position__c =itemList.size()+1;
                            insert PitemNewRec;
                            
                            //calling the method from utility class to get sub stage titan reference number
                            if(PitemNewRec.item_Type__c == 'Sub-stage')                                            
                            utility.generateSerialNo(StageList1,'Titan_Sr_No__c','Titan_Sr_No__c' ,'NPD_Project_Items__c','NPD_Project_Items__r','SubStage');                        
                           
                             //calling the method from utility class to get activity titan reference number
                            if(PitemNewRec.item_Type__c == 'Activity' )
                            utility.generateSerialNo(subStageList,'Titan_Sr_No__c','Titan_Sr_No__c' ,'NPD_Project_Items__c','NPD_Project_Items__r','Activity');
                           
                            //calling the method from utility class to get Sub activity titan reference number
                            if(PitemNewRec.item_Type__c == 'Sub-Activity')
                            utility.generateSerialNo(activityList,'Titan_Sr_No__c','Titan_Sr_No__c' ,'NPD_Project_Items__c','NPD_Project_Items__r','Sub-Activity');
                           
                        }
                        catch(Exception e){
                            apexpages.addMessages(e);
                            
                            //Message to display Titan sr No duplication
                            if(e.getMessage().contains('DUPLICATE_VALUE, duplicate value found: Titan_Sr_No__c')){
                                strPageMsg= 'Duplicate value found: Titan_Sr_No__c';
                            }
                            pageMsg = true;                       
                        } 
                    }         
                }               
                
                if(strEvent == 'edit'){               
                    if((PitemNewRec.Email_on_Completion__c == false && PitemNewRec.Successor_Item_Alerts__c == null) || (PitemNewRec.Email_on_Completion__c == true && PitemNewRec.Successor_Item_Alerts__c != null ))
                    {
                    try{
                       strPageMsg= '';
                       pageMsg = false;   
                       update PitemNewRec;   
                    }
                    catch(Exception e){
                           pageMsg = true;
                    }
                }
                else{  
                     pageMsg = true;                                    
                     strPageMsg = 'Email on Completion and Successor item Alerts both are required';
                    } 
                }           
           }   
            catch(Exception e){
                apexpages.addMessages(e);
                pageMsg = true;             
            }
            List<NPD_Project_Items__c> addList = new List<NPD_Project_Items__c>();
            addList.add(PitemNewRec);
            
            if(strName == 'Stage' && strEvent == 'create'){
                mapStage_StageId.put(PitemNewRec.Id,addList);                
            }
            if(strName == 'Sub-stage' && strEvent == 'create'){
                mapSubStage_StageId.put(PitemNewRec.parent_id__c,addList);
            }
            if(strName == 'Activity' && strEvent == 'create'){        
                mapActivty_SubStageId.put(PitemNewRec.parent_id__c,addList);
            }
            if(strName == 'Sub-Activity' && strEvent == 'create'){         
                mapSubActivity_ActivityId.put(PitemNewRec.parent_id__c,addList);
            }
            
            //Method to call rollup of child lead time to parent total lead time
            callRollupLeadTime();
            
            
            projectItemsCreation(); 
            if(pageMsg  == false)
            closePopup();       
    }
 
    //Method to sort items based on position  
    public void positionSort(){
    
        stageList = new List<id>();        
        subStageList = new List<Id>();     
        activityList = new List<Id>();     
        subActivityList = new List<Id>();
        
        substageset = new set<id>();
        activityset = new set<id>();
        subActivityset = new set<id>();
       
        Map<Decimal,Id> positionMap = new Map<Decimal,Id>();
        List<Decimal> positionList = new List<Decimal>();
        List<Decimal> positionSubstageList = new List<Decimal>();
        List<Decimal> positionActivityList = new List<Decimal>();
        List<Decimal> positionSubActivityList = new List<Decimal>();
        
        //Preparing a map to sort the stage items based on position
        for(List<NPD_Project_Items__c > wrap : mapStage_StageId.values()){
            for(NPD_Project_Items__c rec: wrap){
                positionMap.put(rec.Position__c,rec.id);    
            }            
        }
        positionList.addAll(positionMap.keyset());        
        positionList.sort();       
        for(Decimal i : positionList ){
            Id recId = positionMap.get(i);
            stageList.add(recId );
        }
        positionList.clear();
        Map<decimal,set<id>> positionMap_Childs =  new Map<decimal,set<id>>();  
        
        //Preparing a map to sort the sub stage items based on position      
        for(List<NPD_Project_Items__c > wrap : mapSubStage_StageId.values()){
            for(NPD_Project_Items__c rec: wrap){
                if(positionMap_Childs.containsKey(rec.Position__c)){                    
                    positionMap_Childs.get(rec.Position__c).add(rec.parent_id__c);
                }
                else{
                    positionMap_Childs.put(rec.Position__c,new set<id>{rec.parent_id__c});   
                }               
            }            
        }
        positionList.addAll(positionMap_Childs.keyset());        
        positionList.sort(); 
        
        //storing the substage keys as set to avoid duplications to display in page          
        for(Decimal i : positionList){         
            substageset.addAll(positionMap_Childs.get(i));
            subStageList.addAll(substageset);
        }
        positionList.clear();
        positionMap_Childs =  new Map<decimal,set<id>>(); 
        
        //Preparing a map to sort the activity items based on position to display in page   
        for(List<NPD_Project_Items__c > wrap : mapActivty_SubStageId.values()){
            for(NPD_Project_Items__c rec: wrap){
                if(positionMap_Childs.containsKey(rec.Position__c)){
                    positionMap_Childs.get(rec.Position__c).add(rec.parent_id__c);
                }
                else{
                    positionMap_Childs.put(rec.Position__c,new set<id>{rec.parent_id__c});   
                }
            }            
        }
        
        positionList.addAll(positionMap_Childs.keyset());        
        positionList.sort();
        
        //storing the activity keys as set to avoid duplications to display in page
        for(Decimal i : positionList){         
            activityset.addAll(positionMap_Childs.get(i));
            activityList.addAll(activityset);
        }
        
        positionList.clear();
        positionMap_Childs =  new Map<decimal,set<id>>(); 
        
        //Preparing a map to sort the sub activity items based on position     
        for(List<NPD_Project_Items__c > wrap : mapSubActivity_ActivityId.values()){
            for(NPD_Project_Items__c rec: wrap){
                if(positionMap_Childs.containsKey(rec.Position__c)){
                    positionMap_Childs.get(rec.Position__c).add(rec.parent_id__c);
                }
                else{
                   positionMap_Childs.put(rec.Position__c,new set<id>{rec.parent_id__c});   
                }
            }            
        }
        
        positionList.addAll(positionMap_Childs.keyset());        
        positionList.sort();  
        
        //storing the activity keys as set to avoid duplications to display in page        
        for(Decimal i : positionList){         
            subActivityset.addAll(positionMap_Childs.get(i));
            subActivityList.addAll(subActivityset);
        }
    }
    
    //Method to move up and down of items
   /* public void upAndDown(){
   
    List<NPD_Project_Items__c> addList ;
    List<NPD_Project_Items__c> upPrdecessorRecList = new List<NPD_Project_Items__c>();
    NPD_Project_Items__c upRec = new NPD_Project_Items__c();
    NPD_Project_Items__c downRec = new NPD_Project_Items__c();
    List<NPD_Project_Items__c> exist_PredecessorRecList;
    NPD_Project_Items__c existPredecessorRec = new NPD_Project_Items__c();
    
        if(strEvent == 'down'){
               addList = new  list<NPD_Project_Items__c >();
               upRec = new NPD_Project_Items__c();
               downRec = new NPD_Project_Items__c();
            
            try{
             downRec= [select id,Position__c,Predecessor__c,Titan_Sr_No__c,Titan_SNo_Predecessor__c,Title__C from NPD_Project_Items__c where id=:strActionId and Position__c =:strPosition and Parent_id__c =: strParentTypeId and Item_type__c =: strItemType and Project_Template__c =:templateId  limit 1 ];
           
            downRec.Position__c  = strPosition + 1;  
                    
            upRec= [select id,Position__c,Predecessor__c ,Title__C,Titan_Sr_No__c,Titan_SNo_Predecessor__c  from NPD_Project_Items__c where Position__c =: strPosition +1  and Parent_id__c =: strParentTypeId and Item_type__c =: strItemType  and Project_Template__c =:templateId limit 1];
            upRec.Position__c = upRec.Position__c -1;
            
            upPrdecessorRecList= [select id,Position__c,Predecessor__c,Titan_Sr_No__c,Title__C,Titan_SNo_Predecessor__c   from NPD_Project_Items__c where Position__c =: strPosition-1  and Parent_id__c =: strParentTypeId and Item_type__c =: strItemType  and Project_Template__c =:templateId  limit 1];
            }
            catch(Exception e){
               
            }
            if(upPrdecessorRecList.size() > 0) {
                upRec.Predecessor__c = upPrdecessorRecList[0].Id;
                upRec.Titan_SNo_Predecessor__c =upPrdecessorRecList[0].Titan_Sr_No__c;
            }
            else{
                upRec.Predecessor__c = null;
                upRec.Titan_SNo_Predecessor__c = null;
            }
            downRec.Predecessor__c = upRec.Id ;
            downRec.Titan_SNo_Predecessor__c = upRec.Titan_Sr_No__c ;
            addList.add(downRec);
            addList.add(upRec);
            try{
                update addList;
            }catch(Exception e){                
            }
            
        }
        if(strEvent == 'up'){        
             addList = new  list<NPD_Project_Items__c >();
             upPrdecessorRecList = new List<NPD_Project_Items__c>();
             upRec = new NPD_Project_Items__c();
             downRec = new NPD_Project_Items__c();
             system.debug('strPosition---------'+strPosition);
            try{ 
                upRec= [select id,Position__c,Predecessor__c,Titan_Sr_No__c,Titan_SNo_Predecessor__c,Title__c from NPD_Project_Items__c where id=:strActionId and Position__c   =:strPosition and Parent_id__c =:strParentTypeId and Item_type__c =: strItemType  and Project_Template__c =:templateId limit 1 ];
                upRec.Position__c  = upRec.Position__c - 1;
                system.debug('upRec.Position__c----------'+upRec.Position__c);
                downRec= [select id,Position__c,Predecessor__c,Titan_Sr_No__c,Titan_SNo_Predecessor__c,Title__c  from NPD_Project_Items__c where Position__c =: strPosition - 1  and Parent_id__c =:strParentTypeId and Item_type__c =: strItemType  and Project_Template__c =:templateId  limit 1];
                downRec.Position__c = downRec.Position__c + 1;
                system.debug('downRec.Position__c----------'+downRec.Position__c);
                upPrdecessorRecList= [select id,Position__c,Titan_Sr_No__c,Titan_SNo_Predecessor__c,Predecessor__c  from NPD_Project_Items__c where Position__c =: strPosition -2  and Parent_id__c =:strParentTypeId and Item_type__c =: strItemType and Project_Template__c =:templateId limit 1];
                system.debug('upPrdecessorRecList----------'+upPrdecessorRecList);
                exist_PredecessorRecList = [select id,Position__c,Titan_Sr_No__c,Titan_SNo_Predecessor__c,Predecessor__c  from NPD_Project_Items__c where Position__c =: strPosition + 1  and Parent_id__c =:strParentTypeId and Item_type__c =: strItemType and Project_Template__c =:templateId limit 1];
                
            }
            catch(Exception e){
            }            
            if(upPrdecessorRecList.size() > 0) {
                upRec.Predecessor__c = upPrdecessorRecList[0].Id;
                upRec.Titan_SNo_Predecessor__c = upPrdecessorRecList[0].Titan_Sr_No__c;
                system.debug('upRec------------'+upRec);
            }
            else{
                upRec.Predecessor__c = null;
                upRec.Titan_SNo_Predecessor__c = null;
                system.debug('upRec--else----------'+upRec);
            }
            if(exist_PredecessorRecList.size()>0){
                existPredecessorRec.Predecessor__c = upRec.Id;
                existPredecessorRec.Titan_SNo_Predecessor__c = upRec.Titan_Sr_No__c;
            }
            downRec.Predecessor__c = upRec.Id ;
            downRec.Titan_SNo_Predecessor__c = upRec.Titan_Sr_No__c ;
            system.debug('downrec-11----------'+downRec);
             system.debug('upRec----11------'+upRec);
            addList.add(downRec);
            addList.add(upRec);
            addList.add(existPredecessorRec);
            try{
                system.debug('addList-------before-------'+addList);
                update addList; 
                system.debug('addList--------------'+addList);           
            }
            catch(Exception e){
            }
        }
    } */
    
    //Method to get complexity based on item from the utility class
    public void updateStageLeadTime(){ 
        /*Integer complexity;
        if(strComplexity!=null && strComplexity!='' ) {
            PitemNewRec.Lead_Time__c = Decimal.valueOf(NPD_UtilityController.calculateComplexityValue(strComplexity));
        }*/
        //callRollupLeadTime();
    }
    
    //Method to rollup of child lead time to parent total lead time
    public void callRollupLeadTime(){
        String strFiled ='';
        list<NPD_UtilityController.fieldDefinition> fieldDefinitions =  new list<NPD_UtilityController.fieldDefinition> {
           // new NPD_UtilityController.fieldDefinition('SUM', 'Lead_Time__c', 'Total_Lead_Time__c') 
           new NPD_UtilityController.fieldDefinition('SUM', 'Lead_Time__c', 'Lead_Time__c') 
        };
        
        system.debug('+++++strActionId++'+strActionId);
        List<NPD_Project_Items__c> projectItemsList = [Select Id,Parent_Id__c from NPD_Project_Items__c where Parent_Id__c =: strActionId]; 
        if(strName == 'Sub-stage'){
            NPD_UtilityController.rollUpLeadTime(fieldDefinitions, projectItemsList , 'NPD_Project_Items__c','Parent_Id__c', 'NPD_Project_Items__c', 'and item_Type__c =\'Sub-stage\'');
        }
       /* if(strName == 'Activity'){        
            NPD_UtilityController.rollUpLeadTime(fieldDefinitions, projectItemsList , 'NPD_Project_Items__c','Parent_Id__c', 'NPD_Project_Items__c', 'and item_Type__c =\'Activity\'');
        }
        if(strName == 'Sub-Activity'){        
            NPD_UtilityController.rollUpLeadTime(fieldDefinitions, projectItemsList , 'NPD_Project_Items__c','Parent_Id__c', 'NPD_Project_Items__c', 'and item_Type__c =\'Sub-Activity\'');
        }*/
        projectItemsCreation();
    }
    
    
    
    
    
    
    
    //Redirect to the project
    public PageReference redirectToProjectTemplate(){
      return new Pagereference('/'+templateId).setRedirect(true);
    } 
    
    public PageReference cancel(){ 
        return new Pagereference('/'+templateId).setRedirect(true); 
    }   
    
    public void closePopup()
    {       
        displayPopup = false;   
    } 
       
    public void showPopup()
    {       
        displayPopup = true;   
    }
    
    //Method to get selected checklist from the Checklist Columns 
    public void doCheckListSelection(){    
        strCheklistName=''; 
        strCopyTableName ='';           
        for(checkListWrapper cw : this.checkListWrapperList ){ 
            if(cw.selected==true){
            strCheklistName = strCheklistName +cw.field+',';
                     
            }
            if(cw.copied == true){
             strCopyTableName =  strCopyTableName +cw.field+',';
            }
        } 
        if(strCheklistName.length() >0) {      
        strCheklistName = strCheklistName.substring(0,strCheklistName.length()-1);       
        }
        if(strCopyTableName.length() > 0){
            strCopyTableName = strCopyTableName.substring(0,strCopyTableName.length()-1);
        }
    }
    
    //Method to get selected successor items from the Successor Item alerts 
    public void doProjectItemRecSelection(){    
        strPIRecName='';           
        for(projectItemWrapper cw : this.projectItemWrapperList){             
            if(cw.selected==true){
            strPIRecName= strPIRecName+cw.projectItem.Titan_Sr_No__c+',';             
            }
        }
        if(strPIRecName.length() >0)           
        strPIRecName= strPIRecName.substring(0,strPIRecName.length()-1); 
       
                                         
    }    
    
  
    
   
        
        
        
        public List<complexWrapper> getcomplexityValues(){   
            ComplexWrapperList = new List<complexWrapper>(); 
            complexType = ApexPages.currentPage().getParameters().get('comType');
             ActivityName =  ApexPages.currentPage().getParameters().get('title');
             system.debug('*********Name*****'+ActivityName);
             strType = ApexPages.currentPage().getParameters().get('type');
             
            if(complexType != NULL && complexType !=''){
            if(strType == 'Activity') { 
                 
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Complexity_Type__r.Name__c =:complexType AND Record_Type__c ='Complexity Category' AND NPD_Activity__c != NULL AND NPD_Activity__r.Title__c =: ActivityName AND Sub_Stage__r.Title__c= 'Case Development - INH']){
               
            ComplexWrapperList.add(new complexWrapper(com)); 
            }
            }
            else if(ActivityName == 'Case Development - INH'){
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Complexity_Type__r.Name__c =:complexType AND Complexity_Type__r.Name__c =:complexType AND Record_Type__c ='Complexity Category' AND Sub_Stage__c != NULL AND Sub_Stage__r.Title__c=: ActivityName]){
             ComplexWrapperList.add(new complexWrapper(com)); 
            }
         }
      }          
        return ComplexWrapperList;
    }   
    
    
    
    
    
    public List<complexWrapper> getcomplexityTypeValues(){  
            system.debug('**INher'); 
            ComplexWrapperList = new List<complexWrapper>(); 
            complexType = ApexPages.currentPage().getParameters().get('comType');
             ActivityName =  ApexPages.currentPage().getParameters().get('title');
             strType = ApexPages.currentPage().getParameters().get('type');
             
            if(complexType != NULL && complexType !=''){
            if(strType == 'Activity') { 
                 
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE  Record_Type__c ='Complexity Type' AND Type__c='Activity']){
               
            ComplexWrapperList.add(new complexWrapper(com)); 
            }
            }
            else {
            For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,Sub_Stage__c,Type__c,Lead_Time_del__c,Complexity_Type__c FROM NPD_Complexity__c WHERE Record_Type__c ='Complexity Type' AND Type__c ='Sub-stage']){
             ComplexWrapperList.add(new complexWrapper(com)); 
            }
         }
      }          
        return ComplexWrapperList;
    }   
        
        
        //Method to get selected checklist from the Checklist Columns 
    public void doComplexitySelection(){    
                 
        for(complexWrapper cw : ComplexWrapperList ){ 
            if(cw.selected == true){
            strComCat = cw.com.Name__c;
            if(cw.com.Lead_Time_del__c != NULL)
            numLeadTime = cw.com.Lead_Time_del__c;
                     
            }
         }
            
    }
        
        
        
        
        
        //Class for Complexity Category selection in popup
        public class complexWrapper{
        public Boolean selected {get; set;}  
        public NPD_Complexity__c com{get;set;}
        
            public complexWrapper(NPD_Complexity__c c) {           
                    com = c;
                    selected = false;
                    
            }
           }
       
    
    
    
   
    //Method to return as wrapper list of all checklist column fields
    public List<checkListWrapper> allChecklistFields(){   
        checkListWrapperList = new List<checkListWrapper>();        
        Map<String, Schema.SObjectField> objectFields = NPD_Checklist__c.getSObjectType().getDescribe().fields.getMap();
        List<String> fieldList = new List<String>();
        for(String field : objectFields.keySet()){             
            if(objectFields.get(field).getDescribe().isCustom()){  
            fieldList.add(string.valueOf(field));      
            checkListWrapperList.add(new checkListWrapper(string.valueOf(objectFields.get(field).getDescribe().getLabel()))); 
            }
        }                
        return checkListWrapperList;
    }    
    
     //Method to return as wrapper list of all successor items of particualr iteam
    public List<projectItemWrapper> allProjectItems(String ActionId,Decimal Position,String ParentTypeId,String ItemName,String templateId){
           
        projectItemWrapperList = new List<projectItemWrapper>();
        projectItemList = [Select Id,Name,Title__c,Titan_Sr_No__c,Complexity__c,Lead_Time__c,Department__c,Item_Type__c   from NPD_Project_Items__c where  
                                  Position__c >: Position and Parent_Id__c =:ParentTypeId and Item_Type__c =: ItemName and Project_Template__c =:templateId ];
        List<String> fieldList = new List<String>(); 
        for(NPD_Project_Items__c  rec :projectItemList  ){
            fieldList.add(string.valueOf(rec));    
            projectItemWrapperList.add(new projectItemWrapper(rec));
        }
        
        return projectItemWrapperList;
    }
    
    
    
    
    //Wrapper class used for to display successor items   
    public class projectItemWrapper{
        public Boolean selected {get; set;} 
        public string rec {get;set;}
        public NPD_Project_Items__c projectItem{get; set;}  
            public projectItemWrapper(NPD_Project_Items__c s) {
                projectItem = s;        
                selected = false;         
            }    
    }
    
    //Wrapper class used for to display check list columns  
    public class checkListWrapper{
        public Boolean selected {get; set;}  
        public String field{get;set;}
        public boolean copied{get; set;}
            public checkListWrapper(String s) {           
                    field = s;
                    selected = false;
                    copied = false;
            }  
    }
    
}