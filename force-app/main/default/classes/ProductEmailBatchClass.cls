/*************************************************************
* Created by: Vinoth Kumar A
* Created on: 01/03/2019
* Description: Every day at 7PM an email with re-order details should be triggered to respective team
* ************************************************************/ 

public class ProductEmailBatchClass implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        system.debug('email message:  '+Database.getQueryLocator([SELECT RE_ORDER__c, Re_order_SKU__c, SKU_Code__c, Vendor_Name__c, Cost__c, Re_order_Ref__c, Quantity__c ,OwnerId FROM Product__c WHERE lastmodifieddate = TODAY AND RE_ORDER__c = TRUE]));
        string query = 'SELECT RE_ORDER__c, SKU_Code__c, Vendor_Name__c, Cost__c, Re_order_Ref__c, Quantity__c, Re_order_SKU__c, OwnerId FROM Product__c WHERE lastmodifieddate = TODAY AND RE_ORDER__c = TRUE';
        system.debug('query'+query);
        return Database.getQueryLocator(query);
        
    }
    
    public void execute(Database.BatchableContext bc, List<Product__c> proList){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        system.debug('record details: '+proList);
        map<string,decimal> costMap = new map<string,decimal>();
        map<string,string> originMap = new map<string,string>();
        map<string,string> fabricMap = new map<string,string>();
        map<string,string> craftMap = new map<string,string>();
        map<string,string> orderidMap = new map<string,string>();
        List<string> ListSKU =  new List<string>();
        for(Product__c p:proList){
            ListSKU.add(p.Re_order_Ref__c);
        }
        for(Product__c p1:[SELECT id, Re_order_Ref__c, Cost__c,SKU_Code__c,	Fabric__c,Cluster__c,Workmanship__c,Order_Id__c FROM Product__c WHERE SKU_Code__c in: ListSKU]){
            costMap.put(p1.SKU_Code__c,p1.Cost__c);
            originMap.put(p1.SKU_Code__c,p1.Cluster__c);
            fabricMap.put(p1.SKU_Code__c,p1.Fabric__c);
            craftMap.put(p1.SKU_Code__c,p1.Workmanship__c);
            orderidMap.put(p1.SKU_Code__c,p1.Order_Id__c);
        }
        String Emailbody = '<table border="1" style="border-collapse: collapse;text-align: center;color:black;"><caption>SKU\'s Re-ordered Data</caption><tr><th>Vendor Name</th><th>Original SKU</th><th>Cost</th><th>Origin</th><th>Fabric</th><th>Craft</th><th>Order ID</th><th>Reorder SKU</th><th>Reorder cost</th><th>Quantity</th></tr>';
        for(Product__c pro : proList){
           Emailbody += '<tr><td style="padding:5px;">'+ pro.Vendor_Name__c + '</td><td style="padding:5px;">'+ pro.Re_order_Ref__c + '</td><td style="padding:5px;">'+costMap.get(pro.Re_order_Ref__c)+'</td><td style="padding:5px;">'+originMap.get(pro.Re_order_Ref__c)+'</td><td style="padding:5px;">'+fabricMap.get(pro.Re_order_Ref__c)+'</td><td style="padding:5px;">'+craftMap.get(pro.Re_order_Ref__c)+'</td><td style="padding:5px;">'+orderidMap.get(pro.Re_order_Ref__c)+'</td><td style="padding:5px;">' + pro.SKU_Code__c+ '</td><td style="padding:5px;">' + pro.Cost__c +'</td><td style="padding:5px;">'+ pro.Quantity__c.setScale(0) +'</td></tr>';
        }
        Emailbody += '</table>';
        
        
        /*String Emailbody = ' <html> <body><table> <tr><th>Vendor Name </th> <th>Parent SKU </th> <th>NewSKU Code</th> <th>Cost Price </th> </tr> for(Product__c pro : proList){ <tr> <td>pro.Vendor_Name__c </td> <td>pro.Re_order_Ref__c </td> <td>pro.SKU_Code__c </td> <td>pro.Cost__c</td> </tr> } </table> </body> </html>';
        integer i = 1;
        for(Product__c pro : proList){
            If(Emailbody == ''){
                Emailbody = i+'. '+'The following SKU '+pro.SKU_Code__c + ' has been re-ordered,<br/><br/>'+ 'Vendor Name : '+ pro.Vendor_Name__c
                    + '<br/>Parent SKU : '+ pro.Re_order_Ref__c + '<br/>New SKU Code : ' + pro.SKU_Code__c + '<br/>Cost Price : '+ pro.Cost__c +'<br/>';
            } else {
                Emailbody = Emailbody +'<br/>'+i+'. '+'The following SKU '+pro.SKU_Code__c + ' has been re-ordered,<br/><br/>'+ 'Vendor Name : '+ pro.Vendor_Name__c
                    + '<br/>Parent SKU : '+ pro.Re_order_Ref__c + '<br/>New SKU Code : ' + pro.SKU_Code__c + '<br/>Cost Price : '+ pro.Cost__c +'<br/>';
            }
            i = i+1;
        }*/
        List<string> emailList = new List<string>();        
        emailList.addAll(Label.Arayabatta_TeamNew.split(','));
        emailList.addAll(Label.PO_TeamNew.split(','));
        emailList.addAll(Label.Mechandize_Team.split(','));
        
        system.debug('email message:  '+Emailbody);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSenderDisplayName('Email alert');
        mail.setSubject('Product is Re- ordered');
       // mail.setToAddresses(new String[] { 'vinoth.kumar@kvpcorp.com'});
        mail.setToAddresses(emailList); 
        system.debug('----setToAddresses-----'+emailList);
        //Arayabatta TeamNew(rakeshg@titan.co.in),PO TeamNew(rakesh.mvm@gmail.com), Mechandize_Team(rakeshg@titan.co.in,sfdcadmin@titan.co.in) 
        mail.setHtmlBody(Emailbody);
        mails.add(mail);
        try{
            Messaging.sendEmail(mails);
        }
        catch(Exception e){
            system.debug('-------------exception------'+e);
        }
    }
    
    public void finish(Database.BatchableContext bC){
    }
    
}