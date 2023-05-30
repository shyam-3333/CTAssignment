public class NPD_GanttViewReportController {

    // public variables
    public String selectedCollectionName{get;set;}
    public List<selectoption> collectionNameOption{get;set;}
    
    public String selectedModelName{get;set;}
    public List<selectoption> modelNameOption{get;set;}
    
    public String selectedStageName{get;set;}
    public List<selectoption> stageNameOption{get;set;}
    
    public List<WrapperModel> modelWrapList {get; set; }
    public List<String> noOfModelMonths {get; set; }
    
    public List<Integer> stringDays {get; set; }
    public Map<String, Integer> monthToDaysMap {get; set; }
    
    public Map<Integer, String> monthMap {get; set; }
    Map<Id,NPD_Activity__c> subStageIdToActivity;
    Map<Id,NPD_Stage__c> StageIdTosubStage;
    
    // private variables
    Map<id, NPD_Project_Name__c> projectMap;    
    Map<id, List<NPD_Stage__c>> projectToStageMap;
    
    public NPD_GanttViewReportController(){
        subStageIdToActivity = new Map<Id,NPD_Activity__c>();
        StageIdTosubStage    = new Map<id,NPD_Stage__c>();
        monthMap = new Map<Integer, String>();
        monthMap = buildMonthMap();
        queryCollections();
        queryModels();
        queryStages();
        selectedStageName = 'Stage';
        noOfModelMonths = calcDefaultMonthts(); 
    }
    
    
    // Method to query all collections
    public void queryCollections(){
        collectionNameOption = new List<selectoption>();
        //collectionNameOption.add(new selectoption('--None--', '--None--'));
       collectionNameOption.add(new selectoption('--None--', '--None--'));
     //   selectedCollectionName = [Select Id, Name FROM NPD_Collections__c where Name = 'Projects'].id;
        for(NPD_Collections__c collection :[Select Id, Name FROM NPD_Collections__c order by name,lastmodifieddate desc LIMIT 1000]){
            collectionNameOption.add(new selectoption(collection.Id, collection.Name));
        }        
    }
    
    // Method to query all Models on the basis of selected Models
    public void queryModels(){
        modelNameOption = new List<selectoption>();
        modelNameOption.add(new selectoption('None', 'All'));
        
        if(selectedCollectionName != null){
            for(NPD_Project_Name__c project :[Select Id, Name, NPD_Collections__r.Name FROM NPD_Project_Name__c 
                                            WHERE NPD_Collections__c =:selectedCollectionName
                                            AND Name != 'Marketing Brief/Concept Stage']){
                modelNameOption.add(new selectoption(project.Name, project.Name));
            }
        }
    }
    
    // Method to get the stage and sub-stages
    public void queryStages(){
        stageNameOption = new List<selectoption>();
        stageNameOption.add(new selectoption('Stage','Stage'));
        stageNameOption.add(new selectoption('Stage And Sub-Stage','Stage & Sub-Stage'));
    }
    
    
    // Method to create a map of Project to Map of stage and substage
    public Map<id, Map<NPD_Stage__c, List<NPD_Stage__c>> > createProjectTostageMap(){
    
        list<NPD_Stage__c> subStage = new List<NPD_Stage__c>();                           // store substage details
        set<Id> subStageId = new set<Id>(); // store subStage ID
        set<Id> stageId = new set<Id>();    // store stage ID
              // map for storing substage id and all subStage Activity
        list<NPD_Stage__c> subStageToActivity = new List<NPD_Stage__c>();                    // list for store all activity
        list<NPD_Stage__c> stageToSubStage = new List<NPD_Stage__c>();                     // list to stage to substage with completed substage
        
        List<NPD_Stage__c> stagewithSubStageList = new List<NPD_Stage__c>();
        Map<id, Map<NPD_Stage__c, List<NPD_Stage__c>> > projectToStageMap = new Map<Id, Map<NPD_Stage__c, List<NPD_Stage__c>> >();
        Map<NPD_Stage__c, List<NPD_Stage__c>> stageToListOfSubStageMap = new Map<NPD_Stage__c, List<NPD_Stage__c>>();
             
        stagewithSubStageList= [Select Id, Name__c, Type__c, NPD_Project_Name__c, Planned_Start_Date__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c,   
                                (Select Id, Name__c, Type__c, NPD_Project_Name__c, Planned_Start_Date__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c  
                                FROM Stage__r WHERE Type__c = 'Sub-stage' AND Active__c = true)
                                FROM NPD_Stage__c WHERE NPD_Project_Name__c IN :projectMap.keySet() AND Type__c = 'Stage' AND Active__c = true];
        system.debug('----------stagewithSubStageList---------'+stagewithSubStageList);
        
        for(NPD_Stage__c stage :stagewithSubStageList){
            if(projectToStageMap.containsKey(stage.NPD_Project_Name__c)){
                Map<NPD_Stage__c, List<NPD_Stage__c>> newStageToListOfSubStageMap = new Map<NPD_Stage__c, List<NPD_Stage__c>>();
                newStageToListOfSubStageMap.put(stage, stage.Stage__r);
                projectToStageMap.get(stage.NPD_Project_Name__c).putAll(newStageToListOfSubStageMap);    
            }else {
                Map<NPD_Stage__c, List<NPD_Stage__c>> newStageToListOfSubStageMap = new Map<NPD_Stage__c, List<NPD_Stage__c>>();
                newStageToListOfSubStageMap.put(stage, stage.Stage__r);
                projectToStageMap.put(stage.NPD_Project_Name__c, newStageToListOfSubStageMap);
            }
            
        }
        for(NPD_Stage__c stage :stagewithSubStageList){
                stageId.add(stage.Id);
                for(NPD_Stage__c st : stage.Stage__r){
                   subStageId.add(st.id);
                }
        }
        subStageToActivity = [select id,(select id,Actual_Start_Date__c,Actual_End_Date__c,Status__c,NPD_Stage__c from NPD_Activity__r where Status__c = 'Completed' AND Active__c = true ORDER By Actual_End_Date__c DESC LIMIT 1) FROM NPD_Stage__c where Id in : subStageId];
        system.debug('---------------subStageToActivity ------------'+subStageToActivity );
        
        for(NPD_Stage__c stage : subStageToActivity){
            System.debug('++++++++stage.NPD_Activity__r 1+++++++++++++'+stage.NPD_Activity__r);
            if(stage.NPD_Activity__r.size()>0){
            System.debug('++++++++stage.NPD_Activity__r+++++++++++++'+stage.NPD_Activity__r); 
                subStageIdToActivity.put(stage.id,stage.NPD_Activity__r);
            }
            else{
                subStageIdToActivity.put(stage.id, new NPD_Activity__c());
            }
            
        }
        stageToSubStage = [select id,Actual_Start_Date__c,Actual_End_Date__c,(select id,Actual_Start_Date__c,Actual_End_Date__c from Stage__r where Type__c = 'Sub-stage' AND Active__c = true AND Status__c = 'Completed' ORDER By Actual_End_Date__c DESC LIMIT 1) FROM NPD_Stage__c where Id in : stageId];
        for(NPD_Stage__c stage : stageToSubStage){
            if(stage.Stage__r.size()>0){
                StageIdTosubStage.put(stage.id,stage.Stage__r);
            }
            else{
                StageIdTosubStage.put(stage.id,new NPD_Stage__c());
    
            }
        } 
        
        
        
        System.debug('++++++++subStageToActivity+++++++++++++'+subStageToActivity); 
        System.debug('++++++++subStageId+++++++++++++'+subStageId); 
        System.debug('++++++++subStageIdToActivity+++++++++++++'+subStageIdToActivity.values()); 
        System.debug('++++++++StageIdTosubStage+++++++++++++'+StageIdTosubStage.values()); 
        
        return projectToStageMap;
    }
    
    
    // Mehtod to convert 4 digit year to last 2 digit
    public String subStrYear(Integer year){
        String strYear = (string.valueOf(year)).subString(2,4);
        return strYear;
    }
    
    
    // Method to create List of model with stage and substage wrapper 
    public void createModelWrapper(){
        
        Map<id, Map<NPD_Stage__c, List<NPD_Stage__c>> > projectToStageMap = new Map<Id, Map<NPD_Stage__c, List<NPD_Stage__c>> >();
        projectToStageMap = createProjectTostageMap();
        Date startDate = calcStartDate(selectedCollectionName, selectedModelName);
        
        Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        Integer numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
        Date lastDayOfMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays);
        
        for(NPD_Project_Name__c project :projectMap.values()){
            
            WrapperModel wrapModel = new WrapperModel();
            wrapModel.name = project.Name;
            List<wrapperStage> wrapStageList = new List<wrapperStage>();
            Map<NPD_Stage__c, List<NPD_Stage__c>> newStageToListOfSubStageMap = new Map<NPD_Stage__c, List<NPD_Stage__c>>();
            newStageToListOfSubStageMap = projectToStageMap.get(project.Id);
            System.debug('=======newStageToListOfSubStageMap========='+newStageToListOfSubStageMap);
            for(NPD_Stage__c stage :newStageToListOfSubStageMap.keySet()){
                System.debug('-------stage ------>'+stage );
                wrapperStage wrapStage = new wrapperStage();
                wrapStage.name = stage.Name__c;
                wrapStage.planhighlighted = '#003399';
                wrapStage.marginleft = String.valueOf(stage.Planned_Start_Date__c.day());
                wrapStage.planStartDate = stage.Planned_Start_Date__c;
                System.debug('wrapper name'+wrapStage.name);
                System.debug('wrapper id'+stage.id);
                System.debug('wrapper planed start date'+wrapStage.planStartDate);
                wrapStage.planEndDate = stage.Planned_End_Date__c;
                System.debug('wrapper planed end date'+wrapStage.planEndDate);
                wrapStage.ActualStartDate = stage.Actual_Start_Date__c;
                wrapStage.ActualEndDate = stage.Actual_End_Date__c;
                /*
                wrapStage.strPlanStartDate = stage.Planned_Start_Date__c.format();
                wrapStage.strPlanEndDate = stage.Planned_End_Date__c.format();
                wrapStage.strActualStartDate = (stage.Actual_Start_Date__c != null) ? stage.Actual_Start_Date__c.format() :null;
                wrapStage.strActualEndDate = (stage.Actual_End_Date__c != null) ? stage.Actual_End_Date__c.format() : null;
                */
                
                //wrapStage.strPlanStartDate = stage.Planned_Start_Date__c.day()+'/' + String.valueOf(stage.Planned_Start_Date__c.year()).substring(2,4);
                /*
                wrapStage.strPlanStartDate = stage.Planned_Start_Date__c.day()+'-' + monthMap.get(stage.Planned_Start_Date__c.month())+'-'+subStrYear(stage.Planned_Start_Date__c.year());
                wrapStage.strPlanEndDate = stage.Planned_End_Date__c.day()+'-'+monthMap.get(stage.Planned_End_Date__c.month())+'-'+subStrYear(stage.Planned_End_Date__c.year());
                wrapStage.strActualStartDate = (stage.Actual_Start_Date__c != null) ? stage.Actual_Start_Date__c.day()+'-'+monthMap.get(stage.Actual_Start_Date__c.month())+'-'+subStrYear(stage.Actual_Start_Date__c.year()) :null;
                wrapStage.strActualEndDate = (stage.Actual_End_Date__c != null) ? stage.Actual_End_Date__c.day()+'-'+monthMap.get(stage.Actual_End_Date__c.month())+'-'+subStrYear(stage.Actual_End_Date__c.year()) : null;
                */
                wrapStage.strPlanStartDate = stage.Planned_Start_Date__c.day()+'/' + monthMap.get(stage.Planned_Start_Date__c.month());
                wrapStage.strPlanEndDate = stage.Planned_End_Date__c.day()+'/'+monthMap.get(stage.Planned_End_Date__c.month());
                wrapStage.strActualStartDate = (stage.Actual_Start_Date__c != null) ? stage.Actual_Start_Date__c.day()+'/'+monthMap.get(stage.Actual_Start_Date__c.month()) :null;
              //  wrapStage.strActualEndDate = (stage.Actual_End_Date__c != null) ? stage.Actual_End_Date__c.day()+'/'+monthMap.get(stage.Actual_End_Date__c.month()) : null;
                wrapStage.strActualEndDate = (stage.Actual_End_Date__c != null) ? stage.Actual_End_Date__c.day()+'/'+monthMap.get(stage.Actual_End_Date__c.month()) : StageIdTosubStage.get(stage.id).Actual_End_Date__c!= null ? StageIdTosubStage.get(stage.id).Actual_End_Date__c.day()+'/'+monthMap.get(StageIdTosubStage.get(stage.id).Actual_End_Date__c.month())+'  (Partially Completed)' : (stage.Actual_Start_Date__c != null)? 'No Sub-Stage Completed' : 'Not Started';
               
                wrapStage.firstSpanForPlan = startDate.toStartOfMonth().addMonths(-1).daysBetween(stage.Planned_Start_Date__c);
                wrapStage.secondSpanForPlan = stage.Planned_Start_Date__c.daysBetween(stage.Planned_End_Date__c)+1;
                wrapStage.thirdSpanForPlan = stage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                
                wrapStage.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(stage.Actual_Start_Date__c != null ? stage.Actual_Start_Date__c : stage.Planned_Start_Date__c);
                wrapStage.secondSpanForActual = (stage.Actual_Start_Date__c == null ? stage.Planned_Start_Date__c : stage.Actual_Start_Date__c).daysBetween(stage.Actual_End_Date__c == null ? (StageIdTosubStage.get(stage.id).Actual_End_Date__c!= null? StageIdTosubStage.get(stage.id).Actual_End_Date__c: stage.Actual_Start_Date__c != null ? stage.Actual_Start_Date__c : stage.Planned_Start_Date__c) : stage.Actual_End_Date__c)+1;
             //  wrapStage.secondSpanForActual = (stage.Actual_Start_Date__c == null ? stage.Planned_Start_Date__c : stage.Actual_Start_Date__c).daysBetween(stage.Actual_End_Date__c == null ? stage.Planned_End_Date__c : stage.Actual_End_Date__c)+1;
              //  wrapStage.thirdSpanForActual = (stage.Actual_End_Date__c == null ? stage.Planned_End_Date__c : stage.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
               wrapStage.thirdSpanForActual = (stage.Actual_End_Date__c == null ? (StageIdTosubStage.get(stage.id).Actual_End_Date__c!= null? StageIdTosubStage.get(stage.id).Actual_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1)): stage.Actual_Start_Date__c == null? stage.Planned_Start_Date__c.daysBetween(lastDayOfMonth.addMonths(1)) : stage.Actual_Start_Date__c.daysBetween(lastDayOfMonth.addMonths(1))) : stage.Actual_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1)));
               
               /*
                if(stage.Actual_Start_Date__c != null && stage.Actual_Start_Date__c > stage.Planned_Start_Date__c){
                    wrapStage.strActualStartLtDate = '('+stage.Planned_Start_Date__c.daysBetween(stage.Actual_Start_Date__c)+')';
                }
                if(stage.Actual_End_Date__c != null && stage.Actual_End_Date__c > stage.Planned_End_Date__c){
                    wrapStage.strActualEndLtDate = '('+stage.Planned_End_Date__c.daysBetween(stage.Actual_End_Date__c)+')'; 
                }
                */
                wrapStage.strPlanLeadTime = (stage.Planned_Start_Date__c.daysBetween(stage.Planned_End_Date__c)) == 0 ? ''+1 : ''+(stage.Planned_Start_Date__c.daysBetween(stage.Planned_End_Date__c));
              /*  wrapStage.strActualLeadTime = (stage.Actual_Start_Date__c != null && stage.Actual_End_Date__c != null) ? ''+(stage.Actual_Start_Date__c.daysBetween(stage.Actual_End_Date__c)) : '-'; */
                
                wrapStage.strActualLeadTime = (stage.Actual_Start_Date__c != null && stage.Actual_End_Date__c != null) ? (stage.Actual_Start_Date__c.daysBetween(stage.Actual_End_Date__c)) == 0 ? ''+1 : ''+(stage.Actual_Start_Date__c.daysBetween(stage.Actual_End_Date__c)) : (stage.Actual_Start_Date__c != null && StageIdTosubStage.get(stage.id).Actual_End_Date__c!= null) ? (stage.Actual_Start_Date__c.daysBetween(StageIdTosubStage.get(stage.id).Actual_End_Date__c)) == 0 ? ''+1 : ''+(stage.Actual_Start_Date__c.daysBetween(StageIdTosubStage.get(stage.id).Actual_End_Date__c)): '-';
                
                if(stage.Actual_Start_Date__c != null && stage.Actual_End_Date__c != null){
                    if(stage.Actual_End_Date__c <= stage.Planned_End_Date__c){
                        wrapStage.actualhighlighted = '#006600';
                    }else {
                        wrapStage.actualhighlighted = '#66ff33';    
                    }
                } 
                
                if (stage.Actual_Start_Date__c != null && stage.Actual_End_Date__c == null){
                    wrapStage.actualhighlighted = '#b38600';
                } 
                if(stage.Actual_Start_Date__c == null && stage.Actual_End_Date__c == null) {
                    wrapStage.actualhighlighted = '#F40830';        
                }
                List<wrapperSubStage> wrapSubStageList = new List<wrapperSubStage>();
                
                if(selectedStageName == 'Stage And Sub-Stage'){
                    for(NPD_Stage__c subStage :newStageToListOfSubStageMap.get(stage)){
                        wrapperSubStage wrapSubStage = new wrapperSubStage();
                        wrapSubStage.name = subStage.Name__c;
                        wrapSubStage.planhighlighted = '#003399';
                        //wrapSubStage.marginleft = String.valueOf(subStage.Planned_Start_Date__c.day());
                        System.debug('==subStage.Actual_Start_Date__c=='+subStage);
                        wrapSubStage.planStartDate = subStage.Planned_Start_Date__c;
                        wrapSubStage.planEndDate = subStage.Planned_End_Date__c;
                        /*
                        wrapSubStage.strPlanStartDate = subStage.Planned_Start_Date__c.format();
                        wrapSubStage.strPlanEndDate = subStage.Planned_End_Date__c.format();
                        wrapSubStage.strActualStartDate = (subStage.Actual_Start_Date__c != null) ? subStage.Actual_Start_Date__c.format(): null;
                        wrapSubStage.strActualEndDate = (subStage.Actual_End_Date__c != null) ? subStage.Actual_End_Date__c.format() : null;
                        */
                        /*
                        wrapSubStage.strPlanStartDate = subStage.Planned_Start_Date__c.day()+'-'+monthMap.get(subStage.Planned_Start_Date__c.month())+'-'+subStrYear(subStage.Planned_Start_Date__c.year());
                        wrapSubStage.strPlanEndDate = subStage.Planned_End_Date__c.day()+'-'+monthMap.get(subStage.Planned_End_Date__c.month())+'-'+subStrYear(subStage.Planned_End_Date__c.year());
                        wrapSubStage.strActualStartDate = (subStage.Actual_Start_Date__c != null) ? subStage.Actual_Start_Date__c.day()+'-'+monthMap.get(subStage.Actual_Start_Date__c.month())+'-'+subStrYear(subStage.Actual_Start_Date__c.year()): null;
                        wrapSubStage.strActualEndDate = (subStage.Actual_End_Date__c != null) ? subStage.Actual_End_Date__c.day()+'-'+monthMap.get(subStage.Actual_End_Date__c.month())+'-'+subStrYear(subStage.Actual_End_Date__c.year()) : null;
                        */
                        wrapSubStage.strPlanStartDate = subStage.Planned_Start_Date__c.day()+'/'+monthMap.get(subStage.Planned_Start_Date__c.month());
                        wrapSubStage.strPlanEndDate = subStage.Planned_End_Date__c.day()+'/'+monthMap.get(subStage.Planned_End_Date__c.month());
                        wrapSubStage.strActualStartDate = (subStage.Actual_Start_Date__c != null) ? subStage.Actual_Start_Date__c.day()+'/'+monthMap.get(subStage.Actual_Start_Date__c.month()): null;
                        wrapSubStage.strActualEndDate = (subStage.Actual_End_Date__c != null) ? subStage.Actual_End_Date__c.day()+'/'+monthMap.get(subStage.Actual_End_Date__c.month()) : subStageIdToActivity.get(subStage.id).Actual_End_Date__c!= null ? subStageIdToActivity.get(subStage.id).Actual_End_Date__c.day()+'/'+monthMap.get(subStageIdToActivity.get(subStage.id).Actual_End_Date__c.month())+'  (Partialy Completed)' : (subStage.Actual_Start_Date__c != null)? 'No Activity Completed' : 'Not Started';
                        
                        wrapSubStage.ActualStartDate = subStage.Actual_Start_Date__c;
                        wrapSubStage.ActualEndDate = subStage.Actual_End_Date__c;
                        
                        wrapSubStage.firstSpanForPlan = startDate.toStartOfMonth().addMonths(-1).daysBetween(subStage.Planned_Start_Date__c);
                        wrapSubStage.secondSpanForPlan = subStage.Planned_Start_Date__c.daysBetween(subStage.Planned_End_Date__c)+1;
                        wrapSubStage.thirdSpanForPlan = subStage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                        System.debug('==startDate=='+startDate);
                        
                        wrapSubStage.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(subStage.Actual_Start_Date__c == null ? subStage.Planned_Start_Date__c : subStage.Actual_Start_Date__c);
                       wrapSubStage.secondSpanForActual = (subStage.Actual_Start_Date__c == null ? subStage.Planned_Start_Date__c : subStage.Actual_Start_Date__c).daysBetween(subStage.Actual_End_Date__c == null ? (subStageIdToActivity.get(subStage.id).Actual_End_Date__c!= null? subStageIdToActivity.get(subStage.id).Actual_End_Date__c: subStage.Actual_Start_Date__c != null ? subStage.Actual_Start_Date__c : subStage.Planned_Start_Date__c) : subStage.Actual_End_Date__c)+1;
                     //   wrapSubStage.thirdSpanForActual = (subStage.Actual_End_Date__c == null ? (subStageIdToActivity.get(subStage.id).Actual_End_Date__c!= null? subStageIdToActivity.get(subStage.id).Actual_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1)): subStage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1))) : subStage.Actual_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1)));
                        wrapSubStage.thirdSpanForActual = (subStage.Actual_End_Date__c == null ? (subStageIdToActivity.get(subStage.id).Actual_End_Date__c!= null? subStageIdToActivity.get(subStage.id).Actual_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1)): subStage.Actual_Start_Date__c == null? subStage.Planned_Start_Date__c.daysBetween(lastDayOfMonth.addMonths(1)) : subStage.Actual_Start_Date__c.daysBetween(lastDayOfMonth.addMonths(1))) : subStage.Actual_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1)));
                       
                       /*
                        if(subStage.Actual_Start_Date__c != null && subStage.Actual_Start_Date__c > subStage.Planned_Start_Date__c){
                            wrapSubStage.strActualStartLtDate = '('subStage.Planned_Start_Date__c.daysBetween(subStage.Actual_Start_Date__c)+')';
                        }
                        if(subStage.Actual_End_Date__c != null && subStage.Actual_End_Date__c > subStage.Planned_End_Date__c){
                            wrapSubStage.strActualEndLtDate = '('subStage.Planned_End_Date__c.daysBetween(subStage.Actual_End_Date__c)+')'; 
                        }
                        */
                        wrapSubStage.strPlanLeadTime = (subStage.Planned_Start_Date__c.daysBetween(subStage.Planned_End_Date__c)) == 0 ? ''+1 : ''+(subStage.Planned_Start_Date__c.daysBetween(subStage.Planned_End_Date__c)) ;
                        wrapSubStage.strActualLeadTime = (subStage.Actual_Start_Date__c != null && subStage.Actual_End_Date__c != null) ? (subStage.Actual_Start_Date__c.daysBetween(subStage.Actual_End_Date__c)) == 0 ? ''+1 : ''+(subStage.Actual_Start_Date__c.daysBetween(subStage.Actual_End_Date__c)) : (subStage.Actual_Start_Date__c != null && subStageIdToActivity.get(subStage.id).Actual_End_Date__c!= null) ? (subStage.Actual_Start_Date__c.daysBetween(subStageIdToActivity.get(subStage.id).Actual_End_Date__c)) == 0 ? ''+1 : ''+(subStage.Actual_Start_Date__c.daysBetween(subStageIdToActivity.get(subStage.id).Actual_End_Date__c)) : '-';
                
                        if(subStage.Actual_Start_Date__c != null && subStage.Actual_End_Date__c != null){
                            if(subStage.Actual_End_Date__c <= subStage.Planned_End_Date__c){
                                wrapSubStage.actualhighlighted = '#006600';
                            }else {
                                wrapSubStage.actualhighlighted = '#66ff33';    
                            }
                        } 
                        
                        if (subStage.Actual_Start_Date__c != null && subStage.Actual_End_Date__c == null){
                            wrapSubStage.actualhighlighted = '#b38600';
                        } 
                        if(subStage.Actual_Start_Date__c == null && subStage.Actual_End_Date__c == null) {
                            wrapSubStage.actualhighlighted = '#F40830';        
                        }
                        
                        wrapSubStageList.add(wrapSubStage);
                    }
                    
                    wrapStage.substages = wrapSubStageList;
                }
                
                wrapStageList.add(wrapStage);
            }
            wrapModel.stages = wrapStageList;
            modelWrapList.add(wrapModel);
            
            
        }
    }
    
    // Method to build a map of months
    public Map<Integer, String> buildMonthMap(){
        List<String> strMonths = new List<String>{'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
        
        for(Integer i=1; i <=12; i++){
            monthMap.put(i, strMonths[i-1]); 
        }
        
        return monthMap;
    }
    
    // Method to calculate the months between two Dates
    public void calculateMonths(){
        //Map<Integer, String> monthMap = new Map<Integer, String>();
        //monthMap = buildMonthMap();
        startDate = calcStartDate(selectedCollectionName, selectedModelName);
        startDate = startDate.addMonths(-1);
        Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        endDate = endDate.addMonths(1);
        List<String> StringMonths = new List<String>();
        List<Date> startToEndDates = new List<Date>();
        
        Integer monthsBetween = startDate.monthsBetween(endDate);
        
        for(Integer i=0; i <monthsBetween; i++){
            startToEndDates.add(startDate.addMonths(i));
        }
        startToEndDates.add(endDate);
        
        for(Integer i=0; i< startToEndDates.size(); i++){
            Integer month = startToEndDates[i].month();
            Integer year = startToEndDates[i].year();
            String strYear = String.valueOf(year).subString(2,4);
            StringMonths.add(monthMap.get(month)+' '+strYear);    
        }
        
        noOfModelMonths = StringMonths;
        System.debug('======startToEndDates=========='+StringMonths);
    }
    
    // Method to calculate number of days between start Date and End Date
    public void calculateDays(){
        Date startDate = calcStartDate(selectedCollectionName, selectedModelName);
        Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        
        date firstDate = startDate.toStartOfMonth().addMonths(-1);
        
        Integer numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
        Date lastDayOfMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays).addMonths(1);
        
        stringDays = new List<Integer>();
        Integer daysBetween = firstDate.daysBetween(lastDayOfMonth);  
        
        List<Date> dates = new List<Date>();
        
        monthToDaysMap = new Map<String, Integer>();
        
        while(firstDate < lastDayOfMonth){            
            dates.add(firstDate);
            firstDate  = firstDate.addMonths(1);
        }       
        dates.add(lastDayOfMonth);
        
        for(Integer i=0; i < dates.size(); i++){
            if(i < dates.size()-1){
                for(Integer j=1; j <= dates[i].daysBetween(dates[i+1]); j++){
                    stringDays.add(j);
                    monthToDaysMap.put(noOfModelMonths[i], dates[i].daysBetween(dates[i+1]));    
                }
            }
        }
        System.debug('--dates--'+dates[dates.size() - 1]);
    }
    
    
    public Date  startDate {get; set;}
    // Method to calculate months from the days
    public List<String> calcDefaultMonthts() {
        
        Date  startDate = System.today().addMonths(-6);
        Date endDate = startDate.addMonths(11);
        
        //Map<Integer, String> monthMap = new Map<Integer, String>();
        List<String> StringMonths = new List<String>();
        List<Date> startToEndDates = new List<Date>();
        //monthMap = buildMonthMap();
        
        Integer monthsBetween = startDate.monthsBetween(endDate);
        
        for(Integer i=0; i <monthsBetween; i++){
            startToEndDates.add(startDate.addMonths(i));
        }
        startToEndDates.add(endDate);
        
        for(Integer i=0; i< startToEndDates.size(); i++){
            Integer month = startToEndDates[i].month();
            Integer year = startToEndDates[i].year();
            String strYear = String.valueOf(year).subString(2,4);
            StringMonths.add(monthMap.get(month)+' '+strYear);    
        }
        
        return StringMonths;
    }
    
    // Method to create Project Map 
    public Map<id, NPD_Project_Name__c> createModelMap(){
        
        List<NPD_Project_Name__c> projectToStageList = new List<NPD_Project_Name__c>();
        projectToStageMap = new Map<id, List<NPD_Stage__c>>(); 
        
        // If condition to check if no model is Selected
        if(selectedModelName == null || selectedModelName == 'None'){
            
            if(selectedStageName == null || selectedStageName == 'Stage And Sub-Stage'){
                projectToStageList = [Select Id, Name, NPD_Collections__r.Name,NPD_Collections__c,  
                                    (Select Id, Name, Name__c, NPD_Stage__c, Type__c From Stage__r WHERE Active__c = true) 
                                    FROM NPD_Project_Name__c 
                                    WHERE NPD_Collections__c =:selectedCollectionName
                                    AND Name != 'Marketing Brief/Concept Stage'];
            
            } else {
                projectToStageList = [Select Id, Name, NPD_Collections__r.Name,NPD_Collections__c,  
                                    (Select Id, Name, Name__c, NPD_Stage__c, Type__c From Stage__r WHERE Type__c = :selectedStageName AND Active__c = true) 
                                    FROM NPD_Project_Name__c 
                                    WHERE NPD_Collections__c =:selectedCollectionName
                                    AND Name != 'Marketing Brief/Concept Stage'];   
            }
            
        }
        
        // If condition to check if any one model is Selected
        if(selectedModelName != null && selectedModelName != 'None'){
            
            if(selectedStageName == null || selectedStageName == 'Stage And Sub-Stage'){
                projectToStageList = [Select Id, Name, NPD_Collections__r.Name, NPD_Collections__c,
                                    (Select Id, Name, Name__c, NPD_Stage__c, Type__c From Stage__r WHERE Active__c = true) 
                                    FROM NPD_Project_Name__c 
                                    WHERE NPD_Collections__c =:selectedCollectionName
                                    AND Name != 'Marketing Brief/Concept Stage' AND Name =:selectedModelName];
            } else {
                projectToStageList = [Select Id, Name, NPD_Collections__r.Name, NPD_Collections__c,
                                    (Select Id, Name, Name__c, NPD_Stage__c, Type__c From Stage__r WHERE Type__c = :selectedStageName AND Active__c = true) 
                                    FROM NPD_Project_Name__c 
                                    WHERE NPD_Collections__c =:selectedCollectionName
                                    AND Name != 'Marketing Brief/Concept Stage' AND Name =:selectedModelName];    
                
            } 
            system.debug('------------projectToStageList -----------'+projectToStageList );   
        
        }
        
        // Loop to create a map of project with Stages
        for(NPD_Project_Name__c project :projectToStageList){            
            projectToStageMap.put(project.Id, project.Stage__r);
        } 
        
        // Loop to create a map of project id with project
        for(NPD_Project_Name__c project :projectToStageList){
            projectMap.put(project.Id, project);
        }
        
        System.debug('=======projectToStageMap======'+projectToStageMap);
        return projectMap;
        
    }
    
    //  Method to query the data    
    public void queryData(){
        modelWrapList = new List<WrapperModel>();
        projectMap = new Map<id, NPD_Project_Name__c>();
        
        try{
            projectMap = createModelMap();
            calculateMonths();
            calculateDays();
            createModelWrapper();
           
        }catch(Exception e){
        
        }
    }
    
    // Method to get the start date from the selected collection and selected model
    public Date calcStartDate(String collectionName, String modelName){
        NPD_Stage__c stage;
        List<Date> dateList = new List<Date>();
        if(selectedModelName == null || selectedModelName == 'None'){
            stage = [Select Id, Name, Name__c, Planned_Start_Date__c,Planned_End_Date__c,Actual_Start_Date__c, NPD_Project_Name__r.Name, NPD_Project_Name__r.NPD_Collections__c 
                    From NPD_Stage__c Where NPD_Project_Name__r.NPD_Collections__c = :selectedCollectionName AND Active__c = true
                    AND NPD_Project_Name__r.NPD_Collections__c != null
                    AND Name__c ='Marketing Brief/Concept' Order By Planned_Start_Date__c ASC LIMIT 1];
                    dateList.add(stage.Planned_Start_Date__c);
        }else {
            stage = [Select Id, Name, Name__c, Planned_Start_Date__c,Planned_End_Date__c, Actual_Start_Date__c, NPD_Project_Name__r.Name, NPD_Project_Name__r.NPD_Collections__c 
                    From NPD_Stage__c Where NPD_Project_Name__r.NPD_Collections__c = :selectedCollectionName AND Active__c = true
                    AND NPD_Project_Name__r.NPD_Collections__c != null 
                    AND Name__c ='Marketing Brief/Concept' AND NPD_Project_Name__r.Name =:selectedModelName Order By Planned_Start_Date__c LIMIT 1];
        }
        System.debug('planed start date'+stage.Planned_Start_Date__c);
        if(stage.Planned_Start_Date__c >stage.Actual_Start_Date__c){        // change made by sudama
            return stage.Actual_Start_Date__c;
        }else{
            return stage.Planned_Start_Date__c; 
        }
         
    }
    
    // Method to get the start date from the selected collection and selected model
    public Date calcEndDate(String collectionName, String modelName){
        NPD_Stage__c stage;
        List<Date> dateList = new List<Date>();
        NPD_Stage__c planEndstage;
        NPD_Stage__c actStartstage;
        NPD_Stage__c actEndstage;
         
        
        if(selectedModelName == null || selectedModelName == 'None'){
            
            try{
                planEndstage = [Select Id, Name, Name__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c, 
                                NPD_Project_Name__r.NPD_Collections__c
                                From NPD_Stage__c Where NPD_Project_Name__r.NPD_Collections__c = :selectedCollectionName AND Active__c = true
                                AND Name__c ='Production' Order By Planned_End_Date__c DESC LIMIT 1];
                                
                system.debug('-------planEndstage ---------'+planEndstage );
            }catch(Exception e){
                planEndstage = new NPD_Stage__c();     
            }
            try{
                actStartstage = [Select Id, Name, Name__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c, 
                                NPD_Project_Name__r.NPD_Collections__c
                                From NPD_Stage__c Where NPD_Project_Name__r.NPD_Collections__c = :selectedCollectionName AND Active__c = true
                                AND Name__c ='Production' AND Actual_Start_Date__c != null Order By Actual_Start_Date__c DESC LIMIT 1];
                system.debug('-------actStartstage---------'+actStartstage );                
                
            }catch(Exception e){
                 actStartstage = new NPD_Stage__c();   
            }
            
            try{
                actEndstage = [Select Id, Name, Name__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c, 
                                NPD_Project_Name__r.NPD_Collections__c
                                From NPD_Stage__c Where NPD_Project_Name__r.NPD_Collections__c = :selectedCollectionName  AND Active__c = true
                                AND Name__c ='Production' AND Actual_End_Date__c != null Order By Actual_End_Date__c DESC LIMIT 1];
                                
                 system.debug('-------actEndstage ---------'+actEndstage );
            }catch(Exception e){
                actEndstage = new NPD_Stage__c();
            }
            
            if(actStartstage.Actual_Start_Date__c != null){
                dateList.add(actStartstage.Actual_Start_Date__c);    
            }
            if(actEndstage.Actual_End_Date__c != null){
                dateList.add(actEndstage.Actual_End_Date__c);
            }
            dateList.add(planEndstage.Planned_End_Date__c);
        }else {
            
            try{    
                planEndstage = [Select Id, Name, Name__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c, 
                                NPD_Project_Name__r.NPD_Collections__c
                                From NPD_Stage__c Where NPD_Project_Name__r.NPD_Collections__c = :selectedCollectionName AND Active__c = true
                                AND Name__c ='Production' AND NPD_Project_Name__r.Name =:selectedModelName Order By Planned_End_Date__c DESC LIMIT 1];
            }catch(Exception e){
                planEndstage = new NPD_Stage__c();  
            }
            
            try{
                actStartstage = [Select Id, Name, Name__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c, 
                                NPD_Project_Name__r.NPD_Collections__c
                                From NPD_Stage__c Where NPD_Project_Name__r.NPD_Collections__c = :selectedCollectionName AND Active__c = true
                                AND Name__c ='Production' AND NPD_Project_Name__r.Name =:selectedModelName Order By Actual_Start_Date__c DESC LIMIT 1];
           }catch(Exception e){
               actStartstage = new NPD_Stage__c();
           }
           try{
                actEndstage = [Select Id, Name, Name__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c, 
                                NPD_Project_Name__r.NPD_Collections__c
                                From NPD_Stage__c Where NPD_Project_Name__r.NPD_Collections__c = :selectedCollectionName AND Active__c = true
                                AND Name__c ='Production' AND NPD_Project_Name__r.Name =:selectedModelName Order By Actual_End_Date__c DESC LIMIT 1];
            
            }catch(Exception e){
                actStartstage = new NPD_Stage__c();
            }
            
            if(actStartstage.Actual_Start_Date__c != null){
                dateList.add(actStartstage.Actual_Start_Date__c);    
            }
            if(actEndstage.Actual_End_Date__c != null){
                dateList.add(actEndstage.Actual_End_Date__c);
            }
            dateList.add(planEndstage.Planned_End_Date__c); 
                       
        }
        
        dateList.sort();
        System.debug('end date'+dateList);
        return dateList[dateList.size() - 1];
    }
        
    
    // Model Wrapper Class
    public class WrapperModel {
        public String name {get; set;}
        public List<wrapperStage> stages{get; set; }
        
        public WrapperModel() {
           
        }
            
    }
    
    // Stage Wrapper Class
    public class wrapperStage {
        public String name {get; set; }
        public String plan {get; set; } 
        public String actual {get; set; }
        public String datename {get; set; }
        public Date planStartDate {get; set;}
        public Date planEndDate {get; set;}
        public Date actualStartDate {get; set;}
        public Date actualEndDate {get; set;}
        
        public String strPlanStartDate {get; set;}
        public String strPlanEndDate {get; set;}
        public String strActualStartDate {get; set;}
        public String strActualEndDate {get; set;}
        
        public String marginleft {get; set;}
        public String planhighlighted {get; set;}
        public String actualhighlighted {get; set;}
        public Integer firstSpanForPlan {get; set;}
        public Integer secondSpanForPlan {get; set;}
        public Integer thirdSpanForPlan {get; set;}
        public Integer firstSpanForActual {get; set;}
        public Integer secondSpanForActual {get; set;}
        public Integer thirdSpanForActual {get; set;}
        
        public String strActualStartLtDate {get; set;}
        public String strActualEndLtDate {get; set;}
        
        public String strPlanLeadTime {get; set;}
        public String strActualLeadTime {get; set;}
        
        public List<wrapperSubStage> substages {get; set; }
        
        public wrapperStage(){
            plan = 'Plan';
            actual = 'Actual';    
        }   
    }
    
    // Sub-Stage Wrapper Class
    public class wrapperSubStage {
        public String name {get; set; } 
        public String plan {get; set; } 
        public String actual {get; set; }
        public String datename {get; set; }
        public String startDate {get; set;}
        public String endDate {get; set;}
        public String marginleft {get; set;}
        public String planhighlighted {get; set;}
        public String actualhighlighted {get; set;}
        public Date planStartDate {get; set;}
        public Date planEndDate {get; set;}
        public Date actualStartDate {get; set;}
        public Date actualEndDate {get; set;}
        
        public String strPlanStartDate {get; set;}
        public String strPlanEndDate {get; set;}
        public String strActualStartDate {get; set;}
        public String strActualEndDate {get; set;}
        
        public Integer firstSpanForPlan {get; set;}
        public Integer secondSpanForPlan {get; set;}
        public Integer thirdSpanForPlan {get; set;}
        public Integer firstSpanForActual {get; set;}
        public Integer secondSpanForActual {get; set;}        
        public Integer thirdSpanForActual {get; set;}
        
        public String strActualStartLtDate {get; set;}
        public String strActualEndLtDate {get; set;}
        
        
        public String strPlanLeadTime {get; set;}
        public String strActualLeadTime {get; set;}
        
        public wrapperSubStage(){
            plan = 'Plan';
            actual = 'Actual';    
        }   
    }
    
}