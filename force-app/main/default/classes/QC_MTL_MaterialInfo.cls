public class QC_MTL_MaterialInfo {
    @AuraEnabled
    public static List<QC_MTL_Component__c> fetchMaterialData(sObject reportRefId){
       System.debug('----reportRefId---->>'+reportRefId);
        QC_MTL_Component__c obj1 = (QC_MTL_Component__c) reportRefId;
        System.debug('====obj1---->>>'+obj1.Id);
        List<QC_MTL_Component__c> qcCompList= new List<QC_MTL_Component__c>();
        if(obj1 !=NULL){
            qcCompList=[SELECT ID,Name,Document_Status__c,Createddate,Record_Status__c,MTL_User_Email__c,Sample_Size_Qty__c,Testing_Type__c,Material_Sample_Type__c,Raw_Material_Type__c,Report_Reference_Number__c,Sample_Received_Date__c,
                       Final_Verdict__c,Sample_Received_From__c,MTL_User__c,MTL_User__r.Name,Brand__c,Brand__r.Name FROM QC_MTL_Component__c WHERE ID = :obj1.Id];
          
        }//if ends
        for(QC_MTL_Component__c returnResult : qcCompList){
             if(returnResult.Sample_Received_Date__c == null){
            returnResult.Sample_Received_Date__c = Date.newInstance(returnResult.Createddate.Year(), returnResult.Createddate.Month(), returnResult.Createddate.Day());
        }
        }
        System.debug('----qcCompList-->>'+qcCompList);
        if(qcCompList.size()>0){
            return qcCompList;
        }
        return null;
    }//fetchMaterialData method ends
    
     @AuraEnabled
    public static QC_MTL_Component__c updateComponent(String recId,QC_MTL_Component__c infoData){
       System.debug('recId---qacIdObj'+recId+'==='+infoData);
        infoData.Id=recId;
        update infoData;
        QC_MTL_Component__c returnResult=[SELECT Id,Report_Reference_Number__c,Sample_Received_Date__c,Createddate,Record_Status__c,Document_Status__c,Final_Verdict__c FROM QC_MTL_Component__c where Id = :recId][0];
        
        System.debug('rvvdsgg'+returnResult);
        return returnResult;
      
    }

}