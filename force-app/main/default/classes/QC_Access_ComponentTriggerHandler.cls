public class QC_Access_ComponentTriggerHandler{
  //Map<String,QC_Access_Component__c> bagCompMap= new Map<String,QC_Access_Component__c>();
  //Map<String,QC_Access_Component__c> beltCompMap= new Map<String,QC_Access_Component__c>();
  //Map<String,QC_Access_Component__c> walletCompMap= new Map<String,QC_Access_Component__c>();
  public static Map <String,QC_Access_Component__c> referCheckMap= new Map<String,QC_Access_Component__c>();
  
  /*This method is written in order to verify, the SKU Reference Number is already existing on another record or not.
   This method runs and check the data during record insert.
  
  */
  
  public static void checkSKUReferOnInsert(List<QC_Access_Component__c> newInsList){
    List<QC_Access_Component__c> fetchAllDataList= new List<QC_Access_Component__c>();
    fetchAllDataList=[SELECT ID,Name,SKU_Reference__c,Sample_Type__c,Sample_Category__c,Sub_Category__c FROM QC_Access_Component__c WHERE SKU_Reference__c !='Re-submission' ORDER BY CreatedDate DESC LIMIT 50000];
    if(fetchAllDataList.size()>0){
      for(QC_Access_Component__c obj:fetchAllDataList){
        referCheckMap.put(obj.SKU_Reference__c,obj);
      }
    }
    if(newInsList.size()>0){
      for(QC_Access_Component__c obj:newInsList){
        if(!referCheckMap.isEmpty() && obj.SKU_Reference__c !=NULL && referCheckMap.containsKey(obj.SKU_Reference__c)){
          obj.addError('The SKU Reference Number already exist!!Please enter a new SKU Reference Number.');
        }
      }
    }
    
  }//check SKU Refer OnInsert method ends
  
  
  public static void checkReferOnUpdate(Map<Id,QC_Access_Component__c> newMapData, Map<Id,QC_Access_Component__c> oldMapData)
  {
    if(!newMapData.isEmpty()){
      for(QC_Access_Component__c obj:newMapData.values()){
        if(obj.SKU_Reference__c !=NULL && referCheckMap.containsKey(obj.SKU_Reference__c) && 
                   obj.SKU_Reference__c !=oldMapData.get(obj.Id).SKU_Reference__c){
            obj.addError('The SKU Reference Number already exist!!');
          }
      }
    }
  }//check SKU Reference OnUpdate method ends.
  
  
  public static void updateCompPrefix(Map<Id,QC_Access_Component__c> newMapData){
      System.debug('Entering this method pagal');
    String compName;
    List<QC_Accessories_Component_Prefix__c> custSettList= new List<QC_Accessories_Component_Prefix__c>();
    system.debug('--------------newMapData------------'+newMapData.values());
    if(!newMapData.isEmpty()){
      for(QC_Access_Component__c obj:newMapData.values()){
        if((obj.Sample_Category__c !=NULL && obj.Sample_Category__c!='') && obj.Sample_Type__c !='Re-submission' && 
                   obj.isReliabilityTesting__c ==True){
                   system.debug('--------------firstif----------------');
              compName =  (obj.Sample_Category__c != NULL && obj.Sample_Category__c !='')?
                                    ((obj.Sample_Category__c=='Bags')?'BA':
                      (obj.Sample_Category__c=='Belts')?'BE':
                      (obj.Sample_Category__c=='Wallets')?'WL':null):null;
        }
        else if((obj.Sample_Category__c !=NULL && obj.Sample_Category__c!='' && obj.Sample_Type__c !='Re-submission') && (obj.Sample_Type__c != 'Competitor Products' && 
                   obj.isConstructionTesting__c ==True)){
                   system.debug('------------secondif----------------');
              		compName =(obj.Sample_Category__c != NULL && obj.Sample_Category__c !='')?
                                    ((obj.Sample_Category__c=='Bags')?'BAC':
                    (obj.Sample_Category__c=='Belts')?'BEC':
                    (obj.Sample_Category__c=='Wallets')?'WLC':null):null;
          
        }
          //Added new for Competitor Types.
         else if((obj.Sample_Category__c !=NULL && obj.Sample_Category__c !='' && obj.Sample_Type__c == 'Competitor Products') && (obj.isConstructionTesting__c ==True &&
             obj.Sample_Type__c !='Re-submission')){
             system.debug('------------thirdif-------------');
        compName =   (obj.Sample_Category__c != NULL && obj.Sample_Category__c !='')?
                            ((obj.Sample_Category__c=='Bags')?'CBAC':
              (obj.Sample_Category__c=='Belts')?'CBEC':
              (obj.Sample_Category__c=='Wallets')?'CBWC':null):null;
    }
          else if(obj.Sample_Type__c =='Competitor Products' && obj.isReliabilityTesting__c ==True){
              compName = (obj.Sample_Category__c != NULL && obj.Sample_Category__c !='')?
                            ((obj.Sample_Category__c=='Bags')?'CBA':
              (obj.Sample_Category__c=='Belts')?'CBE':
              (obj.Sample_Category__c=='Wallets')?'CBW':null):null;
          } 
          if(compName !=NULL &&  obj.Sample_Type__c !='Re-submission'){
            QC_Accessories_Component_Prefix__c custSettObj= QC_Accessories_Component_Prefix__c.getValues(compName);
                        System.debug('===custSettObj inside====>>'+custSettObj);
              if(((obj.Master__c == True || obj.Master__c == False) && obj.isConstructionTesting__c == True && obj.Report_Ref_Number__c!=NULL && obj.Master_Refer_Value__c == True)){
                 system.debug('-------------fourthif---------------');
                  String seqNo = String.valueOf(integer.ValueOf(custSettObj.Sequence_Number__c));
                    System.debug('::::seqNo 11 :: ' +seqNo);
                custSettObj.Sequence_Number__c = QC_Access_ComponentTriggerHandler.appendZeros(seqNo); 
              }
             else if((obj.isReliabilityTesting__c ==True && obj.isReferredConstructionTest__c ==True && obj.Construction_Refer_Number__c != NULL) || (obj.isConstructionTesting__c ==True && obj.Construction_Refer_Number__c == NULL && obj.Master_Refer_Value__c == False) || obj.Sample_Category__c == 'Competitor Products'){
              system.debug('--------------fifthIf---------------');
                    String seqNo = String.valueOf(integer.ValueOf(custSettObj.Sequence_Number__c)+1);
                     System.debug('::::seqNo 22 :: ' +seqNo);
                custSettObj.Sequence_Number__c = QC_Access_ComponentTriggerHandler.appendZeros(seqNo);  
              }
              custSettList.add(custSettObj);
          }
        
      }//End of for loop
    }//End of if
        System.debug('=========custSettList=======>>'+custSettList);
    try{
      if(!custSettList.isEmpty()){
        update custSettList;
      }
    }
    catch(Exception e){
      System.debug('Error at Line Number--->'+e.getLineNumber());
      System.debug('Error is------->>'+e.getMessage());
    }
  }//End of Method


  public static string appendZeros(String seqNo){

        return (seqNo != null) 
               ?((seqNo.length() == 1) ? '000'+seqNo
                :(seqNo.length() == 2) ? '00'+seqNo
                :(seqNo.length() == 3) ? '0'+seqNo : seqNo) : seqNo;       
    }     
}