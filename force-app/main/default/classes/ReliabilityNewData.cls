/*Author:-Rahul Mukherji
*Description: This class is written in order to save the QC Accessories Reliability Component New Records
*Contains 2 methods,one save the records for the Sample Type New and other of Sample Type Re-Submission.
*/

public class ReliabilityNewData{
    //This method is to update the records for reliability
    @AuraEnabled
    public static QC_Access_Component__c updateComponent(String recId,QC_Access_Component__c qacIdObj){
       System.debug('recId---qacIdObj'+recId+'==='+qacIdObj);
        qacIdObj.Id=recId;
        update qacIdObj;
        return [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c,Final_Verdict__c FROM QC_Access_Component__c where Id = :recId];
      
    }
    
    @AuraEnabled
    public static QC_Access_Component__c saveNewReliabilityData(QC_Access_Component__c qcObjForReliabNew){
       System.debug('====qcObjForReliabNew====>>'+qcObjForReliabNew);
     //QC_Accessories_Component_Prefix__c custSetObj=new QC_Accessories_Component_Prefix__c();
        String refNo;
        Date d = System.today();
                   Integer currentYear = d.year() - ((d.month() == 1 ||  d.month() == 2 || d.month() == 3) ? 1 : 0);
                   String yr = String.valueOf(currentYear);
                   //String yr = String.valueOf(System.today().year());
                   yr= yr.substring(2,4);
                   Integer value=Integer.valueOf(yr);
                   System.debug('====value=====>>'+value);
        if(qcObjForReliabNew != null){
        
               if((qcObjForReliabNew.Sample_Type__c !='Competitor Products' && qcObjForReliabNew.Sample_Type__c !='Re-Submission') && qcObjForReliabNew.isReliabilityTesting__c !=false){
                   
                   
                    refNo=(qcObjForReliabNew.Sample_Category__c != NULL && qcObjForReliabNew.Sample_Category__c !='')?
                      ((qcObjForReliabNew.Sample_Category__c=='Bags')?'BA':
                      (qcObjForReliabNew.Sample_Category__c=='Belts')?'BE':
                      (qcObjForReliabNew.Sample_Category__c=='Wallets')?'WL':null):null;
                      System.debug('refNo=====>>>'+refNo);
                          if (refNo !=NULL && refNo !=''){
                              System.debug('Coming Inside this to update the report ref no');
                             QC_Accessories_Component_Prefix__c custSettObj= QC_Accessories_Component_Prefix__c.getValues(refNo);
                              if(custSettObj !=NULL){
                                  System.debug('custObj is not null--');
                                   qcObjForReliabNew.Report_Ref_Number__c=String.valueOf(custSettObj.Name)+'/'+String.valueOf(custSettObj.Sequence_Number__c)+'/'+String.valueOf(value)+'-'+String.valueOf((value+1));
                                   System.debug('qcObjForReliabNew.Report_Ref_Number__c======>'+String.valueOf(custSettObj.Name)+String.valueOf(custSettObj.Sequence_Number__c));
                               }

                          }
                         
             }//For New and Other Sample Type,No Re-Submission here.
             
            if(qcObjForReliabNew.Sample_Type__c =='Competitor Products'){
                
                refNo=(qcObjForReliabNew.Sample_Category__c != NULL && qcObjForReliabNew.Sample_Category__c !='')?
                    ((qcObjForReliabNew.Sample_Category__c=='Bags')?'CBA':
                     (qcObjForReliabNew.Sample_Category__c=='Belts')?'CBE':
                     (qcObjForReliabNew.Sample_Category__c=='Wallets')?'CBW':null):null;
                System.debug('refNo=====>>>'+refNo);
                if (refNo !=NULL && refNo !=''){
                    System.debug('Coming Inside this to update the report ref no');
                    QC_Accessories_Component_Prefix__c custSettObj= QC_Accessories_Component_Prefix__c.getValues(refNo);
                    if(custSettObj !=NULL){
                        System.debug('custObj is not null--');
                        qcObjForReliabNew.Report_Ref_Number__c=String.valueOf(custSettObj.Name)+'/'+String.valueOf(custSettObj.Sequence_Number__c)+'/'+String.valueOf(value)+'-'+String.valueOf((value+1));
                        System.debug('qcObjForReliabNew.Report_Ref_Number__c======>'+String.valueOf(custSettObj.Name)+String.valueOf(custSettObj.Sequence_Number__c));
                        
                    }
                    
                }
            }
        
            insert qcObjForReliabNew;
            
        }//end of if(qcObjForReliabNew !=NULL)
        
        
        
        QC_Access_Component__c qcAccesObject = [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c from QC_Access_Component__c where Id = :qcObjForReliabNew.Id];
        return qcAccesObject;   
}//method ends.
    
   
    /*This method is for Reliability's Re-Submission type Record and to generate their prefix([a],[b]).
     *  
     */
    @AuraEnabled
    public static QC_Access_Component__c saveReliabReSubData(String sampleType,sObject referenceNoObj,QC_Access_Component__c qacObj){
         QC_Access_Component__c qcObj = (QC_Access_Component__c)referenceNoObj;
        System.debug(':::qcObj.Report::'+qcObj.Report_Ref_Number__c);
        Integer appnd =1;
        if((qcobj.Report_Ref_Number__c !=NULL && qcObj.Report_Ref_Number__c !='' ) ){
            if(qcobj.Report_Ref_Number__c.indexOf(']') == -1){
               qacObj.Report_Ref_Number__c = qcObj.Report_Ref_Number__c +'[R'+ String.valueOf(appnd) + ']';
            }
            else{
                qacObj.Report_Ref_Number__c =qcObj.Report_Ref_Number__c.substring(0,qcObj.Report_Ref_Number__c.indexOf(']')-1) +
                                            String.valueOf(Integer.valueOf(qcObj.Report_Ref_Number__c.substring((qcObj.Report_Ref_Number__c.indexOf(']')-1),qcObj.Report_Ref_Number__c.indexOf(']')))+1) +
                                            qcObj.Report_Ref_Number__c.substring(qcObj.Report_Ref_Number__c.indexOf(']'));                                          
            }
        }
        if(qacObj !=NULL){
            insert qacObj;
        }
        if(qcObj !=NULL && qcObj.Id !=NULL){
            qcObj.Record_Status__c='Obsolete';
            update qcObj;
        }
      
        return [Select Id,Report_Ref_Number__c,Record_Status__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                Sample_Received_From2__c,Sample_Received_From3__c,Sample_Received_From4__c,Sample_Received_From5__c,
                Vendor__c,Final_Verdict__c,Sub_Category__c,Document_Status__c FROM QC_Access_Component__c WHERE ID =:qacObj.ID];
    
        
    }//Re-Submission for Reliability Ends.
    
    @AuraEnabled
    public static QC_Access_Component__c fetchReSubmissionData(String reportRefNo){
        QC_Access_Component__c qcCompObj = [SELECT ID,Name,Brand__c,Document_Status__c,General_Observation__c,Final_Verdict__c,Gender__c,isConstructionTesting__c,isReliabilityTesting__c,
                                           No_Of_Sample_Received__c,Record_Status__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                                           Sample_Received_From2__c,Sample_Received_From3__c,Sample_Received_From4__c,Sample_Received_From5__c, 
                                           Sample_Type__c,SKU_Reference__c,Sub_Category__c,Vendor__c,Brand__r.Name,Vendor__r.Name,Vendor_Reference__c,Construction_Refer_Number__c,Construction_Refer_Number__r.Report_Ref_Number__c FROM QC_Access_Component__c WHERE 
                                           Id =:reportRefNo];
        if(qcCompObj !=NULL){
            return qcCompObj;
        }
        return NULL;
    }

}