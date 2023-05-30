public class ProductEmailTriggerHandler {
      @future(CallOut=true)
    public static void afterInserProduct(string ProString){
        
      list<product__c> prodList = new list<product__c>();
        prodList = (list<product__c>)JSON.deserialize(ProString,list<product__c>.class);
        Map < Id, User > mapOfUser = new Map < Id, User > ();
        Set < Id > setOfOwnerId = new Set < Id > ();
        Set < String > setOfOrigin = new Set < String > ();
        Map < String, Set<String>> mapOfOriginEmail = new Map < String, Set<String> > ();
        
        for (Product__c eachProd: prodList) {
            setOfOwnerId.add(eachProd.OwnerId);
        }
        
        if(!setOfOwnerId.isEmpty()) {
            for(User usr : [Select Id, UserName,Email, Name from User Where Id In: setOfOwnerId]) {
                mapOfUser.put(usr.Id, usr);
            }
        }
        
        Double totalQuantity = 0; 
        Double totalAmount = 0;
        Double totalAmount2 = 0;
        String VendorName= '';
        String VendorEmail= '';
        Set<String> originEmail = new Set<String>();
       

       Vendor__c ven = new Vendor__c();
        
        if (!prodList.isEmpty()) {
            for (Product__c eachProd: prodList) {
                if (eachProd.Quantity__c != NULL) {
                    totalQuantity += eachProd.Quantity__c;
                }
                if (eachProd.Buyers_Cost__c != NULL && eachProd.Quantity__c != NULL) {
                    totalAmount += (eachProd.Buyers_Cost__c *eachProd.Quantity__c) ;
                }
                if(eachProd.Vendor_custom__c != NULL){
                    ven = [SELECT Id, Name, Email_Id_Vendor__c FROM Vendor__c WHERE Id =: eachProd.Vendor_custom__c limit 1];
                    VendorName = ven.Name;
                    VendorEmail = ven.Email_Id_Vendor__c;
                    //VendorName = [SELECT Id, Name FROM Vendor__c WHERE Id =: eachProd.Vendor_custom__c].Name;
                    //VendorEmail= [SELECT Id,name, Email_Id_Vendor__c FROM Vendor__c WHERE Id =: eachProd.Vendor_custom__c].Email_Id_Vendor__c;
                }
                if(eachProd.Cluster__c != NULL){
                    setOfOrigin.add(eachProd.Cluster__c);  //Banaras
                } 
            }
        }
        Set<String> setOfEmail = new Set<String>();
        for(Product_Origin_Based_Emails__c po : [Select Id, Name, Email__c from Product_Origin_Based_Emails__c where Name In: setOfOrigin]){
            if(po.Email__c != Null){
                if (po.Email__c.contains(',')) {
                     for (String str: po.Email__c.split(',')) {
                          setOfEmail.add(str);
                        }
                    } 
                else {
                        setOfEmail.add(po.Email__c);
                 }
            }
            mapOfOriginEmail.put(po.Name,setOfEmail); //Banaras,abc@gmail.com or Banaras,(ac@gmail.com,xyz@gmail.com)
        }
        
        if (!prodList.isEmpty()) {
            for (Product__c eachProd: prodList) {
                if(eachProd.Cluster__c != Null){
                    String key = eachProd.Cluster__c;  //Banaras
                    if(mapOfOriginEmail.containsKey(key) && mapOfOriginEmail.get(key) != Null){
                       originEmail=mapOfOriginEmail.get(key);
                    }
                }
            }
        }
        
       String table;
        table = '<table border="1"><tr><th>SKU</th><th>Vendor Reference Code / QR Code</th><th>Quantity</th><th>Amount</th><th>Total Amount</th><th>Color</th></tr>';
        for(Product__c pro: prodList){
            System.debug('Test ======>');
            if (pro.Buyers_Cost__c != NULL && pro.Quantity__c != NULL) {
               totalAmount2 = (pro.Buyers_Cost__c *pro.Quantity__c) ;
                

            }
            table = table + '<tr>'+'<td>'+pro.SKU_Code__c+'</td>'+'<td style="text-align:center;">'+pro.Name+'</td>'+'<td style="text-align:center;">'+pro.Quantity__c+'</td>'+'<td>'+pro.Buyers_Cost__c+'</td>'+'<td style="text-align:center;">'+totalAmount2+'</td>'+'<td>'+pro.Base_Colour__c+'</td>'+'</tr>';
            
        }
        table = table+'</table>';
        System.debug('Table===>'+table);
        
        List < String > receiverList2 = new List < String > ();
        String emailSubj2 = '';
        String emailSubj4 = '';
        String emailBody2 = '';
        string emailBody3 = '';
        emailSubj2 = 'Taneira New Sync : '; 
        //emailSubj4 = 'Taneira Procurement : ';
        List < Messaging.SingleEmailMessage > emailList2 = new List < Messaging.SingleEmailMessage > ();
        // Recipient 1 ie Owner Email
        if (!mapOfUser.isEmpty()) {
            for (String str: mapOfUser.keySet()) {
                if(mapOfUser.get(str).id == '0051O00000CJx5L' || mapOfUser.get(str).id == '0055Y00000I6hl0QAB' ){
                    receiverList2.add('kausalya@titan.co.in');
                    receiverList2.add('sriranjinir@titan.co.in');
                    receiverList2.add('sathyaraj@titan.co.in');
                    receiverList2.add('ajay_rajasekar@titan.co.in');
                }
                else if(mapOfUser.get(str).id == '0051400000Bqurz'){
                    receiverList2.add('anandv@titan.co.in');
                    receiverList2.add('sathyaraj@titan.co.in');
                    receiverList2.add('ajay_rajasekar@titan.co.in');
                }
                else{
                    receiverList2.add(mapOfUser.get(str).Email);
                }
            }
            // Recipient 2 ie from Custom Label
            String newEmailCustomLabel = label.New_Email_Custom_Label;
            if (newEmailCustomLabel != null) {
                if (newEmailCustomLabel.contains(',')) {
                    for (String str2: newEmailCustomLabel.split(',')) {
                        receiverList2.add(str2);
                    }
                } else {
                    receiverList2.add(newEmailCustomLabel);
                }
            }
            // Recipient 3 ie Vendor Email
            /*if(VendorEmail != null){
               receiverList2.add(VendorEmail);
            }*/
             // Recipient 4 ie Origin Based Email
            if(originEmail != null && originEmail.size() > 0){
               receiverList2.addAll(originEmail);
            }
          
            // Email Body 
            emailBody2  = '<html> Dear  Team' + ',' + '<br/><br/>' + 'Taneira team has placed orders for the following/attached SKUs.' +
                '<br/> Please confirm the same so that the PO can be issued.' +
                '<br/><br/> Total Quantity=' + totalQuantity +
                '<br/>  Total Amount=' + totalAmount +
                '<br/> Vendor Name=' + VendorName +                        
                '<br/>'+ table;
           /* emailBody3  = '<html> Dear ' +VendorName+ ',' + '<br/><br/>' + 'Taneira team has placed orders for the following/attached SKUs.' +
                '<br/> Please confirm the same so that the PO can be issued.' +
                '<br/><br/> Total Quantity=' + totalQuantity +
                '<br/>  Total Amount=' + totalAmount +
                '<br/> Vendor Name=' + VendorName +                        
                '<br/>'+ table;*/
            system.debug('Email Body 2-------------------------->'+emailBody2);
            Messaging.singleEmailmessage email2 = new Messaging.singleEmailmessage();
            email2.setSubject(emailSubj2+VendorName);
            email2.setHtmlBody(emailBody2);
            /*if(email == 'Sync'){
                email2.setSubject(emailSubj2+VendorName);
                email2.setHtmlBody(emailBody2);
            }
            else if(email == 'AttributionPage'){
                if(VendorEmail != null){
               receiverList2.add(VendorEmail);
            }
                email2.setSubject(emailSubj4+VendorName);
                email2.setHtmlBody(emailBody3);
            }*/
            
            
            
            PageReference pdf = Page.ProductInsertEmailAttachment;
            pdf.getParameters().put('KeyFinder',prodList[0].Product_Key_Finder__c);
            pdf.setRedirect(true);
            Blob b;
            // Take the PDF content
            if(!Test.isRunningTest()){
                system.debug('executing........');
                 b = pdf.getContent();
            }
            else{
                system.debug('executing........Test');
                b = blob.valueOf('Test');
            }
            
            
            // Create the email attachment
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName('Attachment.pdf');
            efa.setBody(b);
            email2.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            email2.setToAddresses(receiverList2);
            emailList2.add(email2);
            
            Messaging.sendEmail(emailList2);
            
        }
    } 
        
}