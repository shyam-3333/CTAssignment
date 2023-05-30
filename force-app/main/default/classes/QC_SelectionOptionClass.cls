public class QC_SelectionOptionClass {
    
    
    @AuraEnabled
    public static List<QC_Access_Component__c> fetchQcAccessCompData(Id reportRefId){
       //System.debug('----reportRefId---->>'+reportRefId);
        //QC_Access_Component__c obj1 = (QC_Access_Component__c) reportRefId;
        //System.debug('====obj1---->>>'+obj1.Id);
        List<QC_Access_Component__c> qcCompList= new List<QC_Access_Component__c>();
        if(reportRefId !=NULL || test.isRunningTest()){
            qcCompList=[SELECT ID,Name,Document_Status__c,Record_Status__c, No_Of_Sample_Received__c,Construction_Refer_Number__c,Construction_Refer_Number__r.Report_Ref_Number__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                       Sample_Type__c,SKU_Reference__c, Sub_Category__c,isConstructionTesting__c,isReliabilityTesting__c,Vendor__c,Vendor__r.Name,Brand__c,Brand__r.Name,General_Observation__c FROM QC_Access_Component__c WHERE ID = :reportRefId];
            
        }//if ends
        System.debug('----qcCompList-->>'+qcCompList);
        if(qcCompList.size()>0){
            return qcCompList;
        }
        return null;
    }//fetchComponentData method ends
    
    
    
    @AuraEnabled
    public static List<QC_Access_Component__c> fetchConstrRefData(Id reportRefId){
        System.debug('----reportRefId---->>'+reportRefId);
        //QC_Access_Component__c obj1 = (QC_Access_Component__c) reportRefId;
        //System.debug('====obj1---->>>'+obj1.Id);
        List<QC_Access_Component__c> qcCompList= new List<QC_Access_Component__c>();
        if(reportRefId !=NULL || test.isRunningTest()){
            qcCompList=[SELECT ID,Name,Document_Status__c,Record_Status__c, No_Of_Sample_Received__c,Construction_Refer_Number__c,Construction_Refer_Number__r.Report_Ref_Number__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                       Sample_Type__c,SKU_Reference__c, Sub_Category__c,isConstructionTesting__c,isReliabilityTesting__c,Vendor__c,Master__c,Vendor__r.Name,Brand__c,Brand__r.Name,General_Observation__c FROM QC_Access_Component__c WHERE ID = :reportRefId];
            
        }//if ends
        System.debug('----qcCompList##-->>'+qcCompList);
        if(qcCompList.size()>0){
            return qcCompList;
        }
        return null;
    }//fetchConstructionData method ends
    @AuraEnabled
    public static  List<QC_Access_Component__c> savemasterReferedValue(Id constrRefId, Boolean masterReferedValue){
         List<QC_Access_Component__c> qcCompList= new List<QC_Access_Component__c>();
        if(constrRefId !=NULL){
           qcCompList=[SELECT ID,Name,Document_Status__c,Record_Status__c, No_Of_Sample_Received__c,Master_Refer_Value__c,Construction_Refer_Number__c,Construction_Refer_Number__r.Report_Ref_Number__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                       Sample_Type__c,SKU_Reference__c, Sub_Category__c,isConstructionTesting__c,isReliabilityTesting__c,Vendor__c,Master__c,Vendor__r.Name,Brand__c,Brand__r.Name,General_Observation__c FROM QC_Access_Component__c WHERE ID = :constrRefId];
            
        }
        if(qcCompList.size()>0){
            qcCompList[0].Master_Refer_Value__c = masterReferedValue;
            update qcCompList;
        }
        
        
        return qcCompList;
    }
    
    
     @AuraEnabled  
    public static Map<String,List<String>> getDependentOptionsImpl(string objApiName , string contrfieldApiName , string depfieldApiName){
        system.debug(objApiName + '##' + contrfieldApiName + '###' + depfieldApiName);
           
        String objectName = objApiName.toLowerCase();
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
            //get the string to sobject global map
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
         
        if (!Schema.getGlobalDescribe().containsKey(objectName)){
            System.debug('OBJNAME NOT FOUND --.> ' + objectName);
            return null;
         }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType==null){
            return objResults;
        }
        Bitset bitSetObj = new Bitset(); //it is a class named as Bitset which is being refrenced for indexing
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        //Check if picklist values exist
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            System.debug('FIELD NOT FOUND --.> ' + controllingField + ' OR ' + dependentField);
            return objResults;     
        }
        
        List<Schema.PicklistEntry> contrEntries = objFieldMap.get(controllingField).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> depEntries = objFieldMap.get(dependentField).getDescribe().getPicklistValues();
         objFieldMap = null;
        List<Integer> controllingIndexes = new List<Integer>();
        for(Integer contrIndex=0; contrIndex<contrEntries.size(); contrIndex++){            
            Schema.PicklistEntry ctrlentry = contrEntries[contrIndex];
            String label = ctrlentry.getLabel();
            objResults.put(label,new List<String>());
            controllingIndexes.add(contrIndex);
        }
        List<Schema.PicklistEntry> objEntries = new List<Schema.PicklistEntry>();
        List<PicklistEntryWrapper> objJsonEntries = new List<PicklistEntryWrapper>();
        for(Integer dependentIndex=0; dependentIndex<depEntries.size(); dependentIndex++){            
               Schema.PicklistEntry depentry = depEntries[dependentIndex];
               objEntries.add(depentry);
        } 
        objJsonEntries = (List<PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objEntries), List<PicklistEntryWrapper>.class);
        List<Integer> indexes;
        for (PicklistEntryWrapper objJson : objJsonEntries){
            if (objJson.validFor==null || objJson.validFor==''){
                continue;
            }
            indexes = bitSetObj.testBits(objJson.validFor,controllingIndexes);
            for (Integer idx : indexes){                
                String contrLabel = contrEntries[idx].getLabel();
                objResults.get(contrLabel).add(objJson.label);
            }
        }
        objEntries = null;
        objJsonEntries = null;
        system.debug('objResults--->' + objResults);
        return objResults;
    }
    
     @AuraEnabled
    public Static string submitForAppProcess(String RecId){
        
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        //Passing record id 
        req.setObjectId(RecId);        
        Approval.ProcessResult result = Approval.process(req);
        string approvalResult = result.getInstanceStatus();
        return approvalResult;
    }
    
   
     @AuraEnabled
    public Static QC_Access_Component__c fetchDocumentStatus(String RecId){
        QC_Access_Component__c qcCompList = new QC_Access_Component__c();
        if(RecId !=NULL){
           qcCompList =[SELECT ID,Name,Document_Status__c FROM QC_Access_Component__c WHERE ID = :RecId];
        }
        return qcCompList;
    }
    @AuraEnabled
    public Static QC_Access_Component__c fetchDocStatusForConstr(String RecId){
        QC_Access_Component__c qcCompList = new QC_Access_Component__c();
        //QC_Access_Component__c qcComp = (QC_Access_Component__c) RecId;
        if(RecId !=NULL ){
           qcCompList =[SELECT ID,Name,Document_Status__c,Construction_Refer_Number__r.Report_Ref_Number__c FROM QC_Access_Component__c WHERE Id = :RecId];
        }
        return qcCompList;
    }
    
   @AuraEnabled
    public Static QC_Access_Component__c fetchMasterValue(String RecId){
        QC_Access_Component__c qcCompList = new QC_Access_Component__c();
        //QC_Access_Component__c qcComp = (QC_Access_Component__c) RecId;
        if(RecId !=NULL ){
           qcCompList =[SELECT ID,Name,Document_Status__c,Construction_Refer_Number__r.Report_Ref_Number__c,master_Reliability__c,Master__c FROM QC_Access_Component__c WHERE Id = :RecId];
        }
        return qcCompList;
    } 
}