/**************************************************
Name:RTWProductSourcingController
Author:Vindya
Description:This class is an controller for RTWSourcingvf .
******************/

public class RTWProductSourcingController {
    public Boolean checkSourcingUser{get;set;}
    public List<RTW_Product__c> RTWProductList {get;set;}   
    public String copyValue{get;set;}
    public Id vendorId {get;set;}
     public Map<Id,RTW_Product__c> RTWObjMap;
    public boolean selected1 {get;set;}
    public  String ProductKey {set;get;}
    public  String productTypeName {set;get;}
    //public static List<RTW_Pricing_Exception__c> RTWPricingexcpList{get;set;}    
    public List<RTWproductWrraper> RTWproductWrraperList {get;set;}
    public Map<Id,RTWproductWrraper> RTWproductWrraperMap {get;set;} 

    public  String selectedCategoryUser{get;set;}
    public List<selectoption>CategoryusersList{get;set;}
    public RTWProductSourcingController(){
        CategoryusersList();
        
        RTWProductList = new List<RTW_Product__c>();
        RTWproductWrraperList= new List<RTWproductWrraper>();
        RTWproductWrraperMap = new Map<Id,RTWproductWrraper>();
        vendorId = ApexPages.CurrentPage().getparameters().get('id');
        fetchData();       
        
    }
    Public void fetchData(){
        if(!Test.isRunningTest()){
            ProductKey=ApexPages.CurrentPage().getparameters().get('ProductKey');
            productTypeName=ApexPages.CurrentPage().getparameters().get('productTypeName');
        }
        checkSourcingUser = true;
        system.debug('ProductKey '+ProductKey);
        system.debug('productTypeName '+productTypeName);
        system.debug(' userInfo.getProfileId() : '+userInfo.getProfileId());
        if( userInfo.getProfileId()=='00e300000018x74AAA'|| UserInfo.getUserId()=='0055Y00000GrYwkQAF'){//giving access to harish kumar to select and submit for category for all rtw products
            system.debug('if admin or harish '+userInfo.getProfileId());
            RTWProductList=[Select id,Photo__c,SKU__c,Product__c,Body_Fit__c,Origin__c,Form__c,Warp__c,Weft__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                   Fabric__c,Size_LCD__c,Dimensions__c,ReadyGHERA_MT__c,MRP_Pc__c,Buyers_Cost__c,Silhouette__c,ReadyWaist_Inch__c, Submit__c,Ecom_Size__c,Submitted_Date__c,
                   ReadyLength_Inch__c,ReadyHip_Inch__c,DupattaDimensions__c,Dupatta_Type__c,BlouseSize_LCD__c,Occasion__c,MASK_DESCRIPTION__c,E_Com_Material__c,
                   Blouse_Type__c,SkirtPanels__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,
                   name,Duppatta__c,SLIP__c,Jacket__c,Kurta__c,Trouser__c, vendor_custom__c,vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,Handwork_Placement__c,Closure_Option__c,Handwork__c,Fabric_1__c,Fabric_2__c,Fabric_1_Quantity__c,Fabric_2_Quantity__c,
                   Neck_Type_Back__c,Neck_Type_Front__c,Opening_Type__c,Padding__c,RTW_SIZE__c,Sleeve_Fit__c,Sleeve_Length__c,SLEEVE_TYPE__c,Proc_type__c,Order_ID__c,
                   STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Hem_Back__c,Hem_Front__c,Loom__c,Body_Length__c,Bottom_Fabric__c,Top_Fabric__c,Style_Name__c,
                   Kurta_Fabric__c,Salwar_Fabric__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                   Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                   BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,Consumtion__c,Consumtion1__c,
                   MStyle_name__c,MDesign__c,MConstruction__c,MPleats__c,MPly__c,MCost__c,MFabric__c,owner.Name,Item_no__c,Pack_no__c,Remarks__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Product_Stage__c,Kurta_Description__c,
                   Vendot_style_code__c,CreatedBy.Name,ImageLink__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Assigned_sourcing_user__c,Assigned_To__c,OwnerId from RTW_Product__c where name=:ProductKey and Product__c=:productTypeName and RTW_Pricing_Submitted_Status__c!='Submitted'and Product_Stage__c='SOURCING' order by createddate Asc];
        }else{
            RTWProductList=[Select id,Photo__c,SKU__c,Product__c,Body_Fit__c,Origin__c,Form__c,Warp__c,Weft__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                   Fabric__c,Size_LCD__c,Dimensions__c,ReadyGHERA_MT__c,MRP_Pc__c,Buyers_Cost__c,Silhouette__c,ReadyWaist_Inch__c, Submit__c,Ecom_Size__c,Submitted_Date__c,
                   ReadyLength_Inch__c,Duppatta__c,SLIP__c,Jacket__c,Kurta__c,Trouser__c,ReadyHip_Inch__c,DupattaDimensions__c,Dupatta_Type__c,BlouseSize_LCD__c,Occasion__c,MASK_DESCRIPTION__c,E_Com_Material__c,
                   Blouse_Type__c,SkirtPanels__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,
                   name, vendor_custom__c,vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,Handwork_Placement__c,Closure_Option__c,Handwork__c,Fabric_1__c,Fabric_2__c,Fabric_1_Quantity__c,Fabric_2_Quantity__c,
                   Neck_Type_Back__c,Neck_Type_Front__c,Opening_Type__c,Padding__c,RTW_SIZE__c,Sleeve_Fit__c,Sleeve_Length__c,SLEEVE_TYPE__c,Proc_type__c,Order_ID__c,
                   STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Hem_Back__c,Hem_Front__c,Loom__c,Body_Length__c,Bottom_Fabric__c,Top_Fabric__c,Style_Name__c,
                   Kurta_Fabric__c,Salwar_Fabric__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                   Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                   BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,Consumtion__c,Consumtion1__c,
                   MStyle_name__c,MDesign__c,MConstruction__c,MPleats__c,MPly__c,MCost__c,MFabric__c,owner.Name,Item_no__c,Pack_no__c,Remarks__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Kurta_Description__c,
                   Vendot_style_code__c,CreatedBy.Name,ImageLink__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Assigned_sourcing_user__c,Assigned_To__c,OwnerId from RTW_Product__c where Assigned_sourcing_user__c=:userInfo.getUserId() and name=:ProductKey and Product__c=:productTypeName and RTW_Pricing_Submitted_Status__c!='Submitted'AND Product_Stage__c=:'SOURCING' order by createddate Asc];
            
        }
        system.debug('data'+RTWProductList);
        for(RTW_Product__c rtwp : RTWProductList){//cw
            RTWproductWrraperList.add(new RTWproductWrraper(rtwp, 0,0 ,rtwp.Assigned_To__c));   
            RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,0,0 ,rtwp.Assigned_To__c));
        }

    }
    public PageReference  doSubmit(){
        System.debug('Category user'+selectedCategoryUser);
        if(selectedCategoryUser==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Select Category User '));
            return null;
        }
        else{
            System.debug('Map values'+RTWproductWrraperMap);
            List<RTW_Product__c> RTWprodList = new List<RTW_Product__c>();
            for(RTWproductWrraper wrp :RTWproductWrraperMap.values()){
                  RTW_Product__c rtw = (RTW_Product__c)wrp.RTWproductRec;              
                 if( rtw.PO_Number__c!=null && rtw.MRP_Pc__c !=null || rtw.MCost__c!=null){
                   if(rtw.Product__c == 'MASK'){
                    rtw.MCost__c = wrp.RTWproductRec.MCost__c;
                }
                else{
                     rtw.MRP_Pc__c = wrp.RTWproductRec.MRP_Pc__c;
                }
                    rtw.Assigned_To__c =selectedCategoryUser;
                    System.debug('Category user'+selectedCategoryUser);
                     rtw.User_who_submitted_to_category__c=UserInfo.getUserName(); 
                    rtw.RTW_Pricing_Submitted_Date__c= system.now();
                    rtw.Product_Stage__c = 'CATEGORY';
                  if(rtw.MRP_Pc__c != null && rtw.Yardage_Cost__c != null){
                      //system.debug('Enter Condition 1');
                        rtw.Total_Costs__c = rtw.MRP_Pc__c + rtw.Yardage_Cost__c;
                    }
                  else if(rtw.MRP_Pc__c != null && rtw.Yardage_Cost__c == null){ 
                      //system.debug('Enter Condition 2');
                      rtw.Total_Costs__c = rtw.MRP_Pc__c;
                  }
                  else if(rtw.MRP_Pc__c == null && rtw.Yardage_Cost__c != null){ 
                      //system.debug('Enter Condition 3');
                      rtw.Total_Costs__c = rtw.Yardage_Cost__c;
                  }
                  else if(rtw.MRP_Pc__c == null && rtw.Yardage_Cost__c == null){ 
                      //system.debug('Enter Condition 4');
                      rtw.Total_Costs__c = 0;
                  }
                    RTWprodList.add(rtw);
                }
            }
            if(RTWprodList.size()>0 && RTWprodList != null){
                
                Integer itemNum = 1;
             List<RTW_product__share> jobShares = new List<RTW_product__share>();
            for(RTW_Product__c rtProd: RTWprodList)
            {
                rtProd.Item_no__c = itemNum;
                itemNum++;
                RTW_product__share shr= new RTW_product__share();
                shr.Parentid=rtProd.id;
                shr.UserOrGroupId=selectedCategoryUser;
                shr.AccessLevel = 'edit';
                shr.RowCause = 'Manual';
                jobShares.add(shr);
            }
            if(!jobShares.isempty()){
                Database.SaveResult[] jobShareInsertResult = Database.insert(jobShares,false);
                system.debug('###  jobShareInsertResult  :'+jobShareInsertResult);
            }
            upsert RTWprodList;
                
            
        }
            
         PageReference pageRef = new PageReference('/apex/RTWProductView');
            pageRef.getParameters().put('ProductKey', RTWprodList[0].name);
           pageRef.getParameters().put('productTypeName', RTWprodList[0].Product__c);
            pageRef.setRedirect(true);
             
            return pageRef; 
           
        }
    }
    
    public List<selectoption> CategoryusersList (){
        CategoryusersList= new List<selectoption>();
        CategoryusersList.add(new selectoption('','--None--'));
        for(user u :[Select id,name  from user where Profile.Name='Category' ]){
            CategoryusersList.add(new selectoption(u.id,u.Name));
            
        }
        
        return CategoryusersList;        
    }
    
    public void doSave(){
        system.debug('in save');
        List<RTW_Product__c> RTWprodList = new List<RTW_Product__c>();
        system.debug('RTWproductWrraperMap.values() =>'+RTWproductWrraperMap.values());
        for(RTWproductWrraper wrp :RTWproductWrraperMap.values()){
            RTW_Product__c rtw = (RTW_Product__c)wrp.RTWproductRec;
            if( rtw.PO_Number__c==null && (rtw.MCost__c!=null || rtw.MRP_Pc__c !=null) ){
                	     //rtw.PO_Number__c=wrp.RTWproductRec.PO_Number__c;
                if(rtw.Product__c == 'MASK'){
                    rtw.MCost__c = wrp.RTWproductRec.MCost__c;
                }
                else{
                     rtw.MRP_Pc__c = wrp.RTWproductRec.MRP_Pc__c;
                }
                    System.debug('Category user'+selectedCategoryUser);
                    //rtw.RTW_Pricing_Submitted_Date__c= system.now();
                    //rtw.Assigned_To__c =selectedCategoryUser;
                    rtw.Product_Stage__c = 'CATEGORY';
                      if(rtw.MRP_Pc__c != null && rtw.Yardage_Cost__c != null){
                      //system.debug('Enter Condition 1');
                        rtw.Total_Costs__c = rtw.MRP_Pc__c + rtw.Yardage_Cost__c;
                    }
                  else if(rtw.MRP_Pc__c != null && rtw.Yardage_Cost__c == null){ 
                      //system.debug('Enter Condition 2');
                      rtw.Total_Costs__c = rtw.MRP_Pc__c;
                  }
                  else if(rtw.MRP_Pc__c == null && rtw.Yardage_Cost__c != null){ 
                      //system.debug('Enter Condition 3');
                      rtw.Total_Costs__c = rtw.Yardage_Cost__c;
                  }
                  else if(rtw.MRP_Pc__c == null && rtw.Yardage_Cost__c == null){ 
                      //system.debug('Enter Condition 4');
                      rtw.Total_Costs__c = 0;
                  }
            }
            rtw.User_saved_in_sourcing__c=UserInfo.getUserName();
            RTWprodList.add(rtw);
        }
        if(RTWprodList.size()>0 && RTWprodList != null){
            system.debug('updated list'+RTWprodList);
            update RTWprodList;    
        }
        //return null;
    }
    public void doCopy(){
        System.debug('copy'+copyValue);
        if(copyValue == 'PO_Number__c'){
            for(RTWproductWrraper rtw : RTWproductWrraperMap.values()){
                rtw.RTWproductRec.PO_Number__c = RTWproductWrraperMap.values()[0].RTWproductRec.PO_Number__c;
            }
        }
        if(copyValue == 'MCost__c'){
            for(RTWproductWrraper rtw : RTWproductWrraperMap.values()){
                rtw.RTWproductRec.MCost__c = RTWproductWrraperMap.values()[0].RTWproductRec.MCost__c;
            }
        }
            if(copyValue == 'MRP_Pc__c'){
                for(RTWproductWrraper rtw : RTWproductWrraperMap.values()){
                    rtw.RTWproductRec.MRP_Pc__c = RTWproductWrraperMap.values()[0].RTWproductRec.MRP_Pc__c;
                }
            }
    }
   // }
    public class RTWproductWrraper{
        public RTW_Product__c RTWproductRec{get;set;}
        public Decimal PONumber {get;set;}
        public Decimal Procurementcost {get;set;}
       public String  SourcinguserId {get;set;}
        
        RTWproductWrraper(RTW_Product__c RTWproductRec,Decimal PONumber,Decimal Procurementcost,String SourcinguserId ){
            this.RTWproductRec=RTWproductRec;
            this.PONumber=PONumber;
            this.Procurementcost=Procurementcost;
            this.SourcinguserId=SourcinguserId;
        }
    }
    
}