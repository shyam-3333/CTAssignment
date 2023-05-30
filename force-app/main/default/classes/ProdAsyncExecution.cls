public class ProdAsyncExecution implements Queueable
{
    public final Set<Id> productSet;
   // public final boolean productInQueue;
    public ProdAsyncExecution (Set<Id> newProdSet)
    {
        productSet= newProdSet;
     //   productInQueue = isQueue;
    }
    public void execute(QueueableContext context)
    {         
     // if(!productInQueue)
     // {
          List<Product__c> productList =  [SELECT vendor_custom__c,RecordTypeId,Name,SKU_Code__c,Product_Category_Taneira__c,Loom__c,Proc_Type__c FROM Product__c WHERE Id IN: productSet];
          List<Product__c> updateProductList = new List<Product__c>();  
             // Process records
           Map<String,String> mapOfMaster = new Map<String,String>();
           Map<Id,Product__c> MapOfProduct = new Map<Id,Product__c>();
           set<String> setOfMaster = new set<String>();
           set<Id> accountIdSet= new set<Id>();
           boolean isAuto = false;
           setOfMaster.add('Product Category');
           setOfMaster.add('Loom');
           setOfMaster.add('Proc-Type');
           setOfMaster.add('Zari Type');
           setOfMaster.add('Base Colour');
           String month = '';
           string yearOfOperation = '';
           Map<Integer,String>mapOfMonth = new Map<Integer,String>();
           Boolean isAutoNum = false;
            Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
           // AutoNumber__c autoNum = [SELECT Auto_Number__c FROM AutoNumber__c];
           AutoNumber__c autoNum = AutoNumber__c.getValues('SKU_Number');
            for(Master__c mast : [SELECT Code__c,Id,Name, Name__c From Master__c Where Active__c= TRUE AND Name__c in: setOfMaster]){
               
               string keyVal = mast.Name__c + mast.Name;
               mapOfMaster.put(keyVal , mast.Code__c);
               
            }
            mapOfMonth.put(1,'A');
            mapOfMonth.put(2,'B');
            mapOfMonth.put(3,'C');
            mapOfMonth.put(4,'D');
            mapOfMonth.put(5,'E');
            mapOfMonth.put(6,'F');
            mapOfMonth.put(7,'G');
            mapOfMonth.put(8,'H');
            mapOfMonth.put(9,'I');
            mapOfMonth.put(10,'J');
            mapOfMonth.put(11,'K');
            mapOfMonth.put(12,'L');
          
            for(Product__c each : productList){
                if(each.RecordTypeId == recordTypeId){
                    accountIdSet.add(each.vendor_custom__c);
                }
                
            }
            Map<Id,vendor__c> mapOfAccount = new Map<Id,vendor__c>([SELECT Vendor_Code__c,Id from vendor__c where Id in : accountIdSet]);
              
            system.debug('**mapOfMaster**'+mapOfMaster);
            for(Product__c prod : productList){
                if(prod.RecordTypeId == recordTypeId ){
                    
                    string numOfZero = '';
                    
                    integer len = string.valueOf(integer.valueOf(autoNum.Auto_Number__c)).length();
                    system.debug('**len**'+len);
                    for(integer i=1; i <= 5-len; i++){
                        numOfZero += '0';
                    }
                    
                    if(date.Today().year() == 2016){
                        yearOfOperation = '01';
                    }
                    else{
                        integer year = (date.Today().year()- 2016) + 1;
                        yearOfOperation = string.valueOf(year).length() < 2 ? '0'+ year : string.valueOf(year);           
                    }
                    month = mapOfMonth.get(date.Today().month());
                    prod.SKU_Code__c= mapOfMaster.get('Product Category'+prod.Product_Category_Taneira__c) + mapOfMaster.get('Loom'+prod.Loom__c) + mapOfMaster.get('Proc-Type'+prod.Proc_Type__c) +yearOfOperation +month+ numOfZero +integer.valueOf(autoNum.Auto_Number__c);
                    autoNum.Auto_Number__c += 1;
                    system.debug('**prod.SKU_Code__c**'+prod.SKU_Code__c);
                    updateProductList.add(prod);
                }
            }
            system.debug('**updateProductList**'+updateProductList);
            try{
                if(updateProductList.size()>0){
                    update updateProductList;
                    update autoNum;
                }
                
            }
            catch(Exception ex){
                system.debug('**exception**'+ex);
            }
       /* }
        else{
            System.enqueueJob(new ProdAsyncExecution(productSet,false));
        } */
    }
}