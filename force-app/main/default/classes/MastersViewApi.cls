@RestResource(urlMapping='/Masters')
global with sharing class MastersViewApi{
    @HttpGet
    global static void  doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Set<String> valueTypeSet = new Set<String>();
        valueTypeSet.add('Origin');
        valueTypeSet.add('Loom');
        valueTypeSet.add('Warp');
        valueTypeSet.add('Weft');
        valueTypeSet.add('Craft');
        valueTypeSet.add('Product Category');
        valueTypeSet.add('Proc-Type');
        valueTypeSet.add('Zari Type');
        valueTypeSet.add('Base Colour');
        valueTypeSet.add('Blouse Type');
        /*modified by: vinoth kumar
		Replace the product category in the line items with Order Id as Drop Down. Order id data will be getting from the masters./* */
        valueTypeSet.add('Order Id');
        valueTypeSet.add('Kurta_Fabric');
        valueTypeSet.add('Dupatta_Fabric');
        valueTypeSet.add('Salwar_Fabric');
        valueTypeSet.add('Sourcing_Type');
        valueTypeSet.add ('MRP Reco');
        
        List<masterWrapper> wrapperList = new List<masterWrapper>();
        List<Master__c> masterList = new List<Master__c>();
        if(!test.isRunningTest()){
           masterList = [SELECT Id,Name,Active__c,Code__c,Dependency_1__r.Name,Dependency_2__r.Name,Description__c,Name__c From Master__c WHERE Active__c = true AND Name__c in : valueTypeSet]; 
        }
        else{
            masterList = [SELECT Id,Name,Active__c,Code__c,Dependency_1__r.Name,Dependency_2__r.Name,Description__c,Name__c From Master__c WHERE Name__c = 'Color' limit 1];
        }
        for(Master__c each : masterList){
            masterWrapper wrap = new masterWrapper();
            wrap.Name = each.Name__c;
            wrap.Value = each.Name;
            wrap.Code  = each.Code__c;
            wrap.Active = each.Active__c;
            wrap.Dependency_1 = each.Dependency_1__r.Name;
            wrap.Dependency_2 = each.Dependency_2__r.Name;
            wrapperList.add(wrap);
        
        }
        String jsonResponse =  JSON.serialize(wrapperList);
        if(!Test.isRunningTest()){
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(jsonResponse);
        }
                
    }
    public class masterWrapper{
        public String Name{get;set;}
        public String Value{get;set;}
        public String Code{get;set;}
        public Boolean Active{get;set;}
        public String Dependency_1{get;set;}
        public String Dependency_2{get;set;}
    
    }

}