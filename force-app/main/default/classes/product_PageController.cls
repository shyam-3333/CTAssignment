/*****
 * Created By :Poornapriya YN
    Description : Controller to create and update the Products for Taneira App
******/

global class product_PageController{

    Public string strRecTypeName {get; set;}
    public Transient blob image{get;set;} // to hold the value of attachment
     List<Product__c> productToUpdate = new List<Product__c>();
    public attachment attachImage{get;set;}
    List<attachment>AttachmentList;
    public boolean isLocked{get;set;}
    public boolean showdata{get;set;}
    public boolean isSku{get;set;}
    public boolean isSkuClone{get;set;}
    public boolean isSkuNew{get;set;}
    public boolean isClicked{get;set;}
    public Id attachId{get;set;}
    public string skuMessage{get;set;}
    public String prodctId {get;set;}
    public String prdPhotUrl {get;set;}
    private final Product__c prod;
    public Product__c prods {get;set;}
    string accId;
    string clickedBtn;
    public string attributeTeamId{get;set;}
    public string reordered {get;set;}
    public string productSource{get;set;}
    public string productCat{get;set;}
    String recordTypeId;
    string userTheme;
    string skuCode= '' ;
    public string oldProdid = '';
    
   public product_PageController(ApexPages.StandardController controller){
    Product__c each12 = new Product__c();
       list<Product__c>Prolist = new list<Product__c>();
        id strRecTypeid = apexpages.currentpage().getparameters().get('RecordType');
        if(strRecTypeid !=  null){
            Schema.DescribeSObjectResult d = Schema.SObjectType.Product__c; 
            Map<Id,Schema.RecordTypeInfo> rtMapById = d.getRecordTypeInfosById();
            strRecTypeName = rtMapById.get(strRecTypeid).getName();
          
          
          
        }
        isSkuNew = false;
        isSkuClone = false;
        system.debug('---isSkuClone --'+isSkuClone );
       isSku = false;
       isClicked = false;
     	List<Attachment> attachList = new List<Attachment>();
       userTheme = UserInfo.getUiThemeDisplayed();
       system.debug('userTheme==='+userTheme);
       system.debug('Url==='+URL.getSalesforceBaseUrl().toExternalForm());
       accId = ApexPages.currentPage().getParameters().get('AccontId');  
       productSource = ApexPages.currentPage().getParameters().get('Source');
       productCat = ApexPages.currentPage().getParameters().get('Category');
       clickedBtn = ApexPages.currentPage().getParameters().get('click');
       oldProdid = ApexPages.currentPage().getParameters().get('prodId');
       reordered = ApexPages.currentPage().getParameters().get('reorder');
       
       if(ApexPages.currentPage().getParameters().get('attId') != null && ApexPages.currentPage().getParameters().get('attId') != 'undefined') {
           
           attachId= ApexPages.currentPage().getParameters().get('attId');
       }

       prodctId =ApexPages.currentPage().getParameters().get('prodId');
       Product__c each1 = new Product__c();
       if(prodctId !=NULL){
        prods = [SELECT ID,Photo__c FROM Product__c WHERE Id =: prodctId];
           
       }
       String urStr,urlSt;
       if(prods !=NULL && prods.Photo__c != null){
          urlSt=prods.Photo__c;
          // urStr =urlSt.substring(urlSt.indexOf('src')+3,urlSt.indexOf('"'));
           prdPhotUrl = urlSt;
       }
       System.debug(':::prdPhotUrl::'+prods);
       
       system.debug('---accId --'+accId );
       this.prod = (Product__c)controller.getRecord();
       if(clickedBtn == 'savenew'){
           isClicked = True;
       }
       if(clickedBtn == 'saveclone' || clickedBtn == 'savenew'){
           isClicked = True;
       }
       if(oldProdid != '' && oldProdid != null){
           assignValueForFields(oldProdid);
                      
       }
       
       if(accId != '' && accId != 'null' && accId != null){
           system.debug('--accId--'+accId);
          prod.vendor_custom__c= accId;
       }
       attachImage = new Attachment();
       isLocked = false;
       AttachmentList = new List<Attachment>();
       if(prod.id!= null){   // Used when user clicks on edit button
           if(Approval.isLocked(prod.id)){
              isLocked = true; 
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Record Is Locked'));
              return;
           }
         
       }
       attributeTeamId = [SELECT Id FROM Profile WHERE  Name =: label.Attribution_Team].Id;
       recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id; 
       
       system.debug('*****attributeTeamId***'+attributeTeamId);
     
        
     
    }
    /******
            assignValueForFields method is used to clone the record or to update 
    ******/
    public void assignValueForFields(id productId){
        Product__c product = [SELECT Id,name,Photo__c,Design_Story__c,Story_1__c,Story_2__c,Design_Description__c,Silkmark__c,Washcare__c,Detailed_Colour__c,Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,
        Collection__c,Proc_Type__c,Blouse__c,Blouse_Size__c,Blouse_Type__c,Body_Des_Density__c,Body_Des_Element__c,Base_Colour__c,Pallu_Design__c,
                            Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Comments__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Product_Category_Taneira__c,Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,Warehouse_Stock__c,Sold_Stock__c,Store_Stock__c,
                            colour__c,Zari_Type__c,IHB__c,Cluster__c,Proc_Source__c,Fold__c,Design_Story_Others__c,vendor_custom__c,Cost__c,Procurement_Cost__c,Packing_Logistic_Cost__c,Quantity__c,Taneira_Material_Weft__c,Saree_Dimensions__c,Blouse_Dimensions__c  ,Material_Wrap__c,Article_Number__c,Design_Type__c,Created_From__c,Buyers_Cost__c 
                            FROM Product__c WHERE ID =: productId LIMIT 1];
        
             prod.Design_Story__c= product.Design_Story__c;
             prod.Design_Story_Others__c= product.Design_Story_Others__c;
             prod.Product_Category_Taneira__c= Product.Product_Category_Taneira__c;
             Prod.Nature__c= Product.Nature__c;
             Prod.Proc_Type__c = Product.Proc_Type__c;
             Prod.Occasion__c=  Product.Occasion__c;
             prod.Workmanship__c= product.Workmanship__c;
             prod.IHB__c= Product.IHB__c;
             prod.Story_1__c= product.Story_1__c;
             prod.Story_2__c = product.Story_2__c;
             prod.Design_Description__c = product.Design_Description__c;
             prod.Taneira_Material_Weft__c= product.Taneira_Material_Weft__c;
             prod.Material_Wrap__c= product.Material_Wrap__c;
             prod.Loom__c= product.Loom__c;
             prod.Base_Colour__c = product.Base_Colour__c;
             prod.Zari_Type__c= product.Zari_Type__c;
             prod.Cluster__c= product.Cluster__c;
             prod.vendor_custom__c = product.vendor_custom__c;
             prod.Buyers_Cost__c = product.Buyers_Cost__c;
             prod.Procurement_Cost__c= product.Procurement_Cost__c;
           //  prod.Cost__c= product.Cost__c;
           // prod.Packing_Logistic_Cost__c= product.Packing_Logistic_Cost__c;
             prod.Quantity__c= product.Quantity__c;
             prod.Comments__c = product.Comments__c ;
             prod.Suggested_MRP__c = product.Suggested_MRP__c;
             prod.Name = product.Name;
             prod.Saree_Dimensions__c = product.saree_Dimensions__c;
             prod.Blouse_Dimensions__c = product.Blouse_Dimensions__c;  
             prod.Silkmark__c = product.Silkmark__c;
             prod.Washcare__c = product.Washcare__c;
             prod.Detailed_Colour__c = product.Detailed_Colour__c;
             prod.Pallu_Des_Density__c = product.Pallu_Des_Density__c;
             prod.Pallu_Des_Material__c = product.Pallu_Des_Material__c;
             prod.Pallu_Pattern__c = product.Pallu_Pattern__c;
             prod.Pallu_Size__c = product.Pallu_Size__c;
             prod.Collection__c = product.Collection__c;
             prod.Blouse_Size__c = product.Blouse_Size__c;
             prod.Blouse_Type__c = product.Blouse_Type__c;
             prod.Body_Des_Density__c = product.Body_Des_Density__c;
             prod.Body_Des_Element__c = product.Body_Des_Element__c;
             prod.Body_Des_Material__c = product.Body_Des_Material__c;
             prod.Body_Pattern__c = product.Body_Pattern__c;
             prod.Border_Des_Element__c = product.Border_Des_Element__c;
             prod.Border_Des_Material__c=product.Border_Des_Material__c;
             prod.Border_Pattern__c=product.Border_Pattern__c;
             prod.Border_Size__c=product.Border_Size__c;
             prod.Proc_Source__c = product.Proc_Source__c;
             prod.Pallu_Design__c = product.Pallu_Design__c;
             prod.Warehouse_Stock__c=product.Warehouse_Stock__c;
             prod.Sold_Stock__c=product.Sold_Stock__c;
             prod.Store_Stock__c=product.Store_Stock__c;
             prod.Created_From__c = product.Created_From__c;
             
    }
   
    public string saveMethod(){
        integer countPro = 0;
        
       
        List<Attachment> attList= new List<Attachment>();
        Map<Id,String> attachMapProdId= new Map<Id,String>();
        String urlstr1;
        try{
            
          
            system.debug('===prod.Id==='+prod.Id);
            system.debug('===prod.re_order__c==='+prod.re_order__c);
            prod.recordTypeId= recordTypeId ; // Taneira recordType
            Prod.Product_Category_Taneira__c= productCat; 
            
            if(prod.id != null){
                // To update the photo field in re-order process
                system.debug('**inside if**');
                if(!test.isRunningTest()){
                        attList= [SELECT Id,parentId FROM Attachment WHERE ParentId = : prod.Id];
                
                if(attList != null){
                    for(Attachment att:attList){
                            urlstr1='';
                        if(!attachMapProdId.isEmpty() && attachMapProdId.containsKey(att.ParentId)){
                            
                          urlstr1 = '<img src="' + URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file=' + att.id + '" width="1000" height="622"></img>';
                          attachMapProdId.put(att.ParentId,attachMapProdId.get(att.ParentId)+','+urlstr1);
                        
                        }
                        if (att.parentId != NULL && !attachMapProdId.containsKey(att.parentId)) {
                            urlstr1 = '<img src="' + URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file=' + att.id + '" width="1000" height="622"></img>';
                            attachMapProdId.put(att.parentId, urlstr1);
                        }
                    }
                }
                
                }System.debug('=====urlstr1====>'+urlstr1);
                System.debug('=====attachMapProdId===='+attachMapProdId); 
                if(!attachMapProdId.isEmpty()){
                    for(Id eachId:attachMapProdId.keySet()){
                        prod.Id=eachId;
                        prod.Photo__c=attachMapProdId.get(eachId);
                        productToUpdate.add(prod);
                    }
                }
                    if(productToUpdate.size()>0 && productToUpdate.size()==1){
                        update productToUpdate;
                    }
                //system.debug('pro'+productToUpdate[0].CreatedDate);
                
                //update prod;
                
            } 
            
            else{
                insert prod; 
            }
           
            system.debug('--image--'+image);
            if(image != null && attachImage != null && !string.isBlank(attachImage.Name)){
           
                attachImage.body= image;
                attachImage.OwnerId = UserInfo.getUserId();
                system.debug('ParentId=='+prod.id);
                attachImage.ParentId = prod.id; // the record the file is attached to
                attachImage.IsPrivate = false;
                AttachmentList.add(attachImage);
                //insert attachImage;            
                   
           }
           if(AttachmentList.size()>0 ){
               insert AttachmentList;
               
           }
          //  system.debug('attachment ----'+AttachmentList);
           if(attachImage.id != null){
               string urlstr = URL.getSalesforceBaseUrl().toExternalForm() +'/servlet/servlet.FileDownload?file='+attachImage.id;
               prod.Photo__c= '<img src="'+urlstr+'" width="500" height="281"></img>';
           }
           
           system.debug('prod.Photo__c==='+prod.Photo__c);
           if(prod.Photo__c != null){
               update prod;
           }
           attachImage.clear();attachMapProdId.values().clear();
                  
        }
        
      catch(DMLException ex){
          String message;
            if(ex.getDmlMessage(0).contains('model')){
                system.debug('Message==='+ex.getDmlMessage(0));
                message = ex.getDmlMessage(0).replace('model','Product');
                system.debug('Message===hello '+ex.getDmlMessage(0));
                isClicked = false;
            }
            else{
                message=ex.getDmlMessage(0);
            }
          // system.debug('Exception===='+ex);
           //ApexPages.addMessages(ex);
           return message;
        }
        system.debug('skuMessage===='+skuMessage ); 
        return skuMessage;
    }
    
    public pageReference doCancel(){
        
        system.debug('accId==='+accId);
        system.debug('prod.id==='+prod.id);
        PageReference pr;
        if(productSource == 'New' && accId != '' && accId != 'null' && accId != null ){
            pr = new PageReference('/'+accId);
            pr.setRedirect(true);
            return pr;
        }
        else if(productSource != 'New' && prod.id!=null && accId == null ){
            pr = new PageReference('/'+prod.id);
            pr.setRedirect(true);
            return pr;
        }
        else{
            pr = new PageReference('/a18/o');
            pr.setRedirect(true);
            return pr;
        }
        return null;
               
    }
    // save and New Method
    public PageReference doSave(){
         integer count =0;
         PageReference pr;
         
         system.debug('isSkuNew ==='+isSkuNew ); 
         if(isSkuNew == true){
           
            pr = new PageReference('/apex/ProductPageSaree?Source=New&AccontId='+prod.vendor_custom__c+'&Category='+prod.Product_Category_Taneira__c +'&click=savenew');
            system.debug('pageReference==='+pr);
            pr.setRedirect(true);
            system.debug('pageReference===&&&'+pr);     
            return pr;
           
           }
        else{
            system.debug('isSkuNewInside else ==='+isSkuNew ); 
             string errMessage = saveMethod();
             if(!string.isBlank(errMessage)){
             system.debug('errMessage else ==='+errMessage); 
            if(errMessage.contains('same vendor at different price')){
                isSkuNew = true;
                system.debug('---diff cost----');
                 return null; 
            }
            else if(errMessage.contains('Same vendor with same price') ){
                system.debug('===Count==='+count);
                isSkuNew = true;
               
                return null;
                
            }
            else if(errMessage.contains('Same Product has earlier been procured from a different Vendor')){
                isSkuNew = true;
              
                system.debug('===Count==='+count);
                return null;
                
            }
            else{
                return null;
            }
        }
        else{
            count++;
        }
        
        if(prod.id != null && count>0 ){
            pr = new PageReference('/apex/ProductPageSaree?Source=New&AccontId='+prod.vendor_custom__c+'&Category='+prod.Product_Category_Taneira__c +'&click=savenew') ;
            pr.setRedirect(true);
            return pr;
        }
        }
        return null;
       
    }
  
    //Clone and Add Method
    public PageReference doClone(){
       // skuCodeGenerate();
       integer count = 0;
       PageReference pr;
       system.debug('isSkuClone==='+isSkuClone );
       if(isSkuClone == true){
           
            system.debug('Inside pr pageReference===');
            pr = new PageReference('/apex/ProductPageSaree?Source=New&AccontId='+prod.vendor_custom__c+'&Category='+prod.Product_Category_Taneira__c+'&prodId='+prod.id+'&click=saveclone');
            system.debug('pageReference==='+pr);
            pr.setRedirect(true);
            system.debug('pageReference===&&&'+pr);     
            return pr;
           
           }
       else{
           system.debug('Inside Else isSkuClone==='+isSkuClone );
           string errMessage = saveMethod();
           if(!string.isBlank(errMessage)){
           if(errMessage.contains('same vendor at different price')){
                
                isSkuClone = true;
                system.debug('---diff cost----');
               
                 return null; 
            }
            else if(errMessage.contains('Same vendor with same price') ){
                system.debug('===Count==='+count);
                isSkuClone = true;
               
                return null;
                
            }
            else if(errMessage.contains('Same Product has earlier been procured from a different Vendor')){
                isSkuClone = true;
               
                system.debug('===Count==='+count);
                return null;
                
            }
            else{
                return null;
            }
        }
        else{
            count++;
        }
        
        if(prod.id != null && count>0 ){
            Id ProductId = prod.id;
            pr = new PageReference('/apex/ProductPageSaree?Source=New&AccontId='+prod.vendor_custom__c+'&Category='+prod.Product_Category_Taneira__c+'&prodId='+prod.id+'&click=saveclone');
            system.debug('pageReference==='+pr);
            pr.setRedirect(true);
            system.debug('pageReference===&&&'+pr);     
           return pr;
           } 
       }
       
       return null;  
    }
    
    public pageReference saveProd(){
    
        integer count = 0;
        Pagereference pr;
        system.debug('inside save');
       // skuCodeGenerate();
       if(isSku == true){
                   
            system.debug('====Inside else issku==='+ isSku);
            pr = new PageReference('/'+prod.id);
            system.debug('pageReference==='+pr);
            pr.setRedirect(true);
            system.debug('pageReference===&&&'+pr);     
            return pr;
           
           }
       else{
        string errMessage = saveMethod();
        
        if(!string.isBlank(errMessage)){
            if(errMessage.contains('same vendor at different price')){
                isSku = true;
                system.debug('---diff cost----');           
                 return null; 
            }
            else if(errMessage.contains('Same vendor with same price') ){
                skuMessage = skuMessage + '. Click OK To discard the Product and Cancel to redirect.';
                isSku = True;
                system.debug('===Count==='+count);
             
                return null;
                
            }
            else if(errMessage.contains('Same Product has earlier been procured from a different Vendor')){
                isSku = true;         
                system.debug('===Count==='+count);
                return null;
                
            }
            else{
                return null;
            }
        }
        else{
            count++;
        }
        
        if(prod.id != null && count>0 ){
            pr = new PageReference('/'+prod.id);
            pr.setRedirect(true);
            return pr;
        }
        }
        return null;
        
    } 
    
     @RemoteAction
     global static prodWrapper getProduct(Id productId,string reorder) {
       
      // List<Product__c> prodListInsert = new List<Product__c>();
       Id TaneiraTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
       system.debug('**productId**'+productId);
       string attachId;
       Attachment attach;
       Attachment newAttach;
        Product__c product = [SELECT Id,name,Photo__c,Story_1__c,Story_2__c,Design_Description__c,Design_Story__c,SKU_Code__c,Silkmark__c,Washcare__c,Detailed_Colour__c,Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,
                            Collection__c,Proc_Type__c,Blouse__c,Blouse_Size__c,Blouse_Type__c,Body_Des_Density__c,Body_Des_Element__c,Base_Colour__c,Pallu_Design__c,Warehouse_Stock__c,Sold_Stock__c,Store_Stock__c,
                            Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Comments__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Product_Category_Taneira__c,Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,
                            colour__c,Zari_Type__c,Old_SKU_Actual_MRP__c,Actual_MRP__c,IHB__c,Parent__c,Proc_Source__c,Parent__r.SKU_Code__c,Cluster__c,fold__c,Design_Story_Others__c,vendor_custom__c,Cost__c,Procurement_Cost__c,Buyers_Cost__c,Packing_Logistic_Cost__c,Quantity__c,Taneira_Material_Weft__c,Saree_Dimensions__c,Blouse_Dimensions__c  ,Material_Wrap__c,Article_Number__c,Design_Type__C,Attribution_User_Email__c
                            FROM Product__c WHERE ID =: productId LIMIT 1];
        /*if(product.Photo__c != null){
            attachId = product.Photo__c.substringBetween('file=','"');
            attach = [SELECT ID,ContentType,Name,Body,IsPrivate,ParentId FROM Attachment where ParentId = : product.Id];
        }*/
        
        
        
        //system.debug('**attachId**'+attachId);
        if(Productid != null && reorder == 'yes'){
                 prodWrapper wrap = new prodWrapper();
                 Product__c newProduct = new Product__c();
                 if(product.Parent__c != null){
                     newProduct.Parent__c = product.Parent__c;
                     newProduct.Re_order_Ref__c = product.Parent__r.SKU_Code__c;
                     
                 }
                 else{
                     newProduct.Parent__c = product.Id;
                     newProduct.Re_order_Ref__c = product.SKU_Code__c;
                 }
                 newProduct.Design_Story__c= product.Design_Story__c;
                 newProduct.Design_Story_Others__c= product.Design_Story_Others__c;
                 newProduct.Product_Category_Taneira__c= Product.Product_Category_Taneira__c;
                 newProduct.Nature__c= Product.Nature__c;
                 newProduct.Proc_Type__c = Product.Proc_Type__c;
                 newProduct.IHB__c= Product.IHB__c;
                 newProduct.Occasion__c=  Product.Occasion__c;
                 newProduct.Workmanship__c= product.Workmanship__c;
                 newProduct.Taneira_Material_Weft__c= product.Taneira_Material_Weft__c;
                 newProduct.Material_Wrap__c= product.Material_Wrap__c;
                 newProduct.Loom__c= product.Loom__c;
                 newProduct.Blouse__C = Product.Blouse__c;
                 newProduct.Route__c= product.Route__c;
                 newProduct.colour__c = product.colour__c;
                 newProduct.Zari_Type__c= product.Zari_Type__c;
                 newProduct.Cluster__c= product.Cluster__c;
                 newProduct.vendor_custom__c = product.vendor_custom__c;
                 newProduct.Buyers_Cost__c = product.Buyers_Cost__c;
                 newProduct.Procurement_Cost__c= product.Procurement_Cost__c;
                // newProduct.Cost__c= product.Cost__c;
                // newProduct.Packing_Logistic_Cost__c= product.Packing_Logistic_Cost__c;
                 newProduct.Quantity__c= product.Quantity__c;
                 newProduct.Comments__c = product.Comments__c ;
                 newProduct.Suggested_MRP__c = product.Suggested_MRP__c;
                 newProduct.Name = product.Name;
                 newProduct.Saree_Dimensions__c = product.saree_Dimensions__c;
                 newProduct.Blouse_Dimensions__c = product.Blouse_Dimensions__c;
                 newProduct.RecordTypeId = TaneiraTypeId ;
                 newProduct.Base_Colour__c = product.Base_Colour__c;
                 newProduct.RE_ORDER__c = true;
                 newProduct.Old_SKU_Actual_MRP__c = product.Actual_MRP__c;
                 newProduct.Story_1__c= product.Story_1__c;
                 newProduct.Story_2__c = product.Story_2__c;
                 newProduct.Design_Description__c = product.Design_Description__c;
                 newProduct.Silkmark__c = product.Silkmark__c;
                 newProduct.Washcare__c = product.Washcare__c;
                 newProduct.Detailed_Colour__c = product.Detailed_Colour__c;
                 newProduct.Pallu_Des_Density__c = product.Pallu_Des_Density__c;
                 newProduct.Pallu_Des_Material__c = product.Pallu_Des_Material__c;
                 newProduct.Pallu_Pattern__c = product.Pallu_Pattern__c;
                 newProduct.Pallu_Size__c = product.Pallu_Size__c;
                 newProduct.Collection__c = product.Collection__c;
                 newProduct.Blouse_Size__c = product.Blouse_Size__c;
                 newProduct.Blouse_Type__c = product.Blouse_Type__c;
                 newProduct.Body_Des_Density__c = product.Body_Des_Density__c;
                 newProduct.Body_Des_Element__c = product.Body_Des_Element__c;
                 newProduct.Body_Des_Material__c = product.Body_Des_Material__c;
                 newProduct.Body_Pattern__c = product.Body_Pattern__c;
                 newProduct.Border_Des_Element__c = product.Border_Des_Element__c;
                 newProduct.Border_Des_Material__c=product.Border_Des_Material__c;
                 newProduct.Border_Pattern__c=product.Border_Pattern__c;
                 newProduct.Border_Size__c=product.Border_Size__c;
                 newProduct.Pallu_Design__c = product.Pallu_Design__c;
                 newProduct.Proc_Source__c = product.Proc_Source__c;
                 system.debug('**SKU_Code__c**'+product.SKU_Code__c);
                 newProduct.Warehouse_Stock__c=product.Warehouse_Stock__c;
                 newProduct.Sold_Stock__c=product.Sold_Stock__c;
                 newProduct.Store_Stock__c=product.Store_Stock__c;
            	 newProduct.Photo__c = product.Photo__c;
                 newProduct.Attribution_User_Email__c = product.Attribution_User_Email__c;
                
                // prodListInsert.add(newProduct); 
                 insert newProduct;
                 
                 if(attach != null){
                     newAttach = new Attachment();
                     newAttach.Name = attach.name;
                     newAttach.Body = attach.Body;
                     newAttach.ParentId = newProduct.Id;
                     newAttach.isPrivate = attach.isprivate;
                     
                     insert newAttach;
                     
                     
                 }
                 wrap.prodWrap = newProduct;
                 system.debug('**newAttach**'+newAttach);
                 if(newAttach != null && newAttach.id!= null){
                     string urlstr = URL.getSalesforceBaseUrl().toExternalForm() +'/servlet/servlet.FileDownload?file='+Attach.id;
                     wrap.reorderImg = '<img src="'+urlstr+'" width="1000" height="622"></img>';
                     wrap.attachmentId = newAttach.id;
                 }
                 system.debug('**wrap**'+wrap);
              //   update newProduct;
                 system.debug('**newProduct**'+newProduct);
                 return wrap;
              
       }
                   
        return null;
    }
    
    global class prodWrapper{
        public Product__c prodWrap {get;set;}
        public string reorderImg {get;set;}
        public Id attachmentId {get;set;}
        public prodWrapper(){
           prodWrap = new Product__c ();
           reorderImg = ''; 
           attachmentId = null;
        }
    }
     
}