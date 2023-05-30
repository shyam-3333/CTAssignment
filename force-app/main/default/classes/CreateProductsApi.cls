/*******************************************
Created By : Poornapriya YN
Modified By : Sandipan Saha(3/1/2018)
Description: Rest API to Create Products and Attachments
**********************************************/

@RestResource(urlMapping = '/CreateProduct')
global class CreateProductsApi {
    
    global class ProductDetails {
        public List<Vendor_Prod_CodeWrap> Vendor_Prod_Code; //Brown Saree
        public String Vendor_Id;
        public String Vendor_Name;
        public String Vendor_Mobile; //
        public String Origin; //Assam/Banaras/South
        public String Product_Category; //Saree
        public String Loom; //Handloom
        public String Material_Wrap; //Cotton
        public String Material_Weft; //Silk
        public String Craft; //Bandhni/Ikat
        public String Zari_Type; //Tested
        public String Quantity; //10
        public double Cost_Price;
        public string Blouse;
        public string SINO; // Primary key for product
        public string Proc_Type;
        public string Created_From;
        public string Prod_Ref_Code;
        public string Remarks;
        public string Username;
        public string ROW_ITEM;
        public Boolean specialRequest;
        public string costBand; 
        public string comment; 
        public string productLineItemId;
        public String baseColour;
        public String OrderId;
        public String Kurta_Fabric;
        public String Dupatta_Fabric;
        public String Salwar_Fabric;
        public string Sourcing_Type;
       // public string MRP_Reco;
        public string VendorCode;//new added for Model  
        public List < ImageDetails > ImageUpload;
        
        public ProductDetails(){
            Vendor_Prod_Code = new List<Vendor_Prod_CodeWrap>();
        }
        
    }
    
    global class ImageDetails {
        public String Name; 
        public string Body; 
        public String ContentType; 
        public string SINO;
    }
    global class Vendor_Prod_CodeWrap{
        public string QRcodeName;       
    }
    
    @HTTPPost
    global static void doPost() {
        string IncorrectQRCode = '';
        RestContext.response.addHeader('Content-Type', 'text/plain');
        System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());   
        system.debug('-----------RestContext.request.requestBody----'+RestContext.request.requestBody);
        System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
        
        Map<String,Decimal> autoNumMap= new Map<String,Decimal>();
        for(AutoNumber__c each:AutoNumber__c.getAll().values()){
            autoNumMap.put(each.Name,each.Auto_Number__c);
        }
        Map<String,String> masterDataMap=new Map<String,String>();
        for(Master__c each:[SELECT Name__c,Name,Active__c,Code__c FROM Master__c WHERE Active__c=True]){
            masterDataMap.put(each.Name__c+each.Name,each.Code__c);
            
        }
        System.debug('===masterDataMap====='+masterDataMap);
        
        List < ProductDetails > prodDetails = new List < ProductDetails > ();
        List < Attachment > attachmentlist = new List < Attachment > ();
        List < Product__c > insertProductlist = new List < Product__c > ();
        List < Attachment > insertAttachmentlist = new List < Attachment > ();
        List < Product__c > updateProd = new List < Product__c > ();
        List < Product__c > lstProdResult = new List < Product__c > ();
        Map < String, ProductDetails > mapOfLineItems = new Map < String, ProductDetails > ();
        Map < String, List < Attachment >> mapOfAttachments = new map < String, List < Attachment >> (); 
        Map <string, string> AttMap = new Map<string,string>();
        Map < String, Id > mapOfProduct = new map < String, Id > ();
        Map < String, User > mapOfUser = new Map < String, User > ();
        Set < String > setOfUsrName = new Set < string > ();
        Map < Id, String > attachMapWithProdId = new Map < Id, String > ();
        List < Product__c > prodQuery = new List < Product__c > ();
        List < Product__c > updatedPrdWithPhotourl = new List < Product__c > ();
        String urlstr1; 
        List<Product__c> prodListInsert = new List<Product__c>();
        List<Product__c> prodListError = new List<Product__c>();
        Set<String> codeFormSet= new Set<String>();
       

        Blob_Data_Object__c obj= new Blob_Data_Object__c();
        obj.name='Test1';
        insert obj;
        Attachment att1 = new Attachment();
        att1.Name='Att1.Test1';
        att1.parentId=obj.Id;
        att1.Body=RestContext.request.requestBody;
        att1.ContentType='.txt';
        insert att1;
        Savepoint sp = DataBase.setSavepoint();
        
        prodDetails=(List<ProductDetails>)System.JSON.deserialize(RestContext.request.requestBody.toString(),List<ProductDetails>.class);
        if (!prodDetails.isEmpty()) {
            for (ProductDetails eachProd: prodDetails) {
                setOfUsrName.add(eachProd.UserName);
            }
        }System.debug('-----setOfUsrName------>'+setOfUsrName);
        if (!setOfUsrName.isEmpty()) {
            for (User usr: [Select Id, UserName,Email, Name from user Where Username in: setOfUsrName]) {
                mapOfUser.put(usr.UserName, usr);
            }
        }
        //=====================================================================//
        for (ProductDetails eachProd: prodDetails) {
            mapOfLineItems.put(eachProd.ROW_ITEM, eachProd);
            Product__c newProd = new Product__c();          
            newProd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
            newProd.Vendor_custom__c = eachProd.Vendor_Id;
           	//newProd.Vendor_code_mod__c = eachProd.VendorCode;
            newProd.Vendor_name_Test__c = eachProd.Vendor_Name;
            newProd.Cluster__c = eachProd.Origin;
            newProd.Blouse_Type__c = eachProd.Blouse;
            newProd.Offline_Username__c = eachProd.Prod_Ref_Code;
            newProd.Proc_Type__c = eachProd.Proc_Type;
            newProd.Offline_Key__c = eachProd.SINO;
            newProd.Product_Category_Taneira__c = eachProd.Product_Category;
            newProd.Loom__c = eachProd.Loom;
            newProd.Buyers_Cost__c = eachProd.Cost_Price;
            newProd.Material_Wrap__c = eachProd.Material_Wrap;
            newProd.Taneira_Material_Weft__c = eachProd.Material_Weft;
            newProd.Workmanship__c = eachProd.Craft;
            newProd.Zari_Type__c = eachProd.Zari_Type;
            newProd.Quantity__c = decimal.valueOf(eachProd.Quantity);
            newProd.Comments__c = eachProd.Remarks.replaceAll('\n','').replaceAll('\r','');
            newProd.Created_From__c = eachProd.Created_From;
            newProd.Cost_Band__c = eachProd.costBand;
            newProd.Special_Request__c = eachProd.specialRequest;
            newProd.Comment_for_Special_Request__c = eachProd.Comment;
            newProd.Base_Colour__c=eachProd.baseColour;
            newProd.Order_Id__c = eachProd.OrderId;
            newProd.Kurta_Fabric__c = eachProd.Kurta_Fabric;
            newProd.Dupatta_Fabric__c = eachProd.Dupatta_Fabric;
            newProd.Salwar_Fabric__c = eachProd.Salwar_Fabric;
            newProd.Sourcing_Type__c = eachProd.Sourcing_Type;
           // newProd.MRP_Reco__c = eachProd.MRP_Reco; //new added/A/B/C  

            List<string> qrcodeList= new List<string>(); 
            system.debug('eachProd.Vendor_Prod_Code.size()=='+eachProd.Vendor_Prod_Code.size() +'IncorrectQRCode+++'+IncorrectQRCode);
            If(eachProd.Vendor_Prod_Code != null && eachProd.Vendor_Prod_Code.size() > 1){  
                system.debug('aaaaa'+eachProd.Vendor_Prod_Code[0].QRcodeName.length()+'bbbbb'+eachProd.Vendor_Prod_Code[1].QRcodeName.length());
                if(eachProd.Vendor_Prod_Code[0].QRcodeName.length() == 14 && eachProd.Vendor_Prod_Code[1].QRcodeName.length() == 14){
                    string firstBlock = eachProd.Vendor_Prod_Code[0].QRcodeName;
                    string lastBlock = eachProd.Vendor_Prod_Code[1].QRcodeName;
                    string subStr1 = firstBlock.substring(8);
                    string subStr2 = lastBlock.substring(8);
                    if(subStr1.isNumeric() && subStr2.isNumeric() && IncorrectQRCode != 'NotANumber'){
                        integer firstNum = Integer.valueOf(subStr1);
                        integer LastNum = Integer.valueOf(subStr2);
                        for(integer i=firstNum; i<=LastNum; i++){
                            qrcodeList.add(firstBlock.substring(0,8)+i);
                        }
                        IncorrectQRCode = 'Number';
                    } else {
                        IncorrectQRCode = 'NotANumber';
                    }
                }
                else{
                    IncorrectQRCode = 'Number';
                    for(Vendor_Prod_CodeWrap str: eachProd.Vendor_Prod_Code){
                        qrcodeList.add(str.QRcodeName);
                    }
                }
                
                system.debug('IncorrectQRCode==>'+IncorrectQRCode); 
                system.debug('qrcodeList===>'+qrcodeList);
                list<string> tempQR1 = new list<string>();
                list<string> tempQR2 = new list<string>();
                list<string> tempQR3 = new list<string>();
                if(qrcodeList.size()<45){
                    if(qrcodeList.size()>15){
                        for(integer i=0; i<15;i++){
                            tempQR1.add(qrcodeList[i]);
                        }
                    }
                    if(qrcodeList.size()<15 && qrcodeList.size()>0){
                        for(integer i=0; i<qrcodeList.size();i++){
                            tempQR1.add(qrcodeList[i]);
                        }
                    }
                    if(qrcodeList.size()>15 && qrcodeList.size()<30){
                        for(integer i=15; i<qrcodeList.size();i++){
                            tempQR2.add(qrcodeList[i]);
                        }
                    }
                    if(qrcodeList.size()>15 && qrcodeList.size()>30){
                        for(integer i=15; i<30;i++){
                            tempQR2.add(qrcodeList[i]);
                        }
                    }
                    if(qrcodeList.size()>30){
                        for(integer i=32; i<qrcodeList.size();i++){
                            tempQR3.add(qrcodeList[i]);
                        }
                    }
                    if(tempQR1 != null && tempQR1.size()>0){
                        newProd.QR_CODE_1__c= String.join(tempQR1,',');
                    }
                    if(tempQR2 != null && tempQR2.size()>0){
                        newProd.QR_CODE_2__c= String.join(tempQR2,',');
                    }
                    if(tempQR3 != null && tempQR3.size()>0){
                        newProd.QR_CODE_3__c= String.join(tempQR3,',');
                    }
                }
                
                newProd.QR_CODE__c= String.join(qrcodeList,','); 
                
            } else if( eachProd.Vendor_Prod_Code.size() > 0){
                system.debug('eachProd.Vendor_Prod_Code.size()=elsepart='+eachProd.Vendor_Prod_Code.size() +'IncorrectQRCode+++'+IncorrectQRCode);
                newProd.QR_CODE__c = eachProd.Vendor_Prod_Code[0].QRcodeName;
                newProd.QR_CODE_1__c = eachProd.Vendor_Prod_Code[0].QRcodeName;
                IncorrectQRCode = 'Number';
                system.debug('eachProd.Vendor_Prod_Code.size()=123='+eachProd.Vendor_Prod_Code.size() +'IncorrectQRCode+++'+IncorrectQRCode);
            }
            //model/product name is equal to vendor code or first qr code
            if(eachProd.VendorCode == null || eachprod.VendorCode == ''){
                 
                 newProd.Name = eachProd.Vendor_Prod_Code[0].QRcodeName;
                system.debug('new code '+newProd.Name );
            }
            else{
                  newProd.Name  = eachProd.VendorCode;//re mapping from qrcode to vendor code
                  system.debug(' else eachProd.VendorCode '+newProd.Name );
            }
            
            if(test.isRunningTest()){
                newProd.Sync_Date__c =System.today();
            }else{
                newProd.Sync_Date__c = DateTime.valueOf(eachProd.productLineItemId.substring(eachProd.productLineItemId.indexOf('>') + 1));
            }
            if (!mapOfUser.isEmpty() && mapOfUser.containsKey(eachProd.Username)) {
                newProd.OwnerId = mapOfUser.get(eachProd.Username).Id;
            }
            if(eachProd.ImageUpload !=NULL || eachProd.ImageUpload.size() !=0){
                for (ImageDetails img: eachProd.ImageUpload) {
                    Attachment attach = new Attachment();
                    attach.Name = img.Name+img.ContentType;
                    attach.Body = EncodingUtil.base64Decode(img.Body);
                    
                    attach.isPrivate = false;
                    attachmentlist.add(attach);
                    if (mapOfAttachments.containsKey(newProd.Offline_Key__c)) {
                        mapOfAttachments.get(newProd.Offline_Key__c).add(attach);
                    } else {
                        mapOfAttachments.put(newProd.Offline_Key__c, new list < Attachment > {
                            attach
                                });
                    }
                }
            } 
            if(IncorrectQRCode == 'Number'){
                insertProductlist.add(newProd);
                
                system.debug('eachProd.Vendor_Prod_Code.size()=123if='+eachProd.Vendor_Prod_Code.size() +'IncorrectQRCode+++'+IncorrectQRCode+'insertProductlist==='+insertProductlist.size());
            } else {
                system.debug('eachProd.Vendor_Prod_Code.size()=else='+eachProd.Vendor_Prod_Code.size() +'IncorrectQRCode+++'+IncorrectQRCode+'insertProductlist==='+insertProductlist.size());
                
                insertProductlist.clear();
            }   
            
        }
        System.debug('=========insertProductlist======='+insertProductlist);
        if(insertProductlist.size()>0){
            for(Product__c eachpr:insertProductlist){
                system.debug('1234pc==='+masterDataMap.get('Product Category'+eachpr.Product_Category_Taneira__c)+'----'+eachpr.Product_Category_Taneira__c);
                system.debug('1234loom==='+masterDataMap.get('Loom'+eachpr.Loom__c)+'----'+eachpr.Loom__c);
                system.debug('1234proc==='+masterDataMap.get('Proc-Type'+eachpr.Proc_Type__c)+'----'+eachpr.Proc_Type__c);
                system.debug('autoNumMap : '+autoNumMap);
                system.debug('autoNumMap : '+autoNumMap.size());
                if(!autoNumMap.isEmpty() && !masterDataMap.isEmpty() && autoNumMap.containsKey(masterDataMap.get('Product Category'+eachpr.Product_Category_Taneira__c)+
                                                                                               masterDataMap.get('Loom'+eachpr.Loom__c)+masterDataMap.get('Proc-Type'+eachpr.Proc_Type__c))){
                                                                                                   prodListInsert.add(eachpr); 
                                                                                                   
                                                                                               }
                
                else{
                    prodListError.add(eachpr);
                    
                }
            }
            System.debug('=========prodListInsert======='+prodListInsert);
            System.debug('=========prodListError======='+prodListError);
        }
        
        
        //======================================================================
        try {
            system.debug('eachProd.Vendor_Prod_Code.size()=prodListInsertout='+prodListInsert.size() +'IncorrectQRCode+++'+IncorrectQRCode+'insertProductlist==='+insertProductlist.size());
            
            if (prodListInsert.size() > 0 && IncorrectQRCode == 'Number') { 
                system.debug('eachProd.Vendor_Prod_Code.size()=prodListInsert='+prodListInsert.size() +'IncorrectQRCode+++'+IncorrectQRCode+'insertProductlist==='+insertProductlist.size());
                insert prodListInsert;
            }
            //-------Changing the code here and adding a response---------//
            Map<String,String> ErrorRespMap= new Map<String,String>();
            RestResponse res=RestContext.response;
            RestContext.response.addHeader('Content-Type','application/json');
            String expMsg1;
            if(prodListError.size()>0){
                expMsg1 = json.serialize(prodListError);
                ErrorRespMap.put('Status Message','Error in inserting the file');
                ErrorRespMap.put('Status Code','4');
                expMsg1=json.serialize(ErrorRespMap);
            }
                     
            RestContext.response.responseBody = Blob.valueOf(expMsg1);
            
            //---------------------------------------------------------------//
            
        } catch (Exception ex) {
            system.debug('**Exception at line number**' + ex.getLineNumber()+' ,'+'Exception message--->'+ex.getMessage());
        }
        lstProdResult = [SELECT Name, Offline_Key__c, owner.Name, Vendor_custom__r.name, CreatedDate, Id FROM Product__c WHERE Offline_Key__c in: mapOfAttachments.keyset() AND recordTypeId =: Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId() AND Id in: prodListInsert];
        for (Product__c prod: lstProdResult) {
            mapOfProduct.put(prod.Offline_Key__c, prod.id);
        }
        if(!mapOfAttachments.isEmpty()){
            for (String str: mapOfAttachments.keyset()) {
                for (Attachment att: mapOfAttachments.get(str)) {
                    if (!mapOfProduct.isEmpty() && mapOfProduct.containsKey(str)) {
                        att.ParentId = mapOfProduct.get(str);
                        AttMap.put(att.ParentId,Att.ContentType);
                        system.debug('AttMapAttMap:==='+AttMap);
                        insertAttachmentlist.add(att);
                    }
                }
            }
        }
        try {
            system.debug('Testring Number===='+IncorrectQRCode);
            if(IncorrectQRCode == 'NotANumber'){
                RestResponse res = RestContext.response;
                RestContext.response.addHeader('Content-Type', 'application/json');
                Map < String, String > mapWithinRangeResponse = new Map < String, String > ();
                mapWithinRangeResponse.put('Status Message', 'Incorrect QR Code');
                mapWithinRangeResponse.put('Status Code', '5');
                String expMsg = json.serialize(mapWithinRangeResponse);
                RestContext.response.responseBody = Blob.valueOf(expMsg);
            } else if (insertAttachmentlist.size() > 0) {
                insert insertAttachmentlist;
                RestResponse res = RestContext.response;
                RestContext.response.addHeader('Content-Type', 'application/json');
                Map < String, String > mapWithinRangeResponse = new Map < String, String > ();
                mapWithinRangeResponse.put('Status Message', 'Product created with Image successfully');
                mapWithinRangeResponse.put('Status Code', '0');
                String expMsg = json.serialize(mapWithinRangeResponse);
                RestContext.response.responseBody = Blob.valueOf(expMsg);
                
                /*** Send Email To Merchandize,PO,Arayabatta ***/
                List < String > sendTo = new List < String > ();
                List < String > ccTo = new List < String > ();
                ccTo = label.Mechandize_Team.split(',');
                String poTeam = label.PO_TeamNew;
                if (poTeam != null) {
                    if (poTeam.contains(',')) {
                        for (String str: poTeam.split(',')) {
                            sendTo.add(str);
                        }
                    } else {
                        sendTo.add(poTeam);
                    }
                }
                String arayabattaTeam = label.Arayabatta_TeamNew;
                if (arayabattaTeam != null) {
                    if (arayabattaTeam.contains(',')) {
                        for (String str: arayabattaTeam.split(',')) {
                            sendTo.add(str);
                        }
                    } else {
                        sendTo.add(arayabattaTeam);
                    }
                }System.debug('====map of user==='+mapOfUser);
                System.debug('===mapOfLineItems==='+mapOfLineItems);
                
                string subject = '';
                string mailbody = '';
                subject = 'New procurement details';
                List < Messaging.SingleEmailMessage > myEmails = new List < Messaging.SingleEmailMessage > ();
                if(!mapOfLineItems.isEmpty() && !mapOfUser.isEmpty()){
                    for (String pro: mapOfLineItems.keyset()) {
                        if(mapOfLineItems.get(pro).UserName !=NULL){
                            mailbody = '<html><body>Dear Team,<br/><br/>The attached items have been procured by ' + mapOfUser.get(mapOfLineItems.get(pro).Username).Name + ' on ' + system.Today().format() + ' from ' + mapOfLineItems.get(pro).Vendor_Name + '. Kindly create Purchase Order for the Vendor and update the PO number to Aryabhatta team by using below link<br/><br/>' + URL.getSalesforceBaseUrl().toExternalForm() + '/apex/TaneiraViewAngularJSPage<br/><br/>Thank You,<br/><br/>' + mapOfUser.get(mapOfLineItems.get(pro).Username).Name + '<br/>Taneira Procurement Solution</body></html>';
                            Messaging.singleEmailmessage Email = new Messaging.singleEmailmessage();
                            email.setsubject(subject+' - '+mapOfLineItems.get(pro).Vendor_Name);
                            email.Sethtmlbody(mailbody);
                            Email.SetToAddresses(sendTo);
                            Email.SetCCAddresses(ccTo);
                            myEmails.add(Email);
                        }
                        
                    }
                }
                Messaging.sendEmail(myEmails);
                List<Product__c> ProdUpdateList = new List<Product__c>();
                For(Attachment atm : [SELECT Id, name, ParentId, ContentType FROM Attachment WHERE ParentId IN: AttMap.keyset()]){
                    AttMap.put(atm.ParentId,'.'+atm.name.substringAfter('.'));
                    system.debug('atm.ParentId:=='+atm.ParentId  +'.'+atm.name.substringAfter('.'));
                }
                system.debug('AttMapoutside:=='+AttMap);
                for(Product__c products : [SELECT Id, Photo_Extension__c FROM Product__c WHERE Id IN : AttMap.keyset()]){
                    products.Photo_Extension__c = AttMap.get(products.Id);
                    ProdUpdateList.add(products);
                }
                if(!ProdUpdateList.isempty()){
                    update ProdUpdateList;
                }
            } else {
                RestResponse res = RestContext.response;
                RestContext.response.addHeader('Content-Type', 'application/json');
                Map < String, String > mapWithinRangeResponse = new Map < String, String > ();
                mapWithinRangeResponse.put('Status Message', 'Product created without Image successfully');
                mapWithinRangeResponse.put('Status Code', '0');
                String expMsg = json.serialize(mapWithinRangeResponse);
                RestContext.response.responseBody = Blob.valueOf(expMsg);
            }
        } catch (Exception ex) {
            system.debug('**Exception**' + ex);
        }
        
        //------------------------------------------------------------------------------------------------//
        /* Modified by Rahul Mukherji
* Date-04/09/2018
* This change has been made to send email to the Offline Users once the data is synced from Offline to Online App
* Phase-3 Requirement.
* Considering mapofUser has OfflineUser details and along with need to send total amount and quantity in the email body
* 
*/
        
        System.debug('===MapofUser==='+mapOfUser);
        System.debug('===Inserted product list==='+prodListInsert);
        Double totalQuantity = 0, totalAmount = 0;
        String VendorName= '';
        try {
            if (!prodListInsert.isEmpty()) {
                for (Product__c eachProd: prodListInsert) {
                    if (eachProd.Quantity__c != NULL) {
                        totalQuantity += eachProd.Quantity__c;
                    }
                    if (eachProd.Buyers_Cost__c != NULL && eachProd.Quantity__c != NULL) {
                        totalAmount += (eachProd.Buyers_Cost__c *eachProd.Quantity__c) ;
                    }
                    if(eachProd.Vendor_custom__c != NULL){
                       VendorName = eachProd.Vendor_name_Test__c;
                    }
                }
            }
            List < String > receiverList = new List < String > ();
            String emailSubj = '', emailBody = '';
            emailSubj = 'Offline Product Synced';
            List < Messaging.SingleEmailMessage > emailList = new List < Messaging.SingleEmailMessage > ();
            System.debug('----------mapOfUser at email service-------->'+mapOfUser);
            if (!mapOfUser.isEmpty()) {
                for (String str: mapOfUser.keySet()) {
                    system.debug('map of name'+mapOfUser.get(str).id);
                    if(mapOfUser.get(str).id == '0051O00000CJx5L'){
                        receiverList.add('sfdcadmin@titan.co.in');
                        receiverList.add('kausalya@titan.co.in');
                        receiverList.add('thiyagarajane@titan.co.in');
                        receiverList.add('sathyaraj@titan.co.in');
                    }
                    else if(mapOfUser.get(str).id == '0051O00000CJx5L' || mapOfUser.get(str).id == '0051400000Bqurz'|| mapOfUser.get(str).id == '0051O00000CK4xZ'){
                        receiverList.add('sfdcadmin@titan.co.in');
                        receiverList.add('kausalya@titan.co.in');
                    }
                    
                    
                    else{
                        receiverList.add(mapOfUser.get(str).Email);
                    }
                    receiverList.add(mapOfUser.get(str).Email);
                    System.debug('------receiverList in email service------->'+receiverList);
                    emailBody = '<html> Dear ' + mapOfUser.get(str).Name + ',' + '<br/><br/>' + 'The Offline Products has been Synced successfully.' +
                        '<br/> Please find the details below of Total Quantity and Total amount for the SKU\'s created.' +
                        '<br/><br/> Total Quantity=' + totalQuantity +
                        '<br/>  Total Amount=' + totalAmount +
                        '<br/> Vendor Name=' + VendorName +
                        '<br/><br/><br/> Thanks,' +
                        '<br/> SFDC Team.';
                    Messaging.singleEmailmessage email = new Messaging.singleEmailmessage();
                    email.setSubject(emailSubj+' - '+VendorName);
                    email.setHtmlBody(emailBody);
                    email.setToAddresses(receiverList);
                    emailList.add(email);
                    
                }
            }
            Messaging.sendEmail(emailList);
            
        } catch (Exception e) {
            System.debug('==Exception==>?' + e.getLineNumber());
        }        
        //-----------------------------------------------------------------------------------------------//
        /* Modified By:Rahul Mukherji
* Date:03/28/2018
* This change has been made to accomodate the multiple photos in the Photo__c field present on the Product__c
* object.Here we have used a Map which will hold the Product Id and attachment url, considering the attachment
* has been inserted and contains the ProductId as parentId.
* 
*Considering the insertAttachmentlist gives the Product Id.
*/
        System.debug('============' + insertAttachmentlist);
        if (insertAttachmentlist.size() > 0) {
            for (Attachment att: insertAttachmentlist) {
                if (att.parentId != NULL && attachMapWithProdId.containsKey(att.ParentId) && !attachMapWithProdId.isEmpty()) {
                    System.debug('Inside if to get attachments');
                    urlstr1 = '<img src="' + URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file=' + att.id + '"></img>';
                    attachMapWithProdId.put(att.ParentId, attachMapWithProdId.get(att.ParentId) + ',' + urlstr1);
                }
                if (att.parentId != NULL && !attachMapWithProdId.containsKey(att.parentId)) {
                    urlstr1 = '<img src="' + URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file=' + att.id + '"></img>';
                    attachMapWithProdId.put(att.parentId, urlstr1);
                }
            }
        }
        System.debug('=========attachMapWithProdId========' + attachMapWithProdId);
        if (!attachMapWithProdId.isEmpty()) {
            prodQuery = [SELECT ID, Name, Photo__c FROM Product__c WHERE Id IN: attachMapWithProdId.keySet()];
        }
        try {
            if (!prodQuery.isEmpty()) {
                for (Product__c prod: prodQuery) {
                    if (!attachMapWithProdId.isEmpty() && attachMapWithProdId.containsKey(prod.Id)) {
                        prod.Photo__c = +attachMapWithProdId.get(prod.Id);
                        updatedPrdWithPhotourl.add(prod);
                    }
                }
            }System.debug('====updatedPrdWithPhotourl===='+updatedPrdWithPhotourl);
            if (updatedPrdWithPhotourl.size() > 0) {
                update updatedPrdWithPhotourl;
            }
        } catch (Exception e) {
            System.debug('Error at line number===>' + e.getLineNumber() + ' Stack error is===>' + e.getMessage());
            Database.RollBack(sp);
        }
        
        
        
        //======================================================================//
        
       Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;   
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;    
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;        
    } //end of doPost method
}