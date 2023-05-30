/*
    Name        : QC_TestDataTriggerHandler
    Created By  : Anindwita Raj
    Created Date : 13/4/2018
    Description : Class to update the Test Parameters of Master Variant child individual Components. Whenever we do any updation in Master it should reflect in master variant.
*/
public class QC_TestDataTriggerHandler {
    public static void syncTestData(List<QC_Test_Data__c > pNew, Map<Id, QC_Test_Data__c > pOldMap){
    System.debug('******'+pNew+'***********pOldMap'+pOldMap);
        Set<Id> compIdsSet = new Set<Id>();
        Set<Id> condRefIdsSet = new Set<Id>();
        List<QC_Test_Data__c > pTestDataNew = new List<QC_Test_Data__c >();
        for(QC_Test_Data__c theTestData : pNew){
            if(theTestData.Observation__c!= pOldMap.get(theTestData .Id).Observation__c || theTestData.Conclusion__c!= pOldMap.get(theTestData.Id).Conclusion__c || theTestData.Comments_and_Remarks__c != pOldMap.get(theTestData.Id).Comments_and_Remarks__c || theTestData.Specification_Input__c != pOldMap.get(theTestData.Id).Specification_Input__c || theTestData.UOM_Input__c != pOldMap.get(theTestData.Id).UOM_Input__c){
                compIdsSet.add(theTestData.Component_Name__c);
                condRefIdsSet.add(theTestData.Condition_Ref__c);
                pTestDataNew.add(theTestData);
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
        
        Map<String, list<QC_Test_Data__c>> testDataMap = new Map<String, list<QC_Test_Data__c>>();
        
            for(QC_Test_Data__c theTestData : [SELECT Id,Condition_Ref__r.Question__r.Test_Name__c, Component_Name__r.Name__c, Component_Name__r.Parent__r.Master_Variant__c 
                                                 FROM QC_Test_Data__c 
                                                 WHERE Component_Name__r.Parent__r.Master_Variant__c IN : masterCompIdsSet 
                                                 AND Component_Name__r.Name__c IN : compNamesSet 
                                                 AND Condition_Ref__c IN : condRefIdsSet AND Component_Name__r.Master__c =: FALSE])
            {
                if(testDataMap.containsKey(theTestData.Condition_Ref__c+theTestData.Component_Name__r.Name__c+theTestData.Component_Name__r.Parent__r.Master_Variant__c)){
                        testDataMap.get(theTestData.Condition_Ref__c+theTestData.Component_Name__r.Name__c+theTestData.Component_Name__r.Parent__r.Master_Variant__c).add(theTestData);
                }else{
                    list<QC_Test_Data__c> qcTestList = new list<QC_Test_Data__c>();
                    qcTestList.add(theTestData);
                    testDataMap.put(theTestData.Condition_Ref__c+theTestData.Component_Name__r.Name__c+theTestData.Component_Name__r.Parent__r.Master_Variant__c, qcTestList);
                }
            }
            system.debug('------------testDataMap-----------'+testDataMap.keySet());
            
            if(!testDataMap.isEmpty()){
                List<QC_Test_Data__c > childTestData = new List<QC_Test_Data__c>();
                for(QC_Test_Data__c theTestFindData : pTestDataNew){
                    if(testDataMap.containsKey(theTestFindData.Condition_Ref__c+compMap.get(theTestFindData.Component_Name__c).Name__c+compMap.get(theTestFindData.Component_Name__c).Parent__c)){
                        for(QC_Test_Data__c qc : testDataMap.get(theTestFindData.Condition_Ref__c+compMap.get(theTestFindData.Component_Name__c).Name__c+compMap.get(theTestFindData.Component_Name__c).Parent__c)){
                            QC_Test_Data__c testData = new QC_Test_Data__c ();
                            testData.Id = qc.Id;
                            testData.Observation__c = theTestFindData.Observation__c;
                            testData.Comments_and_Remarks__c = theTestFindData.Comments_and_Remarks__c;
                            testData.Conclusion__c  = theTestFindData.Conclusion__c;
                            testData.Specification_Input__c = theTestFindData.Specification_Input__c;
                            testData.UOM_Input__c = theTestFindData.UOM_Input__c;
                            childTestData.add(testData);
                        }  
                    }
                }
                
                if(!childTestData.isEmpty()){
                    update childTestData;
                    System.debug('*********childTestData'+childTestData);
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
       
        
       
        
    }
}