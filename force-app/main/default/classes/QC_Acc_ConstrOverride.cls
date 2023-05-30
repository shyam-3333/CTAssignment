public class QC_Acc_ConstrOverride {
	 public static Map<String,Integer> alphaMap= new Map<String,Integer>(); 
  public static Map<Integer,String> reverseMap= new Map<Integer,String>();
       
    static{
       alphaMap.put('a',1);
       alphaMap.put('b',2);
       alphaMap.put('c',3);
       alphaMap.put('d',4);
       alphaMap.put('e',5);
       alphaMap.put('f',6);
       alphaMap.put('g',7);
       alphaMap.put('h',8);
       alphaMap.put('i',9);
       alphaMap.put('j',10);
       alphaMap.put('k',11);
       alphaMap.put('l',12);
       alphaMap.put('m',13);
       alphaMap.put('n',14);
       alphaMap.put('o',15);
       alphaMap.put('p',16);
       alphaMap.put('q',17);
       alphaMap.put('r',18);
       alphaMap.put('s',19);
       alphaMap.put('t',20);
       alphaMap.put('u',21);
       alphaMap.put('v',22);
       alphaMap.put('w',23);
       alphaMap.put('x',24);
       alphaMap.put('y',25);
       alphaMap.put('z',26);
       reverseMap.put(1,'a');
       reverseMap.put(2,'b');
       reverseMap.put(3,'c');
       reverseMap.put(4,'d');
       reverseMap.put(5,'e');
       reverseMap.put(6,'f');
       reverseMap.put(7,'g');
       reverseMap.put(8,'h');
       reverseMap.put(9,'i');
       reverseMap.put(10,'j');
       reverseMap.put(11,'k');
       reverseMap.put(12,'l');
       reverseMap.put(13,'m');
       reverseMap.put(14,'n');
       reverseMap.put(15,'o');
       reverseMap.put(16,'p');
       reverseMap.put(17,'q');
       reverseMap.put(18,'r');
       reverseMap.put(19,'s');
       reverseMap.put(20,'t');
       reverseMap.put(21,'u');
       reverseMap.put(22,'v');
       reverseMap.put(23,'w');
       reverseMap.put(24,'x');
       reverseMap.put(25,'y');
       reverseMap.put(26,'z');
    }
    
    @AuraEnabled
    public static List<QC_Access_Component__c> fetchConstructionData(sObject reportRefId){
       System.debug('----reportRefId---->>'+reportRefId);
        QC_Access_Component__c obj1 = (QC_Access_Component__c) reportRefId;
        System.debug('====obj1---->>>'+obj1.Id);
        List<QC_Access_Component__c> qcCompList= new List<QC_Access_Component__c>();
        if(obj1 !=NULL){
            qcCompList=[SELECT ID,Name,Document_Status__c,Record_Status__c,	No_Of_Sample_Received__c,Vendor_Reference__c,Gender__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
            Sample_Received_From2__c,Sample_Received_From3__c,Sample_Received_From4__c,Sample_Received_From5__c,
                       Sample_Type__c,SKU_Reference__c,Final_Verdict__c,Sub_Category__c,Vendor__c,Vendor__r.Name,Brand__c,Brand__r.Name,General_Observation__c FROM QC_Access_Component__c WHERE ID = :obj1.Id];
            
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

            //insert qacObj;
			
        }//end of if(qacObj !=NULL)
  
        //QC_Access_Component__c qcAccesObject = [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c from QC_Access_Component__c where Id = :qacObj.Id];
        System.debug(':::inside save and display details :: '+qacObj);
        return qacObj;
    }
    
	@AuraEnabled
    public static QC_Access_Component__c updateComponent(String recId,QC_Access_Component__c qacIdObj){
       System.debug('recId---qacIdObj'+recId+'==='+qacIdObj);
        qacIdObj.Id=recId;
        update qacIdObj;
        return [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c,Final_Verdict__c FROM QC_Access_Component__c where Id = :recId];
      
    }
	@AuraEnabled
	public static QC_Access_Component__c saveAndUpdateRecord(QC_Access_Component__c qacObj,sObject ConstrReport){
		String validData='';
		String updatedRefNo='';
        System.debug('::qacObj:: '+qacObj);
        System.debug('::ConstrReport ::  '+ConstrReport);
        QC_Access_Component__c constrObjWithId = (QC_Access_Component__c) ConstrReport; //will use this to find existing ref no.This holds Id,Report Ref No.
			
        QC_Access_Component__c accComp;
        
        
        System.debug('constrObjWithId :: '+constrObjWithId.Report_Ref_Number__c+constrObjWithId.Id+constrObjWithId.Name);
        
		if(constrObjWithId !=NULL && constrObjWithId.Report_Ref_Number__c !=NULL){
            System.debug('substring:: ');
			validData = constrObjWithId.Report_Ref_Number__c.substring(0,constrObjWithId.Report_Ref_Number__c.lastIndexOf('/'));
			if(validData.contains(']')){
				validData = validData.substring(0,validData.indexOf('['));
			}
			else{
				validData = validData.substring(0,constrObjWithId.Report_Ref_Number__c.lastIndexOf('/'));
			}
			QC_Access_Component__c eachComp = [SELECT ID,NAME,Report_Ref_Number__c FROM QC_Access_Component__c WHERE Report_Ref_Number__c LIKE : '%'+validData+'%' ORDER BY CreatedDate Desc LIMIT 1];
			if(eachComp !=NULL){
				validData = eachComp.Report_Ref_Number__c.substring(0,eachComp.Report_Ref_Number__c.lastIndexOf('/'));
				if(validData.contains(']') && validData.substring(validData.indexOf(']')-1,validData.indexOf(']')) !='z'){
					updatedRefNo = validData.substring(0,validData.indexOf('['))+'['+ reverseMap.get(alphaMap.get(validData.substring(validData.indexOf(']')-1,validData.indexOf(']')))+1) +']'+eachComp.Report_Ref_Number__c.substring(eachComp.Report_Ref_Number__c.lastIndexOf('/'));
				}
				else{
					updatedRefNo =validData +'[a]'+eachComp.Report_Ref_Number__c.substring(eachComp.Report_Ref_Number__c.lastIndexOf('/'));
				}
				qacObj.Report_Ref_Number__c = updatedRefNo;
			}//if(eachComp !=NULL) ends.
			/*else{
				qacObj = QC_Acc_ConstrOverride.saveAndDisplayDetails(qacObj);
                System.debug('qacObj@@@:: '+qacObj );
			}*/
		}//if(constrObjWithId != null) ends
        upsert qacObj;
        System.debug('After upsert :: '+qacObj);
        return qacObj;                                                                                             
	}//method ends.
}