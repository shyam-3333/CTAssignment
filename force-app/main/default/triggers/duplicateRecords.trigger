/*
Name: duplicateRecords 
Description:Trigger to avoid duplicate creation of contract details record i.e no two records should have the same Product Category and Sub category.
Created On:11/04/2014
Created By: Shamsher Singh
Last Modified By: Anindwita
Test Class Name : TestduplicateRecords
*/
trigger duplicateRecords on Contract_Details__c (before Insert,before Update) {
    List<Contract_Details__c> oldValueUpdate = new List<Contract_Details__c>();
    List<Contract_Details__c> contrct=new List<Contract_Details__c>();
    Map<String,String> compareValues=new Map<String,String>();
    Map<String,String> contarctValue=new Map<String,String>();
    Set<ID> ids=new Set<ID>(); 
        If(Trigger.isInsert){
            For(Contract_Details__c cdet: Trigger.New){
                if(cdet.Product_Sub_Category__c == null){
                    cdet.addError('Sub-Category cannot be left blank.');
                }
                /*else{           
                    ids.add(cdet.Customer__c); 
                    compareValues.put(cdet.Brand__c,cdet.Product_Sub_Category__c);
                    System.debug('!!!!!!!!!!'+compareValues);
                }            
            contrct=[select Id,Name,Brand__c,Product_Sub_Category__c,Customer__c from Contract_Details__c where Customer__c =: ids];
            For(Contract_Details__c con : contrct){
                contarctValue.put(con.Brand__c,con.Product_Sub_Category__c);
                if(compareValues.equals(contarctValue)){
                    cdet.addError('Duplicate Contract');
                    System.debug('@@@@@@@@@@@@@@@@@@@@');
                }
            }*/ //on the client request comment the else part to avoid the validation on duplicate records(By Anindwita)
            
          }     
      }
           /* if(contrct.size() > 1){
                 For(Contract_Details__c cont : contrct){
                    For(Contract_Details__c con : Trigger.New)
                    {        
                        
                        System.debug('@@@@@'+cont.Brand__c+'@@'+con.Brand__c+'@@'+cont.Product_Sub_Category__c+'@@'+con.Product_Sub_Category__c);
                        if(cont.Brand__c == con.Brand__c && cont.Product_Sub_Category__c == con.Product_Sub_Category__c){
                            con.addError('Duplicate Contract');
                        }
                    }
                }
            }*/
             
        if(Trigger.isUpdate){
            For(Contract_Details__c cdet: Trigger.New){
                if(cdet.Product_Sub_Category__c == null){
                    cdet.addError('Sub-Category cannot be left blank.');
                }
                //else{           
                   // ids.add(cdet.Customer__c); 
                //}
            }            
            /*contrct=[select Id,Name,Brand__c,Product_Sub_Category__c,Customer__c from Contract_Details__c where Customer__c in :ids];
            if(contrct.size() > 1){
                For(Contract_Details__c cd :contrct){
                    For(Contract_Details__c cdetup : Trigger.new){
                        if(cd.Product_Sub_Category__c == cdetup.Product_Sub_Category__c && cd.Brand__c == cdetup.Brand__c){
                            cdetup.addError('Duplicate category and sub category. Cannot update');
                        }
                    }  
                }  
            }  */ //on client request
        }
}