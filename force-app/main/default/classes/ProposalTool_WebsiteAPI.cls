/* Class Name - ProposalTool_WebsiteAPI
* Description :- the class is used to send eyewear data to the 3rd party
* Created - 21/01/2022
* @author - Gaurav Singh/Anish Kumar Shaw
*/

@RestResource(urlMapping ='/ProposalToolAPI')
global class ProposalTool_WebsiteAPI {
    private static final Set<String> eyewearProductToSend = new Set<String>{'Sunglasses','Gift Card','GiftCard'};
    private static final Set<String> watchesProductToSend = new Set<String>{'Watches','Watch','Bags','Belts','Clock','Clocks','Computer Glasses','Computer Glass','Earphones','Face Mask','Fragrances','Sunglasses','Titan Sunglasses','Wallets','Gift Card','GiftCard'};
    private static final Set<String> jewelleryProductToSend = new Set<String>{'Gold Coin','Silver Coin','Gift Card','GiftCard'};
                
                
    public class ApiWrapper{
        public String businessType;
        public DateTime startDate;
        public DateTime endDate;
        public Integer totalRecordsAvailable;
        public Integer recordsSent;
        public Integer batchCount;
    }
    
    @HTTPPost
    global static void doPost(){
        String query;
        String query2;
        String eyeQuery;
        String jewelQuery;
        String watchesQuery;
        Integer numberOfJewels = 0;
        Integer numberOfWatches = 0;
        Integer numberOfeyewear = 0;
        //String SobjectApiName = 'Product_Master__c';
        //Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        //Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
        //tring commaSepratedFields = '';
        List<CBG_sales_Website__c> reqList;
        CBG_sales_Website__c newReq;
        List<CBG_sales_Website__c> reqListUpdated;
        List<Product_Master__c> prodToUpdate;
        String gold = 'Gold Coin';
        String silver = 'Silver Coin';
        String business;
        DateTime startD;
        DateTime endD;
        Integer batchC;
        List<EyewearWrapper> eyeWrrList;
        List<WatchesWrapper> watchWrrList;
        List<JewelleryWrapper> jewelWrrList;
        List<Product_Master__c> prodList = new List<Product_Master__c>();
        //List<Product_Master__c> prodCount = new List<Product_Master__c>();
        ResponseWrapper resp;
        
        String requestBody = RestContext.request.requestBody.toString();
        system.debug('**requestBody**'+requestBody);
        ApiWrapper wrapperList = new ApiWrapper();
        wrapperList = (ApiWrapper)System.Json.deserialize(requestBody, ApiWrapper.class);
        system.debug('wrapperList-----'+wrapperList);
        
        business = wrapperList.businessType;
        Integer d1 = wrapperList.startDate.day();
        Integer mo1 = wrapperList.startDate.month();
        Integer yr1 = wrapperList.startDate.year();
        startD = DateTime.newInstance(yr1, mo1, d1, 05, 30, 00);
        //startD = wrapperList.startDate;
        //endD = wrapperList.endDate;
        Integer d2 = wrapperList.endDate.day();
        Integer mo2 = wrapperList.endDate.month();
        Integer yr2 = wrapperList.endDate.year();
        endD = DateTime.newInstance(yr2, mo2, d2, 05, 29, 59);
        endD = endD.addDays(1);
        batchC = wrapperList.batchCount;
        
        reqList = [select id, name, Start_Date__c, End_Date__c, Business_Type__c, Number_of_Records_Sent__c, Number_of_Total_Records_Available__c, Time_of_System_Hit__c from CBG_sales_Website__c where Start_Date__c=:startD and End_Date__c=:endD and Business_Type__c=:business];
        
        /*for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }*/
        
        if(wrapperList.businessType == 'Eyewear'){
        eyeQuery = 'select sku__c,attribute_set_name__c,sap_sku_id__c,brand__c,categories__c,description__c,aplus_content__c,face_shape__c,acc_bridge_width__c,'+
                   'acc_front_shape__c,acc_lens_height__c,acc_lens_width__c,acc_size__c,acc_size_clip__c,frame_color_code__c,frame_design__c,frame_face_shape__c,'+
                   'frame_front_shape__c,frame_front_shape_label__c,frame_front_styling__c,frame_gender__c,frame_international__c,frame_lifestyle__c,frame_material__c,'+
                   'frame_material_desc__c,frame_parent_model__c,frame_size__c,frame_size_number__c,frame_type__c,frame_weight_without_lens__c,frame_weight_without_lens_no__c,'+
                   'front_color__c,front_color_user__c,front_color_user_sunglass__c,front_colour_pattern__c,front_finish__c,front_material_details__c,front_material_user__c,'+
                   'front_size__c,bestseller__c,new__c,sale__c,collection__c,contactlens_validity__c,country_of_manufacture__c,disposable__c,price__c,name__c,'+
                   'tax_class_id__c,thumbnail__c,url_key__c,url_path__c,virtual_tryon__c,virtual_try_on__c,updated_at__c,Offer_Price__c,List_Price__c,Sellable_SKU__c,final_price__c,images__c from Product_Master__c'+
                   ' where LastModifiedDate>= :startD and LastModifiedDate<= :endD and RecordType.Name= :business and Record_Sent__c = true and Product_To_Show__c = true and Is_Custom_Image__c = false and attribute_set_name__c in :eyewearProductToSend order by LastModifiedDate LIMIT :batchC';
                   
        numberOfeyewear = [Select Count() from Product_Master__c where LastModifiedDate>= :startD and LastModifiedDate<= :endD and RecordType.Name= :business and Record_Sent__c = true and Product_To_Show__c = true and Is_Custom_Image__c = false and attribute_set_name__c in :eyewearProductToSend];
        }
        
        if(wrapperList.businessType == 'Jewellery'){
            jewelQuery = 'select Base_Sku__c,Title__c,Short_Description__c,Long_Description__c,Brand_Code__c,Mother_Brand__c,Display_Brand__c,'+
                         'Gender__c,collection__c,Product__c,Wcs_Type__c,Business_Unit__c,Metal__c,Jewellery_Type__c,Gold_Karatage__c,Metal_Color__c,categories__c,Type__c,Height__c,Width__c,'+
                         'Surface_Finish__c,Finding__c,Unit__c,Coin_Weight__c,Occasion__c,No_Of_Diamonds__c,Diamond_Cut__c,Diamond_Clarity__c,Diamond_Color__c,Diamond_Shape__c,Diamond_Setting__c,'+
                         'Gs1_Stone_Name__c,Gs1_Qty__c,Gs1_Setting_Type__c,Gs1_Cut__c,Gs1_Shape__c,Gs2_Stone_Name__c,Gs2_Qty__c,Gs2_Setting_Type__c,Gs2_Cut__c,Gs2_Shape__c,Gs3_Stone_Name__c,Gs3_Qty__c,'+
                         'Gs3_Setting_Type__c,Gs3_Cut__c,Gs3_Shape__c,Gs4_Stone_Name__c,Gs4_Qty__c,Gs4_Setting_Type__c,Gs4_Cut__c,Gs4_Shape__c,Gs5_Stone_Name__c,Gs5_Qty__c,Gs5_Setting_Type__c,Gs5_Cut__c,'+
                         'Gs5_Shape__c,Other_Gemstones__c,Available__c,Published__c,Buyable__c,New_Arrival_Startdate__c,Discontinued_Date__c,Discounts_Ribbon__c,On_Sale_Ribbon__c,Online_Exclusive_Ribbon__c,'+
                         'New_Arrival_Ribbon__c,Occasion_Ribbon__c,Emi_Ribbon__c,Express_Delivery_Ribbon__c,Bopis_Ribbon__c,Ropis_Ribbon__c,Preorder_Ribbon__c,Collection_Ribbon__c,Ribbon_Tag__c,'+
                         'Bopis__c,Ropis__c,Cod__c,Dc__c,Emi__c,Express_Delivery__c,Issfs__c,Isreturnable__c,International_Eligible__c,International_Only__c,Prod_Qty_Threshold__c,Qty_Max_Threshold__c,'+
                         'International_Brand__c,Isfoc__c,Preorder__c,Advance__c,Backorder__c,Angleimages_Thumbnail_1__c,Angleimages_Thumbnail_2__c,Angleimages_Thumbnail_3__c,Angleimages_Thumbnail_4__c,'+
                         'Angleimages_Thumbnail_5__c,Angleimages_Thumbnail_6__c,Angleimages_Thumbnail_7__c,Angleimages_Thumbnail_8__c,Angleimages_Thumbnail_9__c,Angleimages_Thumbnail_10__c,'+
                         'Angleimages_Fullimage_1__c,Angleimages_Fullimage_2__c,Angleimages_Fullimage_3__c,Angleimages_Fullimage_4__c,Angleimages_Fullimage_5__c,Angleimages_Fullimage_6__c,'+
                         'Angleimages_Fullimage_7__c,Angleimages_Fullimage_8__c,Angleimages_Fullimage_9__c,Angleimages_Fullimage_10__c,Images_1__c,Images_2__c,Images_3__c,Images_4__c,Images_5__c,'+
                         'Images_6__c,Images_7__c,Images_8__c,Images_9__c,Images_10__c,Media_Thumbnail_1__c,Media_1__c,Image_360_Thumbnail_1__c,Image_360_1__c,Image_Small_1__c,Blackband_1_Title__c,'+
                         'Blackband_1_Value__c,Blackband_1_Image__c,Blackband_1_Description__c,Blackband_2_Title__c,Blackband_2_Value__c,Blackband_2_Image__c,Blackband_2_Description__c,'+
                         'Blackband_3_Title__c,Blackband_3_Value__c,Blackband_3_Image__c,Blackband_3_Description__c,Rental_Product__c,Best_Deal__c,new__c,High_End__c,Community__c,Regional_Name__c,'+
                         'Theme__c,Pendant_Height__c,Pendant_Width__c,Earring_Height__c,Earring_Width__c,Offer_Price__c,List_Price__c,Sellable_SKU__c from Product_Master__c'+
                         ' where LastModifiedDate>= :startD and LastModifiedDate<= :endD and RecordType.Name= :business and Record_Sent__c = true and Product_To_Show__c = true and Is_Custom_Image__c = false and categories__c in :jewelleryProductToSend order by LastModifiedDate LIMIT :batchC';
            
            numberOfJewels = [Select Count() from Product_Master__c where LastModifiedDate>= :startD and LastModifiedDate<= :endD and RecordType.Name= :business and Record_Sent__c = true and Product_To_Show__c = true and Is_Custom_Image__c = false and categories__c in :jewelleryProductToSend];
        }
        /*else{
            query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where LastModifiedDate>= :startD and  LastModifiedDate<= :endD and RecordType.Name= :business and Record_Sent__c = true order by LastModifiedDate LIMIT :batchC';
            query2 = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where LastModifiedDate>= :startD and  LastModifiedDate<= :endD and RecordType.Name= :business and Record_Sent__c = true';
        }*/
        if(wrapperList.businessType == 'Watches'){
        watchesQuery =  'select Base_Sku__c,Title__c,Short_Description__c,Long_Description__c,brand__c,Mother_Brand__c,Display_Brand__c,Gender__c,collection__c,Warranty_Period__c,Warranty_Details__c,'+
                        'Special_Feature__c,Product_Category__c,Top_Feature_1__c,Top_Feature_2__c,Top_Feature_3__c,Wcs_Type__c,Business_Unit__c,Brand_Id__c,Sub_Brand_Id__c,Sub_Brand__c,Function_Type__c,'+
                        'Function__c,Movement__c,Dial_Color__c,Dial_Color_Colorcode__c,Case_Shape__c,Case_Material__c,Case_Thickness_Mm__c,Case_Length6H_12H_Mm__c,Case_Width3H_9H_Mm__c,Strap_Color__c,Strap_Color_Colorcode__c,'+
                        'Strap_Material__c,Glass_Material__c,Lock_Mechanism__c,Water_Resistance__c,Occasion__c,Compression_Straps__c,Depth_Inches__c,Handle_Length_Inches__c,Handle_Material__c,Haul_Loop__c,'+
                        'Height_Inches__c,Internal_Organizer__c,Laptop_Holder__c,Laptop_Sleeve_Height_Inches__c,Laptop_Sleeve_Length_Inches__c,Laptop_Sleeve_Width_Inches__c,No_Of_Compartments__c,Padded_Grab_Handle__c,'+
                        'Pattern__c,Quick_Access_Pocket__c,Rain_Cover_Available__c,Shoulder_Strap_Length_Inches__c,Shoulder_Strap_Padding__c,Sternum_Strap__c,Strap_Padding_Thickness_Mm__c,Reflective_Accents__c,Back_Padding__c,'+
                        'Bottle_Holder__c,Waist_Strap__c,Width_Inches__c,Zipper_Brand__c,Length_Inches__c,Compatible_Laptop_Size_Inches__c,VolumeLitres__c,Material_Body__c,Material_Lining__c,Other_Features__c,'+
                        'Closure_Type__c,Smart_Features__c,Water_Resistant__c,Type__c,Branding__c,Weight_Grams__c,Color__c,Color_Colorcode__c,Total_Length_Inches__c,Buckle__c,'+
                        'Buckle_Finish__c,Width_Mm__c,Material__c,Characteristics__c,Dress_Code__c,Finish__c,Leather_Care__c,Tanning__c,Detachable_Strap__c,Cheque_Book_Holder__c,Gusset_Pocket__c,'+
                        'Height_Cm__c,Id_Card_Holder__c,Passport_Holder__c,Pen_Holder__c,Photo_Slot__c,Secret_Pocket__c,Sim_Card_Slot__c,Slip_Pocket__c,Bill_Compartment__c,Cc_Holder__c,Usb_Slot__c,Visiting_Card__c,'+
                        'Width_Cm__c,Zip_Compartment__c,Length_Cm__c,Coin_Pocket__c,Total_Pack_Weight_Grams__c,Family__c,Perfumer__c,Quantity__c,Shelf_Life__c,Fragrances_Included__c,Fragrance_Type__c,No_Of_Bottles_In_A_Pack__c,'+
                        'Outer_Pack_Height_Mm__c,Outer_Pack_Length_Mm__c,Outer_Pack_Width_Mm__c,Product_Care__c,Available__c,Published__c,Buyable__c,New_Arrival_Startdate__c,Discontinued_Date__c,Discounts_Ribbon__c,'+
                        'On_Sale_Ribbon__c,Online_Exclusive_Ribbon__c,New_Arrival_Ribbon__c,Emi_Ribbon__c,Express_Delivery_Ribbon__c,Bopis_Ribbon__c,Ropis_Ribbon__c,Preorder_Ribbon__c,Function_Ribbon__c,'+
                        'Collection_Ribbon__c,Sub_Function_Ribbon__c,Style_Ribbon__c,Strap_Material_Ribbon__c,Ribbon_Tag__c,Bopis__c,Ropis__c,Cod__c,Dc__c,Emi__c,Discount_Facet__c,Express_Delivery__c,'+
                        'Issfs__c,Isreturnable__c,International_Eligible__c,International_Only__c,Prod_Qty_Threshold__c,International_Brand__c,Isfoc__c,Preorder__c,Advance__c,Backorder__c,Angleimages_Thumbnail_1__c,'+
                        'Angleimages_Thumbnail_2__c,Angleimages_Thumbnail_3__c,Angleimages_Thumbnail_4__c,Angleimages_Thumbnail_5__c,Angleimages_Thumbnail_6__c,Angleimages_Thumbnail_7__c,Angleimages_Thumbnail_8__c,'+
                        'Angleimages_Thumbnail_9__c,Angleimages_Thumbnail_10__c,Angleimages_Fullimage_1__c,Angleimages_Fullimage_2__c,Angleimages_Fullimage_3__c,Angleimages_Fullimage_4__c,Angleimages_Fullimage_5__c,'+
                        'Angleimages_Fullimage_6__c,Angleimages_Fullimage_7__c,Angleimages_Fullimage_8__c,Angleimages_Fullimage_9__c,Angleimages_Fullimage_10__c,Images_1__c,Images_2__c,Images_3__c,Images_4__c,'+
                        'Images_5__c,Images_6__c,Images_7__c,Images_8__c,Images_9__c,Images_10__c,Media_Thumbnail_1__c,Media_1__c,Image_360_Thumbnail_1__c,Image_360_1__c,Image_Small_1__c,Blackband_1_Title__c,'+
                        'Blackband_1_Value__c,Blackband_1_Image__c,Blackband_1_Description__c,Blackband_2_Title__c,Blackband_2_Value__c,Blackband_2_Image__c,Blackband_2_Description__c,Blackband_3_Title__c,'+
                        'Blackband_3_Value__c,Blackband_3_Image__c,Blackband_3_Description__c,Bridge_Width__c,Frame_Color__c,frame_design__c,face_shape__c,Frame_Shape__c,frame_material_desc__c,Material_Description__c,'+
                        'frame_size__c,frame_type__c,Weight_Without_Lens__c,Lens_No__c,front_color__c,front_finish__c,front_material_details__c,Hinge__c,Lens_Color__c,Lens_Design__c,Lens_Height_Description__c,'+
                        'Lens_Height__c,Lens_Material__c,Lens_Shape__c,Lens_Technology__c,Lens_Width__c,Bridge_Type__c,Temple_Color__c,Temple_Finish__c,Temple_Length__c,Temple_Material__c,Temple_Design__c,Model_Number__c,'+
                        'Form_Factor__c,Item_Weight__c,Product_Dimension__c,Batteries__c,Battery_Capacity__c,Compatible_Devices__c,Driver__c,Mic__c,Frequency__c,Included_Components__c,Bluetooth_Version__c,'+
                        'Voltage__c,Battery_Average_Life__c,Ip_Rating__c,Connector_Type__c,Recharge_Time__c,Voice_Assistant__c,Play_Or_Pause_Music__c,Answer_Or_Reject_Calls__c,Volume_Adjustment__c,Offer_Price__c,Qty_Max_Threshold__c,'+
                        'List_Price__c,Sellable_SKU__c FROM Product_Master__c where LastModifiedDate>= :startD and LastModifiedDate<= :endD and RecordType.Name= :business and Record_Sent__c = true and Product_To_Show__c = true and Is_Custom_Image__c = false and Product_Category__c in :watchesProductToSend order by LastModifiedDate LIMIT :batchC';
        
        numberOfWatches = [Select Count() from Product_Master__c where LastModifiedDate>= :startD and LastModifiedDate<= :endD and RecordType.Name= :business and Record_Sent__c = true and Product_To_Show__c = true and Is_Custom_Image__c = false and Product_Category__c in :watchesProductToSend];
        }
        
        if(reqList.size()<1 && startD!= null && endD!= null && business!= null && batchC!= null){
            newReq = new CBG_sales_Website__c();
            if(business == 'Eyewear' && numberOfeyewear!= null){
                newReq = createCBGRecords(startD, endD, business, numberOfeyewear, batchC);
            }
            if(business == 'Jewellery' && numberOfJewels!= null){
                newReq = createCBGRecords(startD, endD, business, numberOfJewels, batchC);
            }
            if(business == 'Watches' && numberOfWatches!= null){
                newReq = createCBGRecords(startD, endD, business, numberOfWatches, batchC);
            }
        }
            try{
                if(newReq!= null && newReq.Number_of_Total_Records_Available__c>0){
                    system.debug(newReq);
                    insert newReq;
                }
            }
            catch(Exception exp){
                System.debug('Message-->'+ exp.getMessage());
                System.debug('Line Number--->'+exp.getLineNumber());
            }
        prodToUpdate = new List<Product_Master__c>();
        
        if(wrapperList.businessType!= null && wrapperList.businessType == 'Eyewear'){
            eyeWrrList = new List<EyewearWrapper>();
            prodList = Database.query(eyeQuery);
            system.debug('prodList-----'+prodList);
            for(Product_Master__c pro: prodList){
                eyeWrrList.add(new EyewearWrapper(pro));
                pro.Record_Sent__c = false;
                prodToUpdate.add(pro);
            }
        }
        
        if(wrapperList.businessType!= null && wrapperList.businessType == 'Jewellery'){
            jewelWrrList = new List<JewelleryWrapper>();
            prodList = Database.query(jewelQuery);
            for(Product_Master__c pro: prodList){
                jewelWrrList.add(new JewelleryWrapper(pro));
                pro.Record_Sent__c = false;
                prodToUpdate.add(pro);
            }
        }
        if(wrapperList.businessType!= null && wrapperList.businessType == 'Watches'){
            watchWrrList = new List<WatchesWrapper>();
            prodList = Database.query(watchesQuery);
            for(Product_Master__c pro: prodList){
                watchWrrList.add(new WatchesWrapper(pro));
                pro.Record_Sent__c = false;//Temporary Change
                prodToUpdate.add(pro);
            }
        }
        
        if(prodToUpdate.size()>0){
            system.debug('prodToUpdate--------'+prodToUpdate);
            update prodToUpdate;
        }
        if(reqList.size()>0){
            reqList[0].Number_of_Records_Sent__c = reqList[0].Number_of_Records_Sent__c + prodList.size();
            system.debug('reqList-----'+reqList);
            update reqList;
        }
        System.debug('reqList size---'+reqList.size());
        //System.debug('Number_of_Total_Records_Available__c====='+newReq.Number_of_Total_Records_Available__c);
        if(reqList.size()<1 && newReq.Number_of_Total_Records_Available__c> 0){
            newReq.Number_of_Records_Sent__c = prodList.size();
            system.debug('req----+'+newReq);
            update newReq;
        }
        
        reqListUpdated = [select id, name, Start_Date__c, End_Date__c, Business_Type__c, Number_of_Records_Sent__c, Number_of_Total_Records_Available__c, Time_of_System_Hit__c from CBG_sales_Website__c where Start_Date__c=:startD and End_Date__c=:endD and Business_Type__c=:business];
        System.debug('reqListUpdated-----'+reqListUpdated);    
        resp = new ResponseWrapper();
        if(reqListUpdated.size()>0 && wrapperList.businessType == 'Eyewear'){
            resp.totalRecords = reqListUpdated[0].Number_of_Total_Records_Available__c;
            resp.eyeWrr = eyeWrrList;
            resp.recordsProcessed = reqListUpdated[0].Number_of_Records_Sent__c;
            System.debug('resp-----'+resp);
        }
        if(reqListUpdated.size()>0 && wrapperList.businessType == 'Jewellery'){
            resp.totalRecords = reqListUpdated[0].Number_of_Total_Records_Available__c;
            resp.jewelWrr = jewelWrrList;
            resp.recordsProcessed = reqListUpdated[0].Number_of_Records_Sent__c;
        }
        if(reqListUpdated.size()>0 && wrapperList.businessType == 'Watches'){
            resp.totalRecords = reqListUpdated[0].Number_of_Total_Records_Available__c;
            resp.watchWrr = watchWrrList;
            resp.recordsProcessed = reqListUpdated[0].Number_of_Records_Sent__c;
        }
        system.debug('Response-----'+resp);
        //String expRespStr = json.serializepretty(resp);
        //System.debug('expRespStr----'+expRespStr);
        if(!test.isRunningTest()){
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(resp));
            System.debug('Heap getHeapSize--->'+Limits.getHeapSize());
            System.debug('Heap getLimitHeapSize--->'+Limits.getLimitHeapSize());
        } 
    }
   
    public static CBG_sales_Website__c createCBGRecords(DateTime reqStartDate, DateTime reqEndDate, String reqBusinessType, Integer totalRecords, Integer reqBatchCount){
        CBG_sales_Website__c req = new CBG_sales_Website__c();
        req.Start_Date__c = reqStartDate;
        req.End_Date__c = reqEndDate;
        req.Business_Type__c = reqBusinessType;
        req.Number_of_records_in_single_batch__c = reqBatchCount;
        req.Number_of_Total_Records_Available__c = totalRecords;
        req.Number_of_Records_Sent__c = 0;
        system.debug('req----------'+req);
        return req;
    }
            
    public class ResponseWrapper{
        public Decimal totalRecords;
        public Decimal recordsProcessed;
        List<EyewearWrapper> eyeWrr = new List<EyewearWrapper>();
        List<WatchesWrapper> watchWrr = new List<WatchesWrapper>();
        List<JewelleryWrapper> jewelWrr = new List<JewelleryWrapper>();
    }
    
    public class EyewearWrapper{
        public String sku;
        public String attribute_set_name;
        public String name;
        public String sap_sku_id;
        public String brand;
        public String categories;
        public String description;
        public String aplus_content;
        public String face_shape;
        public String acc_bridge_width;
        public String acc_front_shape;
        public String acc_lens_height;
        public String acc_lens_width;
        public String acc_size;
        public String acc_size_clip;
        public String frame_color_code;
        public String frame_design;
        public String frame_face_shape;
        public String frame_front_shape;
        public String frame_front_shape_label;
        public String frame_front_styling;
        public String frame_gender;
        public String frame_international;
        public String frame_lifestyle;
        public String frame_material;
        public String frame_material_desc;
        public String frame_parent_model;
        public String frame_size;
        public String frame_size_number;
        public String frame_type;
        public String frame_weight_without_lens;
        public String frame_weight_without_lens_no;
        public String front_Color;
        public String front_color_user;
        public String front_color_user_sunglass;
        public String front_colour_pattern;
        public String front_finish;
        public String front_material_details;
        public String front_material_user;
        public String front_size;
        public String bestseller;
        public String new1;
        public String sale;
        public String collection;
        public String contactlens_validity;
        public String country_of_manufacture;
        public String disposable;
        public Decimal price;
        public String tax_class_id;
        public String thumbnail;
        public String url_key;
        public String url_path;
        public String virtual_tryon;
        public String virtual_try_on;
        //public String all_Images;
        public DateTime updated_at;
        public Decimal final_price;
        public Decimal offer_Price;
        public Decimal list_Price;
        public String sellableSKU;
        public String images;
        
        public EyewearWrapper(Product_Master__c prod){
            sku = prod.sku__c;
            attribute_set_name = prod.attribute_set_name__c;
            name = prod.name__c; //have to verify which name field is to map
            sap_sku_id = prod.sap_sku_id__c;
            brand = prod.brand__c;
            categories = prod.categories__c;
            description = prod.description__c;
            aplus_content = prod.aplus_content__c;
            face_shape = prod.face_shape__c;
            acc_bridge_width = prod.acc_bridge_width__c;
            acc_front_shape = prod.acc_front_shape__c;
            acc_lens_height = prod.acc_lens_height__c;
            acc_lens_width = prod.acc_lens_width__c;
            acc_size = prod.acc_size__c;
            acc_size_clip = prod.acc_size_clip__c;
            frame_color_code = prod.frame_color_code__c;
            frame_design = prod.frame_design__c;
            frame_face_shape = prod.frame_face_shape__c;
            frame_front_shape = prod.frame_front_shape__c;
            frame_front_shape_label = prod.frame_front_shape_label__c;
            frame_front_styling = prod.frame_front_styling__c;
            frame_gender = prod.frame_gender__c;
            frame_international = prod.frame_international__c;
            frame_lifestyle = prod.frame_lifestyle__c;
            frame_material = prod.frame_material__c;
            frame_material_desc = prod.frame_material_desc__c;
            frame_parent_model = prod.frame_parent_model__c;
            frame_size = prod.frame_size__c; 
            frame_size_number = prod.frame_size_number__c; 
            frame_type = prod.frame_type__c;
            frame_weight_without_lens = prod.frame_weight_without_lens__c;
            frame_weight_without_lens_no = Prod.frame_weight_without_lens_no__c;
            front_Color = prod.front_color__c;
            front_color_user = prod.front_color_user__c;
            front_color_user_sunglass = prod.front_color_user_sunglass__c;
            front_colour_pattern = prod.front_colour_pattern__c;
            front_finish = prod.front_finish__c;
            front_material_details = prod.front_material_details__c;
            front_material_user = prod.front_material_user__c;
            front_size = prod.front_size__c;
            bestseller = prod.bestseller__c;
            new1 = prod.new__c;
            sale = prod.sale__c;
            collection = prod.collection__c;
            contactlens_validity = prod.contactlens_validity__c;
            country_of_manufacture = prod.country_of_manufacture__c;
            disposable = prod.disposable__c;
            price = prod.price__c;
            tax_class_id = prod.tax_class_id__c;
            thumbnail = prod.thumbnail__c;
            url_key = prod.url_key__c;
            url_path = prod.url_path__c;
            virtual_tryon = prod.virtual_tryon__c;
            virtual_try_on = prod.virtual_try_on__c;
            //all_Images = prod.All_Images__c;
            updated_at = prod.updated_at__c;
            offer_Price = prod.Offer_Price__c;
            list_Price = prod.List_Price__c;
            sellableSKU = prod.Sellable_SKU__c;
            final_price = prod.final_price__c;
            images = prod.images__c;
        }
    }
    
    public class WatchesWrapper{
        public String base_Sku;
        public String title;
        public String short_Description;
        public String long_Description;
        public String brand;
        public String mother_Brand;
        public String display_Brand;
        public String gender;
        public String collection;
        public String warranty_Period;
        public String warranty_Details;
        public String special_Feature;
        public String product_Category;
        public String top_Feature_1;
        public String top_Feature_2;
        public String top_Feature_3;
        public String wcs_Type;
        public String business_Unit;
        public String brand_Id;
        public String sub_Brand_Id;
        public String sub_Brand;
        public String function_Type;
        public String function;
        public String movement;
        public String Dial_Color;
        public String dial_Color_Colorcode;
        public String case_Shape;
        public String case_Material;
        public String case_Thickness_Mm;
        public String case_Length6H_12H_Mm;
        public String case_Width3H_9H_Mm;
        public String strap_Color;
        public String strap_Color_Colorcode;
        public String strap_Material;
        public String glass_Material;
        public String lock_Mechanism;
        public String water_Resistance;
        public String occasion;
        public String compression_Straps;
        public String depth_Inches;
        public String handle_Length_Inches;
        public String handle_Material;
        public String haul_Loop;
        public String height_Inches;
        public String internal_Organizer;
        public String laptop_Holder;
        public String laptop_Sleeve_Height_Inches;
        public String laptop_Sleeve_Length_Inches;
        public String laptop_Sleeve_Width_Inches;
        public Decimal no_Of_Compartments;
        public String padded_Grab_Handle;
        public String pattern;
        public String quick_Access_Pocket;
        public String rain_Cover_Available;
        public String shoulder_Strap_Length_Inches;
        public String shoulder_Strap_Padding;
        public String sternum_Strap;
        public String strap_Padding_Thickness_Mm;
        public String reflective_Accents;
        public String back_Padding;
        public String bottle_Holder;
        public String waist_Strap;
        public String width_Inches;
        public String zipper_Brand;
        public String length_Inches;
        public String compatible_Laptop_Size_Inches;
        public String volumeLitres;
        public String material_Body;
        public String material_Lining;
        public String other_Features;
        public String closure_Type;
        public String smart_Features;
        public String water_Resistant;
        public String type;
        public String branding;
        public String weight_Grams;
        public String color;
        public String color_Colorcode;
        public String total_Length_Inches;
        public String buckle;
        public String buckle_Finish;
        public String width_Mm;
        public String material;
        public String characteristics;
        public String dress_Code;
        public String finish;
        public String leather_Care;
        public String tanning;
        public String detachable_Strap;
        public String cheque_Book_Holder;
        public String gusset_Pocket;
        public String height_Cm;
        public String id_Card_Holder;
        public String passport_Holder;
        public String pen_Holder;
        public String photo_Slot;
        public String secret_Pocket;
        public String sim_Card_Slot;
        public String slip_Pocket;
        public String bill_Compartment;
        public String cc_Holder;
        public String usb_Slot;
        public String visiting_Card;
        public String width_Cm;
        public String zip_Compartment;
        public String length_Cm;
        public String coin_Pocket;
        public String total_Pack_Weight_Grams;
        public String family;
        public String perfumer;
        public String quantity;
        public String shelf_Life;
        public String fragrances_Included;
        public String fragrance_Type;
        public Decimal no_Of_Bottles_In_A_Pack;
        public String outer_Pack_Height_Mm;
        public String outer_Pack_Length_Mm;
        public String outer_Pack_Width_Mm;
        public String product_Care;
        public Decimal available;
        public Decimal published;
        public Decimal buyable;
        public String new_Arrival_Startdate;
        public String discontinued_Date;
        public String discounts_Ribbon;
        public String on_Sale_Ribbon;
        public String online_Exclusive_Ribbon;
        public String new_Arrival_Ribbon;
        public String occasion_Ribbon;
        public String emi_Ribbon;
        public String express_Delivery_Ribbon;
        public String bopis_Ribbon;
        public String ropis_Ribbon;
        public String preorder_Ribbon;
        public String function_Ribbon;
        public String collection_Ribbon;
        public String sub_Function_Ribbon;
        public String style_Ribbon;
        public String strap_Material_Ribbon;
        public String ribbon_Tag;
        public String bopis;
        public String ropis;
        public String cod;
        public String dc;
        public String emi;
        public String discount_Facet;
        public String express_Delivery;
        public String issfs;
        public String isreturnable;
        public String international_Eligible;
        public String international_Only;
        public Integer prod_Qty_Threshold;
        public Integer qty_Max_Threshold;
        public String international_Brand;
        public String isfoc;
        public String preorder;
        public Integer advance;
        public Integer backorder;
        public String angleimages_Thumbnail_1;
        public String angleimages_Thumbnail_2;
        public String angleimages_Thumbnail_3;
        public String angleimages_Thumbnail_4;
        public String angleimages_Thumbnail_5;
        public String angleimages_Thumbnail_6;
        public String angleimages_Thumbnail_7;
        public String angleimages_Thumbnail_8;
        public String angleimages_Thumbnail_9;
        public String angleimages_Thumbnail_10;
        public String angleimages_Fullimage_1;
        public String angleimages_Fullimage_2;
        public String angleimages_Fullimage_3;
        public String angleimages_Fullimage_4;
        public String angleimages_Fullimage_5;
        public String angleimages_Fullimage_6;
        public String angleimages_Fullimage_7;
        public String angleimages_Fullimage_8;
        public String angleimages_Fullimage_9;
        public String angleimages_Fullimage_10;
        public String images_1;
        //public String all_Images;
        public String images_2;
        public String images_3;
        public String images_4;
        public String images_5;
        public String images_6;
        public String images_7;
        public String images_8;
        public String images_9;
        public String images_10;
        public String media_Thumbnail_1;
        public String media_1;
        public String image_360_Thumbnail_1;
        public String image_360_1;
        public String image_Small_1;
        public String blackband_1_Title;
        public String blackband_1_Value;
        public String blackband_1_Image;
        public String blackband_1_Description;
        public String blackband_2_Title;
        public String blackband_2_Value;
        public String blackband_2_Image;
        public String blackband_2_Description;
        public String blackband_3_Title;
        public String blackband_3_Value;
        public String blackband_3_Image;
        public String blackband_3_Description;
        public String bridge_Width;
        public String frame_Color;
        public String frame_design;
        public String face_shape;
        public String frame_Shape;
        public String frame_material_desc;
        public String material_Description;
        public String frame_size;
        public String frame_type;
        public String weight_Without_Lens;
        public String lens_N;
        public String front_color;
        public String front_finish;
        public String front_material_details;
        public String hinge;
        public String lens_Color;
        public String lens_Design;
        public String lens_Height_Description;
        public String lens_Height;
        public String lens_Material;
        public String lens_Shape;
        public String lens_Technology;
        public String lens_Width;
        public String bridge_Type;
        public String temple_Color;
        public String temple_Finish;
        public String temple_Length;
        public String temple_Material;
        public String temple_Design;
        public String model_Number;
        public String form_Factor;
        public String item_Weight;
        public String product_Dimension;
        public String batteries;
        public String battery_Capacity;
        public String compatible_Devices;
        public String driver;
        public String mic;
        public String frequency;
        public String included_Components;
        public String bluetooth_Version;
        public String voltage;
        public String battery_Average_Life;
        public String ip_Rating;
        public String connector_Type;
        public String recharge_Time;
        public String voice_Assistant;
        public String play_Or_Pause_Music;
        public String answer_Or_Reject_Calls;
        public String volume_Adjustment;
        public Decimal offer_Price;
        public Decimal list_Price;
        public String sellableSKU;
        
        public WatchesWrapper(Product_Master__c prod){
            base_Sku = prod.Base_Sku__c;
            title = prod.Title__c;
            short_Description = prod.Short_Description__c;
            if(prod.Long_Description__c != null && prod.Long_Description__c !=''){
                long_Description = prod.Long_Description__c.length()<=1000?prod.Long_Description__c:'Description Too Long';
            }
            
            //long_Description = prod.Long_Description__c;
            brand = prod.brand__c;
            mother_Brand = prod.Mother_Brand__c;
            display_Brand = prod.Display_Brand__c;
            gender = prod.Gender__c;
            collection = prod.collection__c;
            warranty_Period = prod.Warranty_Period__c;
            warranty_Details = prod.Warranty_Details__c;
            special_Feature = prod.Special_Feature__c;
            product_Category = prod.Product_Category__c;
            top_Feature_1 = prod.Top_Feature_1__c;
            top_Feature_2 = prod.Top_Feature_2__c;
            top_Feature_3 = prod.Top_Feature_3__c;
            wcs_Type = prod.Wcs_Type__c;
            business_Unit = prod.Business_Unit__c;
            brand_Id = prod.Brand_Id__c;
            sub_Brand_Id = prod.Sub_Brand_Id__c;
            sub_Brand = prod.Sub_Brand__c;
            function_Type = prod.Function_Type__c;
            function = prod.Function__c;
            movement = prod.Movement__c;
            Dial_Color = prod.Dial_Color__c;
            dial_Color_Colorcode = prod.Dial_Color_Colorcode__c;
            case_Shape = prod.Case_Shape__c;
            case_Material = prod.Case_Material__c;
            case_Thickness_Mm = prod.Case_Thickness_Mm__c;
            case_Length6H_12H_Mm = prod.Case_Length6H_12H_Mm__c;
            case_Width3H_9H_Mm = prod.Case_Width3H_9H_Mm__c;
            strap_Color = prod.Strap_Color__c;
            strap_Color_Colorcode = prod.Strap_Color_Colorcode__c;
            strap_Material = prod.Strap_Material__c;
            glass_Material = prod.Glass_Material__c;
            lock_Mechanism = prod.Lock_Mechanism__c;
            water_Resistance = prod.Water_Resistance__c;
            occasion = prod.Occasion__c;
            compression_Straps = prod.Compression_Straps__c;
            depth_Inches = prod.Depth_Inches__c;
            handle_Length_Inches = prod.Handle_Length_Inches__c;
            handle_Material = prod.Handle_Material__c;
            haul_Loop = prod.Haul_Loop__c;
            height_Inches = prod.Height_Inches__c;
            internal_Organizer = prod.Internal_Organizer__c;
            laptop_Holder = prod.Laptop_Holder__c;
            laptop_Sleeve_Height_Inches = prod.Laptop_Sleeve_Height_Inches__c;
            laptop_Sleeve_Length_Inches = prod.Laptop_Sleeve_Length_Inches__c;
            laptop_Sleeve_Width_Inches = prod.Laptop_Sleeve_Width_Inches__c;
            no_Of_Compartments = prod.No_Of_Compartments__c;
            padded_Grab_Handle = prod.Padded_Grab_Handle__c;
            pattern = prod.Pattern__c;
            quick_Access_Pocket = prod.Quick_Access_Pocket__c;
            rain_Cover_Available = prod.Rain_Cover_Available__c;
            shoulder_Strap_Length_Inches = prod.Shoulder_Strap_Length_Inches__c;
            shoulder_Strap_Padding = prod.Shoulder_Strap_Padding__c;
            sternum_Strap = prod.Sternum_Strap__c;
            strap_Padding_Thickness_Mm = prod.Strap_Padding_Thickness_Mm__c;
            reflective_Accents = prod.Reflective_Accents__c;
            back_Padding = prod.Back_Padding__c;
            bottle_Holder = prod.Bottle_Holder__c;
            waist_Strap = prod.Waist_Strap__c;
            width_Inches = prod.Width_Inches__c;
            zipper_Brand = prod.Zipper_Brand__c;
            length_Inches = prod.Length_Inches__c;
            compatible_Laptop_Size_Inches = prod.Compatible_Laptop_Size_Inches__c;
            volumeLitres = prod.VolumeLitres__c;
            material_Body = prod.Material_Body__c;
            material_Lining = prod.Material_Lining__c;
            other_Features = prod.Other_Features__c;
            closure_Type = prod.Closure_Type__c;
            smart_Features = prod.Smart_Features__c;
            water_Resistant = prod.Water_Resistant__c;
            type = prod.Type__c;
            branding = prod.Branding__c;
            weight_Grams = prod.Weight_Grams__c;
            color = prod.Color__c;
            color_Colorcode = prod.Color_Colorcode__c;
            total_Length_Inches = prod.Total_Length_Inches__c;
            buckle = prod.Buckle__c;
            buckle_Finish = prod.Buckle_Finish__c;
            width_Mm = prod.Width_Mm__c;
            material = prod.Material__c;
            characteristics = prod.Characteristics__c;
            dress_Code = prod.Dress_Code__c;
            finish = prod.Finish__c;
            leather_Care = prod.Leather_Care__c;
            tanning = prod.Tanning__c;
            detachable_Strap = prod.Detachable_Strap__c;
            cheque_Book_Holder = prod.Cheque_Book_Holder__c;
            gusset_Pocket = prod.Gusset_Pocket__c;
            height_Cm = prod.Height_Cm__c;
            id_Card_Holder = prod.Id_Card_Holder__c;
            passport_Holder = prod.Passport_Holder__c;
            pen_Holder = prod.Pen_Holder__c;
            photo_Slot = prod.Photo_Slot__c;
            secret_Pocket = prod.Secret_Pocket__c;
            sim_Card_Slot = prod.Sim_Card_Slot__c;
            slip_Pocket = prod.Slip_Pocket__c;
            bill_Compartment = prod.Bill_Compartment__c;
            cc_Holder = prod.Cc_Holder__c;
            usb_Slot = prod.Usb_Slot__c;
            visiting_Card = prod.Visiting_Card__c;
            width_Cm = prod.Width_Cm__c;
            zip_Compartment = prod.Zip_Compartment__c;
            length_Cm = prod.Length_Cm__c;
            coin_Pocket = prod.Coin_Pocket__c;
            total_Pack_Weight_Grams = prod.Total_Pack_Weight_Grams__c;
            family = prod.Family__c;
            perfumer = prod.Perfumer__c;
            quantity = prod.Quantity__c;
            shelf_Life = prod.Shelf_Life__c;
            fragrances_Included = prod.Fragrances_Included__c;
            fragrance_Type = prod.Fragrance_Type__c;
            no_Of_Bottles_In_A_Pack = prod.No_Of_Bottles_In_A_Pack__c;
            outer_Pack_Height_Mm = prod.Outer_Pack_Height_Mm__c;
            outer_Pack_Length_Mm = prod.Outer_Pack_Length_Mm__c;
            outer_Pack_Width_Mm = prod.Outer_Pack_Width_Mm__c;
            product_Care = prod.Product_Care__c; 
            available = prod.Available__c;
            published = prod.Published__c;
            buyable = prod.Buyable__c;
            new_Arrival_Startdate = prod.New_Arrival_Startdate__c;
            discontinued_Date = prod.Discontinued_Date__c;
            discounts_Ribbon = prod.Discounts_Ribbon__c;
            on_Sale_Ribbon = prod.On_Sale_Ribbon__c;
            online_Exclusive_Ribbon = prod.Online_Exclusive_Ribbon__c;
            new_Arrival_Ribbon = prod.New_Arrival_Ribbon__c;
            occasion_Ribbon = prod.Occasion__c;
            emi_Ribbon = prod.Emi_Ribbon__c;
            express_Delivery_Ribbon = prod.Express_Delivery_Ribbon__c;
            bopis_Ribbon = prod.Bopis_Ribbon__c;
            ropis_Ribbon = prod.Ropis_Ribbon__c;
            preorder_Ribbon = prod.Preorder_Ribbon__c;
            function_Ribbon = prod.Function_Ribbon__c;
            collection_Ribbon = prod.Collection_Ribbon__c;
            sub_Function_Ribbon = prod.Sub_Function_Ribbon__c;
            style_Ribbon = prod.Style_Ribbon__c;
            strap_Material_Ribbon = prod.Strap_Material_Ribbon__c;
            ribbon_Tag = prod.Ribbon_Tag__c;
            bopis = prod.Bopis__c;
            ropis = prod.Ropis__c;
            cod = prod.Cod__c;
            dc = prod.Dc__c;
            emi = prod.Emi__c;
            discount_Facet = prod.Discount_Facet__c;
            express_Delivery = prod.Express_Delivery__c;
            issfs = prod.Issfs__c;
            isreturnable = prod.Isreturnable__c;
            international_Eligible = prod.International_Eligible__c;
            international_Only = prod.International_Only__c;
            prod_Qty_Threshold =(Integer) prod.Prod_Qty_Threshold__c;
            qty_Max_Threshold = (Integer)prod.Qty_Max_Threshold__c;
            international_Brand = prod.International_Brand__c;
            isfoc = prod.Isfoc__c;
            preorder = prod.Preorder__c;
            advance =(Integer) prod.Advance__c;
            backorder =(Integer) prod.Backorder__c;
            angleimages_Thumbnail_1 = prod.Angleimages_Thumbnail_1__c;
            angleimages_Thumbnail_2 = prod.Angleimages_Thumbnail_2__c;
            angleimages_Thumbnail_3 = prod.Angleimages_Thumbnail_3__c;
            angleimages_Thumbnail_4 = prod.Angleimages_Thumbnail_4__c;
            angleimages_Thumbnail_5 = prod.Angleimages_Thumbnail_5__c;
            angleimages_Thumbnail_6 = prod.Angleimages_Thumbnail_6__c;
            angleimages_Thumbnail_7 = prod.Angleimages_Thumbnail_7__c;
            angleimages_Thumbnail_8 = prod.Angleimages_Thumbnail_8__c;
            angleimages_Thumbnail_9 = prod.Angleimages_Thumbnail_9__c;
            angleimages_Thumbnail_10 = prod.Angleimages_Thumbnail_10__c;
            angleimages_Fullimage_1 = prod.Angleimages_Fullimage_1__c;
            angleimages_Fullimage_2 = prod.Angleimages_Fullimage_2__c;
            angleimages_Fullimage_3 = prod.Angleimages_Fullimage_3__c; 
            angleimages_Fullimage_4 = prod.Angleimages_Fullimage_4__c;
            angleimages_Fullimage_5 = prod.Angleimages_Fullimage_5__c;
            angleimages_Fullimage_6 = prod.Angleimages_Fullimage_6__c;
            angleimages_Fullimage_7 = prod.Angleimages_Fullimage_7__c;
            angleimages_Fullimage_8 = prod.Angleimages_Fullimage_8__c;
            angleimages_Fullimage_9 = prod.Angleimages_Fullimage_9__c;
            angleimages_Fullimage_10 = prod.Angleimages_Fullimage_10__c;
            images_1 = prod.Images_1__c;
            //all_Images = prod.All_Images__c;
            images_2 = prod.Images_2__c;
            images_3 = prod.Images_3__c;
            images_4 = prod.Images_4__c;
            images_5 = prod.Images_5__c;
            images_6 = prod.Images_6__c;
            images_7 = prod.Images_7__c;
            images_8 = prod.Images_8__c;
            images_9 = prod.Images_9__c;
            images_10 = prod.Images_10__c;
            media_Thumbnail_1 = prod.Media_Thumbnail_1__c;
            media_1 = prod.Media_1__c;
            image_360_Thumbnail_1 = prod.Image_360_Thumbnail_1__c;
            image_360_1 = prod.Image_360_1__c;
            image_Small_1 = prod.Image_Small_1__c;
            blackband_1_Title = prod.Blackband_1_Title__c;
            blackband_1_Value = prod.Blackband_1_Value__c;
            blackband_1_Image = prod.Blackband_1_Image__c;
            blackband_1_Description = prod.Blackband_1_Description__c;
            blackband_2_Title = prod.Blackband_2_Title__c;
            blackband_2_Value = prod.Blackband_2_Value__c;
            blackband_2_Image = prod.Blackband_2_Image__c;
            blackband_2_Description = prod.Blackband_2_Description__c;
            blackband_3_Title = prod.Blackband_3_Title__c;
            blackband_3_Value = prod.Blackband_3_Value__c;
            blackband_3_Image = prod.Blackband_3_Image__c;
            blackband_3_Description = prod.Blackband_3_Description__c;
            bridge_Width =  prod.Bridge_Width__c;
            frame_Color = prod.Frame_Color__c;
            frame_design = prod.frame_design__c;
            face_shape = prod.face_shape__c;
            frame_Shape = prod.Frame_Shape__c;
            frame_material_desc = prod.frame_material_desc__c;
            material_Description = prod.Material_Description__c;
            frame_size = prod.frame_size__c;
            frame_type = prod.frame_type__c;
            weight_Without_Lens = prod.Weight_Without_Lens__c;
            lens_N = prod.Lens_No__c;
            front_color = prod.front_color__c;
            front_finish = prod.front_finish__c;
            front_material_details =  prod.front_material_details__c;
            hinge = prod.Hinge__c;
            lens_Color = prod.Lens_Color__c;
            lens_Design = prod.Lens_Design__c;
            lens_Height_Description = prod.Lens_Height_Description__c;
            lens_Height = prod.Lens_Height__c;
            lens_Material = prod.Lens_Material__c;
            lens_Shape = prod.Lens_Shape__c;
            lens_Technology = prod.Lens_Technology__c;
            lens_Width = prod.Lens_Width__c;
            bridge_Type = prod.Bridge_Type__c;
            temple_Color = prod.Temple_Color__c;
            temple_Finish = prod.Temple_Finish__c;
            temple_Length = prod.Temple_Length__c;
            temple_Material = prod.Temple_Material__c;
            temple_Design = prod.Temple_Design__c;
            model_Number = prod.Model_Number__c;
            form_Factor = prod.Form_Factor__c;
            item_Weight = prod.Item_Weight__c;
            product_Dimension = prod.Product_Dimension__c;
            batteries = prod.Batteries__c;
            battery_Capacity = prod.Battery_Capacity__c;
            compatible_Devices = prod.Compatible_Devices__c;
            driver = prod.Driver__c;
            mic = prod.Mic__c;
            frequency = prod.Frequency__c;
            included_Components = prod.Included_Components__c;
            bluetooth_Version = prod.Bluetooth_Version__c;
            voltage = prod.Voltage__c;
            battery_Average_Life = prod.Battery_Average_Life__c;
            ip_Rating = prod.Ip_Rating__c;
            connector_Type = prod.Connector_Type__c;
            recharge_Time = prod.Recharge_Time__c;
            voice_Assistant = prod.Voice_Assistant__c;
            play_Or_Pause_Music = prod.Play_Or_Pause_Music__c;
            answer_Or_Reject_Calls = prod.Answer_Or_Reject_Calls__c;
            volume_Adjustment = prod.Volume_Adjustment__c;
            offer_Price = prod.Offer_Price__c;
            list_Price = prod.List_Price__c;
            sellableSKU = prod.Sellable_SKU__c;
        }
    }
    
    public class JewelleryWrapper{
        public String base_Sku;
        public String title;
        public String short_Description;
        public String long_Description;
        public String brand_Code;
        public String mother_Brand;
        public String display_Brand;
        public String gender;
        public String collection;
        public String product;
        public String wcs_Type;
        public String business_Unit;
        public String metal;
        public String jewellery_Type;
        public Integer gold_Karatage;
        public String metal_Color;
        public String categories;
        public String type;
        public String height;
        public String width;
        public String surface_Finish;
        public String finding;
        public String unit;
        public String coin_Weight;
        public String occasion;
        public String no_Of_Diamonds;
        public String diamond_Cut;
        public String diamond_Clarity;
        public String diamond_Color;
        public String diamond_Shape;
        public String diamond_Setting;
        public String gs1_Stone_Name;
        public String gs1_Qty;
        public String gs1_Setting_Type;
        public String gs1_Cut;
        public String gs1_Shape;
        public String gs2_Stone_Name;
        public String gs2_Qty;
        public String gs2_Setting_Type;
        public String gs2_Cut;
        public String gs2_Shape;
        public String gs3_Stone_Name;
        public String gs3_Qty;
        public String gs3_Setting_Type;
        public String gs3_Cut;
        public String gs3_Shape;
        public String gs4_Stone_Name;
        public String gs4_Qty;
        public String gs4_Setting_Type;
        public String gs4_Cut;
        public String gs4_Shape;
        public String gs5_Stone_Name;
        public String gs5_Qty;
        public String gs5_Setting_Type;
        public String gs5_Cut;
        public String gs5_Shape;
        public String other_Gemstones;
        public Integer available;
        public Integer published;
        public Integer buyable;
        public String new_Arrival_Startdate;
        public String discontinued_Date;
        public String discounts_Ribbon;
        public String on_Sale_Ribbon;
        public String online_Exclusive_Ribbon;
        public String new_Arrival_Ribbon;
        public String occasion_Ribbon;
        public String emi_Ribbon;
        public String express_Delivery_Ribbon;
        public String bopis_Ribbon;
        public String ropis_Ribbon;
        public String preorder_Ribbon;
        public String collection_Ribbon;
        public String ribbon_Tag;
        public String bopis;
        public String ropis;
        public String cod;
        public String dc;
        public String emi;
        public String express_Delivery;
        public String issfs;
        public String isreturnable;
        public String international_Eligible;
        public String international_Only;
        public Integer prod_Qty_Threshold;
        public Integer qty_Max_Threshold;
        public String international_Brand;
        public String isfoc;
        public String preorder;
        public Integer advance;
        public Integer backorder;
        public String angleimages_Thumbnail_1;
        public String angleimages_Thumbnail_2;
        public String angleimages_Thumbnail_3;
        public String angleimages_Thumbnail_4;
        public String angleimages_Thumbnail_5;
        public String angleimages_Thumbnail_6;
        public String angleimages_Thumbnail_7;
        public String angleimages_Thumbnail_8;
        public String angleimages_Thumbnail_9;
        public String angleimages_Thumbnail_10;
        public String angleimages_Fullimage_1;
        public String angleimages_Fullimage_2;
        public String angleimages_Fullimage_3;
        public String angleimages_Fullimage_4;
        public String angleimages_Fullimage_5;
        public String angleimages_Fullimage_6;
        public String angleimages_Fullimage_7;
        public String angleimages_Fullimage_8;
        public String angleimages_Fullimage_9;
        public String angleimages_Fullimage_10;
        //public String all_Images;
        public String images_1;
        public String images_2;
        public String images_3;
        public String images_4;
        public String images_5;
        public String images_6;
        public String images_7;
        public String images_8;
        public String images_9;
        public String images_10;
        public String media_Thumbnail_1;
        public String media_1;
        public String image_360_Thumbnail_1;
        public String image_360_1;
        public String image_Small_1;
        public String blackband_1_Title;
        public String blackband_1_Value;
        public String blackband_1_Image;
        public String blackband_1_Description;
        public String blackband_2_Title;
        public String blackband_2_Value;
        public String blackband_2_Image;
        public String blackband_2_Description;
        public String blackband_3_Title;
        public String blackband_3_Value;
        public String blackband_3_Image;
        public String blackband_3_Description;
        public String rental_Product;
        public String best_Deal;
        public String new_Collection;
        public String high_End;
        public String community;
        public String regional_Name;
        public String theme;
        public String pendant_Height;
        public String pendant_Width;
        public String earring_Height;
        public String earring_Width;
        public String design;	
        public String styling;	
        public String pdp_Scroll_Description;	
        public String weight_Band;
        public Decimal offer_Price;
        public Decimal list_Price; 
        public String sellableSKU;
        
        public JewelleryWrapper(Product_Master__c prod){
            base_Sku = prod.Base_Sku__c;
            title = prod.Title__c;
            short_Description = prod.Short_Description__c;
            long_Description = prod.Long_Description__c;
            brand_Code = prod.Brand_Code__c;
            mother_Brand = prod.Mother_Brand__c;
            display_Brand = prod.Display_Brand__c;
            gender = prod.Gender__c;
            collection = prod.collection__c;
            product = prod.Product__c;
            wcs_Type = prod.Wcs_Type__c;
            business_Unit = prod.Business_Unit__c;
            metal = prod.Metal__c;
            jewellery_Type = prod.Jewellery_Type__c;
            gold_Karatage = (Integer)prod.Gold_Karatage__c;
            metal_Color = prod.Metal_Color__c;
            categories = prod.categories__c;
            type = prod.Type__c;
            height = prod.Height__c;
            width = prod.Width__c;
            surface_Finish = prod.Surface_Finish__c;
            finding = prod.Finding__c;
            unit = prod.Unit__c;
            coin_Weight = prod.Coin_Weight__c;
            occasion = prod.Occasion__c;
            no_Of_Diamonds = prod.No_Of_Diamonds__c;
            diamond_Cut = prod.Diamond_Cut__c;
            diamond_Clarity = prod.Diamond_Clarity__c;
            diamond_Color = prod.Diamond_Color__c;
            diamond_Shape = prod.Diamond_Shape__c;  
            diamond_Setting = prod.Diamond_Setting__c;
            gs1_Stone_Name = prod.Gs1_Stone_Name__c;
            gs1_Qty = prod.Gs1_Qty__c;
            gs1_Setting_Type = prod.Gs1_Setting_Type__c;
            gs1_Cut = prod.Gs1_Cut__c;
            gs1_Shape = prod.Gs1_Shape__c;
            gs2_Stone_Name = prod.Gs2_Stone_Name__c;
            gs2_Qty = prod.Gs2_Qty__c;
            gs2_Setting_Type = prod.Gs2_Setting_Type__c;
            gs2_Cut = prod.Gs2_Cut__c;
            gs2_Shape = prod.Gs2_Shape__c;
            gs3_Stone_Name = prod.Gs3_Stone_Name__c;
            gs3_Qty =prod.Gs3_Qty__c;
            gs3_Setting_Type = prod.Gs3_Setting_Type__c;
            gs3_Cut = prod.Gs3_Cut__c;
            gs3_Shape = prod.Gs3_Shape__c;
            gs4_Stone_Name = prod.Gs4_Stone_Name__c;
            gs4_Qty = prod.Gs4_Qty__c;
            gs4_Setting_Type = prod.Gs4_Setting_Type__c;
            gs4_Cut = prod.Gs4_Cut__c;
            gs4_Shape = prod.Gs4_Shape__c;
            gs5_Stone_Name = prod.Gs5_Stone_Name__c;
            gs5_Qty = prod.Gs5_Qty__c;
            gs5_Setting_Type = prod.Gs5_Setting_Type__c;
            gs5_Cut = prod.Gs5_Cut__c;
            gs5_Shape = prod.Gs5_Shape__c;
            other_Gemstones = prod.Other_Gemstones__c;
            available =(Integer) prod.Available__c;
            published =(Integer) prod.Published__c;
            buyable = (Integer)prod.Buyable__c;
            new_Arrival_Startdate = prod.New_Arrival_Startdate__c;
            discontinued_Date = prod.Discontinued_Date__c;
            discounts_Ribbon = prod.Discounts_Ribbon__c;
            on_Sale_Ribbon = prod.On_Sale_Ribbon__c;
            online_Exclusive_Ribbon = prod.Online_Exclusive_Ribbon__c;
            new_Arrival_Ribbon = prod.New_Arrival_Ribbon__c;
            occasion_Ribbon = prod.Occasion_Ribbon__c;
            emi_Ribbon = prod.Emi_Ribbon__c;
            express_Delivery_Ribbon = prod.Express_Delivery_Ribbon__c;
            bopis_Ribbon = prod.Bopis_Ribbon__c;
            ropis_Ribbon = prod.Ropis_Ribbon__c;
            preorder_Ribbon = prod.Preorder_Ribbon__c;
            collection_Ribbon = prod.Collection_Ribbon__c;
            ribbon_Tag = prod.Ribbon_Tag__c;
            bopis = prod.Bopis__c; 
            ropis = prod.Ropis__c;
            cod = prod.Cod__c;
            dc = prod.Dc__c;
            emi = prod.Emi__c;
            express_Delivery = prod.Express_Delivery__c;
            issfs = prod.Issfs__c;
            isreturnable = prod.Isreturnable__c;
            international_Eligible = prod.International_Eligible__c;
            international_Only = prod.International_Only__c;
            prod_Qty_Threshold =(Integer) prod.Prod_Qty_Threshold__c;
            qty_Max_Threshold = (Integer)prod.Qty_Max_Threshold__c;
            international_Brand = prod.International_Brand__c;
            isfoc = prod.Isfoc__c;
            preorder = prod.Preorder__c;
            advance = (Integer)prod.Advance__c;
            backorder =(Integer) prod.Backorder__c;
            angleimages_Thumbnail_1 = prod.Angleimages_Thumbnail_1__c;
            angleimages_Thumbnail_2 = prod.Angleimages_Thumbnail_2__c;
            angleimages_Thumbnail_3 = prod.Angleimages_Thumbnail_3__c;
            angleimages_Thumbnail_4 = prod.Angleimages_Thumbnail_4__c;
            angleimages_Thumbnail_5 = prod.Angleimages_Thumbnail_5__c;
            angleimages_Thumbnail_6 = prod.Angleimages_Thumbnail_6__c;
            angleimages_Thumbnail_7 = prod.Angleimages_Thumbnail_7__c;
            angleimages_Thumbnail_8 = prod.Angleimages_Thumbnail_8__c;
            angleimages_Thumbnail_9 = prod.Angleimages_Thumbnail_9__c;
            angleimages_Thumbnail_10 = prod.Angleimages_Thumbnail_10__c;
            angleimages_Fullimage_1 = prod.Angleimages_Fullimage_1__c;
            angleimages_Fullimage_2 = prod.Angleimages_Fullimage_2__c;
            angleimages_Fullimage_3 = prod.Angleimages_Fullimage_3__c;
            angleimages_Fullimage_4 = prod.Angleimages_Fullimage_4__c;
            angleimages_Fullimage_5 = prod.Angleimages_Fullimage_5__c;
            angleimages_Fullimage_6 = prod.Angleimages_Fullimage_6__c;
            angleimages_Fullimage_7 = prod.Angleimages_Fullimage_7__c;
            angleimages_Fullimage_8 = prod.Angleimages_Fullimage_8__c;
            angleimages_Fullimage_9 = prod.Angleimages_Fullimage_9__c;
            angleimages_Fullimage_10 = prod.Angleimages_Fullimage_10__c;
            //all_Images = prod.All_Images__c;
            images_1 = prod.Images_1__c;
            images_2 = prod.Images_2__c;
            images_3 = prod.Images_3__c;
            images_4 = prod.Images_4__c;
            images_5 = prod.Images_5__c;
            images_6 = prod.Images_6__c;
            images_7 = prod.Images_7__c;
            images_8 = prod.Images_8__c; 
            images_9 = prod.Images_9__c;
            images_10 = prod.Images_10__c;
            media_Thumbnail_1 = prod.Media_Thumbnail_1__c;
            media_1 = prod.Media_1__c;
            image_360_Thumbnail_1 = prod.Image_360_Thumbnail_1__c;
            image_360_1 = prod.Image_360_1__c;
            image_Small_1 = prod.Image_Small_1__c;
            blackband_1_Title = prod.Blackband_1_Title__c;
            blackband_1_Value = prod.Blackband_1_Value__c;
            blackband_1_Image = prod.Blackband_1_Image__c;
            blackband_1_Description = prod.Blackband_1_Description__c;
            blackband_2_Title = prod.Blackband_2_Title__c;
            blackband_2_Value = prod.Blackband_2_Value__c;
            blackband_2_Image = prod.Blackband_2_Image__c;
            blackband_2_Description = prod.Blackband_2_Description__c;
            blackband_3_Title = prod.Blackband_3_Title__c;
            blackband_3_Value = prod.Blackband_3_Value__c;
            blackband_3_Image = prod.Blackband_3_Image__c;
            blackband_3_Description = prod.Blackband_3_Description__c;
            rental_Product = prod.Rental_Product__c;
            best_Deal = prod.Best_Deal__c;
            new_Collection = prod.new__c; //please verify this field
            high_End = prod.High_End__c;
            community = prod.Community__c;
            regional_Name = prod.Regional_Name__c;
            theme = prod.Theme__c;
            pendant_Height = prod.Pendant_Height__c;
            pendant_Width = prod.Pendant_Width__c;
            earring_Height = prod.Earring_Height__c;
            earring_Width = prod.Earring_Width__c;
            // design ;	This below fields are not there
            //styling ;	
            //pdp_Scroll_Description ;	
            //weight_Band = ;
            offer_Price = prod.Offer_Price__c;
            list_Price = prod.List_Price__c; 
            sellableSKU = prod.Sellable_SKU__c;
        }
    } 
}