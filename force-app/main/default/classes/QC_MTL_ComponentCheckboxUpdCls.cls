public class QC_MTL_ComponentCheckboxUpdCls {
    
    public static void updateRespStatusCheckbox(List<QC_MTL_TestResponse__c> qcmtlRespList){
       Set<Id> mtlCompIdSet = new Set<Id>();
        List<QC_MTL_Component__c> mtlCompList = new List<QC_MTL_Component__c>();
        for(QC_MTL_TestResponse__c eachObj :qcmtlRespList){
            if(eachObj.QC_MTL_Component_del__c !=NULL){
                 mtlCompIdSet.add(eachObj.QC_MTL_Component_del__c);
            }
           
        }
        if(mtlCompIdSet.size()>0){
            for(QC_MTL_Component__c each : [SELECT ID,Name,ToBeUpdated__c FROM QC_MTL_Component__c WHERE ID IN :mtlCompIdSet]){
                each.ToBeUpdated__c = true;
                mtlCompList.add(each);
            }
        }
        if(mtlCompList.size() >0){
            update mtlCompList;
        }
    }

}