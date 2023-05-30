/*-------------------------------------------------
Created By :  Vindya Achar
Created Date : 19/09/2022
Company Name : KVP Business Solutions Pvt Ltd. 
Description:This class is an modified version of MM Logic  to capture MM details on the insertion of product from IPAD and update  data into Product object in the respective fields
--------------------------------------------------*/

public class TaneiraMMLogic {
    List<product__c> prodList = new list<Product__c>();
    public  void TaneiraMMLogicmethod(list<Product__c>prodList){ //This method will capture the required data based on certain condition using custom setting on the insertion of Product
        String datbase;
        String cntrlcode;
        String UOM;
        String proddata;
        List<TaneiraPO__c>  tanPO = new list<TaneiraPO__c>();
        tanPO = TaneiraPO__c.getall().values();
        List<ProductMMWrraper> mmWrapper = new List<ProductMMWrraper>();
        Map<String,String> prodWarp  = new Map<String,String>();//store the code based on  Warp from master object
        Map<String,String> prodOrigin = new Map<String,String>();//store the code based on  Origin from master object
        Map<String,String> tanHie = new Map<String,String>();// store the hierarchy code based on Product category from master object
        Map<String,Master__c> ctrlCode = new Map<String,Master__c>();//Store the control code from master object
        Map<String,String> unitMeasure = new Map<String,String>();// Store the unit of measure based on the Product category from master object
        Map<String,String> prodCategoryCode = new Map<String,String>(); // store the code based on the Product category from master object
        List<Master__c>masList = new List<Master__c>();
        Set<String> masterSet = new Set<String>();
        for(Product__c pro:prodList){
            masterSet.add(pro.Product_Category_Taneira__c);
            masterSet.add(pro.Material_Wrap__c);
            masterSet.add(pro.Cluster__c);
        }
    //    System.debug('masterSet'+masterSet);
        for(Master__c mas: [Select Name__c,Name,Code__c,Fabric_Code__c,Hierarchy_Code__c,X8Digit_Code__c,X6Digit_Code__c,Unit_of_Measure__c From Master__c where Name IN:masterSet]){
            if(mas.Name__c == 'Product Category' &&  mas.Code__c!= null){
                prodCategoryCode.put(mas.Name, mas.Code__c);
            }
            if(mas.Name__c == 'Warp' && mas.Fabric_Code__c!= null){
                prodWarp.put(mas.Name, mas.Fabric_Code__c);
            }
            if(mas.Name__c == 'Origin'  && mas.Code__c!= null){
                prodOrigin.put(mas.Name, mas.Code__c);
            }
            if(mas.Name__c == 'Product Category' && mas.Hierarchy_Code__c!= null){
                tanHie.put(mas.Name, mas.Hierarchy_Code__c);
            }
             if(mas.Name__c == 'Product Category' && mas.Unit_of_Measure__c!= null){
                unitMeasure.put(mas.Name, mas.Unit_of_Measure__c);
            }
        }
        for(Master__c mas: [select Name, X8Digit_Code__c, Active__c, X6Digit_Code__c from Master__c where Name__c = 'Control Code']){
            if(mas.Name!= null && mas.X8Digit_Code__c!= null && mas.X6Digit_Code__c!= null){
                ctrlCode.put(mas.Name, mas);
            }
        }
       
        for(product__c pro : prodList){
            ProductMMWrraper proMMWrr = new ProductMMWrraper();
            proMMWrr.proRec = pro;
            
            if(!tanPO.isEmpty()){
                proMMWrr.plant = tanPO[0].Name;
                proMMWrr.storageLocation = tanPO[0].Storage_Location__c;
                proMMWrr.profitCenter = tanPO[0].Profit_Center__c;
            }
         //   System.debug('prodCategoryCode'+prodCategoryCode);
            if((prodCategoryCode!= null) && (proMMWrr.proRec.Product_Category_Taneira__c!= null) && (proMMWrr.proRec.Product_Category_Taneira__c== 'Saree' || proMMWrr.proRec.Product_Category_Taneira__c== 'Stole' || proMMWrr.proRec.Product_Category_Taneira__c== 'Yardage' || proMMWrr.proRec.Product_Category_Taneira__c== 'Pavadai' || proMMWrr.proRec.Product_Category_Taneira__c== 'Shawl' || proMMWrr.proRec.Product_Category_Taneira__c== 'Dupatta')){
           //     System.debug('prodCategoryCode'+prodCategoryCode);
                String des = ' ';
                String data = '';
               
                if(proMMWrr.proRec.Product_Category_Taneira__c.length()>=1){
                    data   = proMMWrr.proRec.Product_Category_Taneira__c.toUpperCase();
                }
                if(prodCategoryCode.containsKey(proMMWrr.proRec.Product_Category_Taneira__c)){
                    des = des + prodCategoryCode.get(proMMWrr.proRec.Product_Category_Taneira__c);
                }
                
                if(proMMWrr.proRec.Cluster__c!= null && proMMWrr.proRec.Cluster__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_Of_Letters_For_Origin__c)){
                    des =  des + '-' + proMMWrr.proRec.Cluster__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_Of_Letters_For_Origin__c)).trim();
                }
                if(proMMWrr.proRec.Cluster__c!= null && proMMWrr.proRec.Cluster__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_Of_Letters_For_Origin__c)){
                    des = des + '-' + proMMWrr.proRec.Cluster__c.trim();
                }
                
                if(proMMWrr.proRec.Material_Wrap__c!= null && proMMWrr.proRec.Material_Wrap__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)){
                    des = des + '-' + proMMWrr.proRec.Material_Wrap__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)).trim();
                }
                if(proMMWrr.proRec.Material_Wrap__c!= null && proMMWrr.proRec.Material_Wrap__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)){
                    des = des + '-' + proMMWrr.proRec.Material_Wrap__c.trim();
                }
                
                if(proMMWrr.proRec.Taneira_Material_Weft__c!= null && proMMWrr.proRec.Taneira_Material_Weft__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)){
                    des = des + '-' + proMMWrr.proRec.Taneira_Material_Weft__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)).trim();
                }
                if(proMMWrr.proRec.Taneira_Material_Weft__c!= null && proMMWrr.proRec.Taneira_Material_Weft__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)){
                    des = des + '-' + proMMWrr.proRec.Taneira_Material_Weft__c.trim();
                }
                
                if(proMMWrr.proRec.Workmanship__c!= null && proMMWrr.proRec.Workmanship__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)){
                    des = des + '-' + proMMWrr.proRec.Workmanship__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)).trim();
                }
                if(proMMWrr.proRec.Workmanship__c!= null && proMMWrr.proRec.Workmanship__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)){
                    des = des + '-' + proMMWrr.proRec.Workmanship__c.trim();
                }
                
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Pure') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Pure').Value__c;
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Tested') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Tested').Value__c;
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Faux') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Faux').Value__c;
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('NIL') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('NIL').Value__c;
                }
                
               
                proMMWrr.materialDescription = des;
                datbase = des;
            }
            if((prodCategoryCode!= null) && (proMMWrr.proRec.Product_Category_Taneira__c!= null) && (proMMWrr.proRec.Product_Category_Taneira__c== 'USKD' || proMMWrr.proRec.Product_Category_Taneira__c== 'SSKD')){
                String des = ' ';
                if(prodCategoryCode.containsKey(proMMWrr.proRec.Product_Category_Taneira__c)){
                    des = des + prodCategoryCode.get(proMMWrr.proRec.Product_Category_Taneira__c);
                }
                
                if(proMMWrr.proRec.Cluster__c!= null && proMMWrr.proRec.Cluster__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_Of_Letters_For_Origin__c)){
                    des =  des + '-' + proMMWrr.proRec.Cluster__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_Of_Letters_For_Origin__c)).trim();
                }
                if(proMMWrr.proRec.Cluster__c!= null && proMMWrr.proRec.Cluster__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_Of_Letters_For_Origin__c)){
                    des = des + '-' + proMMWrr.proRec.Cluster__c.trim();
                }

                if(proMMWrr.proRec.Fabric__c!= null && proMMWrr.proRec.Fabric__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_fabric__c)){
                    des = des + '-' + proMMWrr.proRec.Fabric__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_fabric__c)).trim();
                }
                if(proMMWrr.proRec.Fabric__c!= null && proMMWrr.proRec.Fabric__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_fabric__c)){
                    des = des + '-' + proMMWrr.proRec.Fabric__c.trim();
                }
                if(proMMWrr.proRec.Workmanship__c!= null && proMMWrr.proRec.Workmanship__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_craft__c)){
                    des = des + '-' + proMMWrr.proRec.Workmanship__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_craft__c)).trim();
                }
                if(proMMWrr.proRec.Workmanship__c!= null && proMMWrr.proRec.Workmanship__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_craft__c)){
                    des = des + '-' + proMMWrr.proRec.Workmanship__c.trim();
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Pure') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Pure').Value__c;
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Tested') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Tested').Value__c;
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Faux') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Faux').Value__c;
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('NIL') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('NIL').Value__c;
                }
                 proMMWrr.materialDescription = des;
                datbase = des;
            }
            if((proMMWrr.proRec.Product_Category_Taneira__c!= null) && (proMMWrr.proRec.Product_Category_Taneira__c== 'SAREE' || proMMWrr.proRec.Product_Category_Taneira__c== 'Duppata' || proMMWrr.proRec.Product_Category_Taneira__c== 'Yardage' || proMMWrr.proRec.Product_Category_Taneira__c== 'Pavadai')){
                String hie = 'TA';
                String data = '';
                if(proMMWrr.proRec.Product_Category_Taneira__c.length()>=1){
                    data   = proMMWrr.proRec.Product_Category_Taneira__c.toUpperCase();
                }
                if(proMMWrr.proRec.Product_Category_Taneira__c.length()>= Integer.valueOf(Taneira_Product_Hierarchy__c.getValues(data).Number_of_letters_for_Product_Category__c)){
                    hie = hie + proMMWrr.proRec.Product_Category_Taneira__c.substring(0,Integer.valueOf(Taneira_Product_Hierarchy__c.getValues(data).Number_of_letters_for_Product_Category__c));
                }
                if(proMMWrr.proRec.Loom__c!= null && proMMWrr.proRec.Loom__c.length()>= Integer.valueOf(Taneira_Product_Hierarchy__c.getValues(data).Number_of_letters_for_loom__c)){
                    hie = hie + proMMWrr.proRec.Loom__c.substring(0,Integer.valueOf(Taneira_Product_Hierarchy__c.getValues(data).Number_of_letters_for_loom__c));
                }
                if(proMMWrr.proRec.Material_Wrap__c!= null && prodWarp!= null && prodWarp.containsKey(proMMWrr.proRec.Material_Wrap__c)){
                    hie = hie + prodWarp.get(proMMWrr.proRec.Material_Wrap__c);
                }
               hie = hie + '00009999';
           //     System.debug('prodOrigin'+prodOrigin);
                if(proMMWrr.proRec.Cluster__c!= null && prodOrigin!= null && prodOrigin.containsKey(proMMWrr.proRec.Cluster__c)){
                    hie = hie + prodOrigin.get(proMMWrr.proRec.Cluster__c);
                }
                hie = hie + 'L';
                proMMWrr.productHierarchy = hie;
                proddata = hie;
            }
            if((proMMWrr.proRec.Product_Category_Taneira__c!= null) && (proMMWrr.proRec.Product_Category_Taneira__c== 'USKD' || proMMWrr.proRec.Product_Category_Taneira__c== 'SSKD' || proMMWrr.proRec.Product_Category_Taneira__c== 'Stole')){
                String hie = 'TA';
                if(tanHie!= null && tanHie.containsKey(proMMWrr.proRec.Product_Category_Taneira__c)){
                    hie = hie + tanHie.get(proMMWrr.proRec.Product_Category_Taneira__c);
                }
                if(proMMWrr.proRec.Blouse_Type__c!= null){
                    hie = hie + Taneira_Blouse_Type__c.getValues(proMMWrr.proRec.Blouse_Type__c).Code__c;
                }
                hie = hie + '00009999TAL';
                proMMWrr.productHierarchy = hie;
                proddata = hie;
            }
            
            if(proMMWrr.productHierarchy!= null && proMMWrr.productHierarchy!= ''  && ctrlCode!= null && ctrlCode.containsKey(proMMWrr.productHierarchy.substring(2,7))){
                if(proMMWrr.proRec.Buyers_Cost__c!= null && proMMWrr.proRec.Buyers_Cost__c>=1000 && ctrlCode.get(proMMWrr.productHierarchy.substring(2,7)).Active__c== true){
                    proMMWrr.controlCode = ctrlCode.get(proMMWrr.productHierarchy.substring(2,7)).X8Digit_Code__c;
                    cntrlcode =proMMWrr.controlCode;
                }
            }
            if(proMMWrr.productHierarchy!= null  && ctrlCode!= null  && ctrlCode.containsKey(proMMWrr.productHierarchy.substring(2,7))){
                if(proMMWrr.proRec.Buyers_Cost__c!= null && proMMWrr.proRec.Buyers_Cost__c<1000 && ctrlCode.get(proMMWrr.productHierarchy.substring(2,7)).Active__c== true){
                    proMMWrr.controlCode = ctrlCode.get(proMMWrr.productHierarchy.substring(2,7)).X6Digit_Code__c;
                    cntrlcode =proMMWrr.controlCode;
                }
            }
            if((unitMeasure!= null) && (proMMWrr.proRec.Product_Category_Taneira__c!= null) && (unitMeasure.containsKey(proMMWrr.proRec.Product_Category_Taneira__c)) && (proMMWrr.proRec.Product_Category_Taneira__c== 'Scarf' || proMMWrr.proRec.Product_Category_Taneira__c== 'Multi Piece Saree' || proMMWrr.proRec.Product_Category_Taneira__c== 'Saree' || proMMWrr.proRec.Product_Category_Taneira__c== 'Stole' || proMMWrr.proRec.Product_Category_Taneira__c== 'Yardage' || proMMWrr.proRec.Product_Category_Taneira__c== 'Pavadai' || proMMWrr.proRec.Product_Category_Taneira__c== 'Shawl' || proMMWrr.proRec.Product_Category_Taneira__c== 'Dupatta' || proMMWrr.proRec.Product_Category_Taneira__c== 'USKD' || proMMWrr.proRec.Product_Category_Taneira__c== 'SSKD')){
                proMMWrr.unitOfMeasure = unitMeasure.get(proMMWrr.proRec.Product_Category_Taneira__c);
                UOM = proMMWrr.unitOfMeasure;
            }
            mmWrapper.add(proMMWrr);
        }
        List<product__c> attProdList = new List<product__c>();
        for(product__c product : prodList){ //This for loop will update the fields based on the data generated through custom settings from above method
            product.Material_description__c = datbase;
            product.Unit_of_Measure__c = UOM;
            product.Product_Hierarchy__c = proddata;
            product.Control_Code__c = cntrlcode;
            attProdList.add(product);
        }
    }
    public class ProductMMWrraper{ //Wrapper class to get the data from taneiraPO custom settings and data holding variables  for MM details.
        public product__c proRec{get;set;}
        public String plant{get;set;}
        public String storageLocation{get;set;}
        public String profitCenter{get;set;}
        public String materialDescription{get;set;}
        public String productHierarchy{get;set;}
        public String controlCode{get;set;}
        public String unitOfMeasure{get;set;}
        ProductMMWrraper(){
            proRec = new product__c();
        }
    }
}