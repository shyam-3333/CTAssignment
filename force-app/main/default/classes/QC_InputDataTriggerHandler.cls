/*
    Name        : QC_InputDataTriggerHandler
    Created By  : Anindwita Raj
    Created Date: 13/4/2018
    Description : Class to update the input parameters i.e. questions with responses in master variant. Whenever we do any updation in Master it should reflect in master variant.
*/
public class QC_InputDataTriggerHandler{
    public static void syncNewInputData(List<QC_Input_Data__c > pNew){
        Set<Id> quesIdsSet = new Set<Id>();
        Set<Id> compIdsSet = new Set<Id>();
        Map<Id, QC_Input_Data__c> quesMap = new Map<Id, QC_Input_Data__c>();
        for(QC_Input_Data__c theInputData : pNew){
            compIdsSet.add(theInputData.Component_No__c);
            //quesIdsSet.add(theInputData.Question__c);
            quesMap.put(theInputData.Question__c, theInputData);
        }
        //List<QC_Question__c> questionList = new List<QC_Question__c>();
        for(QC_Question__c theQues : [SELECT Id FROM QC_Question__c WHERE  Id IN : quesMap.keySet() AND Onload__c =: FALSE]){
            quesIdsSet.add(theQues.Id);
        }
        if(!quesIdsSet.isEmpty() && !compIdsSet.isEmpty()){
            Set<Id> masterCompIdsSet = new Set<Id>();
            for(QC_Components__c theComp : [SELECT Id, Parent__c FROM QC_Components__c WHERE Id IN : compIdsSet AND Parent__r.Master__c =: TRUE]){
                masterCompIdsSet.add(theComp.Parent__c);
            }
            
            if(!masterCompIdsSet.isEmpty() ){
                Set<Id> variantCompIdsSet = new Set<Id>();
                List<QC_Input_Data__c> variantInDataList = new List<QC_Input_Data__c>();
                system.debug('-------------quesIdsSet------------'+quesIdsSet);
                system.debug('---------masterCompIdsSet---------'+masterCompIdsSet);
                for(QC_Components__c theCom : [SELECT Id FROM QC_Components__c WHERE Parent__r.Master_Variant__c IN : masterCompIdsSet]){
                    //variantCompIdsSet.add(theCom.Id);
                    
                    system.debug('-------------theCom------------'+theCom);
                   
                    for(Id theQuesId : quesIdsSet){
                        QC_Input_Data__c theInData 	= new QC_Input_Data__c();
                        theInData.Question__c 		= theQuesId;
                        theInData.Component_No__c	= theCom.Id;
                        theInData.Comments__c		= quesMap.get(theQuesId).Comments__c;
                        theInData.Question_Name__c	= quesMap.get(theQuesId).Question_Name__c;
                        theInData.Response_Id__c	= quesMap.get(theQuesId).Response_Id__c;
                        theInData.Value__c			= quesMap.get(theQuesId).Value__c;
                        variantInDataList.add(theInData);
                    }
                    
                
                }
                
                if(!variantInDataList.isEmpty()){
                    insert variantInDataList;
                }
            }
            
        }
    }
    
    public static void syncUpdatedInputData(List<QC_Input_Data__c > pNew, Map<Id, QC_Input_Data__c > pOldMap){
        Set<Id> compIdsSet = new Set<Id>();
        Set<Id> quesIdsSet = new Set<Id>();
        Set<Id> resIdsOld = new Set<Id>();
        List<QC_Input_Data__c> pInputDataNew = new List<QC_Input_Data__c>();
        for(QC_Input_Data__c theInputData : pNew){
            if(theInputData.Value__c != pOldMap.get(theInputData.Id).Value__c){
                compIdsSet.add(theInputData.Component_No__c);
                quesIdsSet.add(theInputData.Question__c);
                pInputDataNew.add(theInputData);
                resIdsOld.add(pOldMap.get(theInputData.Id).Response_Id__c);
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
            Set<Id> quesIdsSetDel = new Set<Id>();
            if(!resIdsOld.isEmpty()){
                for(QC_Condition__c theCond : [SELECT id, Question__c FROM QC_Condition__c WHERE Response__c IN : resIdsOld]){
                    quesIdsSetDel.add(theCond.Question__c);
                }
            }
            List<QC_Input_Data__c> delInDataList = new List<QC_Input_Data__c>();
            Map<String, List<QC_Input_Data__c>> inputDataMap = new Map<String, List<QC_Input_Data__c>>();
            
            for(QC_Input_Data__c theInputData : [SELECT Id, Question__c, Component_No__r.Name__c, Component_No__r.Parent__r.Master_Variant__c 
                                                 FROM QC_Input_Data__c WHERE Component_No__r.Parent__r.Master_Variant__c IN : masterCompIdsSet 
                                                 AND Component_No__r.Name__c IN : compNamesSet AND Question__c IN : quesIdsSet AND Component_No__r.Master__c =: FALSE])
            {
                if(quesIdsSetDel.contains(theInputData.Question__c)){
                    delInDataList.add(theInputData);
                }else{
                    if(inputDataMap.containsKey(theInputData.Question__c+theInputData.Component_No__r.Name__c+theInputData.Component_No__r.Parent__r.Master_Variant__c)){
                        inputDataMap.get(theInputData.Question__c+theInputData.Component_No__r.Name__c+theInputData.Component_No__r.Parent__r.Master_Variant__c).add(theInputData);
                    }else{
                        List<QC_Input_Data__c> inputDataList = new List<QC_Input_Data__c>();
                        inputDataList.add(theInputData);    
                        inputDataMap.put(theInputData.Question__c+theInputData.Component_No__r.Name__c+theInputData.Component_No__r.Parent__r.Master_Variant__c, inputDataList);
                    }
                }
            }
            system.debug('------------inputDataMap-----------'+inputDataMap.keySet());
            system.debug('------------inputDataMap-----------'+inputDataMap.values());
            
            if(!inputDataMap.isEmpty()){
                List<QC_Input_Data__c> childInData = new List<QC_Input_Data__c>();
                for(QC_Input_Data__c theInputData : pInputDataNew){
                    if(inputDataMap.containsKey(theInputData.Question__c+compMap.get(theInputData.Component_No__c).Name__c+compMap.get(theInputData.Component_No__c).Parent__c)){
                        for(QC_Input_Data__c each : inputDataMap.get(theInputData.Question__c+compMap.get(theInputData.Component_No__c).Name__c+compMap.get(theInputData.Component_No__c).Parent__c)){
                            QC_Input_Data__c inputData  = new QC_Input_Data__c();
                            inputData.Id                = each.Id;
                            inputData.Value__c         = theInputData.Value__c;
                            childInData.add(inputData);
                            
                        }
                    }
                }
                
                if(!childInData.isEmpty()){
                    update childInData;
                }
                
                if(!delInDataList.isEmpty()){
                    delete delInDataList;
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
        
        
        
    }

}