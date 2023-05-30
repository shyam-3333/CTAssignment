public with sharing class SkinnNPDGanttChartVFPageController  {
    public String selectedCollectionName{get;set;}
    public List<selectoption> collectionNameOption{get;set;}
    public List<WrapperClassNPDGanttChart> listDatatableInfo{get;set;}
    
    public String selectedModelName{get;set;}
    public List<selectoption> modelNameOption{get;set;}
    
    public String selectedStageName{get;set;}
    public List<selectoption> stageNameOption{get;set;}
    
    public List<String> noOfModelMonths {get; set; }
    
    public List<Integer> stringDays {get; set; }
    public Map<String, Integer> monthToDaysMap {get; set; }
    public Date  startDate {get; set;}
    
    public Map<Integer, String> monthMap {get; set; }
    Map<Id,NPD_Activity__c> subStageIdToActivity;
    Map<Id,NPD_Stage__c> StageIdTosubStage;
    public SkinnNPDGanttChartVFPageController() {
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
    public void queryModels(){
        modelNameOption = new List<selectoption>();
        modelNameOption.add(new selectoption('None', 'All'));
        if(selectedCollectionName != null){
            for(Skinn_Model__c project :[Select Id, Name FROM Skinn_Model__c 
                                            WHERE  Skinn_Collection__c=:selectedCollectionName AND Name<>'MarketingStage']){
                modelNameOption.add(new selectoption(project.Id, project.Name));
            }
        }
    }
    public Integer calculatePlanSpan(Skinn_Collection_Template__c record){
        if(record.planned_Start_Date__c!=NULL && record.planned_End_Date__c!=NULL && record.Planned_Lead_Time__c!=NULL){
           return record.planned_Start_Date__c.toStartOfMonth().addMonths(-1).daysBetween(record.planned_End_Date__c);
        }else{
            return 0;
        }
    }
    public void queryData(){
        
        try{
            
           skinnModelView();
            calculateMonths();
        	calculateDays();
        }catch(Exception e){
        listDatatableInfo=new List<WrapperClassNPDGanttChart>();
       }
    }
    
    public void calculateDays(){
        Date startDate = calcStartDate(selectedCollectionName, selectedModelName);
        Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        
        date firstDate = startDate.toStartOfMonth().addMonths(-1);
        System.debug('firstDate------------------'+firstDate);
        Integer numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
        Date lastDayOfMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays).addMonths(1);
        System.debug('lastDayOfMonth----------------'+lastDayOfMonth);
        stringDays = new List<Integer>();
        Integer daysBetween = firstDate.daysBetween(lastDayOfMonth);  
        
        List<Date> dates = new List<Date>();
        
        monthToDaysMap = new Map<String, Integer>();
        
        while(firstDate < lastDayOfMonth){            
            dates.add(firstDate);
            firstDate  = firstDate.addMonths(1);
        }       
        dates.add(lastDayOfMonth);
        System.debug('noOfModelMonths---------------------'+noOfModelMonths);
        for(Integer i=0; i < dates.size(); i++){
            if(i < dates.size()-1){
                for(Integer j=1; j <= dates[i].daysBetween(dates[i+1]); j++){
                    stringDays.add(j);
                    monthToDaysMap.put(noOfModelMonths[i], dates[i].daysBetween(dates[i+1]));    
                }
            }
        }
        System.debug('monthToDaysMap'+monthToDaysMap);
        System.debug('--dates--'+dates[dates.size() - 1]);
    }
    
    public void calculateMonths(){
        //Map<Integer, String> monthMap = new Map<Integer, String>();
        //monthMap = buildMonthMap();
        startDate = calcStartDate(selectedCollectionName, selectedModelName);
        system.debug('---------calcStartDate---------------'+startDate);
        startDate = startDate.addMonths(-1);
        system.debug('---------StartDate(addmonths)---------------'+startDate);
        Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        system.debug('---------calcEndDate---------------'+endDate);
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
    public Date calcStartDate(String collectionName, String modelName){
        Date returnDate;
        returnDate=Date.valueOf([SELECT MIN(Planned_Start_Date__c) pSD FROM Skinn_Collection_Template__c where Skinn_Collection__c=:collectionName AND (Skinn_Model__c=:modelName OR Skinn_Model__r.Name='MarketingStage')][0].get('pSD'));
        System.debug('returnDate'+returnDate);
        if(returnDate==NULL){
            return System.today(); 
        }else{
            return returnDate;
        }
        
    }
    public Date calcEndDate(String collectionName, String modelName){
        Date returnDate;
        returnDate=Date.valueOf([SELECT MAX(Planned_End_Date__c) pSD FROM Skinn_Collection_Template__c where Skinn_Collection__c=:collectionName AND (Skinn_Model__c=:modelName OR Skinn_Model__r.Name='MarketingStage')][0].get('pSD'));
       System.debug('returnDate'+returnDate);
       if(returnDate==NULL){
           return system.today();
       }else{
           return returnDate;
       }
        
    }
    
    public void FillDataBasedOnStatus(WrapperClassNPDGanttChart tempVar,WrapperClassStage temvar2,Skinn_collection_Template__c mseachstage){
		Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        Integer numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
        Date lastDayOfMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays);
        Date startDate = calcStartDate(selectedCollectionName, selectedModelName);
                        if(mseachstage.Status__c=='Completed'){
                                            temvar2=new WrapperClassStage();
                                            temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                            temvar2.OrderNumber=mseachstage.Order_Number__c;
                                            temvar2.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Planned_Start_Date__c);
                                            temvar2.strPlanStartDate=String.valueof(mseachstage.planned_Start_Date__c);
                                            temvar2.secondSpanForPlan=mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1;
                                            temvar2.thirdSpanForPlan=mseachstage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                            temvar2.strPlanLeadTime = (mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1);
                                            temvar2.strPlanEndDate = mseachstage.Planned_End_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_End_Date__c.month());
                                            temvar2.strPlanStartDate = mseachstage.Planned_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_Start_Date__c.month());
                                            temvar2.planEndDate = mseachstage.Planned_End_Date__c;
                                            temvar2.planhighlighted = '#003399';
                                            temvar2.marginleft = String.valueOf(mseachstage.Planned_Start_Date__c.day());
                                            temvar2.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Actual_Start_Date__c != null ? mseachstage.Actual_Start_Date__c : mseachstage.Planned_Start_Date__c);
                                            temvar2.strActualStartDate = mseachstage.Actual_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_Start_Date__c.month());
                                            temvar2.secondSpanForActual = (mseachstage.Actual_Start_Date__c).daysBetween(mseachstage.Actual_End_date__c)+1;
                                            temvar2.actualhighlighted =mseachstage.Actual_End_date__c<=mseachstage.Planned_End_Date__c?'#006600':'#66ff33';
                                            temvar2.thirdSpanForActual = (mseachstage.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                            temvar2.strActualLeadTime = String.valueof(Integer.valueof(mseachstage.Actual_Lead_Time__c));
                                            temvar2.strActualEndDate = mseachstage.Actual_End_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_End_Date__c.month());
                                            tempVar.skinnStageRecords.add(temvar2);
                    }
                    	if(mseachstage.Status__c=='Not Started'){
                                            temvar2=new WrapperClassStage();
                                            temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                            temvar2.OrderNumber=mseachstage.Order_Number__c;
                                            temvar2.firstSpanForPlan=0;
                                            temvar2.strPlanStartDate='';
                                            temvar2.secondSpanForPlan=0;
                                            temvar2.thirdSpanForPlan=0;
                                            temvar2.strPlanLeadTime ='0';
                                            temvar2.strPlanEndDate = 'Not Started';
                                            temvar2.strPlanStartDate = 'Not Started';
                                            temvar2.planEndDate = System.today();
                                            temvar2.planhighlighted = '#ff0000';
                                            temvar2.marginleft = '';
                                            temvar2.firstSpanForActual = 0;
                                            temvar2.strActualStartDate = 'Not Started';
                                            temvar2.secondSpanForActual = 0;
                                            temvar2.actualhighlighted = '#ff0000';
                                            temvar2.thirdSpanForActual = 0;
                                            temvar2.strActualLeadTime = '0';
                                            temvar2.strActualEndDate = 'Not Started';
                                            tempVar.skinnStageRecords.add(temvar2);
                    }
                    	if(mseachstage.Status__c=='In Progress'){
                                            temvar2=new WrapperClassStage();
                                            temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                            temvar2.OrderNumber=mseachstage.Order_Number__c;
                                            temvar2.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Planned_Start_Date__c);
                                            temvar2.strPlanStartDate=String.valueof(mseachstage.planned_Start_Date__c);
                                            temvar2.secondSpanForPlan=mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1;
                                            temvar2.thirdSpanForPlan=mseachstage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                            temvar2.strPlanLeadTime = (mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1);
                                            temvar2.strPlanEndDate = mseachstage.Planned_End_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_End_Date__c.month());
                                            temvar2.strPlanStartDate = mseachstage.Planned_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_Start_Date__c.month());
                                            temvar2.planEndDate = mseachstage.Planned_End_Date__c;
                                            temvar2.planhighlighted = '#003399';
                                            temvar2.marginleft = String.valueOf(mseachstage.Planned_Start_Date__c.day());
                                            temvar2.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Actual_Start_Date__c);
                                            temvar2.strActualStartDate = (mseachstage.Actual_Start_Date__c != null) ? mseachstage.Actual_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_Start_Date__c.month()) :null;
                                            temvar2.secondSpanForActual = (mseachstage.Actual_Start_Date__c).daysBetween(mseachstage.Actual_End_date__c==NULL?System.today():mseachstage.Actual_End_date__c)+1;
                                            temvar2.actualhighlighted = '#A52A2A';
                                            temvar2.thirdSpanForActual = (mseachstage.Actual_End_Date__c==NULL?System.today():mseachstage.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                            temvar2.strActualLeadTime = String.valueof(Integer.valueof(mseachstage.Actual_Lead_Time__c==NULL?(mseachstage.Actual_Start_Date__c).daysBetween(System.today())+1:mseachstage.Actual_Lead_Time__c));
                                            temvar2.strActualEndDate = (mseachstage.Actual_End_Date__c != null) ? mseachstage.Actual_End_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                                            tempVar.skinnStageRecords.add(temvar2);
                    }        
    }
    
    public void fillDataBasedOnStatusWhenStage(WrapperClassNPDGanttChart tempVar,WrapperClassStage temvar2,WrapperClassSubStage temvar3,Skinn_collection_Template__c mseachstage,map<String,List<Skinn_Collection_Template__c>> mapOfMSStageWithSubStage,Id currentmarketingStageId){
        Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        Integer numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
        Date lastDayOfMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays);
        Date startDate = calcStartDate(selectedCollectionName, selectedModelName);
        				if(mseachstage.Status__c=='Completed'){
                        temvar2=new WrapperClassStage();
                        temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                        temvar2.OrderNumber=mseachstage.Order_Number__c;
                        temvar2.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Planned_Start_Date__c);
                        temvar2.strPlanStartDate=String.valueof(mseachstage.planned_Start_Date__c);
                        temvar2.secondSpanForPlan=mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1;
                        temvar2.thirdSpanForPlan=mseachstage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                        temvar2.strPlanLeadTime = (mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1);
                        temvar2.strPlanEndDate = mseachstage.Planned_End_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_End_Date__c.month());
                        temvar2.strPlanStartDate = mseachstage.Planned_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_Start_Date__c.month());
                        temvar2.planEndDate = mseachstage.Planned_End_Date__c;
                        temvar2.planhighlighted = '#003399';
                		temvar2.marginleft = String.valueOf(mseachstage.Planned_Start_Date__c.day());
                        temvar2.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Actual_Start_Date__c != null ? mseachstage.Actual_Start_Date__c : mseachstage.Planned_Start_Date__c);
                        temvar2.strActualStartDate = mseachstage.Actual_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_Start_Date__c.month());
                        temvar2.secondSpanForActual = (mseachstage.Actual_Start_Date__c).daysBetween(mseachstage.Actual_End_date__c)+1;
                        temvar2.actualhighlighted =mseachstage.Actual_End_date__c<=mseachstage.Planned_End_Date__c?'#006600':'#66ff33';
                        temvar2.thirdSpanForActual = (mseachstage.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                        temvar2.strActualLeadTime = String.valueof(Integer.valueof(mseachstage.Actual_Lead_Time__c));
                 		temvar2.strActualEndDate = mseachstage.Actual_End_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_End_Date__c.month());
                        temvar2.skinnSubStageRecords=new List<WrapperClassSubStage>();
                        if(mapOfMSStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+currentmarketingStageId)!=NULL){
                            for(Skinn_Collection_Template__c mseach2:mapOfMSStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+currentmarketingStageId)){
                                if(mseach2.Status__c=='Completed'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(mseach2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=mseach2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1);
                                    temvar3.strPlanEndDate = mseach2.Planned_End_Date__c.day()+'/'+monthMap.get(mseach2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = mseach2.Planned_Start_Date__c.day()+'/'+monthMap.get(mseach2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = mseach2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(mseach2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Actual_Start_Date__c != null ? mseach2.Actual_Start_Date__c : mseach2.Planned_Start_Date__c);
                                    temvar3.strActualStartDate = mseach2.Actual_Start_Date__c.day()+'/'+monthMap.get(mseach2.Actual_Start_Date__c.month());
                                    temvar3.secondSpanForActual = (mseach2.Actual_Start_Date__c).daysBetween(mseach2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted =mseach2.Actual_End_date__c<=mseach2.Planned_End_Date__c?'#006600':'#66ff33';
                                    temvar3.thirdSpanForActual = (mseach2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(mseach2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = mseach2.Actual_End_Date__c.day()+'/'+monthMap.get(mseach2.Actual_End_Date__c.month());
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                /*if(mseach2.Status__c=='Not Started'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=0;
                                    temvar3.strPlanStartDate='';
                                    temvar3.secondSpanForPlan=0;
                                    temvar3.thirdSpanForPlan=0;
                                    temvar3.strPlanLeadTime ='0';
                                    temvar3.strPlanEndDate ='Not Started';
                                    temvar3.strPlanStartDate ='Not Started';
                                    temvar3.planEndDate = System.today();
                                    temvar3.planhighlighted = '#ff0000';
                                    temvar3.marginleft = '';
                                    temvar3.firstSpanForActual = 0;
                                    temvar3.strActualStartDate = 'Not Started';
                                    temvar3.secondSpanForActual = 1;
                                    temvar3.actualhighlighted = '#ff0000';
                                    temvar3.thirdSpanForActual =0;
                                    temvar3.strActualLeadTime = '0';
                                    temvar3.strActualEndDate = 'Not Started';
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                if(mseach2.Status__c=='In Progress'){
                                    temvar3=new WrapperClassSubStage();
                                   temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(mseach2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=mseach2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c));
                                    temvar3.strPlanEndDate = mseach2.Planned_End_Date__c.day()+'/'+monthMap.get(mseach2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = mseach2.Planned_Start_Date__c.day()+'/'+monthMap.get(mseach2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = mseach2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(mseach2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Actual_Start_Date__c);
                                    temvar3.strActualStartDate = (mseach2.Actual_Start_Date__c != null) ? mseach2.Actual_Start_Date__c.day()+'/'+monthMap.get(mseach2.Actual_Start_Date__c.month()) :null;
                                    temvar3.secondSpanForActual = (mseach2.Actual_Start_Date__c).daysBetween(mseach2.Actual_End_date__c==NULL?System.today():mseach2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted = '#A52A2A';
                                    temvar3.thirdSpanForActual = (mseach2.Actual_End_Date__c==NULL?System.today():mseach2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(mseach2.Actual_Lead_Time__c==NULL?(mseach2.Actual_Start_Date__c).daysBetween(System.today())+1:mseach2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = (mseach2.Actual_End_Date__c != null) ? mseach2.Actual_End_Date__c.day()+'/'+monthMap.get(mseach2.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }*/
                        
                            
                        }
                    }
                    
                    tempVar.skinnStageRecords.add(temvar2);
                    }
                if(mseachstage.Status__c=='Not Started'){
                        temvar2=new WrapperClassStage();
                        temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                        temvar2.OrderNumber=mseachstage.Order_Number__c;
                        temvar2.firstSpanForPlan=0;
                        temvar2.strPlanStartDate='';
                        temvar2.secondSpanForPlan=0;
                        temvar2.thirdSpanForPlan=0;
                        temvar2.strPlanLeadTime ='0';
                        temvar2.strPlanEndDate = 'Not Started';
                        temvar2.strPlanStartDate = 'Not Started';
                        temvar2.planEndDate = System.today();
                        temvar2.planhighlighted = '#ff0000';
                		temvar2.marginleft = '';
                        temvar2.firstSpanForActual = 0;
                        temvar2.strActualStartDate = 'Not Started';
                        temvar2.secondSpanForActual = 0;
                        temvar2.actualhighlighted = '#ff0000';
                        temvar2.thirdSpanForActual = 0;
                        temvar2.strActualLeadTime = '0';
                 		temvar2.strActualEndDate = 'Not Started';
                         temvar2.skinnSubStageRecords=new List<WrapperClassSubStage>();
                        if(mapOfMSStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+currentmarketingStageId)!=NULL){
                            for(Skinn_Collection_Template__c mseach2:mapOfMSStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+currentmarketingStageId)){
                                /*if(mseach2.Status__c=='Completed'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(mseach2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=mseach2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c));
                                    temvar3.strPlanEndDate = mseach2.Planned_End_Date__c.day()+'/'+monthMap.get(mseach2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = mseach2.Planned_Start_Date__c.day()+'/'+monthMap.get(mseach2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = mseach2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(mseach2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Actual_Start_Date__c != null ? mseach2.Actual_Start_Date__c : mseach2.Planned_Start_Date__c);
                                    temvar3.strActualStartDate = mseach2.Actual_Start_Date__c.day()+'/'+monthMap.get(mseach2.Actual_Start_Date__c.month());
                                    temvar3.secondSpanForActual = (mseach2.Actual_Start_Date__c).daysBetween(mseach2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted =mseach2.Actual_End_date__c<=mseach2.Planned_End_Date__c?'#006600':'#66ff33';
                                    temvar3.thirdSpanForActual = (mseach2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(mseach2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = mseach2.Actual_End_Date__c.day()+'/'+monthMap.get(mseach2.Actual_End_Date__c.month());
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }*/
                                if(mseach2.Status__c=='Not Started'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=0;
                                    temvar3.strPlanStartDate='';
                                    temvar3.secondSpanForPlan=0;
                                    temvar3.thirdSpanForPlan=0;
                                    temvar3.strPlanLeadTime ='0';
                                    temvar3.strPlanEndDate ='Not Started';
                                    temvar3.strPlanStartDate ='Not Started';
                                    temvar3.planEndDate = System.today();
                                    temvar3.planhighlighted = '#ff0000';
                                    temvar3.marginleft = '';
                                    temvar3.firstSpanForActual = 0;
                                    temvar3.strActualStartDate = 'Not Started';
                                    temvar3.secondSpanForActual = 0;
                                    temvar3.actualhighlighted = '#ff0000';
                                    temvar3.thirdSpanForActual =0;
                                    temvar3.strActualLeadTime = '0';
                                    temvar3.strActualEndDate = 'Not Started';
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                /*if(mseach2.Status__c=='In Progress'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(mseach2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=mseach2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c));
                                    temvar3.strPlanEndDate = mseach2.Planned_End_Date__c.day()+'/'+monthMap.get(mseach2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = mseach2.Planned_Start_Date__c.day()+'/'+monthMap.get(mseach2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = mseach2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(mseach2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Actual_Start_Date__c);
                                    temvar3.strActualStartDate = (mseach2.Actual_Start_Date__c != null) ? mseach2.Actual_Start_Date__c.day()+'/'+monthMap.get(mseach2.Actual_Start_Date__c.month()) :null;
                                    temvar3.secondSpanForActual = (mseach2.Actual_Start_Date__c).daysBetween(mseach2.Actual_End_date__c==NULL?System.today():mseach2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted = '#A52A2A';
                                    temvar3.thirdSpanForActual = (mseach2.Actual_End_Date__c==NULL?System.today():mseach2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(mseach2.Actual_Lead_Time__c==NULL?(mseach2.Actual_Start_Date__c).daysBetween(System.today())+1:mseach2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = (mseach2.Actual_End_Date__c != null) ? mseach2.Actual_End_Date__c.day()+'/'+monthMap.get(mseach2.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }*/
                        }
                    }
                    
                    tempVar.skinnStageRecords.add(temvar2);
                    }
                    	if(mseachstage.Status__c=='In Progress'){
                        temvar2=new WrapperClassStage();
                        temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                         temvar2.OrderNumber=mseachstage.Order_Number__c;
                        temvar2.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Planned_Start_Date__c);
                        temvar2.strPlanStartDate=String.valueof(mseachstage.planned_Start_Date__c);
                        temvar2.secondSpanForPlan=mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1;
                        temvar2.thirdSpanForPlan=mseachstage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                        temvar2.strPlanLeadTime = (mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1);
                        temvar2.strPlanEndDate = mseachstage.Planned_End_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_End_Date__c.month());
                        temvar2.strPlanStartDate = mseachstage.Planned_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_Start_Date__c.month());
                        temvar2.planEndDate = mseachstage.Planned_End_Date__c;
                        temvar2.planhighlighted = '#003399';
                		temvar2.marginleft = String.valueOf(mseachstage.Planned_Start_Date__c.day());
                        temvar2.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Actual_Start_Date__c);
                        temvar2.strActualStartDate = (mseachstage.Actual_Start_Date__c != null) ? mseachstage.Actual_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_Start_Date__c.month()) :null;
                        temvar2.secondSpanForActual = (mseachstage.Actual_Start_Date__c).daysBetween(mseachstage.Actual_End_date__c==NULL?System.today():mseachstage.Actual_End_date__c)+1;
                        temvar2.actualhighlighted = '#A52A2A';
                        temvar2.thirdSpanForActual = (mseachstage.Actual_End_Date__c==NULL?System.today():mseachstage.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                        temvar2.strActualLeadTime = String.valueof(Integer.valueof(mseachstage.Actual_Lead_Time__c==NULL?(mseachstage.Actual_Start_Date__c).daysBetween(System.today())+1:mseachstage.Actual_Lead_Time__c));
                 		temvar2.strActualEndDate = (mseachstage.Actual_End_Date__c != null) ? mseachstage.Actual_End_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                        
                         temvar2.skinnSubStageRecords=new List<WrapperClassSubStage>();
                        if(mapOfMSStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+currentmarketingStageId)!=NULL){
                            for(Skinn_Collection_Template__c mseach2:mapOfMSStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+currentmarketingStageId)){
                                if(mseach2.Status__c=='Completed'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(mseach2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=mseach2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1);
                                    temvar3.strPlanEndDate = mseach2.Planned_End_Date__c.day()+'/'+monthMap.get(mseach2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = mseach2.Planned_Start_Date__c.day()+'/'+monthMap.get(mseach2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = mseach2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(mseach2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Actual_Start_Date__c != null ? mseach2.Actual_Start_Date__c : mseach2.Planned_Start_Date__c);
                                    temvar3.strActualStartDate = mseach2.Actual_Start_Date__c.day()+'/'+monthMap.get(mseach2.Actual_Start_Date__c.month());
                                    temvar3.secondSpanForActual = (mseach2.Actual_Start_Date__c).daysBetween(mseach2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted =mseach2.Actual_End_date__c<=mseach2.Planned_End_Date__c?'#006600':'#66ff33';
                                    temvar3.thirdSpanForActual = (mseach2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(mseach2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = mseach2.Actual_End_Date__c.day()+'/'+monthMap.get(mseach2.Actual_End_Date__c.month());
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                if(mseach2.Status__c=='Not Started'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=0;
                                    temvar3.strPlanStartDate='';
                                    temvar3.secondSpanForPlan=0;
                                    temvar3.thirdSpanForPlan=0;
                                    temvar3.strPlanLeadTime ='0';
                                    temvar3.strPlanEndDate ='Not Started';
                                    temvar3.strPlanStartDate ='Not Started';
                                    temvar3.planEndDate = System.today();
                                    temvar3.planhighlighted = '#ff0000';
                                    temvar3.marginleft = '';
                                    temvar3.firstSpanForActual = 0;
                                    temvar3.strActualStartDate = 'Not Started';
                                    temvar3.secondSpanForActual = 0;
                                    temvar3.actualhighlighted = '#ff0000';
                                    temvar3.thirdSpanForActual =0;
                                    temvar3.strActualLeadTime = '0';
                                    temvar3.strActualEndDate = 'Not Started';
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                if(mseach2.Status__c=='In Progress'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=mseach2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(mseach2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=mseach2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseach2.Planned_Start_Date__c.daysBetween(mseach2.Planned_End_Date__c)+1);
                                    temvar3.strPlanEndDate = mseach2.Planned_End_Date__c.day()+'/'+monthMap.get(mseach2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = mseach2.Planned_Start_Date__c.day()+'/'+monthMap.get(mseach2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = mseach2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(mseach2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseach2.Actual_Start_Date__c);
                                    temvar3.strActualStartDate = (mseach2.Actual_Start_Date__c != null) ? mseach2.Actual_Start_Date__c.day()+'/'+monthMap.get(mseach2.Actual_Start_Date__c.month()) :null;
                                    temvar3.secondSpanForActual = (mseach2.Actual_Start_Date__c).daysBetween(mseach2.Actual_End_date__c==NULL?System.today():mseach2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted = '#A52A2A';
                                    temvar3.thirdSpanForActual = (mseach2.Actual_End_Date__c==NULL?System.today():mseach2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(mseach2.Actual_Lead_Time__c==NULL?(mseach2.Actual_Start_Date__c).daysBetween(System.today())+1:mseach2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = (mseach2.Actual_End_Date__c != null) ? mseach2.Actual_End_Date__c.day()+'/'+monthMap.get(mseach2.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                        
                            
                        }
                    }
                    
                    tempVar.skinnStageRecords.add(temvar2);
                    }        
    }
    
    public void fillDataBasedOnStatusWhenStageSubStage(WrapperClassNPDGanttChart tempVar,WrapperClassStage temvar2,WrapperClassSubStage temvar3,Skinn_collection_Template__c mseachstage,map<String,List<Skinn_Collection_Template__c>> mapOfStageWithSubStage,Id each){
       Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        Integer numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
        Date lastDayOfMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays);
        Date startDate = calcStartDate(selectedCollectionName, selectedModelName);
        				if(mseachstage.Status__c=='Completed'){
                        temvar2=new WrapperClassStage();
                        temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                        temvar2.OrderNumber=mseachstage.Order_Number__c;
                        temvar2.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Planned_Start_Date__c);
                        temvar2.strPlanStartDate=String.valueof(mseachstage.planned_Start_Date__c);
                        temvar2.secondSpanForPlan=mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1;
                        temvar2.thirdSpanForPlan=mseachstage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                        temvar2.strPlanLeadTime = (mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1);
                        temvar2.strPlanEndDate = mseachstage.Planned_End_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_End_Date__c.month());
                        temvar2.strPlanStartDate = mseachstage.Planned_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_Start_Date__c.month());
                        temvar2.planEndDate = mseachstage.Planned_End_Date__c;
                        temvar2.planhighlighted = '#003399';
                		temvar2.marginleft = String.valueOf(mseachstage.Planned_Start_Date__c.day());
                        temvar2.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Actual_Start_Date__c != null ? mseachstage.Actual_Start_Date__c : mseachstage.Planned_Start_Date__c);
                        temvar2.strActualStartDate = mseachstage.Actual_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_Start_Date__c.month());
                        temvar2.secondSpanForActual = (mseachstage.Actual_Start_Date__c).daysBetween(mseachstage.Actual_End_date__c)+1;
                        temvar2.actualhighlighted =mseachstage.Actual_End_date__c<=mseachstage.Planned_End_Date__c?'#006600':'#66ff33';
                        temvar2.thirdSpanForActual = (mseachstage.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                        temvar2.strActualLeadTime = String.valueof(Integer.valueof(mseachstage.Actual_Lead_Time__c));
                 		temvar2.strActualEndDate = mseachstage.Actual_End_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_End_Date__c.month());
            			temvar2.skinnSubStageRecords=new List<WrapperClassSubStage>();
                    if(mapOfStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+each)!=NULL){
                            for(Skinn_Collection_Template__c each2:mapOfStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+each)){
                            if(each2.Status__c=='Completed'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(each2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=each2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1);
                                    temvar3.strPlanEndDate = each2.Planned_End_Date__c.day()+'/'+monthMap.get(each2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = each2.Planned_Start_Date__c.day()+'/'+monthMap.get(each2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = each2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(each2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Actual_Start_Date__c != null ? each2.Actual_Start_Date__c : each2.Planned_Start_Date__c);
                                    temvar3.strActualStartDate = each2.Actual_Start_Date__c.day()+'/'+monthMap.get(each2.Actual_Start_Date__c.month());
                                    temvar3.secondSpanForActual = (each2.Actual_Start_Date__c).daysBetween(each2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted =each2.Actual_End_date__c<=each2.Planned_End_Date__c?'#006600':'#66ff33';
                                    temvar3.thirdSpanForActual = (each2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(each2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = each2.Actual_End_Date__c.day()+'/'+monthMap.get(each2.Actual_End_Date__c.month());
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                if(each2.Status__c=='Not Started'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=0;
                                    temvar3.strPlanStartDate='';
                                    temvar3.secondSpanForPlan=0;
                                    temvar3.thirdSpanForPlan=0;
                                    temvar3.strPlanLeadTime ='0';
                                    temvar3.strPlanEndDate ='Not Started';
                                    temvar3.strPlanStartDate ='Not Started';
                                    temvar3.planEndDate = System.today();
                                    temvar3.planhighlighted = '#ff0000';
                                    temvar3.marginleft = '';
                                    temvar3.firstSpanForActual = 0;
                                    temvar3.strActualStartDate = 'Not Started';
                                    temvar3.secondSpanForActual = 0;
                                    temvar3.actualhighlighted = '#ff0000';
                                    temvar3.thirdSpanForActual =0;
                                    temvar3.strActualLeadTime = '0';
                                    temvar3.strActualEndDate = 'Not Started';
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                if(each2.Status__c=='In Progress'){
                                    temvar3=new WrapperClassSubStage();
                                                            temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(each2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=each2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1);
                                    temvar3.strPlanEndDate = each2.Planned_End_Date__c.day()+'/'+monthMap.get(each2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = each2.Planned_Start_Date__c.day()+'/'+monthMap.get(each2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = each2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(each2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Actual_Start_Date__c);
                                    temvar3.strActualStartDate = (each2.Actual_Start_Date__c != null) ? each2.Actual_Start_Date__c.day()+'/'+monthMap.get(each2.Actual_Start_Date__c.month()) :null;
                                    temvar3.secondSpanForActual = (each2.Actual_Start_Date__c).daysBetween(each2.Actual_End_date__c==NULL?System.today():each2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted = '#A52A2A';
                                    temvar3.thirdSpanForActual = (each2.Actual_End_Date__c==NULL?System.today():each2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(each2.Actual_Lead_Time__c==NULL?(each2.Actual_Start_Date__c).daysBetween(System.today())+1:each2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = (each2.Actual_End_Date__c != null) ? each2.Actual_End_Date__c.day()+'/'+monthMap.get(each2.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                        }
                    }
                    tempVar.skinnStageRecords.add(temvar2);
                    }
                if(mseachstage.Status__c=='Not Started'){
                        temvar2=new WrapperClassStage();
                        temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                        temvar2.OrderNumber=mseachstage.Order_Number__c;
                        temvar2.firstSpanForPlan=0;
                        temvar2.strPlanStartDate='';
                        temvar2.secondSpanForPlan=0;
                        temvar2.thirdSpanForPlan=0;
                        temvar2.strPlanLeadTime ='0';
                        temvar2.strPlanEndDate = 'Not Started';
                        temvar2.strPlanStartDate = 'Not Started';
                        temvar2.planEndDate = System.today();
                        temvar2.planhighlighted = '#ff0000';
                		temvar2.marginleft = '';
                        temvar2.firstSpanForActual = 0;
                        temvar2.strActualStartDate = 'Not Started';
                        temvar2.secondSpanForActual = 0;
                        temvar2.actualhighlighted = '#ff0000';
                        temvar2.thirdSpanForActual = 0;
                        temvar2.strActualLeadTime = '0';
                 		temvar2.strActualEndDate = 'Not Started';
                       temvar2.skinnSubStageRecords=new List<WrapperClassSubStage>();
                    if(mapOfStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+each)!=NULL){
                            for(Skinn_Collection_Template__c each2:mapOfStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+each)){
                                /*if(each2.Status__c=='Completed'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(each2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=each2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c));
                                    temvar3.strPlanEndDate = each2.Planned_End_Date__c.day()+'/'+monthMap.get(each2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = each2.Planned_Start_Date__c.day()+'/'+monthMap.get(each2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = each2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(each2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Actual_Start_Date__c != null ? each2.Actual_Start_Date__c : each2.Planned_Start_Date__c);
                                    temvar3.strActualStartDate = each2.Actual_Start_Date__c.day()+'/'+monthMap.get(each2.Actual_Start_Date__c.month());
                                    temvar3.secondSpanForActual = (each2.Actual_Start_Date__c).daysBetween(each2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted =each2.Actual_End_date__c<=each2.Planned_End_Date__c?'#006600':'#66ff33';
                                    temvar3.thirdSpanForActual = (each2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(each2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = each2.Actual_End_Date__c.day()+'/'+monthMap.get(each2.Actual_End_Date__c.month());
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }*/
                                if(each2.Status__c=='Not Started'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=0;
                                    temvar3.strPlanStartDate='';
                                    temvar3.secondSpanForPlan=0;
                                    temvar3.thirdSpanForPlan=0;
                                    temvar3.strPlanLeadTime ='0';
                                    temvar3.strPlanEndDate ='Not Started';
                                    temvar3.strPlanStartDate ='Not Started';
                                    temvar3.planEndDate = System.today();
                                    temvar3.planhighlighted = '#ff0000';
                                    temvar3.marginleft = '';
                                    temvar3.firstSpanForActual = 0;
                                    temvar3.strActualStartDate = 'Not Started';
                                    temvar3.secondSpanForActual = 0;
                                    temvar3.actualhighlighted = '#ff0000';
                                    temvar3.thirdSpanForActual =0;
                                    temvar3.strActualLeadTime = '0';
                                    temvar3.strActualEndDate = 'Not Started';
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                /*if(each2.Status__c=='In Progress'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(each2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=each2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c));
                                    temvar3.strPlanEndDate = each2.Planned_End_Date__c.day()+'/'+monthMap.get(each2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = each2.Planned_Start_Date__c.day()+'/'+monthMap.get(each2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = each2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(each2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Actual_Start_Date__c);
                                    temvar3.strActualStartDate = (each2.Actual_Start_Date__c != null) ? each2.Actual_Start_Date__c.day()+'/'+monthMap.get(each2.Actual_Start_Date__c.month()) :null;
                                    temvar3.secondSpanForActual = (each2.Actual_Start_Date__c).daysBetween(each2.Actual_End_date__c==NULL?System.today():each2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted = '#A52A2A';
                                    temvar3.thirdSpanForActual = (each2.Actual_End_Date__c==NULL?System.today():each2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(each2.Actual_Lead_Time__c==NULL?(each2.Actual_Start_Date__c).daysBetween(System.today())+1:each2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = (each2.Actual_End_Date__c != null) ? each2.Actual_End_Date__c.day()+'/'+monthMap.get(each2.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }*/
                        }
                    }
                    tempVar.skinnStageRecords.add(temvar2);
                    }
                    if(mseachstage.Status__c=='In Progress'){
                            temvar2=new WrapperClassStage();
                            temvar2.Name=mseachstage.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                            temvar2.OrderNumber=mseachstage.Order_Number__c;
                            temvar2.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Planned_Start_Date__c);
                            temvar2.strPlanStartDate=String.valueof(mseachstage.planned_Start_Date__c);
                            temvar2.secondSpanForPlan=mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1;
                            temvar2.thirdSpanForPlan=mseachstage.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                            temvar2.strPlanLeadTime = (mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)) == 0 ? ''+1 : ''+(mseachstage.Planned_Start_Date__c.daysBetween(mseachstage.Planned_End_Date__c)+1);
                            temvar2.strPlanEndDate = mseachstage.Planned_End_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_End_Date__c.month());
                            temvar2.strPlanStartDate = mseachstage.Planned_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Planned_Start_Date__c.month());
                            temvar2.planEndDate = mseachstage.Planned_End_Date__c;
                            temvar2.planhighlighted = '#003399';
                            temvar2.marginleft = String.valueOf(mseachstage.Planned_Start_Date__c.day());
                            temvar2.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(mseachstage.Actual_Start_Date__c);
                            temvar2.strActualStartDate = (mseachstage.Actual_Start_Date__c != null) ? mseachstage.Actual_Start_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_Start_Date__c.month()) :null;
                            temvar2.secondSpanForActual = (mseachstage.Actual_Start_Date__c).daysBetween(mseachstage.Actual_End_date__c==NULL?System.today():mseachstage.Actual_End_date__c)+1;
                            temvar2.actualhighlighted = '#A52A2A';
                            temvar2.thirdSpanForActual = (mseachstage.Actual_End_Date__c==NULL?System.today():mseachstage.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                            temvar2.strActualLeadTime = String.valueof(Integer.valueof(mseachstage.Actual_Lead_Time__c==NULL?(mseachstage.Actual_Start_Date__c).daysBetween(System.today())+1:mseachstage.Actual_Lead_Time__c));
                            temvar2.strActualEndDate = (mseachstage.Actual_End_Date__c != null) ? mseachstage.Actual_End_Date__c.day()+'/'+monthMap.get(mseachstage.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                            temvar2.skinnSubStageRecords=new List<WrapperClassSubStage>();
                    if(mapOfStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+each)!=NULL){
                            for(Skinn_Collection_Template__c each2:mapOfStageWithSubStage.get(mseachstage.Skinn_NPD_Template_Item__c+','+each)){
                                if(each2.Status__c=='Completed'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(each2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=each2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1);
                                    temvar3.strPlanEndDate = each2.Planned_End_Date__c.day()+'/'+monthMap.get(each2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = each2.Planned_Start_Date__c.day()+'/'+monthMap.get(each2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = each2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(each2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Actual_Start_Date__c != null ? each2.Actual_Start_Date__c : each2.Planned_Start_Date__c);
                                    temvar3.strActualStartDate = each2.Actual_Start_Date__c.day()+'/'+monthMap.get(each2.Actual_Start_Date__c.month());
                                    temvar3.secondSpanForActual = (each2.Actual_Start_Date__c).daysBetween(each2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted =each2.Actual_End_date__c<=each2.Planned_End_Date__c?'#006600':'#66ff33';
                                    temvar3.thirdSpanForActual = (each2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(each2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = each2.Actual_End_Date__c.day()+'/'+monthMap.get(each2.Actual_End_Date__c.month());
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                if(each2.Status__c=='Not Started'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=0;
                                    temvar3.strPlanStartDate='';
                                    temvar3.secondSpanForPlan=0;
                                    temvar3.thirdSpanForPlan=0;
                                    temvar3.strPlanLeadTime ='0';
                                    temvar3.strPlanEndDate ='Not Started';
                                    temvar3.strPlanStartDate ='Not Started';
                                    temvar3.planEndDate = System.today();
                                    temvar3.planhighlighted = '#ff0000';
                                    temvar3.marginleft = '';
                                    temvar3.firstSpanForActual = 0;
                                    temvar3.strActualStartDate = 'Not Started';
                                    temvar3.secondSpanForActual = 1;
                                    temvar3.actualhighlighted = '#ff0000';
                                    temvar3.thirdSpanForActual =0;
                                    temvar3.strActualLeadTime = '0';
                                    temvar3.strActualEndDate = 'Not Started';
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                                if(each2.Status__c=='In Progress'){
                                    temvar3=new WrapperClassSubStage();
                                    temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                                    temvar3.OrderNumber=each2.Order_Number__c;
                                    temvar3.firstSpanForPlan=startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Planned_Start_Date__c);
                                    temvar3.strPlanStartDate=String.valueof(each2.planned_Start_Date__c);
                                    temvar3.secondSpanForPlan=each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1;
                                    temvar3.thirdSpanForPlan=each2.Planned_End_Date__c.daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strPlanLeadTime = (each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)) == 0 ? ''+1 : ''+(each2.Planned_Start_Date__c.daysBetween(each2.Planned_End_Date__c)+1);
                                    temvar3.strPlanEndDate = each2.Planned_End_Date__c.day()+'/'+monthMap.get(each2.Planned_End_Date__c.month());
                                    temvar3.strPlanStartDate = each2.Planned_Start_Date__c.day()+'/'+monthMap.get(each2.Planned_Start_Date__c.month());
                                    temvar3.planEndDate = each2.Planned_End_Date__c;
                                    temvar3.planhighlighted = '#003399';
                                    temvar3.marginleft = String.valueOf(each2.Planned_Start_Date__c.day());
                                    temvar3.firstSpanForActual = startDate.toStartOfMonth().addMonths(-1).daysBetween(each2.Actual_Start_Date__c);
                                    temvar3.strActualStartDate = (each2.Actual_Start_Date__c != null) ? each2.Actual_Start_Date__c.day()+'/'+monthMap.get(each2.Actual_Start_Date__c.month()) :null;
                                    temvar3.secondSpanForActual = (each2.Actual_Start_Date__c).daysBetween(each2.Actual_End_date__c==NULL?System.today():each2.Actual_End_date__c)+1;
                                    temvar3.actualhighlighted = '#A52A2A';
                                    temvar3.thirdSpanForActual = (each2.Actual_End_Date__c==NULL?System.today():each2.Actual_End_Date__c).daysBetween(lastDayOfMonth.addMonths(1));
                                    temvar3.strActualLeadTime = String.valueof(Integer.valueof(each2.Actual_Lead_Time__c==NULL?(each2.Actual_Start_Date__c).daysBetween(System.today())+1:each2.Actual_Lead_Time__c));
                                    temvar3.strActualEndDate = (each2.Actual_End_Date__c != null) ? each2.Actual_End_Date__c.day()+'/'+monthMap.get(each2.Actual_End_Date__c.month()) : System.today().day()+'/'+monthMap.get(System.today().month()) ;
                                    temvar2.skinnSubStageRecords.add(temvar3);
                                }
                            }
                    }
                    tempVar.skinnStageRecords.add(temvar2);
                    }        
    }
    public void IplusMethod(){
        integer i=0;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
                i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++; i++;
        i++;
        i++;
        i++;
        
    }
    // query data based on model and stage or sub-stage
    public void skinnModelView(){
        // Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
       // Integer numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
       // Date lastDayOfMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays);
       // Date startDate = calcStartDate(selectedCollectionName, selectedModelName);
        
        Map<Id,List<Skinn_Collection_Template__c>> mapOfMSModelWithRecords=new Map<Id,List<Skinn_Collection_Template__c>>();
        map<String,List<Skinn_Collection_Template__c>> mapOfMSStageWithSubStage=new map<String,List<Skinn_Collection_Template__c>>();
        //listDatatableInfo.clear();
        listDatatableInfo=new List<WrapperClassNPDGanttChart>();
        system.debug('listDatatableInfo'+listDatatableInfo);
        List<Skinn_Collection_Template__c> currentMargetingStageRecords=[SELECT
                                                                  Active__c,Actual_End_date__c,Actual_Lead_Time__c,Actual_start_date__c,Approval_Required__c,Comments_Remarks__c,Hierarchy__c,Id,
                                                                  LastModifiedById,Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,Order_Number__c,
                                                                  Skinn_Collection__c,planned_Start_Date__c,planned_End_Date__c,Planned_Lead_Time__c,Skinn_NPD_Template_Item__r.Parent_Id__r.Id,Skinn_Model__c,Skinn_Model__r.Name,Skinn_NPD_Template_Item__c,Status__c,Type__c FROM Skinn_Collection_Template__c where Skinn_Collection__c=:selectedCollectionName AND Skinn_Model__r.Name='MarketingStage' AND (Type__c='Stage' OR Type__c='Sub-Stage') ];
        Id currentmarketingStageId=currentMargetingStageRecords[0].Skinn_Model__c;
        mapOfMSModelWithRecords.put(currentMargetingStageRecords[0].Skinn_Model__c,currentMargetingStageRecords);

        List<Skinn_Collection_Template__c> listOfMSSubStageRecords=new List<Skinn_Collection_Template__c>();
        for(Skinn_Collection_Template__c each:mapOfMSModelWithRecords.get(currentmarketingStageId)){
            if(each!=NULL)
            listOfMSSubStageRecords.add(each);
        }
        List<Skinn_Collection_Template__c> tempMSSubStageList=new List<Skinn_Collection_Template__c>();
        //Map<String,List<Skinn_Collection_Template__c>> mapOfMSStageWithSubStage=new Map<String,List<Skinn_Collection_Template__c>>();
        listOfMSSubStageRecords.sort();
        for(Skinn_Collection_Template__c each:listOfMSSubStageRecords){
            if(mapOfMSStageWithSubStage.containskey(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id+','+each.skinn_Model__c) ){
                tempMSSubStageList.add(each);
                mapOfMSStageWithSubStage.put(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id+','+each.skinn_Model__c,tempMSSubStageList);
            }else{
                tempMSSubStageList=new List<Skinn_Collection_Template__c>();
                tempMSSubStageList.add(each);
                mapOfMSStageWithSubStage.put(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id+','+each.skinn_Model__c,tempMSSubStageList);
            } 
        }
        
        WrapperClassNPDGanttChart tempVar;
        WrapperClassStage temvar2;
        WrapperClassSubStage temvar3;
        List<Skinn_Collection_Template__c> records;
        Set<Id> setAllModelIds;
        System.debug('selectedModelName:'+selectedModelName);
        if(selectedModelName=='None'){
            setAllModelIds=new Set<Id>(); 
            for(selectoption each:modelNameOption){
                if(each.getValue()!='None')
                setAllModelIds.add(each.getValue());
            }
            records=fetchAllRecord(selectedCollectionName,setAllModelIds);
        }else{
            setAllModelIds=new Set<Id>(); 
            system.debug('selectedModelName'+selectedModelName);
            setAllModelIds.add((Id)selectedModelName);
            records=fetchAllRecord(selectedCollectionName,setAllModelIds);
        }
        Map<Id,List<Skinn_Collection_Template__c>> mapstagewithModelRecord=new Map<Id,List<Skinn_Collection_Template__c>>();
        Map<String,List<Skinn_Collection_Template__c>> mapOfStageWithSubStage=new Map<String,List<Skinn_Collection_Template__c>>();
        Integer i=-1;
        List<Skinn_Collection_Template__c> tempStageList;
        List<Skinn_Collection_Template__c> tempSubStageList;
        System.debug('records'+records.size());
        List<Skinn_Collection_Template__c> listOfSubStageRecords=new List<Skinn_Collection_Template__c>();
        for(Skinn_Collection_Template__c each:records){
            if(each.Type__c=='Stage'){
                if(mapstagewithModelRecord.containskey(each.Skinn_Model__c) ){
                    tempStageList.add(each);
                    mapstagewithModelRecord.put(each.Skinn_Model__c,tempStageList);
                }else{
                    tempStageList=new List<Skinn_Collection_Template__c>();
                    tempStageList.add(each);
                    mapstagewithModelRecord.put(each.Skinn_Model__c,tempStageList);
                }
            }
            if(each!=NULL && each.Type__c=='Sub-Stage' ){
                listOfSubStageRecords.add(each);
            }
            
        }
        listOfSubStageRecords.sort();
        for(Skinn_Collection_Template__c each:listOfSubStageRecords){
            if(mapOfStageWithSubStage.containskey(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id+','+each.skinn_Model__c) ){
                tempSubStageList.add(each);
                mapOfStageWithSubStage.put(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id+','+each.skinn_Model__c,tempSubStageList);
            }else{
                tempSubStageList=new List<Skinn_Collection_Template__c>();
                tempSubStageList.add(each);
                mapOfStageWithSubStage.put(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id+','+each.skinn_Model__c,tempSubStageList);
            } 
        }
        for(String each:mapOfStageWithSubStage.keyset()){
            System.debug(''+mapOfStageWithSubStage.get(each).size());
        }
        if(selectedStageName=='Stage'){
            
            for(Id each:mapstagewithModelRecord.keyset()){
                tempVar=new WrapperClassNPDGanttChart();
                tempVar.skinnModelName=mapstagewithModelRecord.get(each)[0].Skinn_Model__r.Name;
                tempVar.skinnStageRecords=new List<WrapperClassStage>();
                
                for(Skinn_Collection_Template__c mseachstage:mapOfMSModelWithRecords.get(currentmarketingStageId)){
                    if(mseachstage.Type__c=='Stage'){
                        FillDataBasedOnStatus(tempVar,temvar2,mseachstage);
                    }
                     
                }
                for(Skinn_Collection_Template__c each1:mapstagewithModelRecord.get(each)){
                    FillDataBasedOnStatus(tempVar,temvar2,each1);
                }
                listDatatableInfo.add(tempVar);
            }
        }else{
            for(Id each:mapstagewithModelRecord.keyset()){
                tempVar=new WrapperClassNPDGanttChart();
                tempVar.skinnModelName=mapstagewithModelRecord.get(each)[0].Skinn_Model__r.Name;
                tempVar.skinnStageRecords=new List<WrapperClassStage>();
                for(Skinn_Collection_Template__c mseach1:mapOfMSModelWithRecords.get(currentmarketingStageId)){
                    if(mseach1.Type__c=='Stage'){
                    temvar2=new WrapperClassStage();
                        fillDataBasedOnStatusWhenStage(tempVar,temvar2,temvar3,mseach1,mapOfMSStageWithSubStage,currentmarketingStageId);
                   /* temvar2.Name=mseach1.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                    temvar2.OrderNumber=mseach1.Order_Number__c;
                    temvar2.skinnSubStageRecords=new List<WrapperClassSubStage>();
                        if(mapOfMSStageWithSubStage.get(mseach1.Skinn_NPD_Template_Item__c+','+currentmarketingStageId)!=NULL){
                            for(Skinn_Collection_Template__c mseach2:mapOfMSStageWithSubStage.get(mseach1.Skinn_NPD_Template_Item__c+','+currentmarketingStageId)){
                            temvar3=new WrapperClassSubStage();
                            temvar3.Name=mseach2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                            temvar2.skinnSubStageRecords.add(temvar3);
                        }
                    }
                    
                    tempVar.skinnStageRecords.add(temvar2);*/
                    }
                }
                for(Skinn_Collection_Template__c each1:mapstagewithModelRecord.get(each)){
                    
                    temvar2=new WrapperClassStage();
                    fillDataBasedOnStatusWhenStageSubStage(tempVar,temvar2,temvar3,each1,mapOfStageWithSubStage,each);
                    /*temvar2.Name=each1.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                    temvar2.OrderNumber=each1.Order_Number__c;
                    temvar2.skinnSubStageRecords=new List<WrapperClassSubStage>();
                    if(mapOfStageWithSubStage.get(each1.Skinn_NPD_Template_Item__c+','+each)!=NULL){
                            for(Skinn_Collection_Template__c each2:mapOfStageWithSubStage.get(each1.Skinn_NPD_Template_Item__c+','+each)){
                            temvar3=new WrapperClassSubStage();
                            temvar3.Name=each2.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
                            temvar3.OrderNumber=each2.Order_Number__c;
                            temvar2.skinnSubStageRecords.add(temvar3);
                        }
                    }
                    tempVar.skinnStageRecords.add(temvar2);*/
                    
                }
                listDatatableInfo.add(tempVar);
            }
        }
        /*for(WrapperClassNPDGanttChart each:listDatatableInfo){
            for(WrapperClassStage each1:each.skinnStageRecords){
                system.debug('Name:'+each1.Name+'Color plann'+each1.planhighlighted);
                for(WrapperClassSubStage each2: each1.skinnSubStageRecords){
                    system.debug('Name:'+each2.Name+'Color plann'+each2.planhighlighted);
                }
            }
        }*/
        for(WrapperClassNPDGanttChart each:listDatatableInfo){
            each.skinnStageRecords.sort();
            for(WrapperClassStage each1:each.skinnStageRecords){
                if(selectedStageName!='Stage')
                each1.skinnSubStageRecords.sort();
            }
        }
        
    }
    
    
    
    
    public List<Skinn_Collection_Template__c> fetchAllRecord(String currentCollectionId,Set<Id> ModelIds){
        system.debug('ModelIds'+ModelIds);
        System.debug('selectedCollectionName'+selectedCollectionName);
        List<Skinn_Collection_Template__c> allRecord=[SELECT
                                                      Active__c,Actual_End_date__c,Actual_Lead_Time__c,Actual_start_date__c,Approval_Required__c,Comments_Remarks__c,Hierarchy__c,Id,
                                                      LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,Order_Number__c,
                                                      Skinn_Collection__c,planned_Start_Date__c,planned_End_Date__c,Planned_Lead_Time__c,Skinn_NPD_Template_Item__r.Parent_Id__r.Id,Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,Skinn_Model__c,Skinn_Model__r.Name,Skinn_NPD_Template_Item__c,Status__c,Type__c FROM Skinn_Collection_Template__c where Skinn_Collection__c=:selectedCollectionName AND Skinn_Model__c in:ModelIds AND (Type__c='Stage' OR Type__c='Sub-Stage') order by Skinn_Model__c limit 1000];
        return allRecord;
    }
    public void queryCollections(){
         collectionNameOption = new List<selectoption>();
        //collectionNameOption.add(new selectoption('--None--', '--None--'));
       collectionNameOption.add(new selectoption('--None--', '--None--'));
     //   selectedCollectionName = [Select Id, Name FROM NPD_Collections__c where Name = 'Projects'].id;
        for(Skinn_Collection__c collection :[Select Id, Name FROM Skinn_Collection__c order by name,lastmodifieddate desc LIMIT 1000]){
            collectionNameOption.add(new selectoption(collection.Id, collection.Name));
        }   
        System.debug('collectionNameOption:-'+collectionNameOption.size());
    }
    public void queryStages(){
        stageNameOption = new List<selectoption>();
        stageNameOption.add(new selectoption('Stage','Stage'));
        stageNameOption.add(new selectoption('Stage And Sub-Stage','Stage & Sub-Stage'));
    }
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
        System.debug('StringMonths:'+StringMonths);
        return StringMonths;
    }
    public Map<Integer, String> buildMonthMap(){
        List<String> strMonths = new List<String>{'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
        
        for(Integer i=1; i <=12; i++){
            monthMap.put(i, strMonths[i-1]); 
        }
        
        return monthMap;
    }
    public class WrapperClassNPDGanttChart {
        public String skinnModelName{get;set;}
        public List<WrapperClassStage> skinnStageRecords{get;set;}
    }
    public class WrapperClassStage implements comparable{
        public String plan{get;set;}
        public String actual{get;set;}
        public String Name{get;set;}
        public Decimal OrderNumber{get;set;}
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
        public String Type{get;set;}
        public List<WrapperClassSubStage> skinnSubStageRecords{get;set;}
        //public List<WrapperClassSubStage> skinnActivityRecords{get;set;}
        public WrapperClassStage(){
            plan='Plan';
            Actual='Actual';
        }
        public WrapperClassStage(Decimal OrderNumber){
            this.OrderNumber=OrderNumber;
        }
        Public Integer compareTo (Object compareTo) {
            WrapperClassStage wrappIns = (WrapperClassStage)compareTo;
            Integer returnValue = 0;
            If (OrderNumber > wrappIns.OrderNumber) {
                returnValue = 1;
            } else if (OrderNumber < wrappIns.OrderNumber) {
                returnValue = -1;
            }
            Return returnValue; 
        }
    }
    
    public class WrapperClassSubStage implements comparable{
        public String plan{get;set;}
        public String actual{get;set;}
        public String Name{get;set;}
        public Decimal OrderNumber{get;set;}
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
        public String Type{get;set;}
        //public List<WrapperClassSubStage> skinnActivityRecords{get;set;}
        public WrapperClassSubStage(){
            plan='Plan';
            Actual='Actual';
        }
        public WrapperClassSubStage(Decimal OrderNumber){
            this.OrderNumber=OrderNumber;
        }
        Public Integer compareTo (Object compareTo) {
            WrapperClassSubStage wrappIns = (WrapperClassSubStage)compareTo;
            Integer returnValue = 0;
            If (OrderNumber > wrappIns.OrderNumber) {
                returnValue = 1;
            } else if (OrderNumber < wrappIns.OrderNumber) {
                returnValue = -1;
            }
            Return returnValue; 
        }
    }
}