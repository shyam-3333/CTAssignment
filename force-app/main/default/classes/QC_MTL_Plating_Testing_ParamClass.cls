/*
 * Company : Kvp Business Solution 
 * Date    : 8/1/2019
 * Author  : Sameer Ranjan
 * Description : Controller Class for QC_Mtl_Plating_InputParam.cmp Component.
 * History     : N/L 
 */
public class QC_MTL_Plating_Testing_ParamClass {
    public class WrapperClass{
        @AuraEnabled
        public QC_MTL_Component__c materialInformation;
    }
    @AuraEnabled
    public Static WrapperClass getRecordInfo(String recordId){
        WrapperClass returnResult=new WrapperClass();
        returnResult.materialInformation=[Select ID,Sample_Size_Plating__c,Createddate,MTL_User_Email__c,Sample_Received_Date__c,Record_Status__c,Sample_Received_From__c,MTL_User__c,Brand__c,Final_Verdict__c,Material_Sample_Type__c,Brand__r.Name From QC_MTL_Component__c where Id=:recordId];
        if(returnResult.materialInformation.Sample_Received_Date__c == null){
            returnResult.materialInformation.Sample_Received_Date__c = Date.newInstance(returnResult.materialInformation.Createddate.Year(), returnResult.materialInformation.Createddate.Month(), returnResult.materialInformation.Createddate.Day());
        }
        return returnResult;
    }
    @AuraEnabled
    public static QC_MTL_Component__c updateComponent(QC_MTL_Component__c infoData){
        update infoData;
        QC_MTL_Component__c mtlObjectResult=[SELECT Id,Document_Status__c,Record_Status__c,Report_Reference_Number__c FROM QC_MTL_Component__c where Id = :infoData.Id][0];
        System.debug('--------------rvvdsgg'+mtlObjectResult);
        return mtlObjectResult;
    }
}