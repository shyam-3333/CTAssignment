/********************************************************************************
* Created by: Vinoth kumar A
* Crated on :12/08/2019
* Description: The scanned QR code from Json will be matched with the existing QR code of the product and captured in QR code scanned field.
This code is called in CreateProductQRCodeApi
***********************************************************************************/
global class CreateProductQRCodeApiBatch implements Database.Batchable<sObject>, Database.Stateful{
    
    global Map<string,DateTime> JsonData;
    global CreateProductQRCodeApiBatch(List<product__c> pList){
        JsonData = new Map<string,DateTime>();
        for(product__c pr: pList){
            JsonData.put(pr.QR_CODE__c, pr.QR_Code_Scanned_Date__c);
        }
    }
    global string JsonEmailString = '';
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT id,QR_Code_Scanned__c,QR_CODE__c FROM Product__c');
    }
    
    global void execute(Database.BatchableContext BC, List<Product__C> ProdList){
        system.debug('JsonData:***************'+JsonData);
        List<Product__c> productList = new List<Product__c>(); 
        for(Product__c pro : ProdList){
            if(JsonData.containskey(pro.QR_CODE__c)){
                Product__c p = new product__c();
                p.id = pro.id;
                p.QR_Code_Scanned__c = pro.QR_CODE__c;
                p.QR_Code_Scanned_Date__c = JsonData.get(pro.QR_CODE__c)-(5.5/24);
                productList.add(p);
            }
        }
        system.debug('productList------'+productList);
        if(!productList.isEmpty()){
            List<Database.SaveResult> rs = Database.Update(productList);
            for(Database.SaveResult ds : rs){
                if(ds.isSuccess()){
                    if(!JsonEmailString.contains(string.valueOf(productList))){
                        JsonEmailString = JsonEmailString +'\n'+ productList;
                    }
                }
            }
        }
        system.debug('JsonEmailString=====:'+JsonEmailString);
        
    }
    
    global void finish(Database.BatchableContext BC){
        system.debug('JsonEmailString=====finish:'+JsonEmailString);
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        Msg.setToAddresses(new String[] {'sfdcadmin@titan.co.in'});
        Msg.setSubject('QR code sync data');
        Msg.setplaintextbody('Hi, Updated product data as follows :' +JsonEmailString+'\n'+'Json Data is:'+JsonData);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {msg});
    }
}