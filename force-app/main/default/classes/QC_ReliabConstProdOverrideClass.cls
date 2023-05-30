public class QC_ReliabConstProdOverrideClass {
    
    @AuraEnabled
    public static List<QC_Access_Component__c> fetchConstructionData(sObject reportRefId){
       System.debug('----reportRefId---->>'+reportRefId);
        QC_Access_Component__c obj1 = (QC_Access_Component__c) reportRefId;
       // System.debug('====obj1---->>>'+obj1.Id);
        List<QC_Access_Component__c> qcCompList= new List<QC_Access_Component__c>();
        if(obj1 !=NULL){
            qcCompList=[SELECT ID,Name,Document_Status__c,Record_Status__c,	No_Of_Sample_Received__c,Vendor_Reference__c,Gender__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                       Sample_Type__c,SKU_Reference__c,Final_Verdict__c,Sub_Category__c,Vendor__c,Vendor__r.Name,Brand__c,Brand__r.Name,General_Observation__c FROM QC_Access_Component__c WHERE Id = :obj1.Id];
            
        }//if ends
        System.debug('----qcCompList-->>'+qcCompList);
        if(qcCompList.size()>0){
            return qcCompList;
        }
        return null;
    }//fetchConstructionData method ends
    
   @AuraEnabled
    public static QC_Access_Component__c saveAndDisplayDetails(QC_Access_Component__c qacObj){
        System.debug('====qacObj====>>'+qacObj);
        if(qacObj != null){
        
               if((qacObj.Sample_Type__c !='Competitor Products' && qacObj.Sample_Type__c !='Re-Submission') && qacObj.isConstructionTesting__c !=false){
                    String refNo;
                    String yr = String.valueOf(System.today().year());
                           yr= yr.substring(2,4);
                   Integer value=Integer.valueOf(yr);
                   System.debug('====value=====>>'+value);
                    refNo=(qacObj.Sample_Category__c != NULL && qacObj.Sample_Category__c !='')?
                      ((qacObj.Sample_Category__c=='Bags')?'BAC':
                      (qacObj.Sample_Category__c=='Belts')?'BEC':
                      (qacObj.Sample_Category__c=='Wallets')?'WLC':null):null;
                      System.debug('refNo=====>>>'+refNo);
                          if (refNo !=NULL && refNo !=''){
                              System.debug('Coming Inside this to update the report ref no');
                             QC_Accessories_Component_Prefix__c custSettObj= QC_Accessories_Component_Prefix__c.getValues(refNo);
                              if(custSettObj !=NULL){
                                  System.debug('custObj is not null--');
                                   qacObj.Report_Ref_Number__c=String.valueOf(custSettObj.Name)+'/'+String.valueOf(custSettObj.Sequence_Number__c)+'/'+String.valueOf(value)+'-'+String.valueOf((value+1));
                                   System.debug('qacObj.Report_Ref_Number__c======>'+String.valueOf(custSettObj.Name)+String.valueOf(custSettObj.Sequence_Number__c));
                                  
                              }

                          }
                         
             }//For New and Other Sample Type,No Re-Submission here.

            insert qacObj;
			
        }//end of if(qacObj !=NULL)
  
        QC_Access_Component__c qcAccesObject = [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c from QC_Access_Component__c where Id = :qacObj.Id];
        return qcAccesObject;
    }
    
	@AuraEnabled
    public static QC_Access_Component__c updateComponent(String recId,QC_Access_Component__c qacIdObj){
       System.debug('recId---qacIdObj'+recId+'==='+qacIdObj);
        qacIdObj.Id=recId;
        update qacIdObj;
        return [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c,Final_Verdict__c FROM QC_Access_Component__c where Id = :recId];
      
    }


}