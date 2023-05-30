//This is for QC_Access Component records.(Construction AND Construction's Re-Submission)

public class selectComponentClass {
    
    
    @AuraEnabled
    public static QC_Access_Component__c updateComponent(String recId,QC_Access_Component__c qacIdObj){
        System.debug('recId---qacIdObj'+recId+'==='+qacIdObj);
        qacIdObj.Id=recId;
        update qacIdObj;
        return [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c,Final_Verdict__c FROM QC_Access_Component__c where Id = :recId];
        
    }
    
    
    @AuraEnabled
    public static QC_Access_Component__c saveAndFetchDetails(QC_Access_Component__c qacObj){
        System.debug('====qacObj====>>'+qacObj);
        System.debug('====qacObj====>>'+qacObj.Sample_Type__c);
        //QC_Accessories_Component_Prefix__c custSetObj=new QC_Accessories_Component_Prefix__c();
        String refNo;
         Date d = System.today();
         Integer currentYear = d.year() - ((d.month() == 1 ||  d.month() == 2 || d.month() == 3) ? 1 : 0);
        String yr = String.valueOf(currentYear);
        //String yr = String.valueOf(System.today().year());
        yr = yr.substring(2,4);
        Integer value = Integer.valueOf(yr);
        if(qacObj != null){
            
            if((qacObj.Sample_Type__c !='Competitor Products' && qacObj.Sample_Type__c !='Re-Submission') && qacObj.isConstructionTesting__c !=false){
                
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
            system.debug('Coming=========================>'+qacObj);
            if(qacObj.Sample_Type__c =='Competitor Products'){
                
                refNo=(qacObj.Sample_Category__c != NULL && qacObj.Sample_Category__c !='')?
                    ((qacObj.Sample_Category__c=='Bags')?'CBAC':
                     (qacObj.Sample_Category__c=='Belts')?'CBEC':
                     (qacObj.Sample_Category__c=='Wallets')?'CBWC':null):null;
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
            }
            insert qacObj;
        }//end of if(qacObj !=NULL)        
        QC_Access_Component__c qcAccesObject = [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c,Final_Verdict__c FROM QC_Access_Component__c where Id = :qacObj.Id];
        return qcAccesObject;
    }//end of method
    
    
    @AuraEnabled
    public static QC_Access_Component__c saveReSubmissionData(String sampleType,sObject referenceNoObj,QC_Access_Component__c qacObj){
        QC_Access_Component__c qcObj = (QC_Access_Component__c)referenceNoObj;
        System.debug(':::qcObj.Report::'+qcObj.Report_Ref_Number__c);
        System.debug(':::qacObj ::: '+qacObj);
        Integer appnd =1;
        if((qcobj.Report_Ref_Number__c !=NULL && qcObj.Report_Ref_Number__c !='' ) ){
            if(qcobj.Report_Ref_Number__c.lastIndexOf(']') == -1){
                qacObj.Report_Ref_Number__c = qcObj.Report_Ref_Number__c +'[R'+ String.valueOf(appnd) + ']';
                System.debug('::::qacObj Ref::: '+qcObj.Report_Ref_Number__c +'[R'+ String.valueOf(appnd) + ']');
            }
            else{
                
                if((qcobj.Report_Ref_Number__c.lastIndexOf(']') > 0)  && (qcobj.Report_Ref_Number__c.lastIndexOf(']') == qcobj.Report_Ref_Number__c.length()-1)){
                    qacObj.Report_Ref_Number__c =qcObj.Report_Ref_Number__c.substring(0,qcObj.Report_Ref_Number__c.lastIndexOf(']')-1) +
                    String.valueOf(Integer.valueOf(qcObj.Report_Ref_Number__c.substring((qcObj.Report_Ref_Number__c.lastIndexOf(']')-1),qcObj.Report_Ref_Number__c.lastIndexOf(']')))+1) +
                    qcObj.Report_Ref_Number__c.substring(qcObj.Report_Ref_Number__c.lastIndexOf(']')); 
                }
                else{
                    qacObj.Report_Ref_Number__c = qcObj.Report_Ref_Number__c +'[R'+ String.valueOf(appnd) + ']';
                }
                                                            
            }
        }
        if(qacObj !=NULL){
            insert qacObj;
        }
        if(qcObj !=NULL && qcObj.Id !=NULL){
            qcObj.Record_Status__c='Obsolete';
            update qcObj;
        }
        
        return [Select Id,Report_Ref_Number__c,Record_Status__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,Vendor__c,Final_Verdict__c,Sub_Category__c,Document_Status__c FROM QC_Access_Component__c WHERE ID =:qacObj.ID];
    }
    
    @AuraEnabled
    public static QC_Access_Component__c fetchReSubmissionData(String reportRefNo){
        QC_Access_Component__c qcCompObj = [SELECT ID,Name,Brand__c,Document_Status__c,General_Observation__c,Final_Verdict__c,Gender__c,isConstructionTesting__c,isReliabilityTesting__c,
                                            No_Of_Sample_Received__c,Record_Status__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                                            Sample_Received_From2__c,Sample_Received_From3__c,Sample_Received_From4__c,Sample_Received_From5__c,
                                            Sample_Type__c,SKU_Reference__c,Sub_Category__c,Vendor__c,Brand__r.Name,Vendor__r.Name,Vendor_Reference__c FROM QC_Access_Component__c WHERE 
                                            Id =:reportRefNo];
        if(qcCompObj !=NULL){
            return qcCompObj;
        }
        return NULL;
    }
    
}