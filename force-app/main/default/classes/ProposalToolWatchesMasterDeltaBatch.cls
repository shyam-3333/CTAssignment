/*Created By : KVP- Chakresh Verma
*Name : FetchGiftCardsDetailsFromAWS
*Created on : 20 Nov 2021
*Description : 
*/
public class ProposalToolWatchesMasterDeltaBatch implements Database.Batchable<Object>,Database.AllowsCallouts,Database.Stateful{
    private static String className = 'ProposalToolWatchesMasterDeltaBatch';
    
    Product_Master__c watch;
    public List<String> exception_List;
    public String fileName = '';
    public Integer noOfRecordsCreated = 0;
    public Integer noOfRecordsUpdated = 0;
    public Integer noOfRecordsFailed = 0;
    public Integer rowCount = 0;
    String fileTime;

    //Constructor
    public ProposalToolWatchesMasterDeltaBatch(String fileTime){
        this.fileTime = fileTime;
    }
    
    //Start Method
    public Iterable<Object> start(Database.BatchableContext bc){
        List<List<String>> masterProductList = new List<List<String>>();
        try{
            String contentType='application/Json';
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            String folderName = generateFileName();
            SYstem.debug('folderName'+folderName);
            folderName = 'titan-pim-prodstg?list-type=2&max-keys=2&prefix=Watches/archive/Watches-ENRICHMENT_OUT2/'+folderName;
            req.setEndpoint('callout:Proposal_Tool_Jwellery_Watches/'+folderName);//titan-pim-prodstg/Watches/archive/Watches-ENRICHMENT_OUT2/
            req.setTimeout(120000);
            req.setHeader('Content-Type','application/xml');
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getStatusCode());
            String s = res.getBody();
            System.debug('s-->'+s);
            Dom.Document doc = new Dom.Document();  
            doc.load( s );  
            Dom.XMLNode rootElement = doc.getRootElement(); 
            List<Dom.XMLNode> childElementForKeyCount = rootElement.getChildElements();
            Integer fileCount= 0;
            
            if(res.getStatusCode() == 200){
                if(childElementForKeyCount.size()>=2){
                    if(childElementForKeyCount[2].getName()=='KeyCount'){
                        fileCount = Integer.valueOf(childElementForKeyCount[2].getText());
                    }
                }
            }
            
            if(fileCount>0){
                for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                    System.debug(childElement.getName());
                    System.debug(childElement.getText());
                    if(childElement.getName() == 'KeyCount'){
                        fileCount = Integer.valueOf(childElement.getText());
                        
                    }
                    for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                        if(detailElement.getName()=='key'){
                            fileName += detailElement.getText()+',';
                            system.debug( detailElement.getName() + '-' + detailElement.getText() );  
                            HttpRequest reqData = new HttpRequest();
                            reqData.setMethod('GET');
                            reqData.setEndpoint('callout:Proposal_Tool_Jwellery_Watches/titan-pim-prodstg/'+detailElement.getText());//titan-pim-prodstg/Watches/archive/Watches-ENRICHMENT_OUT2/
                            reqData.setTimeout(120000);
                            reqData.setHeader('Content-Type','application/xml');
                            //Http httpData = new Http();
                            // HTTPResponse resData = httpData.send(reqData);
                            masterProductList.addAll(CSVReaderUtililty.Parse(new Http().send(reqData).getBody()));
                        }
                    
                }
            }else{
                System.debug('File Not Found');
            }
            
            System.debug('masterProductList'+masterProductList.size());
            System.debug('Heap getHeapSize--->'+Limits.getHeapSize());
            System.debug('Heap getLimitHeapSize--->'+Limits.getLimitHeapSize());
            
        }catch(Exception exp){
            System.debug('Message-->'+ exp.getMessage());
            System.debug('Line Number--->'+exp.getLineNumber());
        }   
        System.debug('masterProductList'+(List<Object>)masterProductList);
        return (List<Object>)masterProductList;
        
    }
    
    //Execute Method
    public void execute(Database.BatchableContext bc, List<Object> scope){
        try{
            System.debug('scope'+scope);
            List<List<String>> data = new List<List<String>>();
            Set<String> productSKUs = new Set<String>();
            Map<String,String> mapOfExistingProducts = new Map<String,String>();
            List<Product_Master__c> watchList = new List<Product_Master__c>();
            String recordTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Watches').getRecordTypeId();
            
            data = (List<List<String>>)JSON.deserialize(JSON.serialize(scope), List<List<String>>.class);
            System.debug('data'+data);
            for(List<String> masterProduct : data){
                if(!masterProduct.isEmpty() && masterProduct.size()>=255){
                    System.debug(masterProduct.size());
                    productSKUs.add(masterProduct[0]);
                }
            }
            if(!productSKUs.isEmpty()){
                for(Product_Master__c master : [Select Id,Base_SKU__c from Product_Master__c where Base_SKU__c IN : productSKUs And RecordTypeId =:recordTypeId]){
                    mapOfExistingProducts.put(master.Base_SKU__c, master.Id);
                }   
            }
            for(List<String> masterProduct : data){
                
                if(!masterProduct.isEmpty() && masterProduct.size()>=255){
                    if(masterProduct[0] != '' && masterProduct[0] !='Common' && masterProduct[0] != 'BASE SKU'){
                        rowCount++;
                        System.debug('rowCount'+rowCount);
                        if(mapOfExistingProducts.containsKey(masterProduct[0])){
                            System.debug('mapOfExistingProducts'+masterProduct[0]);
                            watchList.add(createWatches(masterProduct, mapOfExistingProducts.get(masterProduct[0]),recordTypeId));
                            
                        }else{
                            watchList.add(createWatches(masterProduct, null,recordTypeId));
                            
                            System.debug('mapOfExistingProducts'+masterProduct[0]);
                        }
                    }else{
                        continue;
                    }
                    
                }
            }
            
            
            System.debug('watchList-->'+watchList.size());
            if(!watchList.isEmpty()){
                exception_List = new List<String>();
                
                Database.UpsertResult[] results = Database.upsert(watchList, false);
                for(Integer index = 0, size = results.size(); index < size; index++) {
                    if(results[index].isSuccess()) {
                        if(results[index].isCreated()) {
                            System.debug(results[index].Id +' was created');
                            noOfRecordsCreated++;
                        } else {
                            System.debug(results[index].Id +' was updated');
                            noOfRecordsUpdated++;
                        }
                    }else{
                        noOfRecordsFailed++;
                        Database.Error err = results.get(index).getErrors().get(0);
                        System.debug('Error - '+err.getMessage() + '\nStatus Code : '+err.getStatusCode()+'\n Fields : '+err.getFields());
                        exception_List.add('Error - '+err.getMessage() + '\nStatus Code : '+err.getStatusCode()+'\n Fields : '+err.getFields());
                    }
                }
                
            }
            
        }catch(Exception exp){
            System.debug('Exception Line Number-->'+exp.getLineNumber());
            System.debug('Exception Message-->'+exp.getMessage());  
        }
    }
    
    //Finish Method
    public void finish(Database.BatchableContext bc){
        System.debug('rowCount-->'+rowCount);
        System.debug('noOfRecordsCreated-->'+noOfRecordsCreated);
        System.debug('noOfRecordsUpdated-->'+noOfRecordsUpdated);
        System.debug('exception_List-->'+exception_List);
        System.debug('finish');
    }
    
    
    
    //Mapping data with repective fields
    private Product_Master__c createWatches(List<String> masterProduct, String existingProductId, String recordTypeId){
        watch = new Product_Master__c();
        watch.RecordTypeId = recordTypeId; 
        if(existingProductId != null){
            watch.Id = existingProductId;
        }
        watch.Base_Sku__c = masterProduct[0];
        watch.Record_Sent__c = true;
        watch.Title__c = masterProduct[1];
        watch.Short_Description__c = masterProduct[2];
        
        if(masterProduct[3] != null && masterProduct[3] != ''){
            if(masterProduct[3].length()>1000){
                watch.Long_Description__c = masterProduct[2];
            }
            else{
                watch.Long_Description__c = masterProduct[2];
            }
        }
        watch.brand__c = masterProduct[4];
        watch.Mother_Brand__c = masterProduct[5];
        watch.Display_Brand__c = masterProduct[6];
        watch.Gender__c = masterProduct[7];
        watch.collection__c = masterProduct[8];
        watch.Warranty_Period__c = masterProduct[9];
        watch.Warranty_Details__c = masterProduct[10];
        watch.Special_Feature__c = masterProduct[11];
        watch.Product_Category__c = masterProduct[12];
        watch.Top_Feature_1__c = masterProduct[13];
        watch.Top_Feature_2__c = masterProduct[14];
        watch.Top_Feature_3__c = masterProduct[15];
        watch.Wcs_Type__c = masterProduct[16];
        watch.Business_Unit__c = masterProduct[17];
        watch.Brand_Id__c = masterProduct[18];
        watch.Sub_Brand_Id__c = masterProduct[19];
        watch.Sub_Brand__c = masterProduct[20]; 
        watch.Function_Type__c = masterProduct[21];
        watch.Function__c = masterProduct[22];
        watch.Movement__c = masterProduct[23];
        watch.Dial_Color__c = masterProduct[24];
        watch.Dial_Color_Colorcode__c = masterProduct[25];
        watch.Case_Shape__c = masterProduct[26];
        watch.Case_Material__c = masterProduct[27];
        watch.Case_Thickness_Mm__c = masterProduct[28];
        watch.Case_Length6H_12H_Mm__c = masterProduct[29];
        watch.Case_Width3H_9H_Mm__c = masterProduct[30];
        watch.Strap_Color__c = masterProduct[31];
        watch.Strap_Color_Colorcode__c = masterProduct[32];
        watch.Strap_Material__c = masterProduct[33];
        watch.Glass_Material__c = masterProduct[34];
        watch.Lock_Mechanism__c = masterProduct[35];
        watch.Water_Resistance__c = masterProduct[36];
        watch.Occasion__c = masterProduct[37];
        watch.Compression_Straps__c = masterProduct[38];
        watch.Depth_Inches__c = masterProduct[39];
        watch.Handle_Length_Inches__c = masterProduct[40];
        watch.Handle_Material__c = masterProduct[41];
        watch.Haul_Loop__c = masterProduct[42];
        watch.Height_Inches__c = masterProduct[43];
        watch.Internal_Organizer__c = masterProduct[44];
        watch.Laptop_Holder__c = masterProduct[45];
        watch.Laptop_Sleeve_Height_Inches__c = masterProduct[46];
        watch.Laptop_Sleeve_Length_Inches__c = masterProduct[47];
        watch.Laptop_Sleeve_Width_Inches__c = masterProduct[48];
        if(masterProduct[49] != null && masterProduct[49] != ''){
            watch.No_Of_Compartments__c = Integer.ValueOf(masterProduct[49]); 
        }
        watch.Padded_Grab_Handle__c = masterProduct[50];
        watch.Pattern__c = masterProduct[51];
        watch.Quick_Access_Pocket__c = masterProduct[52];
        watch.Rain_Cover_Available__c = masterProduct[53];
        watch.Shoulder_Strap_Length_Inches__c = masterProduct[54];
        watch.Shoulder_Strap_Padding__c = masterProduct[55];
        watch.Sternum_Strap__c = masterProduct[56];
        watch.Strap_Padding_Thickness_Mm__c = masterProduct[57];
        watch.Reflective_Accents__c = masterProduct[58];
        watch.Back_Padding__c = masterProduct[59];
        watch.Bottle_Holder__c = masterProduct[60];
        watch.Waist_Strap__c = masterProduct[61];
        watch.Width_Inches__c = masterProduct[62];
        watch.Zipper_Brand__c = masterProduct[63];
        watch.Length_Inches__c = masterProduct[64];
        watch.Compatible_Laptop_Size_Inches__c = masterProduct[65];
        watch.VolumeLitres__c = masterProduct[66];
        watch.Material_Body__c = masterProduct[67];
        watch.Material_Lining__c = masterProduct[68];
        watch.Other_Features__c = masterProduct[69];
        watch.Closure_Type__c = masterProduct[70];
        watch.Smart_Features__c = masterProduct[71];
        watch.Water_Resistant__c = masterProduct[72];
        watch.Type__c = masterProduct[73];
        watch.Branding__c = masterProduct[74];
        watch.Weight_Grams__c = masterProduct[75];
        watch.Color__c = masterProduct[76];
        watch.Color_Colorcode__c = masterProduct[77];
        watch.Total_Length_Inches__c = masterProduct[78];
        watch.Buckle__c = masterProduct[79];
        watch.Buckle_Finish__c = masterProduct[80];
        watch.Width_Mm__c = masterProduct[81];
        watch.Material__c = masterProduct[82];
        watch.Characteristics__c = masterProduct[83];
        watch.Dress_Code__c = masterProduct[84];
        watch.Finish__c = masterProduct[85];
        watch.Leather_Care__c = masterProduct[86];
        watch.Tanning__c = masterProduct[87];
        watch.Detachable_Strap__c = masterProduct[88];
        watch.Cheque_Book_Holder__c = masterProduct[89];
        watch.Gusset_Pocket__c = masterProduct[90];
        watch.Height_Cm__c = masterProduct[91];
        watch.Id_Card_Holder__c = masterProduct[92];
        watch.Passport_Holder__c = masterProduct[93];
        watch.Pen_Holder__c = masterProduct[94];
        watch.Photo_Slot__c = masterProduct[95];
        watch.Secret_Pocket__c = masterProduct[96];
        watch.Sim_Card_Slot__c = masterProduct[97];
        watch.Slip_Pocket__c = masterProduct[98];
        watch.Bill_Compartment__c = masterProduct[99];
        watch.Cc_Holder__c = masterProduct[100];
        watch.Usb_Slot__c = masterProduct[101];
        watch.Visiting_Card__c = masterProduct[102];
        watch.Width_Cm__c = masterProduct[103];
        watch.Zip_Compartment__c = masterProduct[104];
        watch.Length_Cm__c = masterProduct[105];
        watch.Coin_Pocket__c = masterProduct[106];
        watch.Total_Pack_Weight_Grams__c = masterProduct[107];
        watch.Family__c = masterProduct[108];
        watch.Perfumer__c = masterProduct[109];
        watch.Quantity__c = masterProduct[110];
        watch.Shelf_Life__c = masterProduct[111];
        watch.Fragrances_Included__c = masterProduct[112];
        watch.Fragrance_Type__c = masterProduct[113];
        if(masterProduct[114] != null && masterProduct[114] != ''){
            watch.No_Of_Bottles_In_A_Pack__c = Integer.ValueOf(masterProduct[114]);
        }
        watch.Outer_Pack_Height_Mm__c = masterProduct[115];
        watch.Outer_Pack_Length_Mm__c = masterProduct[116];
        watch.Outer_Pack_Width_Mm__c = masterProduct[117];
        watch.Product_Care__c = masterProduct[118];
        if(masterProduct[119] != null && masterProduct[119] != ''){
            watch.Available__c = Integer.ValueOf(masterProduct[119]);
        }
        if(masterProduct[120] != null && masterProduct[120] != ''){
            watch.Published__c = Integer.ValueOf(masterProduct[120]);
        }
        if(masterProduct[121] != null && masterProduct[121] != ''){
            watch.Buyable__c = Integer.ValueOf(masterProduct[121]);
        }
        watch.New_Arrival_Startdate__c = masterProduct[122];
        watch.Discontinued_Date__c = masterProduct[123];
        watch.Discounts_Ribbon__c = masterProduct[124];
        watch.On_Sale_Ribbon__c = masterProduct[125];
        watch.Online_Exclusive_Ribbon__c = masterProduct[126];
        watch.New_Arrival_Ribbon__c = masterProduct[127];
        watch.Occasion_Ribbon__c = masterProduct[128];
        watch.Emi_Ribbon__c = masterProduct[129];
        watch.Express_Delivery_Ribbon__c = masterProduct[130];
        watch.Bopis_Ribbon__c = masterProduct[131];
        watch.Ropis_Ribbon__c = masterProduct[132];
        watch.Preorder_Ribbon__c = masterProduct[133];
        watch.Function_Ribbon__c = masterProduct[134];
        watch.Collection_Ribbon__c = masterProduct[135];
        watch.Sub_Function_Ribbon__c = masterProduct[136];
        watch.Style_Ribbon__c = masterProduct[137];
        watch.Strap_Material_Ribbon__c = masterProduct[138];
        watch.Ribbon_Tag__c = masterProduct[139];
        watch.Bopis__c = masterProduct[140];
        watch.Ropis__c = masterProduct[141];
        watch.Cod__c = masterProduct[142];
        watch.Dc__c = masterProduct[143];
        watch.Emi__c = masterProduct[144];
        watch.Discount_Facet__c = masterProduct[145];
        watch.Express_Delivery__c = masterProduct[146];
        watch.Issfs__c = masterProduct[147];
        watch.Isreturnable__c = masterProduct[148];
        watch.International_Eligible__c = masterProduct[149];
        watch.International_Only__c  = masterProduct[150];
        if(masterProduct[151] != null && masterProduct[151] != ''){
            watch.Prod_Qty_Threshold__c = Integer.valueOf(masterProduct[151]);
        }
        if(masterProduct[152] != null && masterProduct[152] != ''){
            watch.Qty_Max_Threshold__c = integer.valueOf(masterProduct[152]);
        }
        watch.International_Brand__c = masterProduct[153];
        watch.Isfoc__c = masterProduct[154];
        watch.Preorder__c = masterProduct[155];
        if(masterProduct[156] != null && masterProduct[156] != ''){
            watch.Advance__c = integer.valueOf(masterProduct[156]);
        }
        if(masterProduct[157] != null && masterProduct[157] != ''){
            watch.Backorder__c = integer.valueOf(masterProduct[157]);
        }
        watch.Angleimages_Thumbnail_1__c = masterProduct[158];
        watch.Angleimages_Thumbnail_2__c = masterProduct[159];
        watch.Angleimages_Thumbnail_3__c = masterProduct[160];
        watch.Angleimages_Thumbnail_4__c = masterProduct[161];
        watch.Angleimages_Thumbnail_5__c = masterProduct[162];
        watch.Angleimages_Thumbnail_6__c = masterProduct[163];
        watch.Angleimages_Thumbnail_7__c = masterProduct[164];
        watch.Angleimages_Thumbnail_8__c = masterProduct[165];
        watch.Angleimages_Thumbnail_9__c = masterProduct[166];
        watch.Angleimages_Thumbnail_10__c = masterProduct[167];
        watch.Angleimages_Fullimage_1__c = masterProduct[168];
        watch.Angleimages_Fullimage_2__c = masterProduct[169];
        watch.Angleimages_Fullimage_3__c = masterProduct[170];
        watch.Angleimages_Fullimage_4__c = masterProduct[171];
        watch.Angleimages_Fullimage_5__c = masterProduct[172];
        watch.Angleimages_Fullimage_6__c = masterProduct[173];
        watch.Angleimages_Fullimage_7__c = masterProduct[174];
        watch.Angleimages_Fullimage_8__c = masterProduct[175];
        watch.Angleimages_Fullimage_9__c = masterProduct[176];
        watch.Angleimages_Fullimage_10__c = masterProduct[177];
        if(masterProduct[178] != null && masterProduct[178] != ''){
            watch.Images_1__c = masterProduct[178];
            watch.All_Images__c = masterProduct[178];
        }
        if(masterProduct[179] != null && masterProduct[179] != ''){
            watch.Images_2__c = masterProduct[179];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[179];
        }
        if(masterProduct[180] != null && masterProduct[180] != ''){
            watch.Images_3__c = masterProduct[180];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[180];
        }
        if(masterProduct[181] != null && masterProduct[181] != ''){
            watch.Images_4__c = masterProduct[181];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[181];
        }
        if(masterProduct[182] != null && masterProduct[182] != ''){
            watch.Images_5__c = masterProduct[182];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[182];
        }
        if(masterProduct[183] != null && masterProduct[183] != ''){
            watch.Images_6__c = masterProduct[183];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[183];
        }
        if(masterProduct[184] != null && masterProduct[184] != ''){
            watch.Images_7__c = masterProduct[184];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[184];
        }
        if(masterProduct[179] != null && masterProduct[185] != ''){
            watch.Images_8__c = masterProduct[185];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[185];
        }
        if(masterProduct[186] != null && masterProduct[186] != ''){
            watch.Images_9__c = masterProduct[186];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[186];
        }
        if(masterProduct[187] != null && masterProduct[187] != ''){
            watch.Images_10__c = masterProduct[187];
            watch.All_Images__c = watch.All_Images__c+','+masterProduct[187];
        }
        watch.Media_Thumbnail_1__c = masterProduct[188];
        watch.Media_1__c = masterProduct[189];
        watch.Image_360_Thumbnail_1__c = masterProduct[190];
        watch.Image_360_1__c = masterProduct[191];
        watch.Image_Small_1__c = masterProduct[192];
        watch.Blackband_1_Title__c = masterProduct[193];
        watch.Blackband_1_Value__c = masterProduct[194];
        watch.Blackband_1_Image__c = masterProduct[195];
        watch.Blackband_1_Description__c = masterProduct[196];
        watch.Blackband_2_Title__c = masterProduct[197];
        watch.Blackband_2_Value__c = masterProduct[198];
        watch.Blackband_2_Image__c = masterProduct[199];
        watch.Blackband_2_Description__c = masterProduct[200];
        watch.Blackband_3_Title__c = masterProduct[201];
        watch.Blackband_3_Value__c = masterProduct[202];
        watch.Blackband_3_Image__c = masterProduct[203];
        watch.Blackband_3_Description__c = masterProduct[204];
        watch.Bridge_Width__c = masterProduct[205];
        watch.Frame_Color__c = masterProduct[206];
        watch.frame_design__c = masterProduct[207];
        watch.face_shape__c = masterProduct[208];
        watch.Frame_Shape__c = masterProduct[209];
        watch.frame_material_desc__c = masterProduct[210];
        watch.Material_Description__c = masterProduct[211];
        watch.frame_size__c = masterProduct[212];
        watch.frame_type__c = masterProduct[213];
        watch.Weight_Without_Lens__c = masterProduct[214];
        watch.Lens_No__c = masterProduct[215];
        watch.front_color__c = masterProduct[216];
        watch.front_finish__c = masterProduct[217];
        watch.front_material_details__c = masterProduct[218];
        watch.Hinge__c = masterProduct[219];
        watch.Lens_Color__c = masterProduct[220];
        watch.Lens_Design__c = masterProduct[221];
        watch.Lens_Height_Description__c = masterProduct[222];
        watch.Lens_Height__c = masterProduct[223];
        watch.Lens_Material__c = masterProduct[224];
        watch.Lens_Shape__c = masterProduct[225];
        watch.Lens_Technology__c = masterProduct[226];
        watch.Lens_Width__c = masterProduct[227];
        watch.Bridge_Type__c = masterProduct[228];
        watch.Temple_Color__c = masterProduct[229];
        watch.Temple_Finish__c = masterProduct[230];
        watch.Temple_Length__c = masterProduct[231];
        watch.Temple_Material__c = masterProduct[232];
        watch.Temple_Design__c = masterProduct[233];
        watch.Model_Number__c = masterProduct[234];
        watch.Form_Factor__c = masterProduct[235];
        watch.Item_Weight__c = masterProduct[236];
        watch.Product_Dimension__c = masterProduct[237];
        watch.Batteries__c = masterProduct[238];
        watch.Battery_Capacity__c = masterProduct[239];
        watch.Compatible_Devices__c = masterProduct[240];
        watch.Driver__c = masterProduct[241];
        watch.Mic__c = masterProduct[242];
        watch.Frequency__c = masterProduct[243];
        watch.Included_Components__c = masterProduct[244];
        watch.Bluetooth_Version__c = masterProduct[245];
        watch.Voltage__c = masterProduct[246];
        watch.Battery_Average_Life__c = masterProduct[247];
        watch.Ip_Rating__c = masterProduct[248];
        watch.Connector_Type__c = masterProduct[249];
        watch.Recharge_Time__c = masterProduct[250];
        watch.Voice_Assistant__c = masterProduct[251];
        watch.Play_Or_Pause_Music__c = masterProduct[252];
        watch.Answer_Or_Reject_Calls__c = masterProduct[253];
        watch.Volume_Adjustment__c = masterProduct[254];
        
        return watch; 
    }
    
    private String generateFileName(){
        List<AWS_Configuration__c> awsConfig = new List<AWS_Configuration__c>();
        awsConfig = [Select Id,Name,Number_of_days_to_be_deducted__c from AWS_Configuration__c where Name =: className];
        Integer numberOfDayToBeDecducted = !awsConfig.isEmpty()?Integer.valueOf(awsConfig[0].Number_of_days_to_be_deducted__c):-1;
        
        
        Date todayDate = System.today().addDays(numberOfDayToBeDecducted);
        String day = todayDate.day()<=9?'0'+String.valueOf(todayDate.day()):String.valueOf(todayDate.day());
        String month = todayDate.month()<=9?'0'+String.valueOf(todayDate.month()):String.valueOf(todayDate.month());
        String year = String.valueOf(todayDate.year());
        year = year.substring(2, 4);
        String folderName = day+'-'+month+'-'+year+fileTime;
        return folderName;
    }
}