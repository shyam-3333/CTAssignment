public class RTWProdCategoryController {
    public Boolean checkCategoryUser{get;set;}
    public List<RTW_Product__c> RTWProductList {get;set;}   
    
    public static String copyValue{get;set;}
    public Id vendorId {get;set;}
    public Static String ProductKey {set;get;}
    public Static String productTypeName {set;get;}
    public static List<RTW_Pricing_Exception__c> RTWPricingexcpList{get;set;}    
    public List<RTWproductWrraper> RTWproductWrraperList {get;set;}
    public Map<Id,RTWproductWrraper> RTWproductWrraperMap {get;set;} 
    
    
    public RTWProdCategoryController(){
        Set<String> mulproduct = new Set<String>();
        Set<String> mulcraft = new Set<String>();
        Set<String> mulfabric = new Set<String>();
        Set<String> mulCollection = new Set<String>();
        RTWProductList = new List<RTW_Product__c>();
        RTWproductWrraperList= new List<RTWproductWrraper>();
        RTWproductWrraperMap = new Map<Id,RTWproductWrraper>();
        vendorId = ApexPages.CurrentPage().getparameters().get('id');
        if(!Test.isRunningTest()){
            
            
            ProductKey=ApexPages.CurrentPage().getparameters().get('ProductKey');
            productTypeName=ApexPages.CurrentPage().getparameters().get('productTypeName');
        }
        checkCategoryUser = true;
        if( userInfo.getProfileId()=='00e300000018x74AAA'){
            RTWProductList=[Select id,Name,SKU__c,Vendor_custom__r.Name,PO_Number__c,	Pricing_date__c,Base_Colour__c,Collection__c,Craft__c,Form__c,Quantity__c,Top_Fabric__c,Bottom_Fabric__c,Source__c,
                            Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Loom__c,Ecom_Size__c,E_com_Material__c,Style_Code__c,Zari__c,Description__c,Order_ID__c,
                            Remarks__c,CreatedBy.Name,Suggested_MRP__c,Actual_MRP__c,MCost__c,Actual_MRP_Update__c,Multiplier__c,Multiplier_Update__c,Product__c,Fabric__c,MFabric__c,Assigned_To__c,warp__c,weft__c from RTW_Product__c where name=:ProductKey and Product__c=:productTypeName and RTW_Pricing_Submitted_Status__c!='Submitted' order by createddate Asc];
        }else{
            RTWProductList=[Select id,Name,SKU__c,Vendor_custom__r.Name,PO_Number__c,	Pricing_date__c,Base_Colour__c,Collection__c,Craft__c,Form__c,Quantity__c,Top_Fabric__c,Bottom_Fabric__c,Source__c,
                            Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Loom__c,Ecom_Size__c,E_com_Material__c,Style_Code__c,Zari__c,Description__c,Order_ID__c,
                            Remarks__c,CreatedBy.Name,Suggested_MRP__c,Actual_MRP__c,Actual_MRP_Update__c,Multiplier__c,Multiplier_Update__c,Product__c,Fabric__c,MFabric__c,Assigned_To__c,warp__c,weft__c from RTW_Product__c where Assigned_To__c=:userInfo.getUserId() and name=:ProductKey and Product__c=:productTypeName and RTW_Pricing_Submitted_Status__c!='Submitted' order by createddate Asc];
            
        }
        
        
        for(RTW_Product__c rtwp : RTWProductList){
            mulproduct.add(rtwp.Product__c);
            mulcraft.add(rtwp.Craft__c);
            mulfabric.add(rtwp.MFabric__c);
            mulCollection.add(rtwp.Collection__c);
        }
        
        
        getAllExceptionvalue(mulproduct);
        List<RTW_Multiplier_Master__c> RTWMultiplierList=[Select id,Product_Category__c,Craft__c,Fabric__c,Collection__c,Multiplier_c__c from RTW_Multiplier_Master__c where Product_Category__c IN :mulproduct and( Craft__c	IN :mulcraft or Fabric__c IN :mulfabric or Collection__c IN :mulCollection) order by precedence__c asc];
        
        for(RTW_Product__c rtwp : RTWProductList){//cw
            Boolean check_2_and_3 = true;
            if(RTWMultiplierList.size() > 0){
                for(RTW_Multiplier_Master__c RTWMas : RTWMultiplierList){
                    //==================================================================================================================================================================
                    if(RTWMas.Product_Category__c.toLowercase()==rtwp.Product__c.toLowercase() && RTWMas.Craft__c.toLowercase()==rtwp.Craft__c.toLowercase() && RTWMas.Fabric__c.toLowercase()==rtwp.MFabric__c.toLowercase() && RTWMas.Collection__c.toLowercase()==rtwp.Collection__c.toLowercase()){                   
                        check_2_and_3=false;
                        decimal MRP=0.0;
                        
                        if(RTWMas.Multiplier_c__c !=null && rtwp.Total_Costs__c!=null){
                            MRP =double.valueof(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c);
                            
                            //Round off of MRP
                            for(RTW_Pricing_Exception__c pricing :RTWPricingexcpList){
                                if(MRP>pricing.Min__c && MRP<pricing.Max__c && pricing.SetNearestTo__c!=0){
                                    MRP=setNearestvalue(MRP,Integer.valueof(pricing.SetNearestTo__c));
                                    
                                }
                            }
                            system.debug('rtwp.Product__c '+rtwp.Product__c);
                            if(rtwp.Product__c == 'KURTA' || rtwp.Product__c == 'LEHENGA'){
                                RTWproductWrraperList.add(new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP-10,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3)-10,rtwp.Assigned_To__c));   
                                RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP-10,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3)-10,rtwp.Assigned_To__c));
                                
                            }
                            else if(rtwp.Product__c == 'BLOUSE'){
                                RTWproductWrraperList.add(new RTWproductWrraper(rtwp,
                                                                                RTWMas.Multiplier_c__c.setScale(3),
                                                                                MRP-1,
                                                                                MRP,
                                                                                RTWMas.Multiplier_c__c.setScale(3),
                                                                                (rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3)-1,
                                                                                rtwp.Assigned_To__c));   
                                RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,
                                                                                        RTWMas.Multiplier_c__c.setScale(3),
                                                                                        MRP-1,
                                                                                        MRP,
                                                                                        RTWMas.Multiplier_c__c.setScale(3),
                                                                                        (rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3)-1,
                                                                                        rtwp.Assigned_To__c));
                                
                            }
                            else{
                                RTWproductWrraperList.add(new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3),rtwp.Assigned_To__c));   
                                RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3),rtwp.Assigned_To__c));
                            }
                            
                        }
                        break;                                                                                                                                                                                                                                                                              
                    } //condition
                    //==================================================================================================================================================================
                    if(check_2_and_3==true){
                        
                        if(RTWMas.Product_Category__c.toLowercase() == rtwp.Product__c.toLowercase() && RTWMas.Collection__c.toLowercase() == rtwp.Collection__c.toLowercase() && RTWMas.Fabric__c.toLowercase() == 'DEFAULT' && RTWMas.Craft__c.toLowercase() == 'DEFAULT' ){               
                            decimal MRP=0.0;                   
                            if(RTWMas.Multiplier_c__c !=null && rtwp.Total_Costs__c!=null){
                                MRP =double.valueof(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c);
                                
                                
                                //Round off of MRP
                                for(RTW_Pricing_Exception__c pricing :RTWPricingexcpList){
                                    if(MRP>pricing.Min__c && MRP<pricing.Max__c && pricing.SetNearestTo__c!=0){
                                        MRP=setNearestvalue(MRP,Integer.valueof(pricing.SetNearestTo__c));
                                    }
                                }         
                                if(rtwp.Product__c == 'KURTA' || rtwp.Product__c == 'LEHENGA'){
                                    RTWproductWrraperList.add(new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP-10,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3)-10,rtwp.Assigned_To__c));   
                                    RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP-10,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3)-10,rtwp.Assigned_To__c));
                                }
                                if(rtwp.Product__c == 'BLOUSE'){
                                    RTWproductWrraperList.add(new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP-1,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3)-1,rtwp.Assigned_To__c));   
                                    RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP-1,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3)-1,rtwp.Assigned_To__c));
                                }
                                else {
                                    RTWproductWrraperList.add(new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3),rtwp.Assigned_To__c));   
                                    RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,RTWMas.Multiplier_c__c.setScale(3),MRP,MRP,RTWMas.Multiplier_c__c.setScale(3),(rtwp.Total_Costs__c*RTWMas.Multiplier_c__c).setScale(3),rtwp.Assigned_To__c));
                                }
                                
                            }
                            break;
                        }
                        
                        else {                     
                            decimal MRP=0.0;
                            
                            if(rtwp.Total_Costs__c!=null){
                                
                                MRP =double.valueof(rtwp.Total_Costs__c*0);         
                                
                                RTWproductWrraperList.add(new RTWproductWrraper(rtwp,
                                                                                0,
                                                                                MRP,
                                                                                MRP,
                                                                                0,
                                                                                (rtwp.Total_Costs__c*0),
                                                                                rtwp.Assigned_To__c));   
                                RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,
                                                                                        0,
                                                                                        MRP,
                                                                                        MRP,
                                                                                        0,
                                                                                        (rtwp.Total_Costs__c*0),
                                                                                        rtwp.Assigned_To__c));
                            }
                        }                            
                    } 
                } //for 2
            }  //if 
            else if(RTWMultiplierList.size() == 0){
                decimal MRP=0.0;               
                MRP =rtwp.Total_Costs__c != Null?double.valueof(rtwp.Total_Costs__c*0):0;         
                
                RTWproductWrraperList.add(new RTWproductWrraper(rtwp,0,MRP,MRP,0,(rtwp.Total_Costs__c != Null?double.valueof(rtwp.Total_Costs__c*0):0),rtwp.Assigned_To__c));   
                RTWproductWrraperMap.put(rtwp.Id, new RTWproductWrraper(rtwp,0,MRP,MRP,0,(rtwp.Total_Costs__c != Null?double.valueof(rtwp.Total_Costs__c*0):0),rtwp.Assigned_To__c));              
            }
        }  // for 1
    }
    public void getAllExceptionvalue(Set<String> mulproduct){
        RTWPricingexcpList=[Select id,Min__c,Max__c,SetNearestTo__c from RTW_Pricing_Exception__c where RTW_Product_Category__c IN :mulproduct];
    }
    public integer setNearestvalue(decimal MRP,Integer setnearestval){
        
        Integer afterNearest;
        if(MRP ==0){
            afterNearest=0;
            
        }else{
            
            decimal sb2 = Math.signum(MRP) * Math.floor(Math.abs(MRP)/setnearestval) * setnearestval;
            
            afterNearest=integer.valueof(sb2)+setnearestval;
        }
        return afterNearest;
    }
    
    public PageReference  doSubmit(){
        PageReference pageRef = new PageReference('/apex/RTWProductView');
        pageRef.setRedirect(true);
        List<RTW_Product__c> RTWprodList = new List<RTW_Product__c>();
        for(RTWproductWrraper wrp :RTWproductWrraperMap.values()){
            RTW_Product__c rtw = (RTW_Product__c)wrp.RTWproductRec;
            pageRef.getParameters().put('ProductKey', rtw.name);
            pageRef.getParameters().put('productTypeName', rtw.Product__c);
            if(wrp.ActualMRP !=null && wrp.ActualMRP !=0){
                if( rtw.Multiplier__c==null && rtw.Actual_MRP__c==null){
                    rtw.Multiplier__c=wrp.Multiplier;            
                    rtw.Actual_MRP__c=wrp.ActualMRP;
                    rtw.Multiplier_Update__c=wrp.Multiplier;
                    rtw.Actual_MRP_Update__c=wrp.ActualMRP;
                }else{
                    rtw.Multiplier_Update__c=wrp.Multiplier;
                    rtw.Actual_MRP_Update__c=wrp.ActualMRP;
                }
                if(rtw.Suggested_MRP__c == null){
                    rtw.Suggested_MRP__c=wrp.ActualMRP;    
                }
                rtw.Assigned_To__c = wrp.categoryuserId;
                rtw.RTW_Pricing_Submitted_Date__c= system.now();
                rtw.RTW_Pricing_Submitted_Status__c='Submitted';
                //rtw.Product_Stage__c = 'CATEGORY';
                RTWprodList.add(rtw);
                
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Actual MRP should not be Zero for '+rtw.name));
            }
        }
        if(RTWprodList.size()>0 && RTWprodList != null){
            
            update RTWprodList;  
            
        }
        
        return pageRef;
    }
    public PageReference doassignback(){
        List<RTW_Product__c> RTWprodList = new List<RTW_Product__c>();
        set<Id> assigedtouserIdset= new set<Id>();
        PageReference pageRef = new PageReference('/apex/RTWProdCategoryVf');
        pageRef.setRedirect(true);
        for(RTWproductWrraper wrp :RTWproductWrraperMap.values()){
            pageRef.getParameters().put('ProductKey', ProductKey);
            pageRef.getParameters().put('productTypeName', productTypeName);
            RTW_Product__c rtw = (RTW_Product__c)wrp.RTWproductRec;           
            rtw.Multiplier__c=null;            
            rtw.Actual_MRP__c=null;
            rtw.Multiplier_Update__c=null;
            rtw.Actual_MRP_Update__c=null;            
            rtw.Suggested_MRP__c=null;    
            rtw.Assigned_To__c=null;
            RTWprodList.add(rtw);
            assigedtouserIdset.add(rtw.Assigned_To__c);
        }
        if(RTWprodList.size()>0 && RTWprodList != null){
            update RTWprodList;    
        }
        List<RTW_product__share> sharerecords= [Select id,UserOrGroupId from RTW_product__share where UserOrGroupId IN :assigedtouserIdset];
        if(!sharerecords.isempty()){
            delete sharerecords;
        }
        return pageRef;
    }
    public PageReference onchangemultiplier(){
        
        for(RTWproductWrraper wrp :RTWproductWrraperMap.values()){
            RTW_Product__c rtw = (RTW_Product__c)wrp.RTWproductRec;
            if(rtw.Product__c == 'KURTA' || rtw.Product__c == 'LEHENGA'){
                wrp.ActualMRP= ((wrp.Multiplier*wrp.RTWproductRec.Total_Costs__c).setScale(3))-10;
            }
            else if(rtw.Product__c == 'BLOUSE'){
                wrp.ActualMRP= ((wrp.Multiplier*wrp.RTWproductRec.Total_Costs__c).setScale(3))-1;
            }
            else{
                wrp.ActualMRP= (wrp.Multiplier*wrp.RTWproductRec.Total_Costs__c).setScale(3);
            }
        }
        return null;
    }
    public PageReference onchangeActualMrp(){
        
        for(RTWproductWrraper wrp :RTWproductWrraperMap.values()){
            
            if(wrp.ActualMRP==0){
                wrp.Multiplier=0;
            }else{
                wrp.Multiplier= (wrp.ActualMRP/wrp.RTWproductRec.Total_Costs__c).setScale(3);   
            }            
        }
        return null;
    }
    public PageReference doSave(){
        List<RTW_Product__c> RTWprodList = new List<RTW_Product__c>();
        for(RTWproductWrraper wrp :RTWproductWrraperMap.values()){
            RTW_Product__c rtw = (RTW_Product__c)wrp.RTWproductRec;
            if( rtw.Multiplier__c==null && rtw.Actual_MRP__c==null){
                rtw.Multiplier__c=wrp.InitialMultiplier;            
                rtw.Actual_MRP__c=wrp.InitialActualMRP;
                rtw.Multiplier_Update__c=wrp.Multiplier;
                rtw.Actual_MRP_Update__c=wrp.ActualMRP;
            }else{
                rtw.Multiplier_Update__c=wrp.Multiplier;
                rtw.Actual_MRP_Update__c=wrp.ActualMRP;
            }
            if(rtw.Suggested_MRP__c == null){
                rtw.Suggested_MRP__c=wrp.ActualMRP;    
            }
            rtw.RTW_Pricing_Submitted_Date__c= system.now();
            rtw.RTW_Pricing_Submitted_Status__c='Submitted';
            
            RTWprodList.add(rtw);
        }
        if(RTWprodList.size()>0 && RTWprodList != null){
            update RTWprodList;    
        }
        
        
        return null;
    }
    public void copyAll(){
        
        Decimal value = 0.0;
        Integer enter = 0;
        
        for(RTWproductWrraper wrp : RTWproductWrraperList){
            RTW_Product__c prod=wrp.RTWproductRec;
            //  System.debug('prod Id : '+prod.Id);
            if(copyValue == 'Actual_MRP_Update__c'){
                if(enter ==0 ){
                    //   System.debug('Inside if');
                    //   System.debug('RTWproductWrraperMap : '+RTWproductWrraperMap.get(prod.Id).ActualMRP);
                    //   System.debug('2 : '+RTWproductWrraperMap.keySet());
                    value = RTWproductWrraperMap.get(prod.Id).ActualMRP;
                    wrp.Multiplier=RTWproductWrraperMap.get(prod.Id).Multiplier;
                    enter = 1;
                }
                if(enter==1){
                    RTWproductWrraperMap.get(prod.Id).ActualMRP = value;
                    //  System.debug('Value : '+value);
                    wrp.ActualMRP=value;
                    wrp.Multiplier=RTWproductWrraperMap.get(prod.Id).Multiplier;
                }
                onchangeActualMrp();
            }
            if(copyValue == 'Multiplier__c'){
                if(enter ==0 ){
                    value = RTWproductWrraperMap.get(prod.Id).Multiplier;
                    wrp.ActualMRP=RTWproductWrraperMap.get(prod.Id).ActualMRP;
                    enter = 1;
                }
                if( enter==1){
                    RTWproductWrraperMap.get(prod.Id).Multiplier = value;
                    wrp.Multiplier=value;
                    wrp.ActualMRP=RTWproductWrraperMap.get(prod.Id).ActualMRP;
                }               
                onchangemultiplier();                
            }
        }
        enter =0;
        value=0.0;        
    }
    
    public class RTWproductWrraper{
        public RTW_Product__c RTWproductRec{get;set;}
        public Decimal InitialMultiplier {get;set;}
        public Decimal InitialActualMRP {get;set;}
        public Decimal Multiplier {get;set;}
        public Decimal  ActualMRP {get;set;}
        public Decimal  SuggestedMRP {get;set;}
        public Id  categoryuserId {get;set;}
        
        RTWproductWrraper(RTW_Product__c RTWproductRec,Decimal Multiplier,Decimal  ActualMRP,Decimal SuggestedMRP,Decimal InitialMultiplier,Decimal InitialActualMRP,id categoryuserId ){
            this.RTWproductRec=RTWproductRec;
            this.InitialMultiplier=InitialMultiplier;
            this.InitialActualMRP=InitialActualMRP;
            this.Multiplier=Multiplier;
            this.ActualMRP=ActualMRP;
            this.SuggestedMRP=SuggestedMRP;
            this.categoryuserId=categoryuserId;
        }
    }
}