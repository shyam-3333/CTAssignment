/*Created By : KVP- Chakresh Verma
*Name : ProposalToolJewelleryBaseLinkingBatch
*Created on : 20 Jan 2021
*Description :
*/
//(SKU_CODE, Base_Code, PRODUCT_CATEGORY, BRAND, BUSINESS_UNIT, Offer_price, List_price)
//aws s3 ls s3://titan-pim-prodstg/Jewellery/BaselinkingReport/

public class ProposalToolJewelleryBaseLinkingBatch implements Database.Batchable<String>,Database.AllowsCallouts,Database.Stateful{
    private static String className = 'ProposalToolJewelleryBaseLinkingBatch';
    
    Integer noOfRows = 0;
    public List<String> exception_List;
    Set<String> skuIds = new Set<String>();
    public Integer noOfRecordsCreated = 0;
    public Integer noOfRecordsUpdated = 0;
    public Integer noOfRecordsFailed = 0;
    
    
    //Start Method
    public Iterable<String> start(Database.BatchableContext bc){
        
        List<String> mainData = new List<String>();
        try{
            String contentType='application/Json';
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            String folderName = generateFileName();
            //folderName = '10_01_2022';
            System.debug('folderName-->'+folderName);
            req.setEndpoint('callout:Proposal_Tool_Jwellery_Watches/titan-pim-prodstg?list-type=2&max-keys=1&prefix=Jewellery/BaselinkingReport/BaseLinkingReport_Jewellery_'+folderName);
            req.setTimeout(120000);
            req.setHeader('Content-Type','application/xml');
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getStatusCode());
            String s = res.getBody();
            System.debug('s-->'+s);
            Dom.Document doc = new Dom.Document();  
            doc.load( s );  
            Dom.XMLNode rootElement = doc.getRootElement(); 
            List<Dom.XMLNode> childElementForKeyCount = rootElement.getChildElements();
            Integer fileCount= 0;
            
            if(res.getStatusCode() == 200){
                if(childElementForKeyCount.size()>=2){
                    if(childElementForKeyCount[2].getName()=='KeyCount'){
                        fileCount = Integer.valueOf(childElementForKeyCount[2].getText());
                    }
                }
            }
            
            if(fileCount>0){
                for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                    System.debug(childElement.getName());
                    System.debug(childElement.getText());
                    if(childElement.getName() == 'KeyCount'){
                        fileCount = Integer.valueOf(childElement.getText());
                        
                    }
                    for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                        if(detailElement.getName()=='key'){
                            system.debug( detailElement.getName() + '-' + detailElement.getText() );  
                            HttpRequest reqData = new HttpRequest();
                            reqData.setMethod('GET');
                            reqData.setEndpoint('callout:Proposal_Tool_Jwellery_Watches/titan-pim-prodstg/'+detailElement.getText());
                            reqData.setTimeout(120000);
                            reqData.setHeader('Content-Type','application/xml');
                            Utility_RowIterator row = new Utility_RowIterator(new Http().send(reqData).getBody());
                            while(row.hasNext()){
                                mainData.add(row.next());
                            }
                        }
                    
                }
            }else{
                System.debug('File Not Found');
            }
            
            System.debug('masterProductList'+mainData.size());
            System.debug('Heap getHeapSize--->'+Limits.getHeapSize());
            System.debug('Heap getLimitHeapSize--->'+Limits.getLimitHeapSize());
            
        }catch(Exception exp){
            System.debug('Message-->'+ exp.getMessage());
            System.debug('Line Number--->'+exp.getLineNumber());
        } 
        
        
        
        return mainData;
        
    }
    
    //Execute Method
    public void execute(Database.BatchableContext bc, List<String> scope){
        try{
            List<Product_SKU__c> productSKU = new List<Product_SKU__c>();
            Set<String> baseSKUs = new Set<String>();
            Set<String> sellebleSKUs = new Set<String>();
            
            Map<String,String> mapOfProductMaster= new Map<String,String>();
            Map<String,Product_SKU__c> mapOfProductSKU= new Map<String,Product_SKU__c>();
            
            for(String row : scope){
                if(row != null && row != ''){
                    List<String> mainData = row.split(',');
                    System.debug('mainData-->'+mainData);
                    if(mainData.size()>=6){
                        baseSKUs.add(mainData[1]);
                        sellebleSKUs.add(mainData[0]);
                    }
                }
            }
            
            
            System.debug('baseSKUs'+baseSKUs);
            
            if(!baseSKUs.isEmpty()){
                for(Product_Master__c master : [Select Id,Base_SKU__c from Product_Master__c where Base_SKU__c IN :baseSKUs LIMIT 10000]){
                    if(master.Base_SKU__c != null){
                        mapOfProductMaster.put(master.Base_SKU__c,master.Id);
                    }
                }  
            }
            
            
            
            if(!sellebleSKUs.isEmpty()){
                for(Product_SKU__c skus : [Select Id,sku__c,Offer_Price__c,List_Price__c from Product_SKU__c where sku__c IN : sellebleSKUs And Product_Master__r.RecordTypeId =:Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId() LIMIT 10000]){
                    mapOfProductSKU.put(skus.sku__c,skus);
                }  
            }
            
            
            Product_SKU__c  jewelBase;
            
            for(String row : scope){
                if(row != null && row != ''){
                    List<String> mainData = row.split(',');
                    if(mapOfProductMaster.containsKey(mainData[1]) && mainData.size()>=6){
                        //(SKU_CODE, Base_Code, PRODUCT_CATEGORY, BRAND, BUSINESS_UNIT, Offer_price, List_price)
                        if(mainData[0] != null && mainData[0] != '' && mainData[1] != null && mainData[1] != ''
                           && mainData[2] != null && mainData[2] != '' && mainData[3] != null && mainData[3] != ''
                           && mainData[4] != null && mainData[4] != '' && mainData[5] != null && mainData[5] != ''
                           && mainData[6] != null && mainData[6] != '' && mainData[0] != 'SKU_CODE'){
                               jewelBase =new Product_SKU__c();
                               if(mapOfProductSKU.containsKey(mainData[0])){
                                   
                                   System.debug('Contains Section');
                                   jewelBase.Id = mapOfProductSKU.get(mainData[0]).Id;
                                   Integer listPrice;
                                   Integer offerPrice;
                                   
                                   if(mainData[5].containsAny('.')){
                                       String tempOfferPrice = mainData[5].substring(0, mainData[5].indexOf('.'));
                                       offerPrice = Integer.valueOf(tempOfferPrice);
                                   }
                                   if(mainData[6].containsAny('.')){
                                       String tempListPrice = mainData[6].substring(0, mainData[6].indexOf('.'));
                                       listPrice = Integer.valueOf(tempListPrice);
                                   }
                                   
                                   System.debug('listPrice-->'+listPrice);
                                   System.debug('mainData[0]).List_Price__c-->'+mapOfProductSKU.get(mainData[0]).List_Price__c);
                                   System.debug(mapOfProductSKU.get(mainData[0]).List_Price__c != listPrice);
                                   
                                   
                                   
                                   
                                   if(mapOfProductSKU.get(mainData[0]).List_Price__c != listPrice || mapOfProductSKU.get(mainData[0]).Offer_Price__c != offerPrice){
                                       jewelBase.Offer_price__c = offerPrice;
                                       jewelBase.List_price__c = listPrice;
                                       productSKU.add(jewelBase); 
                                   }
                               }else{
                                   System.debug('Not Contains Section');
                                   
                                   jewelBase.Product_Master__c = mapOfProductMaster.get(mainData[1]);
                                   jewelBase.sku__c = mainData[0];
                                   jewelBase.Base_Sku__c = mainData[1];
                                   jewelBase.Product_Category__c = mainData[2];
                                   jewelBase.brand__c = mainData[3];
                                   jewelBase.Business_Unit__c = mainData[4];
                                   Integer listPrice;
                                   Integer offerPrice;
                                   if(mainData[5].containsAny('.')){
                                       String tempOfferPrice = mainData[5].substring(0, mainData[5].indexOf('.'));
                                       offerPrice = Integer.valueOf(tempOfferPrice);
                                   }
                                   if(mainData[6].containsAny('.')){
                                       String tempListPrice = mainData[6].substring(0, mainData[6].indexOf('.'));
                                       listPrice = Integer.valueOf(tempListPrice);
                                   }
                                   jewelBase.Offer_price__c = offerPrice;
                                   jewelBase.List_price__c = listPrice;
                                   productSKU.add(jewelBase); 
                               }
                               
                           }
                    }
                }
            }
            
            if(!productSKU.isEmpty()){
                exception_List = new List<String>();
                
                Database.UpsertResult[] results = Database.upsert(productSKU, false);
                for(Integer index = 0, size = results.size(); index < size; index++) {
                    if(results[index].isSuccess()) {
                        if(results[index].isCreated()) {
                            System.debug(results[index].Id +' was created');
                            
                            noOfRecordsCreated++;
                        } else {
                            System.debug(results[index].Id +' was updated');
                            noOfRecordsUpdated++;
                        }
                        skuIds.add(results[index].Id);
                    }else{
                        noOfRecordsFailed++;
                        Database.Error err = results.get(index).getErrors().get(0);
                        System.debug('Error - '+err.getMessage() + '\nStatus Code : '+err.getStatusCode()+'\n Fields : '+err.getFields());
                        exception_List.add('Error - '+err.getMessage() + '\nStatus Code : '+err.getStatusCode()+'\n Fields : '+err.getFields());
                    }
                }
            }
            
        }catch(Exception exp){
            System.debug('Exception Line Number-->'+exp.getLineNumber());
            System.debug('Exception Message-->'+exp.getMessage());  
        }
    }
    
    //Finish Method
    public void finish(Database.BatchableContext bc){
        System.debug('noOfRows-->'+noOfRows);
        System.debug('noOfRecordsCreated-->'+noOfRecordsCreated);
        System.debug('noOfRecordsUpdated-->'+noOfRecordsUpdated);
        System.debug('exception_List-->'+exception_List);
        if(!skuIds.isEmpty()){
            Database.executeBatch(new ProposalToolSellebleSKUBatch(skuIds,false),1000);
        }
        
    } 
    
    
    private String generateFileName(){
        List<AWS_Configuration__c> awsConfig = new List<AWS_Configuration__c>();
        awsConfig = [Select Id,Name,Number_of_days_to_be_deducted__c from AWS_Configuration__c where Name =: className];
        Integer numberOfDayToBeDecducted = !awsConfig.isEmpty()?Integer.valueOf(awsConfig[0].Number_of_days_to_be_deducted__c):-1;
        
        Date todayDate = System.today();
        todayDate = todayDate.addDays(numberOfDayToBeDecducted);
        String day = todayDate.day()<=9?'0'+String.valueOf(todayDate.day()):String.valueOf(todayDate.day());
        String month = todayDate.month()<=9?'0'+String.valueOf(todayDate.month()):String.valueOf(todayDate.month());
        String year = (String.valueOf(Date.Today().Year()).right(2));
        String folderName = day+'-'+month+'-'+year;
        return folderName;
    }
}