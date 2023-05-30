/*******************************************************************
Created by: Vinoth Kumar A
Created on:16/07/2019
Description: Class to download all the Jewellery type products as CSV file
********************************************************************/
public class ProductDownload_Helper {
    public List<Product2> ProdList{get;set;}
    
    public class proWrapper{
        public string prodId{get;set;}
        public string prodName{get;set;}
        public string priceBookEntry{get;set;}
    }
    
    transient public List<proWrapper> WrapList{get;set;} 
    public ProductDownload_Helper(){
        WrapList = new list<proWrapper>();
        ProdList = new List<Product2>();
        ProdList = [SELECT Id, name FROM Product2 WHERE RecordType.Name='Jewellery']; 
        system.debug('ProdList:'+ProdList.size());
         List<id> prodIdList = new List<id>();
            for(product2 prod:ProdList){
                prodIdList.add(prod.id);
            }
            map<id,id> prodPrice = new map<id,id>();
            for(PriceBookEntry pb:[SELECT ID,UnitPrice,Product2Id FROM PriceBookEntry WHERE Product2Id IN : prodList]){
                prodPrice.put(pb.Product2Id,pb.id);
            }
        for(product2 pr:ProdList){
            system.debug('pro:'+pr);
            proWrapper pw = new proWrapper();
            pw.prodId=pr.id;
            pw.prodName=pr.Name;
            pw.priceBookEntry = prodPrice.get(pr.id);
            WrapList.add(pw);
        }
    }
}