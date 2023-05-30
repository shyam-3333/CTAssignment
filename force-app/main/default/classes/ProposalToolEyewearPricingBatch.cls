/*Created By : KVP- Chakresh Verma
*Name : ProposalToolEyewearPricingBatch
*Created on : 20 Jan 2021
*Description :
*/
//(sku, normal_price, final_price)
//aws s3 ls s3://eyeware/Production/priceTableExport_03_01_20221641266427.csv
public class ProposalToolEyewearPricingBatch implements Database.Batchable<String>,Database.AllowsCallouts,Database.Stateful,Schedulable{
    private static String className = 'ProposalToolEyewearPricingBatch';
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
            System.debug('folderName-->'+folderName);
            req.setEndpoint('callout:Proposal_Tool_Eyewear/eyeware?list-type=2&max-keys=1&prefix=Production/priceTableExport_'+folderName+'&delimiter=/');
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
                            reqData.setEndpoint('callout:Proposal_Tool_Eyewear/eyeware/'+detailElement.getText());
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
            Map<String,String> mapOfProductMaster= new Map<String,String>();
            Map<String,Product_SKU__c> mapOfExistingSKU= new Map<String,Product_SKU__c>();
            
            Product_SKU__c sku;
            for(String row : scope){
                if(row != null && row != ''){
                    List<String> mainData = row.split(',');
                    if(mainData.size()>=3){
                        noOfRows++;
                        baseSKUs.add(mainData[0]);
                    }
                    
                }
            }
            
            for(Product_Master__c master : [Select Id,Sku__c from Product_Master__c where Sku__c IN :baseSKUs LIMIT 10000]){
                if(master.Sku__c != null){
                    mapOfProductMaster.put(master.Sku__c,master.Id);
                }
            }
            
            for(Product_SKU__c existingSKU : [Select Id,sku__c,List_Price__c,Offer_Price__c from Product_SKU__c where sku__c In : baseSKUs And Product_Master__r.RecordTypeId =:Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Eyewear').getRecordTypeId() LIMIT 10000]){
                if(existingSKU.sku__c != null){
                    mapOfExistingSKU.put(existingSKU.sku__c,existingSKU);
                }
            }
            
            System.debug('mapOfProductMaster-->'+mapOfProductMaster.size());
            
            for(String row : scope){
                if(row != null && row != ''){
                    List<String> mainData = row.split(',');
                    if(mainData.size()>=3){
                        if(mainData[0] != 'sku' && mapOfProductMaster.containsKey(mainData[0])){
                            sku = new Product_SKU__c();
                            if(mainData[0] != '' && mainData[0] != null && mainData[1] != '' && mainData[1] != null && mainData[2] != '' && mainData[2] != null){
                                sku.sku__c = mainData[0];
                                sku.Base_Sku__c = mainData[0];
                                sku.Product_Master__c = mapOfProductMaster.get(mainData[0]);
                                Decimal listPrice = Decimal.valueOf(mainData[1]);
                                Decimal offerPrice = Decimal.valueOf(mainData[2]);
                                
                                sku.Business_Unit__c = 'EYEWEAR';
                                if(mapOfExistingSKU.containsKey(mainData[0])){
                                    System.debug('mapOfExistingSKU.get(mainData[0]).Id -->'+mapOfExistingSKU.get(mainData[0]).Id );
                                    System.debug('listPrice-->'+listPrice);
                                    System.debug('mapOfExistingSKU.get(mainData[0]).List_Price__c -->'+mapOfExistingSKU.get(mainData[0]).List_Price__c );
                                    System.debug('offerPrice-->'+offerPrice);
                                    System.debug('mapOfExistingSKU.get(mainData[0]).Offer_Price__c -->'+mapOfExistingSKU.get(mainData[0]).Offer_Price__c );

                                    sku.Id = mapOfExistingSKU.get(mainData[0]).Id; 
                                    if(listPrice != mapOfExistingSKU.get(mainData[0]).List_Price__c || offerPrice != mapOfExistingSKU.get(mainData[0]).Offer_Price__c){
                                        sku.List_price__c = listPrice;
                                        sku.Offer_price__c = offerPrice;
                                        productSKU.add(sku);
                                    }
                                }else{
                                    sku.List_price__c = listPrice;
                                    sku.Offer_price__c = offerPrice;
                                    productSKU.add(sku);
                                }
                            }else{
                                System.debug('Null Values Found'+mainData[0]);
                                
                            }
                        }else{
                            System.debug('Not Contains SKU-->'+mainData[0]);
                        }
                    }else{
                        System.debug('Column Missing');
                        
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
    
    public void execute(SchedulableContext SC) {
        Database.executeBatch(new ProposalToolEyewearPricingBatch(),1000);   
    }
    
    private String generateFileName(){
        List<AWS_Configuration__c> awsConfig = new List<AWS_Configuration__c>();
        awsConfig = [Select Id,Name,Number_of_days_to_be_deducted__c from AWS_Configuration__c where Name =: className];
        Integer numberOfDayToBeDecducted = !awsConfig.isEmpty()?Integer.valueOf(awsConfig[0].Number_of_days_to_be_deducted__c):-1;
        
        Date todayDate = System.today().addDays(numberOfDayToBeDecducted);
        String day = todayDate.day()<=9?'0'+String.valueOf(todayDate.day()):String.valueOf(todayDate.day());
        String month = todayDate.month()<=9?'0'+String.valueOf(todayDate.month()):String.valueOf(todayDate.month());
        String year = String.valueOf(todayDate.year());
        String folderName = day+'_'+month+'_'+year;
        return folderName;
    }
}