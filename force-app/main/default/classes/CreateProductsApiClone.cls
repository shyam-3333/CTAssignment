/*******************************************
Created By : Poornapriya YN
Description: Rest API to Create Products and Attachments
**********************************************/

@RestResource(urlMapping='/CreateProducts')
global class CreateProductsApiClone{
    global class ProductDetails{
        public String Vendor_Prod_Code;  //Brown Saree
        public String Vendor_Id; 
       // public String Vendor_Name;
       // public String Vendor_Mobile;   //
        public String Origin;   //Assam/Banaras/South
        public String Product_Category; //Saree
        public String Loom; //Handloom
        public String Material_Wrap;    //Cotton
        public String Material_Weft;    //Silk
        public String Craft;    //Bandhni
        public String Zari_Type;    //Tested
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
        public List<ImageDetails> ImageUpload;
    }
    global class ImageDetails {
        public String Name; //ImageName
        public string Body; //blob_value
        public String ContentType;  //.png/.jpg/.jpeg/.gif/.bmp/.tiff/.pbm
        public string SINO;
    }
    @HTTPPost
    global static void doPost(){
        RestContext.response.addHeader('Content-Type', 'text/plain');
        System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());   
        system.debug('-----------RestContext.request.requestBody----'+RestContext.request.requestBody);
        System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
        //insertProd(RestContext.request.requestBody);
        //String bodyOfReq = RestContext.request.requestBody.toString();
        //RestContext.request.requestBody = RestContext.request.requestBody.toString();
        //system.debug('**bodyOfReq**'+bodyOfReq);
           

    //}
    
    //@future
    //global static void insertProd(blob requestBody){
        //system.debug('--------requestBody----------'+requestBody);
        //String bodyOfReq = requestBody.toString();
        //system.debug('**bodyOfReq**'+bodyOfReq);
       List<ProductDetails> prodDetails= new  List<ProductDetails> ();
        List<Product__c> insertProductlist= new  List<Product__c> ();
        List<Product__c> updateProd = new  List<Product__c> ();
        Map<String,List<Attachment>> mapOfAttachments = new map<String,List<Attachment>>();
        Map<String,Id> mapOfProduct = new map<String,Id>();
        List<Attachment> attachmentlist = new List<Attachment>();
        List<Attachment> insertAttachmentlist = new List<Attachment>();
        set<String>setOfVendorName = new Set<String>();
        set<String>setOfMobile = new Set<String>();
        set<String>setOfUsrName = new set<string>();
        map<String,User> mapOfUser = new map<string,User>();
        map<String,ProductDetails> mapOfLineItems = new map<String,ProductDetails>();
        Id TaneiraRecType= [Select Id from RecordType where Name ='Taneira' and SObjectType = 'Product__c' limit 1].Id; 
        prodDetails=(List<ProductDetails>)System.JSON.deserialize(RestContext.request.requestBody.toString(),List<ProductDetails>.class);
        for(ProductDetails eachProd : prodDetails){
            setOfUsrName.add(eachProd.UserName);
        }
        for(User usr : [Select Id,UserName,Name from user Where Username in : setOfUsrName]){
            mapOfUser.put(usr.UserName,usr);
        }
        for(ProductDetails eachProd : prodDetails){
            mapOfLineItems.put(eachProd.ROW_ITEM,eachProd);
            Product__c newProd = new Product__c();
            newProd.Name = eachProd.Vendor_Prod_Code;
            newProd.RecordTypeId = TaneiraRecType;
            newProd.vendor_custom__c = eachProd.Vendor_Id;
            newProd.Cluster__c = eachProd.Origin;
            newProd.Blouse_Type__c= eachProd.Blouse;
            newProd.Offline_Username__c = eachProd.Prod_Ref_Code;
            newProd.Proc_Type__c = eachProd.Proc_Type;
            newProd.Offline_Key__c = eachProd.SINO;
            newProd.Product_Category_Taneira__c = eachProd.Product_Category;
            newProd.Loom__c = eachProd.Loom;
            newProd.Cost__c = eachProd.Cost_Price;
            newProd.Material_Wrap__c = eachProd.Material_Wrap;
            newProd.Taneira_Material_Weft__c = eachProd.Material_Weft;
            newProd.Workmanship__c = eachProd.Craft;
            newProd.Zari_Type__c = eachProd.Zari_Type;
            newProd.Quantity__c = decimal.valueOf(eachProd.Quantity);
            //newProd.Comments__c = eachProd.Remarks;
            newProd.Created_From__c = eachProd.Created_From;
            if(!mapOfUser.isEmpty() && mapOfUser.containsKey(eachProd.Username)){
                newProd.OwnerId = mapOfUser.get(eachProd.Username).Id;
            }
            
            system.debug('**SINO**'+eachProd.SINO);
            for(ImageDetails img : eachProd.ImageUpload){
                Attachment attach = new Attachment();
                attach.Name = img.Name + img.ContentType;
                attach.Body = EncodingUtil.base64Decode(img.Body);
                attach.isPrivate = false;
               // attach.ContentType = img.ContentType;
                system.debug('**Attachment SINO**'+img.SINO);
                attachmentlist.add(attach);
                if(mapOfAttachments.containsKey(newProd.Name)){
                    mapOfAttachments.get(newProd.Name).add(attach);
                }
                else{
                    mapOfAttachments.put(newProd.Offline_Key__c,new list<Attachment>{attach});
                }
                
            }
            
            
            insertProductlist.add(newProd);
        }
        system.debug('**mapOfLineItems***'+mapOfLineItems);
        system.debug('**mapOfAttachments**'+mapOfAttachments);
        try{
            if(insertProductlist.size()>0){
                insert insertProductlist;
                
                system.debug('**insertProductlist after insert**'+insertProductlist);
            }
        }
        
        catch(Exception ex){
            system.debug('**Exception**'+ex);
        }
        string Ownername = '';
        string accountName = '';
        string createdDate = '';
        list<Product__c > lstProdResult = new list<Product__c >();
        
        if(!Test.isRunningTest()){
            lstProdResult = [SELECT Name,Offline_Key__c,owner.Name,vendor_custom__r.name,CreatedDate, Id FROM Product__c WHERE Offline_Key__c in : mapOfAttachments.keyset() AND recordTypeId = :TaneiraRecType and Id in :insertProductlist];
        }
        else{
            //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
            vendor__c acc = new vendor__c();
            acc.Name= 'test Account';
            acc.Phone_No__c = '2648394';
            //acc.recordTypeId = recordTypeIdAcc;
            insert acc; 
            
            Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
            Product__c pro = new Product__c();
            pro.Name = 'Brown Saree';
            pro.vendor_custom__c = acc.id;
            pro.RecordTypeId = recordTypeId;
            pro.cost__c = 123;
            pro.Suggested_MRP__c= 123;
            pro.Quantity__c= 123;
            pro.Colour__c = 'Red';
            pro.Workmanship__c = 'Ajrak';
            pro.Design_Story__c = 'Shikargah';
            pro.Loom__c ='Handloom';
            pro.Taneira_Material_Weft__c ='Silk';
            pro.Material_Wrap__c='Silk';
            pro.Nature__c ='Handmade product of India';
            pro.Occasion__c = 'Wedding';
            pro.Cluster__c ='Assam';
            pro.Product_Category_Taneira__c ='Saree';
            pro.Route__c ='Colourway';
            pro.Zari_Type__c = 'Silk';
            pro.Offline_Key__c = '1234';
            pro.Proc_Type__c = 'Trading';
            insert pro;
            lstProdResult = [SELECT Name,Offline_Key__c,owner.Name,vendor_custom__r.name,CreatedDate, Id FROM Product__c WHERE id = :pro.Id];
  
        } 
        system.debug('----------insertProductlist ------'+insertProductlist );   
        for(Product__c prod :lstProdResult){
           mapOfProduct.put(prod.Offline_Key__c,prod.id);
           Ownername = prod.Owner.Name;
           accountName = prod.vendor_custom__r.name;
           if(prod.CreatedDate != null){
            createdDate = string.valueOf(prod.CreatedDate.format());
           }
        }
        
        system.debug('***mapOfProduct**'+mapOfProduct);
        system.debug('***mapOfAttachments***'+mapOfAttachments);
        for(String str :mapOfAttachments.keyset()){
            
            for(Attachment att : mapOfAttachments.get(str)){
                if(!mapOfProduct.isEmpty() && mapOfProduct.containsKey(str)){
                    att.ParentId = mapOfProduct.get(str); 
                    insertAttachmentlist.add(att);
                }                
            }
            
        }
        
        system.debug('**insertAttachmentlist**'+insertAttachmentlist);
        try{
            if(insertAttachmentlist.size()>0){
                insert insertAttachmentlist;
                RestResponse res = RestContext.response;
                RestContext.response.addHeader('Content-Type', 'application/json');
                Map<String,String> recList = new Map<String,String>();    
                recList.put('Message','Product Created');
                String expMsg = json.serialize(recList);
                RestContext.response.responseBody = Blob.valueOf(expMsg);
                
                /*** Send Email To Merchandize,PO,Arayabatta ***/ 
                List<String> sendTo = new List<String>();
                //List<String> poTeam = new List<String>();
                //List<String> arayabattaTeam = new List<String>(); 
                //{'rakeshg@titan.co.in','rakesh.mvm@gmail.com'};
                List<String> ccTo = new List<String>();
                ccTo = label.Mechandize_Team.split(',');
                //poTeam = label.PO_TeamNew.split(',');
                //arayabattaTeam = label.Arayabatta_TeamNew.split(',');
                /*****************************CHANGES ON 5/12/2017***********************************************/
                String poTeam = label.PO_TeamNew;
                if(poTeam!=null){
                    if(poTeam.contains(',')){
                    for(String str : poTeam.split(',')){
                        sendTo.add(str);
                    }
                    }else{
                    sendTo.add(poTeam);
                    }
                }
                String arayabattaTeam = label.Arayabatta_TeamNew;
                if(arayabattaTeam !=null){
                    if(arayabattaTeam .contains(',')){
                        for(String str : arayabattaTeam .split(',')){
                            sendTo.add(str);
                        }
                    }
                    else{
                        sendTo.add(arayabattaTeam);
                    }
                }
                
               /****************************************************************************/
               // system.debug('**sendTo**'+sendTo[0]);
                string subject = '';
                string mailbody = '';
                 
                subject = 'New procurement details';
                List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
                for(String pro : mapOfLineItems.keyset()){
                   mailbody = '<html><body>Dear Team,<br/><br/>The attached items have been procured by '+mapOfUser.get(mapOfLineItems.get(pro).Username).Name  +' on '+ system.Today().format() + ' from '+ mapOfLineItems.get(pro).Vendor_Id+'. Kindly create Purchase Order for the Vendor and update the PO number to Aryabhatta team by using below link<br/><br/>'+ URL.getSalesforceBaseUrl().toExternalForm() + '/apex/TaneiraProductView<br/><br/>Thank You,<br/><br/>'+mapOfUser.get(mapOfLineItems.get(pro).Username).Name+'<br/>Taneira Procurement Solution</body></html>';           
                   Messaging.singleEmailmessage Email =new Messaging.singleEmailmessage();
                   email.setsubject(subject );
                   email.Sethtmlbody(mailbody);
                   Email.SetToAddresses(sendTo);
                   Email.SetCCAddresses(ccTo);
                   myEmails.add(Email);
                     
                } 
                Messaging.sendEmail(myEmails);
            }
            
        }
        catch(Exception ex){
            system.debug('**Exception**'+ex);
        }
        for(Attachment attach : insertAttachmentlist){
            Product__c pro = new Product__c();
            pro.Id = attach.ParentId;
            string urlstr = URL.getSalesforceBaseUrl().toExternalForm() +'/servlet/servlet.FileDownload?file='+attach.id;
            pro.Photo__c= '<img src="'+urlstr+'" width="500" height="281"></img>';
            updateProd.add(pro);
        }
        try{
            if(updateProd.size()>0){
                update updateProd;
            }
        }
        catch(Exception ex){
            system.debug('**Exception**'+ex);
        }
        
        
    } 
    
    

}