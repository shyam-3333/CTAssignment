public class SendProcurementCostUpdateEmailHandler{
    List<Product__c> updatedProductList = new List<Product__c>();
    public  String vendorName;
    Set<String> categoryUserEmailid = new Set<String>();
    public void sendProcurementCostUpdateEmail(List<Product__c> productList, Map<ID,Product__c> oldproduct){
        //Product__c prodInstance = new Product__c();
        for(Product__c prod:productList ){
            if(prod.Stage__c=='Category'&&prod.Procurement_Cost__c!=oldproduct.get(prod.id).Procurement_Cost__c&&oldproduct.get(prod.id).Procurement_Cost__c!=null){
                // prod.Old_Procurement_Cost__c=oldproduct.get(prod.id).Procurement_Cost__c
                vendorName=prod.Vendor_Name__c;
                categoryUserEmailid.add(prod.category_user_email__c);
            }
            
        }
        system.debug('categoryUserEmailid'+categoryUserEmailid);
        if(!categoryUserEmailid.isEmpty()){
            // update updatedProductList;
            Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
            list<String> sendTo = new list<String>();
            sendTo.addAll(categoryUserEmailid);
            mail.setToAddresses(sendTo); 
            
            mail.setCcAddresses(new list<string>{'sfdcadmin@titan.co.in'});
            mail.setSubject('Taneira Procurement Cost changed:'+vendorName);
            String table;
            table = '<table border="1"><tr><th>SKU</th><th>Old Procurement Cost</th><th>Updated procurement Cost</th></tr>';
            for(Product__c prod: productList){
                // if(prod.Stage__c=='Category'&&prod.Procurement_Cost__c!=oldproduct.get(prod.id).Procurement_Cost__c&&oldproduct.get(prod.id).Procurement_Cost__c!=null){
                
                
                table = table + '<tr>'+'<td>'+prod.SKU_Code__c+'</td>'+'<td style="text-align:center;">'+oldproduct.get(prod.id).Procurement_Cost__c+'</td>'+'<td style="text-align:center;">'+prod.Procurement_Cost__c+'</td></tr>';
                //}
            }
            table = table+'</table>';
            mail.setHtmlBody('Hi,<br></br>Please find the Taneira Procurement Cost details:<br></br>'+table);
             Messaging.Email[] emails = new Messaging.Email[]{mail};
                Messaging.sendEmail(emails);
        }
    }
    
    
}