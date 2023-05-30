/***************************************************
Created By : Poornapriya YN
Description: Rest Api to fetch the Vendor based on origin 
*********************************************************/

@RestResource(urlMapping='/Origin/*')
global with sharing class ProductOriginApi{
    @HttpGet
    global static void  doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String origin = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Map<Id,String>mapOfAccount = new Map<Id,String>();
        Id taneiraRecType = Schema.Sobjecttype.product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        for(Product__c each : [SELECT vendor_custom__c , vendor_custom__r.Name FROM Product__c WHERE Cluster__c = :origin and RecordTypeId =: taneiraRecType]){
            if(each.vendor_custom__c != null){
                mapOfAccount.put(each.vendor_custom__c,each.vendor_custom__r.Name);
            }
            
        }
        
        List<OriginWrap> wrapList = new List<OriginWrap>();
            if(!mapOfAccount.isEmpty()){
                for(Id eachId : mapOfAccount.keyset()){
                OriginWrap wrap = new OriginWrap();
                wrap.Vendor_Name = mapOfAccount.get(eachId);
                wrap.Vendor_Id = eachId;
                wrapList.add(wrap);
            }
        }
        if(wrapList.size()>0){
            String jsonResponse =  JSON.serialize(wrapList);
            if(!Test.isRunningTest()){
                RestContext.response.addHeader('Content-Type', 'application/json');
                RestContext.response.responseBody = Blob.valueOf(jsonResponse);
            }
        }
        else{
            
            Map<String,String> recList = new Map<String,String>();    
            recList.put('Message','Vendor Not available for this Origin');
            String expMsg = json.serialize(recList);
            if(!Test.isRunningTest()){
                RestContext.response.addHeader('Content-Type', 'application/json');
                RestContext.response.responseBody = Blob.valueOf(expMsg);
            }
        }
        
        
    }
    public class OriginWrap{
        public string Vendor_Name;
        public string Vendor_Id;
    }
}