public class TaneiraProdCategoryClass {
    public List<product__c> prodList{get;set;}
    public List<product__c> prdctLst;
    public List<product__c> prodListUpdated;
    public list<productWrraper> wrraperList{get;set;}
    public list<String> finalRecordSet{get;set;}
    public list<Taneira_View__c> taneiraViewList;
    public Double quantity {get;set;}
    public String param{get;set;}
    public string header{get;set;}
    public string headerUSKD{get;set;}
    public string csvOutput{get;set;}
    String productKey;
    String accId;
    String origin;
    public String Category{get;set;}
    String Createddate;
    public List<Multiplier_value__c> MultiplierList;
    public List<Multiplier_value__c> MultiplierLst{get;set;}
    public List<Multiplier_value__c> MultiplierLst1{get;set;}
    public List<Cost_band__c> costBandList{get;set;}
    public Boolean check{get;set;}
    public String CategoryUser{get;set;}
    public Boolean checkCategoryUser{get;set;}
    public String copyValue{get;set;}
    public Boolean check1{get;set;}
    public String SLno{get;set;}
    public Boolean checkColor{get;set;}
    //Constructor
    public TaneiraProdCategoryClass(){
        costBandList = Cost_band__c.getall().values();			//For Custom Object Cost_band__c data download
        MultiplierList = Multiplier_value__c.getall().values();//For Custom Object Multiplier_value__c data download
        MultiplierLst = new List<Multiplier_value__c>();
        MultiplierLst1 = new List<Multiplier_value__c>();
        MultiplierList = Multiplier_value__c.getall().values();
        for(Integer i = 0; i< 1000; i++){
            MultiplierLst1.add(MultiplierList[i]);
        }
        for(Integer i = 1000; i< MultiplierList.size(); i++){
            MultiplierLst.add(MultiplierList[i]);
        }
        
        checkColor = false;
        prdctLst = new List<product__c>();
        productKey = apexpages.currentpage().getparameters().get('ProductKeyFinder');
        accId = apexpages.currentpage().getparameters().get('Vendor');
        origin = apexpages.currentpage().getparameters().get('Origin');
        Category = apexpages.currentpage().getparameters().get('Category');
        Createddate = apexpages.currentpage().getparameters().get('CDate');
        SLno = apexpages.currentpage().getparameters().get('serialnumber'); 
        date oldDate = Date.today().addDays(-15);
        prodListUpdated = new list<Product__c>();
        //   prodListExcel = new list<Product__c>();
        header = 'Id,Record Type,SKU,Product,Vendor,Vendor Prod Code,Proc Type,Proc Source,Origin,PO Number,Username,MRP,Cost,Warp,Weft,Design Story,Story 1,Story 2,Design Description,Base Colour,Detailed Colour,Quantity,Fabric,Zari Type,Loom,Occasion,Blouse Size,Blouse Type,Craft,Fold,Handloom Mark,Collection,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,Vendor Code,Warehouse Stock,Sold Stock,Store Stock,Order ID';
        
        if(prodList != null && prodList.size() > 0 && prodList[0].Product_Category_Taneira__c == 'USKD') {
            
            header = 'Id,Record Type,SKU,Product,Vendor,Vendor Prod Code,Proc Type,Proc Source,Origin,PO Number,Username,MRP,Cost,Dupatta Fabric,Kurta Fabric,Salwar Fabric,Design Story,Story 1,Story 2,Design Description,Base Colour,Detailed Colour,Quantity,Fabric,Zari Type,Loom,Occasion,Blouse Size,Blouse Type,Craft,Fold,Handloom Mark,Collection,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,Vendor Code,Warehouse Stock,Sold Stock,Store Stock,Order ID';
        }
        prodList = [Select Dupatta_Fabric__c,No_of_pieces__c,Kurta_Fabric__c,Salwar_Fabric__c,FabricR__c,CraftR__c,vendor_custom__r.Vendor_code__c,Id,Product_Key_Finder__c,Owner.Email,Story_1__c,Story_2__c,Design_Description__c,RecordTypeId,name,Photo__c,Proc_Source__c,OwnerId,Owner.Name,Design_Story__c ,Fold__c,Offline_Username__c,Product_Category_Taneira__c,Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,Actual_MRP_Update__c,Detailed_Colour__c,Fabric__c ,Collection_Update__c,Pallu_Size__c,Warehouse_Stock__c,Sold_Stock__c,Store_Stock__c,
                    Colour__c,Zari_Type__c,Cluster__c,vendor_custom__c,vendor_custom__r.name,Vendor_Name__c,Cost__c,Quantity__c,Base_Colour__c ,Taneira_Material_Weft__c,Pallu_Design__c,
                    Saree_Dimensions__c,Sync_Date__c,SKU_Code__c,Material_Wrap__c,CreatedDate,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,
                    Border_Des_Material__c,Border_Pattern__c,Blouse_Size__c,Blouse_Type__c,Border_Size__c,PO_Number__c,Body_Pattern_Update__c,Handloommark__c,Pallu_Des_Density__c,Comments__c,Pallu_Des_Material__c,Pallu_Pattern__c,Proc_Type__c,Order_Id__c,
                    Body_Des_Element_Update__c,Body_Des_Material_Update__c,Body_Des_Density_Update__c,Border_Pattern_Update__c,Border_Des_Material_Update__c,Border_Des_Element_Update__c,
                    Border_Size_Update__c,Pallu_Pattern_Update__c,Pallu_Design_Update__c,Pallu_Des_Material_Update__c,Pallu_Des_Density_Update__c,Pallu_Size_Update__c,Occasion_Update__c,Yardage_Cost__c,Procurement_Cost__c,Packing_Logistic_Cost__c, 
                    Design_Story_Update__c, Story_1_Update__c,Story_2_Update__c,Multiplier__c,Pricing_Comment__c,Sourcing_Type__c,Old_SKU_Actual_MRP__c,Buyers_Cost__c,MRP_Reco__c From Product__c
                    WHERE Product_Key_Finder__c =:productKey AND Created_From__c = 'Offline App' Order By SKU_Code__c ASC];
        System.debug('Debug prodList===>'+prodList);
        System.debug('ProdList Size=====>'+prodList.size());
        taneiraViewList = [SELECT Id, Product_Key_Finder1__c,Category_User__c,Assign_Back_date__c,Attribution_completed_date__c,APPD__c,Assign_Back_date2__c,Attribution_Pending_days__c,Category_completed_date__c,Category_pending_days__c,CPPD__c,createdDate FROM Taneira_View__c Where Product_Key_Finder1__c = :productKey ];
        system.debug('taneiraViewList:===='+taneiraViewList.size());
        if(taneiraViewList.size() > 0){
            if(taneiraViewList[0].Category_User__c != null){
                if(taneiraViewList[0].Category_User__c.substringBefore(',') == UserInfo.getUserId() || UserInfo.getUserId() == '00530000003Nll9AAC' ){
                    checkCategoryUser = true;
                }else{
                    checkCategoryUser = false;
                }
            }
        }
        //Assigning Suggeste_MRP to Actual_MRP when Actual MRP is equal to 0 or null.
        for(Product__c prd : prodList){
            if(prd.Actual_MRP_Update__c == null || prd.Actual_MRP_Update__c <= 0){
                prd.Actual_MRP_Update__c = prd.Suggested_MRP__c;
                system.debug('prd.Suggested_MRP__c'+prd.Suggested_MRP__c);
            }if(prd.Multiplier__c == null || prd.Multiplier__c <= 0){
                system.debug('Actual_MRP_Update__c==>'+prd.Actual_MRP_Update__c);
                system.debug('prd.Cost__c==>'+prd.Cost__c);
                if(prd.Actual_MRP_Update__c != null && prd.Cost__c != null && prd.Cost__c != 0){
                    prd.Multiplier__c = (prd.Actual_MRP_Update__c / prd.Cost__c).setScale(2);
                }
                
            }
        }
        wrraperList = new List<productWrraper>();
        String firstSubString;
        String secondSubString;
        if(!prodList.isEmpty()){
            for(Product__c prod: prodList){
                prodListUpdated.add(prod);
            }
        }
        System.debug('====Updated Prod List===>'+prodListUpdated);
        System.debug('====Updated Prod List Size===>'+prodListUpdated.size());
        System.debug('Again prodList size====>'+prodList.size());
        for(product__c pro : prodListUpdated){
            productWrraper proWrr = new productWrraper();
            if(!String.isBlank(pro.Photo__c) && pro.Photo__c !=NULL){
                firstSubString = pro.Photo__c.substringBetween('<img', 'img>');
                secondSubString = firstSubString.substringBetween('src="', '"');
                proWrr.imgLink = secondSubString.replace('amp;', '');
                
            }System.debug('::::proWrr.imgLink:::@@@@::: '+proWrr.imgLink);
            if(pro.Comments__c != null){
                
                proWrr.comments = pro.Comments__c.escapeCsv();
            }
            system.debug('**proWrr.comments**'+proWrr.comments);
            proWrr.productRec = pro;
            wrraperList.add(proWrr);
            system.debug('wrraper list data==>'+wrraperList);
            system.debug('checkk==>'+proWrr.productRec.Multiplier__c+proWrr.productRec.Id);
            system.debug('product data==>'+proWrr);
        }
        
        csvOutput = JSON.serialize(wrraperList);
        System.debug('Heap Size----->>'+csvOutput);
    }
    public pagereference downloadProducts(){
        
        finalRecordSet = new List<String>();
        List<String> tmp;
        
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
                
                tmp = new List<String>();
                tmp.add(wrap.productRec.Id);
                tmp.add(wrap.productRec.RecordTypeId);
                tmp.add(wrap.productRec.SKU_Code__c);
                
                if(prodList != null && prodList.size() > 0 && prodList[0].Product_Category_Taneira__c == 'USKD') {
                    
                    tmp.add(wrap.productRec.Product_Category_Taneira__c);
                }
                finalRecordSet.add(String.join(tmp, ','));
                
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
        
        //csvOutput =
        //csvOutput =  JSON.serialize(recordsSet);
        PageReference page = new PageReference('/apex/TnraProdDwnldPage');
        
        return page;
        
    }
    /* public pagereference downloadProductsPdf(){
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
PageReference page = new PageReference('/apex/ProductPDFDownloadPage1');

return page;

}*/
    /*  public void exportToexcel(){
for(Product__c prod: prodListUpdated){
// prodListExcel.add(prod);
}
} */
    /* public void dataUpdated(){
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
mailbody = '<html><body>Dear Team,<br/><br/>The attribution for the list of items procured by '+prod.owner.Name +' on '+ CreatedDate + ' from '+ prod.Account__r.name +' is now COMPLETE. Kindly refer the below link and PRICE the products.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/OfflineProductsPage?Account='+accId + '&Category='+category+'&CDate='+CreatedDate+'&Origin='+origin+'<br/><br/>Thank You,<br/>Aryabhatta for Taneira<br/>Taneira Procurement Solution</body></html>';
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


}*/
    /* public void priceUpdated(){
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
' from '+ prod.Account__r.name +' now ready for inwarding and tagging. The PO number for this list of item is ' + prod.PO_Number__c +'. Please refer the below link and kindly inward and tag when received.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/OfflineProductsPage?Account='+accId + '&Category='+category+'&CDate='+CreatedDate+'&Origin='+origin+'<br/><br/>Thank You,<br/>'+UserInfo.getname()+'<br/>Taneira Procurement Solution</body></html>';            
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
}*/
    
    /* public void poNumUpdated(){
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
mailbody = '<html><body>Dear Team,<br/><br/>The PO Number is updated for products procured by '+prod.owner.Name +' on '+ CreatedDate+ ' from '+ prod.Account__r.name +' <br/>Please refer the below link for the products.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/TaneiraProductView<br/><br/>Thank You,<br/>'+UserInfo.getname()+'<br/>Taneira Procurement Solution</body></html>';           
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
}*/
    public Messaging.SingleEmailMessage sendEmailMsg(string emailBody,String[] sendTo,String subj,String[] ccTo){
        Messaging.SingleEmailMessage newemail = new Messaging.SingleEmailMessage ();
        newemail.setHtmlBody(emailBody);
        newemail.setSubject(subj);
        newemail.setToAddresses(sendTo);  
        newemail.setCCAddresses(ccTo);
        return newemail;
    }
    //*************Start****************
    //Values should be update from Replica fields to Orginal fields.
    public PageReference doSubmit(){
        checkColor = true;
        check = true;
        check1 = true;
        Integer count = 0;
        prdctLst.clear();
        if(prodList.size()>0){
            for(product__c product: prodList){
                if(product.Actual_MRP_Update__c != Null && product.Actual_MRP_Update__c > 0 && product.Multiplier__c != null){
                    product.Collection__c = product.Collection_Update__c;
                    product.Body_Pattern__c = product.Body_Pattern_Update__c;
                    product.Body_Des_Element__c = product.Body_Des_Element_Update__c;
                    product.Body_Des_Material__c  = product.Body_Des_Material_Update__c;
                    product.Body_Des_Density__c = product.Body_Des_Density_Update__c;
                    product.Border_Pattern__c = product.Border_Pattern_Update__c;
                    product.Border_Des_Material__c = product.Border_Des_Material_Update__c;
                    product.Border_Size__c = product.Border_Size_Update__c;
                    product.Pallu_Pattern__c =  product.Pallu_Pattern_Update__c;
                    product.Pallu_Design__c = product.Pallu_Design_Update__c;
                    product.Pallu_Des_Material__c = product.Pallu_Des_Material_Update__c;
                    product.Pallu_Des_Density__c = product.Pallu_Des_Density_Update__c;
                    product.Pallu_Size__c = product.Pallu_Size_Update__c;
                    product.Border_Des_Element__c = product.Border_Des_Element_Update__c;
                    product.Occasion__c = product.Occasion_Update__c;
                    product.Design_Story__c = product.Design_Story_Update__c;
                    product.Story_1__c = product.Story_1_Update__c;
                    product.Actual_MRP__c = product.Actual_MRP_Update__c;
                    product.Story_2__c = product.Story_2_Update__c;
                    product.Category_Submitted_Date__c = system.today();
                    product.Pricing_date__c = datetime.now();	
                    prdctLst.add(product);
                }
                if(product.Multiplier__c < 1){
                    count++;
                }
            }
            if(prdctLst.size() != prodList.size() && count == 0){
                check = false; 
                check1 = true;
            }else if(count != 0 && prdctLst.size() == prodList.size() ){
                check = true; 
                check1 = false;
            }else if(prdctLst.size() != prodList.size() && count != 0){
                check = false; 
                check1 = false;
            }      
            else{
                update prdctLst;
                //This List of Taneira_View__c is used to update the page control field with Orignal value
                List<Taneira_View__c> taneiraViewLst = new List<Taneira_View__c>();
                for(Taneira_View__c taneiraView : taneiraViewList ){
                    taneiraView.Page_Control__c = 'Original';
                    taneiraView.Category_completed_date__c = datetime.now();
                    taneiraView.Pricing_completed__c = true;
                    if(taneiraView.Assign_Back_date__c == null && taneiraView.Assign_Back_date2__c == null){
                        DateTime CCD = taneiraView.Attribution_completed_date__c;
                        Date CCDV = date.newinstance(CCD.year(), CCD.month(), CCD.day());
                        integer PD = CCDV.daysBetween(date.today());
                        taneiraView.CPPD__c = PD;
                    }
                    else if(taneiraView.Assign_Back_date__c != null || taneiraView.Assign_Back_date2__c != null){
                        taneiraView.CPPD__c = taneiraView.Attribution_completed_date__c.daysBetween(date.today()) + taneiraView.CPPD__c;
                    }
                    taneiraViewLst.add(taneiraView);
                }
                update taneiraViewLst;
                PageReference pr = new PageReference('/apex/TaneiraViewAngularJSPage');
                return pr;
            }
        }return null;
    }
    //Partial Save to replica fields
    public void doSave(){
        update prodList;
    }
    //copy all the Actual MRP fields or Multiplier values
    public void copyAll(){
        /*
* ====Vydhyula Sruthi====Modified Date: 10/01/2020
* This method is used to copy the values to preceding rows. 
*/
        Map<Id,product__c> oldProdList = new MAP<Id,product__c>([SELECT id,Actual_MRP_Update__c,Cost__c,Multiplier__c FROM product__c WHERE Product_Key_Finder__c =:productKey]); 
        Decimal value = prodList[0].Actual_MRP_Update__c;
        Decimal value1 = prodList[0].Multiplier__c;
        Integer enter = 0;
        
        for(product__c prod: prodList ){
            if(copyValue == 'Actual_MRP_Update__c'){
                if(prod.Actual_MRP_Update__c != oldProdList.get(prod.Id).Actual_MRP_Update__c){
                    value = prod.Actual_MRP_Update__c;
                    enter = 1;
                }
                if(enter == 1){
                    prod.Actual_MRP_Update__c = value;
                }
            }
            if(copyValue == 'Multiplier__c'){ 
                if(prod.Multiplier__c != oldProdList.get(prod.Id).Multiplier__c){
                    enter = 1;
                    value1 = prod.Multiplier__c;
                }if(enter == 1){
                    prod.Multiplier__c = value1;
                }
            }
        }
        
    }
    //Depending on cost and Multiplier values Actual MRP should be updated. Vise-versa
    public void onKeyUpForMultiplier(){
        Decimal mul;
        Map<Id,product__c> oldProdList2 = new MAP<Id,product__c>([SELECT id,Actual_MRP_Update__c,Cost__c,Multiplier__c FROM product__c WHERE Product_Key_Finder__c =:productKey]);        
        for(product__c prod : prodList){  //newList

            if(oldProdList2.containsKey(prod.Id) && (prod.Actual_MRP_Update__c != oldProdList2.get(prod.Id).Actual_MRP_Update__c)){
                mul=prod.Actual_MRP_Update__c / prod.Cost__c ;
                prod.Multiplier__c = mul.setScale(2);
            }
            else if(oldProdList2.containsKey(prod.Id) && (prod.Multiplier__c != oldProdList2.get(prod.Id).Multiplier__c)){
                prod.Actual_MRP_Update__c = prod.Cost__c*prod.Multiplier__c;
            }
            else if(oldProdList2.containsKey(prod.Id) && (prod.Multiplier__c == oldProdList2.get(prod.Id).Multiplier__c) && (prod.Actual_MRP_Update__c == oldProdList2.get(prod.Id).Actual_MRP_Update__c)){
                prod.Multiplier__c = oldProdList2.get(prod.Id).Multiplier__c ;
                prod.Actual_MRP_Update__c = oldProdList2.get(prod.Id).Actual_MRP_Update__c;
        }     
        } 
        update prodList;
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
    }
    //On click of button Multiplier and cost band data sholud be downloaded in the excel format.
    public PageReference mrpMasterData(){
        System.debug('hai');
        PageReference pageRef = new PageReference('/apex/CustomSettingReportPDF');
        return pageRef;
    }
    public PageReference assignBack(){
        String ownerId = '';
        String categoryUserEmail = '';
        List<String> attributionUserEmail = new List<String>();
        String categoryUserName = '';
        String mailbody = '';
        List<string> emailList = new List<string>();
        list<Taneira_View__c> assinedBackList = new list<Taneira_View__c>();
        emailList.add('sfdcadmin@titan.co.in');
        for(Taneira_View__c taneiraView : [SELECT Id, Product_Key_Finder1__c,Attribution_completed_date__c,Assign_Back_date__c,APPD__c,Assign_Back_date2__c,Attribution_Pending_days__c,Category_completed_date__c,Category_pending_days__c,CPPD__c,CreatedDate FROM Taneira_View__c Where Product_Key_Finder1__c = :productKey ] ){
            taneiraView.Page_Control__c = 'Attribution';
            if(taneiraView.Assign_Back_date__c == null){
                taneiraView.Assign_Back_date__c = datetime.now();
                taneiraView.CPPD__c = taneiraView.Attribution_completed_date__c.daysbetween(date.today());
            }
            else if(taneiraView.Assign_Back_date__c != null && taneiraView.Assign_Back_date2__c == null){
                taneiraView.Assign_Back_date2__c = datetime.now();
                taneiraView.CPPD__c = taneiraView.Attribution_completed_date__c.daysbetween(date.today()) + taneiraView.CPPD__c;
            }
            assinedBackList.add(taneiraView);
        }
        if(assinedBackList.size()>0){
            update assinedBackList;
        }
        //**************************************************************************************************************************new
        for(Product__c pro :[Select Id,OwnerId,category_user_email__c,Attribution_User_Email__c from Product__c Where Product_Key_Finder__c = :productKey]){
            if(pro != null){
                if(pro.category_user_email__c != null){
                    categoryUserEmail = pro.category_user_email__c;
                }
                if(pro.Attribution_User_Email__c != null){
                    attributionUserEmail.add(pro.Attribution_User_Email__c);
                }           
            }
        }
        for(User us : [SELECT Id,Name FROM User Where Email =: categoryUserEmail And Name != null]){
            if(us != null){
                categoryUserName = us.Name;
            }
        }
        String table;
        table = '<table border="1"><tr><th>Vendor</th><th>Product Category</th><th>Origin</th><th>Total Quantity</th><th>Total Value</th></tr>';
        for(Taneira_View__c tv : [SELECT Id,Vendor_Acc_Name__c,Product_Category__c,Origin__c,Total_Value__c,Total_Quantity__c FROM Taneira_View__c Where Product_Key_Finder1__c = :productKey ] ){
            table = table + '<tr>'+'<td style="text-align:center;">'+tv.Vendor_Acc_Name__c+'</td>'+'<td style="text-align:center;">'+tv.Product_Category__c+'</td>'+'<td style="text-align:center;">'+tv.Origin__c+'</td>'+'<td style="text-align:center;">'+tv.Total_Quantity__c+'</td>'+'</td style="text-align:center;">'+tv.Total_Value__c+'</td>'+'</tr>';            
        }
        table = table+'</table>';
        mailbody = '<html><body>Hi Team,<br/><br/>Category user '+categoryUserName+' has assigned back the product to Attribution team.'+
            '<br/><br/>'+ table;
        if(categoryUserEmail != null || categoryUserEmail != ''){
            emailList.add(categoryUserEmail);            
        }
       // system.debug('attributionUserEmail : '+attributionUserEmail);
       // system.debug('emailList : '+emailList);
        if(attributionUserEmail.size() == 0)
        {
         attributionUserEmail.add('sfdcadmin@titan.co.in');
        }
        Messaging.SingleEmailMessage Msg = new Messaging.SingleEmailMessage();
        msg.setToAddresses(attributionUserEmail);
        msg.setCcAddresses(emailList);
        msg.Sethtmlbody(mailbody);
        msg.setSubject('Category team assigned back the Product');
        Messaging.sendEmail(new Messaging.SingleEmailmessage[] {msg});
        
        //**************************************************************************************************************************new
        PageReference pr = new PageReference('/apex/TaneiraViewAngularJSPage');
        return pr;
        
    }
    //***********END************************
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