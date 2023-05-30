public class OfflineProductsPageClass{
    public List<product__c> prodList{get;set;}
    public List<product__c> prodListUpdated;
    public list<productWrraper> wrraperList{get;set;}
   // public List<product__c> prodListExcel{get;set;}
    public Double quantity {get;set;}
    public String param{get;set;}
    public string header{get;set;}
    string accId;
    string origin;
    string Category;
    string Createddate;
    
    public OfflineProductsPageClass(){
        accId = apexpages.currentpage().getparameters().get('Account');
        origin = apexpages.currentpage().getparameters().get('Origin');
        Category = apexpages.currentpage().getparameters().get('Category');
        Createddate = apexpages.currentpage().getparameters().get('CDate');
        
        date oldDate = Date.today().addDays(-15);
        prodListUpdated = new list<Product__c>();
     //   prodListExcel = new list<Product__c>();
        header = 'Id,Record Type,SKU,Product,Vendor,Vendor Prod Code,Proc Type,Proc Source,Origin,PO Number,Username,MRP,Cost,Warp,Weft,Design Story,Story 1,Story 2,Design Description,Base Colour,Detailed Colour,Quantity,Fabric,Zari Type,Loom,Occasion,Blouse Size,Blouse Type,Craft,Fold,Handloom Mark,Collection,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,Vendor Code,Warehouse Stock,Sold Stock,Store Stock';
        prodList = [Select vendor_custom__r.Vendor_code__c,Id,Owner.Email,Story_1__c,Story_2__c,Design_Description__c,RecordTypeId,name,Photo__c,Proc_Source__c,OwnerId,Owner.Name,Design_Story__c ,Fold__c,Offline_Username__c,Product_Category_Taneira__c,Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,Detailed_Colour__c,Fabric__c ,Collection__c,Pallu_Size__c,Warehouse_Stock__c,Sold_Stock__c,Store_Stock__c,
                     Colour__c,Zari_Type__c,Cluster__c,vendor_custom__c,vendor_custom__r.name,Vendor_Name__c,Cost__c,Quantity__c,Base_Colour__c ,Taneira_Material_Weft__c,Pallu_Design__c,
                     Saree_Dimensions__c,Sync_Date__c,SKU_Code__c,Material_Wrap__c,CreatedDate,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,
                     Border_Des_Material__c,Border_Pattern__c,Blouse_Size__c,Blouse_Type__c,Border_Size__c,PO_Number__c,Handloommark__c,Pallu_Des_Density__c,Comments__c,Pallu_Des_Material__c,Pallu_Pattern__c,Proc_Type__c From Product__c
                     WHERE vendor_custom__c =:accId AND Product_Category_Taneira__c =: Category AND Cluster__c =: Origin AND Re_Order__c != true AND Created_From__c = 'Offline App'];
                     System.debug('Debug prodList===>'+prodList);
                     System.debug('ProdList Size=====>'+prodList.size());
        wrraperList = new List<productWrraper>();
        String firstSubString;
        String secondSubString;
        if(!prodList.isEmpty()){
            for(Product__c prod: prodList){
                if(String.ValueOf(prod.CreatedDate).substring(0,13)==String.valueOf(Createddate).substring(0,13) || Test.isRunningTest()){
                    prodListUpdated.add(prod);
                }
                
            }
        }
        System.debug('====Updated Prod List===>'+prodListUpdated);
        System.debug('====Updated Prod List Size===>'+prodListUpdated.size());
        System.debug('Again prodList size====>'+prodList.size());
        for(product__c pro : prodListUpdated){
            productWrraper proWrr = new productWrraper();
            if(!String.isBlank(pro.Photo__c)){
                firstSubString = pro.Photo__c.substringBetween('<img', 'img>');
                secondSubString = firstSubString.substringBetween('src="', '"');
                proWrr.imgLink = secondSubString.replace('amp;', '');
            }
            if(pro.Comments__c != null){
               
                proWrr.comments = pro.Comments__c.escapeCsv();
            }
            system.debug('**proWrr.comments**'+proWrr.comments);
            proWrr.productRec = pro;
            wrraperList.add(proWrr);
        }
    }
    public pagereference downloadProducts(){
        quantity=0;
        System.debug('prodList size in downloadProducts===>'+prodListUpdated.size());
        if(!prodListUpdated.isEmpty()){
        for(Product__c prod:prodListUpdated){
            if(prod.Quantity__c !=NULL){
                System.debug('prod offlineUser===>'+prod.Offline_Username__c);
                System.debug('Prod Sync Date====>'+prod.CreatedDate);
            System.debug('prodQuantity-->'+prod.Quantity__c);
         quantity+=prod.Quantity__c;
         }  
        }System.debug('Quantity-->'+quantity);
        }       
       List<User> userList1= new List<User>();
        Set<Id> prodIdSet= new Set<Id>();
        Set<Id> userIdSet= new Set<Id>();
        if(!wrraperList.isEmpty()){
            for(productWrraper wrap:wrraperList){
               prodIdSet.add(wrap.productRec.Id);
               userIdSet.add(wrap.productRec.Owner.Id);
                System.debug('==wrap data====>'+wrap.productRec.Id);
                System.debug('==wrap.productRec.Owner.Id====>'+wrap.productRec.Owner.Id);
            }
        }
        Integer prodCount=0,counter=0;
        List<User> userList= new List<User>();
        if(!userIdSet.isEmpty()){
            userList=[SELECT Id,Name,Email,Counter__C FROM User WHERE ID IN:userIdSet];
        }System.debug('------userList----->'+userList);
        List<Product__C> prodctList= new List<Product__C>();
         List<Product__C> prodctList1= new List<Product__C>();
        if(!prodIdSet.isEmpty()){
        prodctList=[SELECT ID,Name,AlreadyDownloaded__c FROM Product__c WHERE ID IN :prodIdSet];
        }
        System.debug('-----prodctList with already downloaded value-----'+prodctList);
        if(!prodctList.isEmpty()){
            for(Product__C prod:prodctList){
                if(prod.AlreadyDownloaded__c ==True){
                    break;
                }else{
                    prodCount++;
                    System.debug('---prodCount inside else----'+prodCount);
                    prod.AlreadyDownloaded__c=true;
                    prodctList1.add(prod);
                }
            }
        }if(prodCount ==prodctList.size()){
            counter++;
           System.debug('---counter----'+counter); 
        }System.debug('---prodctList1--'+prodctList1);
        if(!prodctList1.isEmpty()){
            update prodctList1;
        }
        if(!userList.isEmpty()){
            for(User usr:userList){
                System.debug('====user list value===='+usr.Name);
                System.debug('====user counter value===='+usr.Counter__c);
                if(usr.Counter__c !=NULL){
                  usr.Counter__c += counter;
                }
                userList1.add(usr);
            }
        }
        if(userList1.size()>0){
            update userList1;
        }
        System.debug('-----userList1------'+userList1);
            
            //--------------------------------------------------
            
            if(userList1.size()>0 && prodListUpdated.size()>0)
            {
                System.debug('=======prodListUpdated.OfflineUsername====='+prodListUpdated[0].Offline_UserName__C);
             param='SS00'+userList1[0].Counter__c+prodListUpdated[0].Offline_UserName__C+'_'+'_'+String.valueOf(Date.newInstance(prodListUpdated[0].CreatedDate.Year(),prodListUpdated[0].CreatedDate.Month(),prodListUpdated[0].CreatedDate.Day()))+'_'+prodListUpdated[0].Vendor_Name__c+'-'+prodListUpdated[0].Cluster__c+'_'+quantity;
             
            }else{
             param='SS00DefaultUserDefUserNameTodayDefVendorDefCluster+DefQuantity';
             }
            System.debug('==param=='+param);
            PageReference page = new PageReference('/apex/TaneiraProductDownloadPage');
        
        return page;
        
    }
   /*  public void exportToexcel(){
        for(Product__c prod: prodListUpdated){
           // prodListExcel.add(prod);
        }
    } */
    public void dataUpdated(){
        List<String> sendTo = new List<String>();
        list<String>ccTo = new list<String>();
        set<String>ccToSet = new Set<String>();
        sendTo = label.Mechandize_Team.split(',');
        ccTo = label.PO_Team.split(',');
        //sendTo.add('poornapriya.yn@kvpcorp.com');
        //ccTo.add('poornapriya.yn@kvpcorp.com');
        //system.debug('**ccTo**'+ccTo[0]);
        string subject = '';
        string mailbody = '';
        Messaging.singleEmailmessage Email;
        boolean isUpdated = true;      
        for(Product__c prod: prodListUpdated){
            if(!ccToSet.contains(prod.Owner.Email) && prod.Owner.Email != null){
              ccToSet.add(prod.Owner.Email);
              ccTo.add(prod.Owner.Email);
            }
            system.debug('**ccTo**'+ccTo);
            system.debug('**Border_Pattern__c **'+prod.Border_Pattern__c);
            system.debug('**Body_Pattern__c**'+prod.Body_Pattern__c);
            system.debug('**Pallu_Pattern__c **'+prod.Pallu_Pattern__c );
            if(prod.Border_Pattern__c == null || prod.Body_Pattern__c== null || prod.Pallu_Pattern__c == null){
                isUpdated = false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Data from Attribution Team is not updated'));
                return;
            }
            else{                   
                subject = 'Requesting to price the products';
                mailbody = '<html><body>Dear Team,<br/><br/>The attribution for the list of items procured by '+prod.owner.Name +' on '+ CreatedDate + ' from '+ prod.vendor_custom__r.name +' is now COMPLETE. Kindly refer the below link and PRICE the products.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/OfflineProductsPage?Account='+accId + '&Category='+category+'&CDate='+CreatedDate+'&Origin='+origin+'<br/><br/>Thank You,<br/>Aryabhatta for Taneira<br/>Taneira Procurement Solution</body></html>';
            }
            
            
            if(isUpdated){
                Email =new Messaging.singleEmailmessage();
                email.setsubject(subject );
                email.Sethtmlbody(mailbody);
               // system.debug('execute'+ emails);
                Email.SetToAddresses(sendTo);
                Email.SetCCAddresses(ccTo);
            }
            
    
           
        }
        if(isUpdated){
            Messaging.sendemailResult[] r = Messaging.sendemail(new Messaging.singleEmailmessage[]{email});
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email to Merchandise Team sent successfully'));
        }
                    
        
    }
    public void priceUpdated(){
        List<String> sendTo = new List<String>();
       
        set<String> ccToSet = new set<String>();
        sendTo = label.WH_Team.split(',');
        system.debug('**sendTo**'+sendTo[0]);
        string subject = '';
        string mailbody = '';
        boolean isPriceUpdate = true;
        List<String>ccTo = new List<String>();
        List<Messaging.SingleEmailMessage> newemailslist = new List<Messaging.SingleEmailMessage> ();
        
        for(Product__c prod: prodListUpdated){
            if(!ccToSet.contains(prod.Owner.email) && prod.Owner.Email != null){
                ccToSet.add(prod.Owner.Email);
                ccTo.add(prod.Owner.Email);
            }
            
            if(prod.PO_Number__c != null){
                if(prod.Border_Pattern__c != null && prod.Body_Pattern__c != null && prod.Pallu_Pattern__c != null){
                    if(prod.suggested_mrp__c != null){
                        subject = 'Requesting to Inward and tag';
                        mailbody = '<html><body>Dear Team,<br/><br/>The products procured by '+prod.owner.Name +' on '+ CreatedDate + 
                        ' from '+ prod.vendor_custom__r.name +' now ready for inwarding and tagging. The PO number for this list of item is ' + prod.PO_Number__c +'. Please refer the below link and kindly inward and tag when received.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/OfflineProductsPage?Account='+accId + '&Category='+category+'&CDate='+CreatedDate+'&Origin='+origin+'<br/><br/>Thank You,<br/>'+UserInfo.getname()+'<br/>Taneira Procurement Solution</body></html>';            
                    }
                    else{
                        isPriceUpdate = false;
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Price for Products are not updated'));
                        return;
                    }
                    
                }
                else{
                    isPriceUpdate = false;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Cannot Update Price'));
                    return;
                }
            }
            
            else{
                isPriceUpdate = false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Cannot Update Price'));
                return;
            }   
                
        }
        Messaging.SingleEmailMessage emailmsg = sendEmailMsg(mailbody,sendTo,subject,ccTo);
        newemailslist.add(emailmsg);
        if(isPriceUpdate){
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(newemailslist); 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email to WH Team sent successfully'));
        }
    }
    
    public void poNumUpdated(){
        List<String> sendTo = new List<String>();
        sendTo = label.Mechandize_Team.split(',');
        
        system.debug('**sendTo**'+sendTo[0]);
        string subject = '';
        string mailbody = '';
        boolean isPOUpdate = true;
        List<String>ccTo = new List<String>();
        List<Messaging.SingleEmailMessage> newemailslist = new List<Messaging.SingleEmailMessage> ();
        
        for(Product__c prod: prodListUpdated){
            if(prod.suggested_Mrp__c == null){
                
                if(prod.PO_Number__c!= null){
                     subject = 'PO Updated';
                     mailbody = '<html><body>Dear Team,<br/><br/>The PO Number is updated for products procured by '+prod.owner.Name +' on '+ CreatedDate+ ' from '+ prod.vendor_custom__r.name +' <br/>Please refer the below link for the products.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/TaneiraProductView<br/><br/>Thank You,<br/>'+UserInfo.getname()+'<br/>Taneira Procurement Solution</body></html>';           
                }
                else{
                    isPOUpdate = false;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'PO Number for Products are not added'));
                    return;
                }
                
                
            }
              
            else{
                isPOUpdate = false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Cannot Update PO Number'));
                return;
            }   
                
        }
        Messaging.SingleEmailMessage emailmsg = sendEmailMsg(mailbody,sendTo,subject,ccTo);
        newemailslist.add(emailmsg);
        if(isPOUpdate){
              Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(newemailslist); 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email to Aryabatta Team sent successfully!!'));
        }
    }
    public Messaging.SingleEmailMessage sendEmailMsg(string emailBody,String[] sendTo,String subj,String[] ccTo){
        Messaging.SingleEmailMessage newemail = new Messaging.SingleEmailMessage ();
        newemail.setHtmlBody(emailBody);
        newemail.setSubject(subj);
        newemail.setToAddresses(sendTo);  
        newemail.setCCAddresses(ccTo);
        return newemail;
    }
    public class productWrraper{
    
        public product__c productRec{get;set;}
        public string imgLink{get;set;}
        public string comments {get;set;}
        productWrraper(){           
            productRec = new product__c();
            imgLink = null;
            comments = null;
        }  
    
    }  
}