/*Created By : KVP- Chakresh Verma
*Name : ProposalToolEyeWearMasterDeltaBatch
*Created on : 10 Oct 2021
*Description : This Batch Class is used to Fetch the Delta Master Data Of EyeWear
*/
//recentProductExport_10_01_20221641870602.csv
public class ProposalToolEyeWearMasterDeltaBatch implements Database.Batchable<Object>,Database.AllowsCallouts,Database.Stateful,Schedulable{
    private static String className = 'ProposalToolEyeWearMasterDeltaBatch';
    
    Product_Master__c eyewear;
    Integer noOfRows = 0;
    public List<String> exception_List;
    Set<String> skuIds = new Set<String>();
    public Integer noOfRecordsCreated = 0;
    public Integer noOfRecordsUpdated = 0;
    public Integer noOfRecordsFailed = 0;
    //Start Method
    public Iterable<Object> start(Database.BatchableContext bc){
        List<List<String>> masterProductList = new List<List<String>>();
        try{
            String contentType='application/Json';
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            
            String folderName = generateFileName();
            
            req.setEndpoint('callout:Proposal_Tool_Eyewear/eyeware?list-type=2&max-keys=1&prefix=Production/recentProductExport_'+folderName+'&delimiter=/');
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
                            reqData.setEndpoint('callout:Proposal_Tool_Eyewear/eyeware/'+detailElement.getText());//titan-pim-prodstg/Watches/archive/Watches-ENRICHMENT_OUT2/
                            reqData.setTimeout(120000);
                            reqData.setHeader('Content-Type','application/xml');
                            masterProductList.addAll(CSVReaderUtililty.Parse(new Http().send(reqData).getBody()));
                        }
                    
                }
            }else{
                System.debug('File Not Found');
            }
            
            System.debug('masterProductList'+masterProductList.size());
            System.debug('Heap getHeapSize--->'+Limits.getHeapSize());
            System.debug('Heap getLimitHeapSize--->'+Limits.getLimitHeapSize());
            
        }catch(Exception exp){
            System.debug('Message-->'+ exp.getMessage());
            System.debug('Line Number--->'+exp.getLineNumber());
        }   
        System.debug('masterProductList'+(List<Object>)masterProductList);
        return (List<Object>)masterProductList;
        
    }
    
    //Execute Method
    public void execute(Database.BatchableContext bc, List<Object> scope){
        try{
            List<List<String>> data = new List<List<String>>();
            Set<String> productSKUs = new Set<String>();
            Map<String,String> mapOfExistingProducts = new Map<String,String>();
            List<Product_Master__c> eyewearList = new List<Product_Master__c>();
            String recordTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Eyewear').getRecordTypeId();
            
            
            
            data = (List<List<String>>)JSON.deserialize(JSON.serialize(scope), List<List<String>>.class);
            Integer i = 1;
            for(List<String> masterProduct : data){
                if(!masterProduct.isEmpty() && masterProduct.size()>=55){
                    productSKUs.add(masterProduct[0]);
                }
            }
            if(!productSKUs.isEmpty()){
                for(Product_Master__c master : [Select Id,sku__c from Product_Master__c where sku__c IN : productSKUs And RecordTypeId =:Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Eyewear').getRecordTypeId()]){
                    mapOfExistingProducts.put(master.sku__c, master.Id);
                }   
            }
            for(List<String> masterProduct : data){
                noOfRows++;
                System.debug('noOfRows'+noOfRows);
                if(!masterProduct.isEmpty() && masterProduct.size()>=55 && masterProduct[0]!='sku'){
                    if(mapOfExistingProducts.containsKey(masterProduct[0])){
                        eyewearList.add(createEyewear(masterProduct, mapOfExistingProducts.get(masterProduct[0]),recordTypeId));
                    }else{
                        eyewearList.add(createEyewear(masterProduct, null,recordTypeId));
                    }
                }
            }
            
            if(!eyewearList.isEmpty()){
                exception_List = new List<String>();
                
                Database.UpsertResult[] results = Database.upsert(eyewearList, false);
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
            System.debug('Error-->'+exp.getMessage());
            System.debug('Error-->'+exp.getLineNumber());
        }
    }
    
    //Finish Method
    public void finish(Database.BatchableContext bc){
        System.debug('noOfRows-->'+noOfRows);
        System.debug('noOfRecordsCreated-->'+noOfRecordsCreated);
        System.debug('noOfRecordsUpdated-->'+noOfRecordsUpdated);
        System.debug('exception_List-->'+exception_List);        
    }
    
    public void execute(SchedulableContext SC) {
        Database.executeBatch(new ProposalToolEyeWearMasterDeltaBatch(),1000);   
    }
    
    
    //Mapping data with repective fields
    private Product_Master__c createEyewear(List<String> masterProduct, String existingProductId, String recordTypeId){
        eyewear = new Product_Master__c();
        eyewear.RecordTypeId = recordTypeId;
        if(existingProductId!= null){
            eyewear.Id=existingProductId;
        }
        eyewear.Record_Sent__c = true;
        //eyewear = new Product_Master__c();
        eyewear.sku__c = masterProduct[0];
        eyewear.attribute_set_name__c = masterProduct[1];
        eyewear.name__c = masterProduct[2];
        eyewear.sap_sku_id__c = masterProduct[3];
        eyewear.brand__c = masterProduct[4];
        eyewear.categories__c = masterProduct[5];
        eyewear.description__c = masterProduct[6];
        eyewear.aplus_content__c = masterProduct[7];
        eyewear.face_shape__c = masterProduct[8];
        eyewear.acc_bridge_width__c = masterProduct[9];
        eyewear.acc_front_shape__c = masterProduct[10];
        eyewear.acc_lens_height__c = masterProduct[11];
        eyewear.acc_lens_width__c = masterProduct[12];
        eyewear.acc_size__c = masterProduct[13];
        eyewear.acc_size_clip__c = masterProduct[14];
        eyewear.frame_color_code__c = masterProduct[15];
        eyewear.frame_design__c = masterProduct[16];
        eyewear.frame_face_shape__c = masterProduct[17];//
        
        eyewear.frame_front_shape__c = masterProduct[18];
        eyewear.frame_front_shape_label__c = masterProduct[19];
        eyewear.frame_front_styling__c = masterProduct[20];
        eyewear.frame_gender__c = masterProduct[21];
        eyewear.frame_international__c = masterProduct[22];
        eyewear.frame_lifestyle__c = masterProduct[23];
        eyewear.frame_material__c = masterProduct[24];
        eyewear.frame_material_desc__c = masterProduct[25];
        
        eyewear.frame_parent_model__c = masterProduct[26];
        eyewear.frame_size__c = masterProduct[27];
        eyewear.frame_size_number__c = masterProduct[28];//
        
        eyewear.frame_type__c = masterProduct[29];
        eyewear.frame_weight_without_lens__c = masterProduct[30];
        eyewear.frame_weight_without_lens_no__c = masterProduct[31];
        eyewear.front_Color__c = masterProduct[32];
        eyewear.front_color_user__c = masterProduct[33];
        eyewear.front_color_user_sunglass__c = masterProduct[34];//Check
        eyewear.front_colour_pattern__c = masterProduct[35];
        eyewear.front_finish__c = masterProduct[36];
        eyewear.front_material_details__c = masterProduct[37];
        
        eyewear.front_material_user__c = masterProduct[38];
        eyewear.front_size__c = masterProduct[39];
        eyewear.bestseller__c = masterProduct[40];
        eyewear.new__c = masterProduct[41];
        eyewear.sale__c = masterProduct[42];
        eyewear.collection__c = masterProduct[43];
        eyewear.contactlens_validity__c = masterProduct[44];
        eyewear.country_of_manufacture__c = masterProduct[45];
        
        eyewear.disposable__c = masterProduct[46];
        if(masterProduct[47] != '' && masterProduct[47] !=''){
            eyewear.price__c = Decimal.valueOf(masterProduct[47]);
        }
        
        eyewear.tax_class_id__c = masterProduct[48];
        eyewear.thumbnail__c = masterProduct[49];
        
        eyewear.url_key__c = masterProduct[50];
        eyewear.url_path__c = masterProduct[51];
        eyewear.virtual_tryon__c = masterProduct[52];
        eyewear.virtual_try_on__c = masterProduct[53];
        //eyewear.All_Images__c  = masterProduct[54];
        eyewear.images__c  = masterProduct[54];
        if(masterProduct[55] != '' && masterProduct[55] != null){
            eyewear.updated_at__c = DateTime.valueOf(masterProduct[55]);
        }
        return eyewear;
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