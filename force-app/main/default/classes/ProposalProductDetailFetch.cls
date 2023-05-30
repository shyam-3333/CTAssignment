/*Created By : KVP- Chakresh Verma
* Name : orderProductDetailedComponent
* Created on : 10 Jan 2022
* Description : This Component is used to Show the Product Details and Multiple Images Of the Selected Product
*/

public class ProposalProductDetailFetch {
    
    @AuraEnabled
    public static List<LabelValueWrapper> fetchProductDetail(String productId, Boolean hidePriceFromDetail){
        
        List<LabelValueWrapper> mainWrapper = new List<LabelValueWrapper>();
        List<Product_Master__c> PmList = new List<Product_Master__c>();
        String recordTypeName = [Select RecordType.Name from Product_Master__c where Id =:productId LIMIT 1].RecordType.Name;
        String query = '';
        if(recordTypeName=='Eyewear'){
            query = 'Select Id,Name,Name__c,List_Price__c,Offer_Price__c,sku__c ,attribute_set_name__c ,price__c,sap_sku_id__c ,brand__c ,categories__c,description__c,disposable__c,frame_gender__c,frame_front_shape__c,front_color__c,frame_material__c,front_finish__c,Warranty_Period__c from Product_Master__c where Id =:productId';
            PmList = Database.query(query);
            Product_Master__c product = PmList[0];
            
            if(product.attribute_set_name__c == 'Sunglasses'){
                mainWrapper.add(new LabelValueWrapper('Sku',product.sku__c));
                if(!hidePriceFromDetail){
                    mainWrapper.add(new LabelValueWrapper('List Price',product.List_Price__c != null ?String.valueOf(product.List_Price__c.setScale(2)):'NA'));
                    mainWrapper.add(new LabelValueWrapper('Offer Price',product.Offer_Price__c != null?String.valueOf(product.Offer_Price__c.setScale(2)):'NA'));
                }
                
                mainWrapper.add(new LabelValueWrapper('Title',product.Name__c)) ;
                mainWrapper.add(new LabelValueWrapper('Brand',product.brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Category',product.attribute_set_name__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.frame_gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Shape',product.frame_front_shape__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Color',product.front_color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Material',product.frame_material__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Finish',product.front_finish__c)) ;
                mainWrapper.add(new LabelValueWrapper('Description',product.description__c)) ;
                return mainWrapper;                
            }
            else if(product.attribute_set_name__c == 'Accessories'){
                mainWrapper.add(new LabelValueWrapper('Sku',product.sku__c)) ;
                if(!hidePriceFromDetail){
                    mainWrapper.add(new LabelValueWrapper('List Price',product.List_Price__c != null ?String.valueOf(product.List_Price__c.setScale(2)):'NA'));
                    mainWrapper.add(new LabelValueWrapper('Offer Price',product.Offer_Price__c != null?String.valueOf(product.Offer_Price__c.setScale(2)):'NA'));
                }
                
                mainWrapper.add(new LabelValueWrapper('Title',product.Name)) ;
                mainWrapper.add(new LabelValueWrapper('Brand',product.brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Description',product.description__c)) ;
                return mainWrapper;                
            }
            else if(product.attribute_set_name__c == 'Contactlens'){
                mainWrapper.add(new LabelValueWrapper('Sku',product.sku__c)) ;
                if(!hidePriceFromDetail){
                    mainWrapper.add(new LabelValueWrapper('List Price',product.List_Price__c != null ?String.valueOf(product.List_Price__c.setScale(2)):'NA'));
                    mainWrapper.add(new LabelValueWrapper('Offer Price',product.Offer_Price__c != null?String.valueOf(product.Offer_Price__c.setScale(2)):'NA'));
                }
                
                mainWrapper.add(new LabelValueWrapper('Title',product.Name)) ;
                mainWrapper.add(new LabelValueWrapper('Brand',product.brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Category',product.attribute_set_name__c)) ;
                mainWrapper.add(new LabelValueWrapper('Disposable ',product.disposable__c)) ;
                mainWrapper.add(new LabelValueWrapper('Description',product.description__c)) ;
                return mainWrapper;                
            } 
            else if(product.attribute_set_name__c == 'Frames'){
                mainWrapper.add(new LabelValueWrapper('Sku',product.sku__c)) ;
                if(!hidePriceFromDetail){
                    mainWrapper.add(new LabelValueWrapper('List Price',String.valueOf(product.List_Price__c.setScale(2))));
                    mainWrapper.add(new LabelValueWrapper('Offer Price',String.valueOf(product.Offer_Price__c.setScale(2))));
                }
                
                mainWrapper.add(new LabelValueWrapper('Title',product.Name)) ;
                mainWrapper.add(new LabelValueWrapper('Brand',product.brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Category',product.attribute_set_name__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.frame_gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Shape',product.frame_front_shape__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Color',product.front_color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Material',product.frame_material__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Finish',product.front_finish__c)) ;
                mainWrapper.add(new LabelValueWrapper('Description',product.description__c)) ;
                return mainWrapper;                
            }
            else if(product.attribute_set_name__c == 'Lens Migrated'){
                mainWrapper.add(new LabelValueWrapper('Sku',product.sku__c)) ;
                if(!hidePriceFromDetail){
                    mainWrapper.add(new LabelValueWrapper('List Price',String.valueOf(product.List_Price__c.setScale(2))));
                    mainWrapper.add(new LabelValueWrapper('Offer Price',String.valueOf(product.Offer_Price__c.setScale(2))));
                }
                
                mainWrapper.add(new LabelValueWrapper('Title',product.Name)) ;
                mainWrapper.add(new LabelValueWrapper('Brand',product.brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Category',product.attribute_set_name__c)) ;
                mainWrapper.add(new LabelValueWrapper('Description',product.description__c)) ;
                return mainWrapper;                
            }
        }else if(recordTypeName=='Watches'){
            query = 'Select Id,Sellable_SKU__c,List_Price__c,Offer_Price__c,(Select Id,Offer_price__c,sku__c,List_Price__c from Product_SKUs1__r LIMIT 1),Product_Category__c,Type__c,Material_Lining__c ,Closure_Type__c,Weight_Grams__c ,Perfumer__c , Total_Pack_Weight_Grams__c,Shelf_Life__c,Compatible_Devices__c ,Included_Components__c, Driver__c,Battery_Average_Life__c ,Form_Factor__c ,Frame_Color__c,frame_material__c,Lens_Width__c,Special_Feature__c,Dial_Color__c,Function__c,Total_Length_Inches__c ,Buckle__c,Handle_Material__c ,Material__c,Depth_Inches__c,Material_Body__c ,color__c,Strap_Color__c,Strap_Material__c ,Title__c ,Short_Description__c,Long_Description__c,Base_Sku__c,Mother_Brand__c,Gender__c,Warranty_Period__c,Display_Brand__c ,attribute_set_name__c ,sap_sku_id__c ,brand__c ,categories__c,description__c,Lens_Color__c from Product_Master__c where Id =:productId LIMIT 1';
            system.debug('query'+query);//
            PmList = Database.query(query);
            Product_Master__c product = PmList[0];
            system.debug('PmList[0]'+PmList[0]);//
            List<Product_SKU__c> pro = new List<Product_SKU__c>();
            pro.addAll(product.Product_SKUs1__r); 
            mainWrapper.add(new LabelValueWrapper('Sku',product.Sellable_SKU__c));
            if(!hidePriceFromDetail){
                mainWrapper.add(new LabelValueWrapper('List Price',product.List_Price__c!= null?String.valueOf(product.List_Price__c.setScale(2)):'NA'));
                mainWrapper.add(new LabelValueWrapper('Offer Price',product.Offer_Price__c!= null?String.valueOf(product.Offer_Price__c.setScale(2)):'NA'));
            }
            
            if(product.Product_Category__c == 'Bags'){
                
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Color',product.Color__c )) ;
                mainWrapper.add(new LabelValueWrapper('Handle Material',product.Handle_Material__c )) ;
                mainWrapper.add(new LabelValueWrapper('Material Body',product.Material_Body__c )) ; 
                mainWrapper.add(new LabelValueWrapper('Bag Type',product.Type__c )) ; 
                mainWrapper.add(new LabelValueWrapper('Depth Inches',product.Depth_Inches__c )) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
            }else if(product.Product_Category__c == 'Belts'){
                
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Material',product.Material__c )) ;
                mainWrapper.add(new LabelValueWrapper('Color',product.Color__c )) ;
                mainWrapper.add(new LabelValueWrapper('Buckle',product.Buckle__c )) ; 
                mainWrapper.add(new LabelValueWrapper('Length',product.Total_Length_Inches__c )) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;	
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Clocks'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Color',product.Color__c )) ;
                mainWrapper.add(new LabelValueWrapper('Dial Color',product.Dial_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Body Material',product.Material_Body__c)) ;
                mainWrapper.add(new LabelValueWrapper('Special Features',product.Special_Feature__c)) ;
                mainWrapper.add(new LabelValueWrapper('Function',product.Function__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Computer Glasses'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Color',product.Frame_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Material',product.Frame_Material__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
                
            }
            else if(product.Product_Category__c == 'Earphones'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Compatible Devices',product.Compatible_Devices__c)) ;
                mainWrapper.add(new LabelValueWrapper('Included Components',product.Included_Components__c)) ;
                mainWrapper.add(new LabelValueWrapper('Driver',product.Driver__c)) ;
                mainWrapper.add(new LabelValueWrapper('Battery Average Life',product.Battery_Average_Life__c)) ;
                mainWrapper.add(new LabelValueWrapper('Form Factor',product.Form_Factor__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
                
            }
            else if(product.Product_Category__c == 'Face Mask'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
                
            }
            else if(product.Product_Category__c == 'Fragrances'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Perfumer',product.Perfumer__c)) ;
                mainWrapper.add(new LabelValueWrapper('Total Pack Weight Grams',product.Total_Pack_Weight_Grams__c)) ;
                mainWrapper.add(new LabelValueWrapper('Shelf Life',product.Shelf_Life__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Frames'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Color',product.Frame_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Material',product.Frame_Material__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                
                return mainWrapper;
                
                
            }
            else if(product.Product_Category__c == 'Gift Purchase'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Gift With Purchase'){//Data is Not there
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'GiftCard'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Pop Socket'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Reusable'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Type',product.Type__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
                
            }
            else if(product.Product_Category__c == 'Strap'){//Data is Not there
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Strap Color',product.Strap_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Strap Material',product.Strap_Material__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Straps'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Strap Color',product.Strap_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Strap Material',product.Strap_Material__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
                
            }
            else if(product.Product_Category__c == 'Sunglasses'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Color',product.Frame_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Frame Material',product.Frame_Material__c)) ;
                mainWrapper.add(new LabelValueWrapper('Lens Color',product.Lens_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Titan Sunglasses'){//Data is Not there
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
                
            }
            else if(product.Product_Category__c == 'Wallets'){ 
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Color',product.Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Material Lining',product.Material_Lining__c)) ;
                mainWrapper.add(new LabelValueWrapper('Closure Type',product.Closure_Type__c)) ;
                mainWrapper.add(new LabelValueWrapper('Weight Grams',product.Weight_Grams__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                
                return mainWrapper;
                
            }
            else if(product.Product_Category__c == 'Watches'){
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Title',product.Title__c)) ;
                mainWrapper.add(new LabelValueWrapper('Gender',product.Gender__c)) ;
                mainWrapper.add(new LabelValueWrapper('Strap Color',product.Strap_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Strap Material',product.Strap_Material__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Warranty Period',product.Warranty_Period__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;
                
            }
            return mainWrapper;
            
        }else if(recordTypeName=='Jewellery'){
            query = 'Select Id,Name,Sellable_SKU__c,List_Price__c,Offer_Price__c,(Select Id,Offer_price__c,sku__c,List_Price__c from Product_SKUs1__r LIMIT 1) ,sku__c ,Base_Sku__c,Gold_Karatage__c,Metal_Color__c,sap_sku_id__c ,Display_Brand__c ,collection__c,categories__c,Long_Description__c,Short_Description__c,Warranty_Period__c,description__c  from Product_Master__c where Id =:productId';
            PmList = Database.query(query);
            Product_Master__c product = PmList[0];
            List<Product_SKU__c> pro = new List<Product_SKU__c>();
            pro.addAll(product.Product_SKUs1__r); 
            mainWrapper.add(new LabelValueWrapper('Sku',product.Sellable_SKU__c));
            if(!hidePriceFromDetail){
                mainWrapper.add(new LabelValueWrapper('List Price',product.List_Price__c != null?String.valueOf(product.List_Price__c.setScale(2)):'NA'));
                mainWrapper.add(new LabelValueWrapper('Offer Price',product.Offer_Price__c != null?String.valueOf(product.Offer_Price__c.setScale(2)):'NA'));
            }
            
            
            if(product.categories__c == 'Gold Coin'){
                mainWrapper.add(new LabelValueWrapper('Title',product.Name)) ;
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Category',product.categories__c)) ;
                mainWrapper.add(new LabelValueWrapper('Collection',product.collection__c)) ;
                mainWrapper.add(new LabelValueWrapper('Metal Color',product.Metal_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;                
            }
            else if(product.categories__c == 'Silver coin'){
                mainWrapper.add(new LabelValueWrapper('Title',product.Name)) ;
                mainWrapper.add(new LabelValueWrapper('Brand',product.Display_Brand__c)) ;
                mainWrapper.add(new LabelValueWrapper('Category',product.categories__c)) ;
                mainWrapper.add(new LabelValueWrapper('Collection',product.collection__c)) ;
                mainWrapper.add(new LabelValueWrapper('Metal Color',product.Metal_Color__c)) ;
                mainWrapper.add(new LabelValueWrapper('Short Description',product.Short_Description__c)) ;
                mainWrapper.add(new LabelValueWrapper('Long Description',product.Long_Description__c)) ;
                return mainWrapper;                
            }
            return mainWrapper;
        }
        return null;
    }
    
    public class LabelValueWrapper{
        @AuraEnabled
        public String label  {get;set;}
        @AuraEnabled
        public String value   {get;set;}
        public LabelValueWrapper(String label, String value){
            this.label = label;
            this.value = value;
        }
    } 
}