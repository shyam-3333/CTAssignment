public class SKUImageDownloadController {
    public List<proWrap> listWrap{get;set;}
    public List<product__c> proList{get;set;}
    public List<string> strList {get;set;}
    public SKUImageDownloadController(){
        proList = new List<product__c>();
        listWrap = new List<proWrap>();
        string ProdId = apexpages.currentpage().getparameters().get('ID');
        string str = [SELECT SKUImageDownloadData__c FROM Product__c WHERE ID =: ProdId].SKUImageDownloadData__c;
        system.debug('str:'+str);
        if(str != null){
            strList = str.split(',');
        }
        if(!strList.isEmpty()){
           proList = [SELECT Id, Photo__c, Cost__c,SKU_Code__c,PO_Number__c FROM Product__c WHERE SKU_Code__c IN : strList];
        } else {
            proList = [SELECT Id, Photo__c, Cost__c,SKU_Code__c,PO_Number__c FROM Product__c limit 1];
        }
        for(Product__c pro : proList){
            proWrap prowr = new proWrap();
            if(!String.isBlank(pro.Photo__c) && pro.Photo__c !=NULL){
                string firstSubString = pro.Photo__c.substringBetween('<img', 'img>');
                string secondSubString = firstSubString.substringBetween('src="', '"');
                prowr.imgLink = secondSubString.replace('amp;', '');
                prowr.cost = pro.cost__c;
                prowr.SKU = pro.sku_code__c;
                prowr.poNum = pro.PO_Number__c;
                listWrap.add(prowr);
            }
            
        }
        
    }
    public class proWrap{
        public string imgLink{get;set;}
        public string SKU{get;set;}
        public string poNum{get;set;}
        public decimal cost{get;set;}
    }
}