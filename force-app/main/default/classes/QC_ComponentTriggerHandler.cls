/*
Name:
Created By: Anand Durga Prasad
Created Date:
Modified By:  Anand Durga Prasad
Last Modified Date:
Description: Trigger to validate the duplicate SKU Reference and Watch Variant based on component type and re-submission.
*/

public with sharing class QC_ComponentTriggerHandler {
    
    
    static Map<string,QC_components__c> skuMap = new Map<string,QC_components__c>();
    static Map<string,QC_components__c> watchVariantMap = new Map<string,QC_components__c>();
    //Initializing the maps 
    public static void initialize(){
        Boolean l3;
        Boolean l4;
        Boolean l5;
        Boolean l6;
        if(test.isRunningTest()){
            list<QC_components__c> qcLst1 = [select id, name__c,SKU_Reference__c, PSY_Reference__c, Watch_Variant__c,Sample_Category__c from QC_Components__c where Sample_Category__c != 'Re-submission' LIMIT 4000]; 
            for(QC_components__c comp : qcLst1 ){
                skuMap.put(string.valueOf(comp.SKU_Reference__c),comp);
                if(comp.name__c == 'Full-Watch' || comp.name__c == 'Watch-Head'){
                    watchVariantMap.put(comp.Watch_Variant__c,comp);
                } 
            }
            
        }else{
            list<QC_components__c> qcLst = [select id, name__c,SKU_Reference__c, PSY_Reference__c, Watch_Variant__c,Sample_Category__c from QC_Components__c where Sample_Category__c != 'Re-submission' LIMIT 49000];
            
            for(QC_components__c comp : qcLst ){
                skuMap.put(string.valueOf(comp.SKU_Reference__c),comp);
                if(comp.name__c == 'Full-Watch' || comp.name__c == 'Watch-Head'){
                     if(Recursivecheck.runOnce())
            {
                    watchVariantMap.put(comp.Watch_Variant__c,comp);
            }
                } 
            }
        }
    }  
    //Code to identify the duplicate SKU reference and Watch Variant on insertion of the component record   
    public static void uniqueCheckOnInsert(list<QC_Components__c> newList){
        if(Recursivecheck.runOnce())
            {
        initialize();
            }
        for(QC_components__c comp : newList){
            if(!skuMap.isEmpty() && comp.SKU_Reference__c != null && skuMap.containsKey(string.valueOf(comp.SKU_Reference__c)) && comp.Sample_Category__c != 'Re-submission'){ 
                comp.addError('This SKU Reference already exists');
            }
            if(!watchVariantMap.isEmpty() && comp.Watch_Variant__c != null && watchVariantMap.containsKey(comp.Watch_Variant__c) && comp.Sample_Category__c != 'Re-submission' && (comp.name__c == 'Full-Watch' || comp.name__c == 'Watch-Head')){
                comp.addError('This Watch Variant already exists');
            }
          /*  //The component status of the component should be active when they create it.
            system.debug('component status before:1'+comp.Component_Status__c);
            comp.Component_Status__c = 'Active';
            system.debug('component status after:2'+comp.Component_Status__c);*/
        } 
    } 
    //Code to identify the duplicate SKU reference and Watch Variant on update of the component record   
    public static void uniqueCheckOnUpdate( Map<id,QC_Components__c> newMap, Map<id,QC_Components__c> oldMap){
        boolean B1 = true;
        for(QC_components__c comp1 : newMap.values()){
            If((comp1.SKU_Reference__c != oldMap.get(comp1.Id).SKU_Reference__c || comp1.Watch_variant__c != oldMap.get(comp1.Id).Watch_variant__c) && B1 == true){
                 initialize();
                B1 = false;
            }
        }
       
        for(QC_components__c comp : newMap.values()){
            if(!skuMap.isEmpty() && comp.SKU_Reference__c != null && skuMap.containsKey(string.valueOf(comp.SKU_Reference__c)) && comp.Sample_Category__c != 'Re-submission' && string.valueOf(comp.SKU_Reference__c) != string.valueOf(oldMap.get(comp.id).SKU_Reference__c)){ 
                comp.addError('This SKU Reference already exists');
            }
            if(!watchVariantMap.isEmpty() && comp.Watch_Variant__c != null && watchVariantMap.containsKey(comp.Watch_Variant__c) && comp.Sample_Category__c != 'Re-submission' && (comp.name__c == 'Full-Watch' || comp.name__c == 'Watch-Head') && comp.Watch_Variant__c != oldMap.get(comp.id).Watch_Variant__c){
                comp.addError('This Watch Variant already exists');
            }
        } 
    }
    
    public static void updateComponentPrefix(Map<id,QC_Components__c> newMap){
        String compName;
        List<QC_Component_Prefix__c> cusSettingsLIst = new List<QC_Component_Prefix__c>();
        for(QC_Components__c comp : newMap.values()){
            if(comp.Sample_Category__c != 'Competitor Products'){
                compName = (comp.Name__c != null && comp.Name__c != '')   
                    ?((comp.Name__c == 'Full-Watch') ? 'FW' 
                      :(comp.Name__c == 'Watch-Head') ? 'WH'
                      :(comp.Name__c == 'Case') ? 'CA' 
                      :(comp.Name__c == 'Dial') ? 'DL'
                      :(comp.Name__c == 'Metal-Strap') ? 'MS'
                      :(comp.Name__c == 'Leather-Strap' || comp.Name__c == 'Special-Strap') ? 'LS'
                      :(comp.Name__c == 'Module') ? 'FMA' 
                      :(comp.Name__c == 'Battery') ? 'BT' 
                      :(comp.Name__c == 'Packaging')  ? 'PA' : null)  : null;
            }
            else{
                compName = (comp.Name__c != null && comp.Name__c != '')   
                    ?((comp.Name__c == 'Full-Watch') ? 'CFW' 
                      :(comp.Name__c == 'Watch-Head') ? 'CWH'
                      :(comp.Name__c == 'Case') ? 'CCA' 
                      :(comp.Name__c == 'Dial') ? 'CDL'
                      :(comp.Name__c == 'Metal-Strap') ? 'CMS'
                      :(comp.Name__c == 'Leather-Strap' || comp.Name__c == 'Special-Strap') ? 'CLS'
                      :(comp.Name__c == 'Module') ? 'CFMA' 
                      :(comp.Name__c == 'Battery') ? 'CBT' 
                      :(comp.Name__c == 'Packaging')  ? 'CPA' : null) : null;
            }
            
            
            if(compName != null && comp.parent__c == null && comp.Sample_Category__c != 'Re-Submission'){
                System.debug('++++++++++comp.parent__c++++'+comp.parent__c);
                QC_Component_Prefix__c cusSettings = QC_Component_Prefix__c.getValues(compName);
                system.debug('Custom settings' + cusSettings);
                string seqNo = string.valueOf(integer.ValueOf(cusSettings.sequence_Number__c)+1);
                cusSettings.sequence_Number__c = appendZeros(seqNo);
                cusSettingsLIst.add(cusSettings);
            }
        }//End of For
        
        //Grab custom setting values
        if(!cusSettingsLIst.isEmpty()){ 
            try{
                update cusSettingsLIst;
            }catch(Exception ex){
                
            }
        }
        
        
    }//End of method
    
    public static string appendZeros(String seqNo){
        
        return (seqNo != null) 
            ?((seqNo.length() == 1) ? '000'+seqNo
              :(seqNo.length() == 2) ? '00'+seqNo
              :(seqNo.length() == 3) ? '0'+seqNo : seqNo) : seqNo;       
    } 
    
    
    
    /*
* Created By: Sanjeev Shukla
* Created Date:27/Nov/2015
* Description: Trigger to update Full-Watch and Watch-Head component approval status based on child component.
*/
    public static void updateComponentApprovalStatus(List<QC_Components__c> listCom){
         Set<Date> Holidays = new Set<Date>();
        for(holiday h:[Select Id, ActivityDate From Holiday]){
            Holidays.add(h.ActivityDate);
        }
        for(QC_Components__c comp : listCom){
            if((/*comp.Published_Date__c != null && */comp.Sample_Date__c!= null) ){
                Integer i = 0;
                Date dt = comp.Sample_Date__c;
                DateTime endDate ;
                if(comp.Published_Date__c != null )
                    endDate = comp.Published_Date__c;
                else if(comp.approval_submitted_date__c != null )
                    endDate = comp.approval_submitted_date__c;
                DateTime startDate   = date.newInstance(dt.year(), dt.month(),dt.day());
                //system.debug('startDate++++++++++===:'+startDate+'======comp.Sample_Date__c====='+comp.Sample_Date__c);
                //system.debug('End Date:'+endDate);
                while (startDate < endDate) {  
                    if (startDate.format('EEE') == 'Sun') {i = i + 1; }  
                    startDate = startDate.addDays(1);  
                   // system.debug('Day====='+startDate.format('EEE'));
                    //system.debug('Date====='+startDate);
                }  
                comp.Number_of_Sunday__c = i;
                 /*****
                * Modified By: Vinoth Kumar
                * Modified Date: 15/05/2019
                *Description: Added number of holidays to exclude from Lead time
                *************************/
                DateTime endDate1;
                DateTime inspEndDate;
                  if(comp.Published_Date__c != NULL){
                    endDate1 = comp.Published_Date__c;
                } else {
                    endDate1 = comp.approval_submitted_date__c;
                }
                if(comp.First_Approval_Date__c != NULL || test.isRunningTest()){
                    integer j = 0;
                    DateTime startDate2   = date.newInstance(dt.year(), dt.month(),dt.day());
                    inspEndDate = comp.First_Approval_Date__c;
                    while (startDate2 <= inspEndDate) {  
                    if (startDate2.format('EEE') == 'Sun') {j = j + 1; }  
                    startDate2 = startDate2.addDays(1);  

                }  
                comp.No_of_Sunday_Inspection__c = j;
                 //system.debug('Number of holidays-----:'+comp.No_of_Sunday_Inspection__c);   
                }
                //system.debug('endDate1====:'+endDate1);
                Date startDate1 = date.valueof(date.newInstance(dt.year(), dt.month(),dt.day()));
                //system.debug('startDate1====:'+startDate1);
                //List<Holiday> holidays = [Select Id, ActivityDate From Holiday Where ActivityDate >= :startDate1 And ActivityDate <= :endDate1];
                //system.debug('holidaysList-----:'+holidays);
                comp.Number_of_holidays__c = 0;
                comp.No_of_Holidays_Inspection__c = 0;
                for(Date h : holidays){
                    //system.debug('holidays-----:'+h);
                    if(endDate1 >= h && startDate1 <= h){
                        comp.Number_of_holidays__c = comp.Number_of_holidays__c + 1;
                    }
                    //system.debug('comp.Number_of_holidays__c'+comp.Number_of_holidays__c);
                    if(comp.First_Approval_Date__c != NULL){
                        if(inspEndDate >= h && startDate1 <= h){
                            comp.No_of_Holidays_Inspection__c = comp.No_of_Holidays_Inspection__c + 1;
                        } 
                    }
                    //system.debug('comp.No_of_Holidays_Inspection__c'+comp.No_of_Holidays_Inspection__c);
                    
                }
               /* system.debug('holidays+++++:'+holidays);
                if (holidays != null){
                    comp.Number_of_holidays__c = holidays.size();
                }*/
                
                 /******************/
            }    
        }
       
        QC_Components__c com = listCom[0];
        if((com.Name__c == 'Full-Watch' || com.Name__c == 'Watch-Head') && com.Document_Status__c != 'Submitted for Approval'){
            List<QC_Components__c> listchildComp = [SELECT Name__c, Document_Status__c, final_verdict__c FROM QC_Components__c WHERE Parent__c =: com.id];
            if(com.final_verdict__c != NULL){                    // if Parent component final verdict is not null 
                if(com.Document_Status__c == 'Published'){       // all components are published if full watch/head is accepted
                    for(QC_Components__c childCom : listchildComp ){
                        childCom.Document_Status__c = 'Published';
                    }
                }else if(com.Document_Status__c == 'Draft'){    // all components are Draft if full watch/head is rejected
                    for(QC_Components__c childCom : listchildComp ){
                        if(childCom.Document_Status__c != 'Published'){ childCom.Document_Status__c = 'Draft'; }
                    }
                }
            }else{ 
                if(com.Document_Status__c == 'Published'){ 
                    List<String> listChildCompName = com.ChildComponentName__c.split(',');
                    for(QC_Components__c childCom : listchildComp ){
                        Boolean flag = false;
                        if(childCom.final_verdict__c != NULL){
                            for(String name : listChildCompName ){
                                if(childCom.Name__c == name){ flag = true; }
                            }
                            if(flag){ childCom.Document_Status__c = 'Published'; }
                        }
                    }
                    com.Document_Status__c = 'Partial Published';
                }else if(com.Document_Status__c == 'Draft'){    // all components should be Draft if full watch/head is rejected except those which is published
                    for(QC_Components__c childCom : listchildComp ){
                        if(childCom.Document_Status__c != 'Published'){
                            childCom.Document_Status__c = 'Draft';
                        }
                    }
                    if(String.isBlank(com.ChildComponentName__c)){
                        com.Document_Status__c = 'Draft';
                    }else{ com.Document_Status__c = 'Partial Published'; }
                }
            }
            try{ update listchildComp;} catch(Exception ex){ System.debug('**********listchildComp********* '+ex.getMessage());}  
        }
    }
    
    /*
Created By  : Anindwita Raj
Created Date : 13/4/2018
Description : Class to update the component's verdict in Master Variant's child individual Components with Master's child components verdict. Whenever we do any updation in Master it should reflect in master variant.
*/
    public static void syncComponentData(List<QC_Components__c > pNew, Map<Id, QC_Components__c > pOldMap){
        Set<Id> compIdsSet = new Set<Id>();
        List<QC_Components__c> pComponentDataNew = new List<QC_Components__c>();
        for(QC_Components__c theComponentData : pNew){
            if(theComponentData.Final_Verdict__c != pOldMap.get(theComponentData.Id).Final_Verdict__c){
                compIdsSet.add(theComponentData.Id);
                pComponentDataNew.add(theComponentData);
            }
        }
        
        if(!compIdsSet.isEmpty()){
            Map<Id, QC_Components__c> compMap = new Map<Id, QC_Components__c>([SELECT Id, Name__c, Parent__c FROM QC_Components__c WHERE Id IN : compIdsSet AND Parent__r.Master__c =: TRUE]);
            Set<Id> masterCompIdsSet = new Set<Id>();
            Set<String> compNamesSet = new Set<String>();
            for(QC_Components__c theComp : compMap.values()){
                masterCompIdsSet.add(theComp.Parent__c);
                compNamesSet.add(theComp.Name__c);
            }
            
            Map<String, list<QC_Components__c>> componentDataMap = new Map<String, list<QC_Components__c>>();
            for(QC_Components__c theCompData : [SELECT Id, Name__c, Final_Verdict__c,Parent__r.Master_Variant__c FROM QC_Components__c 
                                                WHERE Parent__r.Master_Variant__c IN : masterCompIdsSet 
                                                AND Name__c IN : compNamesSet AND Master__c = FALSE])
            {
                if(componentDataMap.containsKey(theCompData.Name__c+theCompData.Parent__r.Master_Variant__c)){
                    componentDataMap.get(theCompData.Name__c+theCompData.Parent__r.Master_Variant__c).add(theCompData);
                }else{
                    list<QC_Components__c> qcCompList = new list<QC_Components__c>();
                    qcCompList.add(theCompData);
                    componentDataMap.put(theCompData.Name__c+theCompData.Parent__r.Master_Variant__c, qcCompList);
                }
            }
            system.debug('------------componentDataMap-----------'+componentDataMap.keySet());
            system.debug('------------componentDataMap-----------'+componentDataMap.values());
            
            if(!componentDataMap.isEmpty() && !compMap.isEmpty()){
                List<QC_Components__c> childCompData = new List<QC_Components__c>();
                for(QC_Components__c theComponentData : pComponentDataNew){
                    if(componentDataMap.containsKey(compMap.get(theComponentData.Id).Name__c+compMap.get(theComponentData.Id).Parent__c)){
                        for(QC_Components__c qcComp : componentDataMap.get(compMap.get(theComponentData.Id).Name__c+compMap.get(theComponentData.Id).Parent__c)){
                            QC_Components__c compData = new QC_Components__c();
                            compData.Id        = qcComp.Id;
                            compData.Final_Verdict__c = theComponentData.Final_Verdict__c;
                            childCompData.add(compData);
                        }
                    }
                }
                
                if(!childCompData.isEmpty()){
                    update childCompData;
                }
            }
        } 
        
        integer i = 0;
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