public class QC_Acc_ReliabProdInfo {
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
    public static QC_Access_Component__c updateComponent(String recId,QC_Access_Component__c qacIdObj){
       System.debug('recId---qacIdObj'+recId+'==='+qacIdObj);
        qacIdObj.Id=recId;
        update qacIdObj;
        return [SELECT Id,Record_Status__c,Document_Status__c,Report_Ref_Number__c,Final_Verdict__c FROM QC_Access_Component__c where Id = :recId];
      
    }

    @AuraEnabled
    public static List<QC_Access_Component__c> fetchConstructionData(sObject reportRefId){
       System.debug('----reportRefId---->>'+reportRefId);
        QC_Access_Component__c obj1 = (QC_Access_Component__c) reportRefId;
        System.debug('====obj1---->>>'+obj1.Id);
        List<QC_Access_Component__c> qcCompList= new List<QC_Access_Component__c>();
        if(obj1 !=NULL){
            qcCompList=[SELECT ID,Name,Document_Status__c,Record_Status__c,  No_Of_Sample_Received__c,Vendor_Reference__c,Gender__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                        Sample_Received_From2__c,Sample_Received_From3__c,Sample_Received_From4__c,Sample_Received_From5__c,
                       Sample_Type__c,SKU_Reference__c,  Sub_Category__c,Vendor__c,Vendor__r.Name,Brand__c,Brand__r.Name,General_Observation__c,Final_Verdict__c FROM QC_Access_Component__c WHERE ID = :obj1.Id];
            
        }//if ends
        System.debug('----qcCompList-->>'+qcCompList);
        if(qcCompList.size()>0){
            return qcCompList;
        }
        return null;
    }//fetchConstructionData method ends
    
   @AuraEnabled
     public static QC_Access_Component__c saveAndDisplayDetails(QC_Access_Component__c qacObj, sObject ConstrReport){
        Integer index1,index2,index3;
        System.debug('-------------qacObj----------'+qacObj);
       system.debug('----------qacObj.Master_Refer_Value__c-------'+qacObj.Master_Refer_Value__c);
        QC_Access_Component__c qcRepObj = (QC_Access_Component__c)ConstrReport;
        System.debug('-------------qcRepObj----------'+qcRepObj);
        index1 = qcRepObj.Report_Ref_Number__c.lastIndexOf(']');
        index2 =qcRepObj.Report_Ref_Number__c.lastIndexOf('/');
        index3 =qcRepObj.Report_Ref_Number__c.indexOf(']');
        String compVal = qcRepObj.Report_Ref_Number__c.substring(0,qcRepObj.Report_Ref_Number__c.indexOf('/'));
        String compData = qcRepObj.Report_Ref_Number__c.substring(0,qcRepObj.Report_Ref_Number__c.lastIndexOf('/'));
        String tempData;
        QC_Access_Component__c eachObj1;
        System.debug('index1 && index2 :: '+index1 +'$$ '+index2+'%% '+index3 + 'len ::: '+qcRepObj.Report_Ref_Number__c.length());
         //adding the logic to verify if other report ref no exist related to same
         if((index1 ==index3) && (index3==-1) && (compVal.contains('BAC') || compVal.contains('BEC') || compVal.contains('WLC'))){
             eachObj1 = [SELECT ID,NAME,Report_Ref_Number__c FROM QC_Access_Component__c WHERE Report_Ref_Number__c LIKE : '%'+compData+'%' ORDER BY CreatedDate DESC LIMIT 1];
             
         }
         else if((index3 !=-1 && index3 != qcRepObj.Report_Ref_Number__c.length()) && qcRepObj.Report_Ref_Number__c.indexOf('[') !=-1 ){
             tempData =qcRepObj.Report_Ref_Number__c.substring(0,qcRepObj.Report_Ref_Number__c.indexOf('['));
             	eachObj1 =[SELECT ID,NAME,Report_Ref_Number__c FROM QC_Access_Component__c WHERE Report_Ref_Number__c LIKE : '%'+tempData+'%' ORDER BY CreatedDate DESC LIMIT 1];
         }
         else if((index3 == index1 && index3 == qcRepObj.Report_Ref_Number__c.length())){
             eachObj1 =[SELECT ID,NAME,Report_Ref_Number__c FROM QC_Access_Component__c WHERE Report_Ref_Number__c LIKE : '%'+compData+'%' ORDER BY CreatedDate DESC LIMIT 1];
         }
         System.debug(':::eachObj1:: '+eachObj1);
         if(eachObj1 !=NULL){
             String validData;
            String tempData1 = eachObj1.Report_Ref_Number__c.substring(0,eachObj1.Report_Ref_Number__c.lastIndexOf('/'));
             if(tempData1.contains(']') && tempData1.substring(tempData1.indexOf(']')-1,tempData1.indexOf(']')) !='z'){
                 validData = tempData1.substring(tempData1.indexOf(']')-1,tempData1.indexOf(']'));
                 validData =tempData1.substring(0,tempData1.indexOf('[')) +'[' + reverseMap.get(alphaMap.get(validData)+1) +']' + eachObj1.Report_Ref_Number__c.substring(eachObj1.Report_Ref_Number__c.lastIndexOf('/'));
                 System.debug('validData:: '+validData);
             }
             else{
                 validData = eachObj1.Report_Ref_Number__c.substring(0,eachObj1.Report_Ref_Number__c.lastIndexOf('/')) + '[a]' +eachObj1.Report_Ref_Number__c.substring(eachObj1.Report_Ref_Number__c.lastIndexOf('/'));
                 System.debug('else validaData:: '+validData);
             }
             qacObj.Report_Ref_Number__c = validData;
         }
		 else{
			 if(qacObj !=NULL && qacObj.Master__c !=True && (qcRepObj.Report_Ref_Number__c !=NULL && qcRepObj.Report_Ref_Number__c != '') && 
           qacObj.isConstructionTesting__c !=false && qacObj.Sample_Type__c !='Re-Submission'){
              if(qcRepObj.Report_Ref_Number__c.lastIndexOf(']') == -1 && (index3 == index1)){
                  System.debug('First if');
                  qacObj.Report_Ref_Number__c = qcRepObj.Report_Ref_Number__c.substring(0,index2) +'['+'a'+']'+
                                    qcRepObj.Report_Ref_Number__c.substring(index2);
              }
        else if((index1 == qcRepObj.Report_Ref_Number__c.length()-1) && (index3 != index1)){
                System.debug('First else if');
                  if(alphaMap.get(qcRepObj.Report_Ref_Number__c.substring(index3 -1 ,index3)) !=26){
                     qacObj.Report_Ref_Number__c = qcRepObj.Report_Ref_Number__c.substring(0,index3-1)  + reverseMap.get(alphaMap.get(qcRepObj.Report_Ref_Number__c.substring(index3-1 ,index3))+1) + qcRepObj.Report_Ref_Number__c.substring(index3,index3+1) + qcRepObj.Report_Ref_Number__c.substring(index2); 
                  }
                  else{
                      qacObj.Report_Ref_Number__c = qcRepObj.Report_Ref_Number__c.substring(0,index3-1) + reverseMap.get(1) + qcRepObj.Report_Ref_Number__c.substring(index3,index3+1) + qcRepObj.Report_Ref_Number__c.substring(index2);
                  }
                  
        }
       
        else if((index1 != qcRepObj.Report_Ref_Number__c.length()-1) && (index1 != -1 && index1 ==index3) ){
        System.debug('Third else if');
                  if(alphaMap.get(qcRepObj.Report_Ref_Number__c.substring(index3 -1 ,index3)) !=26){
                      qacObj.Report_Ref_Number__c = qcRepObj.Report_Ref_Number__c.substring(0,index3-1) + reverseMap.get(alphaMap.get(qcRepObj.Report_Ref_Number__c.substring(index3-1 ,index3))+1) + qcRepObj.Report_Ref_Number__c.substring(index3,index3+1) + qcRepObj.Report_Ref_Number__c.substring(index2); 
                  }
                  else{
                      qacObj.Report_Ref_Number__c = qcRepObj.Report_Ref_Number__c.substring(0,index3-1) + reverseMap.get(1) + qcRepObj.Report_Ref_Number__c.substring(index3,index3+1) + qcRepObj.Report_Ref_Number__c.substring(index2);
                  }
                 
        }
             System.debug('qacObj.Report_Ref_Number__c ::: '+qacObj.Report_Ref_Number__c);
        }
        else{
            if((qacObj.isConstructionTesting__c == True && qacObj.Master__c !=True) || (qacObj.isReliabilityTesting__c == True && qacObj.Sample_Type__c == 'Re-Submission')){
                if(index1 ==qacObj.Report_Ref_Number__c.length()-1){
                    qacObj.Report_Ref_Number__c = qcRepObj.Report_Ref_Number__c.substring(0,index1-1)+Integer.valueOf(qcRepObj.Report_Ref_Number__c.substring(index1-1,index1)+1)+ qcRepObj.Report_Ref_Number__c.substring(index1);
                }
                else{
                    qacObj.Report_Ref_Number__c = qcRepObj.Report_Ref_Number__c.substring(0,qcRepObj.Report_Ref_Number__c.length())+'[R1]';
                }
            }
        }
        
			 
		 }
        
        //qacObj.isConstructionTesting__c =false;
        insert qacObj;
        return [Select Id,Report_Ref_Number__c,Record_Status__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                Sample_Received_From2__c,Sample_Received_From3__c,Sample_Received_From4__c,Sample_Received_From5__c,
                Vendor__c,Final_Verdict__c,Sub_Category__c,Document_Status__c FROM QC_Access_Component__c WHERE ID =:qacObj.ID];
    }
}