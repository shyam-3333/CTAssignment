/*Created By : KVP- Chakresh Verma
*Name : ProposalToolProductFetchController
*Created on : 15 Nov 2021
*Description : This Class is controller for thr Product Listing Component and Used to Generate the Product Data and Also it is User to Filter the Products
*/

public with sharing class ProposalToolProductFetchController {
    
    //Constructor
    public ProposalToolProductFetchController() {
        
    }
    
    //This Method is For Pagination and Filters the Product based on the Filters and Returns the Product Data
    @AuraEnabled
    public static String fetchProducts(String selectedValue,Integer pageSize, Integer pageNumber, String wrapperObject){
        System.debug('selectedValue-->'+selectedValue);
        System.debug('wrapperObject-->'+wrapperObject);
        MainWrapper objDT =  new MainWrapper();  
        
        try {
            
            FilterWrapper filters = new FilterWrapper();
            filters = (FilterWrapper)JSON.deserialize(wrapperObject, FilterWrapper.class);
            
            //Common Filters
            //Search Name
            String searchValue = filters.searchName;
            //Selected Genders
            Set<String> selectedGender = new Set<String>();
            selectedGender.addAll(filters.selectedGender);
            
            //Selected Genders
            Set<String> selectedColor = new Set<String>();
            selectedColor.addAll(filters.selectedColor);
            
            //Selected Brands
            Set<String> selectedBrand= new Set<String>();
            selectedBrand.addAll(filters.selectedBrand);
            
            //Selected ProductCategory
            String selectedProductCategory = filters.selectedProductCategory;
            //selectedProductCategory.addAll(selectedProductCategory);
            
            //Sort By Feature
            String sortBy = filters.sortBy;
            
            //Price Range Filter
            String selectedPriceValue = filters.selectedPriceValue;
            //Common End
            
            
            //Bags Filters
            Set<String> selectedBagType= new Set<String>(filters.selectedBagTypeData);
            
            Set<String> selectedBagMaterialBody= new Set<String>(filters.selectedBagMaterialBodyData);
            
            Set<String> selectedBagMaterialLining= new Set<String>(filters.selectedBagMaterialLiningData);
            
            Set<String> selectedBagClosureType= new Set<String>(filters.selectedBagClosureTypeData);
            
            Set<String> selectedBagGender= new Set<String>(filters.selectedBagGenderData);
            
            Set<String> selectedBagBrand= new Set<String>(filters.selectedBagBrandData);
            
            Set<String> selectedBagColor= new Set<String>(filters.selectedBagColorData);
            
            Set<String> selectedBagCollection= new Set<String>(filters.selectedBagCollectionData);
            
            Set<String> selectedBagOccassion = new Set<String>(filters.selectedBagOccassionData);
            
            
            //Belt
            Set<String> selectedBeltType= new Set<String>(filters.selectedBeltTypeData);
            
            Set<String> selectedBeltGender= new Set<String>(filters.selectedBeltGenderData);
            
            Set<String> selectedBeltBrand= new Set<String>(filters.selectedBeltBrandData);
            
            Set<String> selectedBeltColor= new Set<String>(filters.selectedBeltColorData);
            
            Set<String> selectedBeltDressCode = new Set<String>(filters.selectedBeltDressCodeData);
            
            Set<String> selectedBeltLength = new Set<String>(filters.selectedBeltLengthData);
            
            //Wallet
            
            Set<String> selectedWalletGender= new Set<String>(filters.selectedWalletGenderData);
            
            Set<String> selectedWalletBrand= new Set<String>(filters.selectedWalletBrandData);
            
            Set<String> selectedWalletColor= new Set<String>(filters.selectedWalletColorData);
            
            Set<String> selectedWalletDressCode= new Set<String>(filters.selectedWalletDressCodeData);
            
            Set<String> selectedWalletType = new Set<String>(filters.selectedWalletTypeData);
            
            
            //Fragnances
            
            Set<String> selectedFragranceType= new Set<String>(filters.selectedFragranceTypeData);
            
            Set<String> selectedFragranceGender= new Set<String>(filters.selectedFragranceGenderData);
            
            Set<String> selectedFragranceBrand= new Set<String>(filters.selectedFragranceBrandData);
            
            Set<String> selectedFragranceFamily= new Set<String>(filters.selectedFragranceFamilyData);
            
            Set<String> selectedFragranceCollection = new Set<String>(filters.selectedFragranceCollectionData);
            
            Set<String> selectedFragranceQuantity = new Set<String>(filters.selectedFragranceQuantityData);
            
            //Earphones
            
            Set<String> selectedEarPhoneGender= new Set<String>(filters.selectedEarPhoneGenderData);
            
            Set<String> selectedEarPhoneBrand= new Set<String>(filters.selectedEarPhoneBrandData);
            
            Set<String> selectedEarPhoneColor= new Set<String>(filters.selectedEarPhoneColorData);
            
            Set<String> selectedEarPhoneCollection= new Set<String>(filters.selectedEarPhoneCollectionData);
            
            //Clocks
            
            Set<String> selectedClockGender= new Set<String>(filters.selectedClockGenderData);
            
            Set<String> selectedClockBrand= new Set<String>(filters.selectedClockBrandData);
            
            Set<String> selectedClockColor= new Set<String>(filters.selectedClockColorData);
            
            Set<String> selectedClockCollection= new Set<String>(filters.selectedClockCollectionData);
            
            Set<String> selectedClockFunction = new Set<String>(filters.selectedClockFunctionData);
            
            //Sunglasses
            
            Set<String> selectedSunglassGender= new Set<String>(filters.selectedSunglassGenderData);
            
            Set<String> selectedSunglassBrand= new Set<String>(filters.selectedSunglassBrandData);
            
            Set<String> selectedSunglassColor= new Set<String>(filters.selectedSunglassColorData);
            
            Set<String> selectedSunglassCollection= new Set<String>(filters.selectedSunglassCollectionData);
            
            
            //Watches
            Set<String> selectedWatchGender= new Set<String>(filters.selectedWatchGenderData);
            
            Set<String> selectedWatchBrand= new Set<String>(filters.selectedWatchBrandData);
            
            Set<String> selectedWatchStrapColor= new Set<String>(filters.selectedWatchStrapColorData);
            
            Set<String> selectedWatchStrapMaterial= new Set<String>(filters.selectedWatchStrapMaterialData);
            
            Set<String> selectedWatchDialColor= new Set<String>(filters.selectedWatchDialColorData);
            
            Set<String> selectedWatchCollection= new Set<String>(filters.selectedWatchCollectionData);
            
            Set<String> selectedWatchMovements= new Set<String>(filters.selectedWatchMovementsData);
            
            
            //EyeWear Sunglasses
            Set<String> selectedSunglassEyewearGender= new Set<String>(filters.selectedSunglassEyewearGenderData);
            
            Set<String> selectedSunglassEyewearRIM= new Set<String>(filters.selectedSunglassEyewearRIMData);
            
            Set<String> selectedSunglassEyewearBrand= new Set<String>(filters.selectedSunglassEyewearBrandData);
            
            Set<String> selectedSunglassEyewearCategory= new Set<String>(filters.selectedSunglassEyewearCategoryData);
            
            Set<String> selectedSunglassEyewearShape= new Set<String>(filters.selectedSunglassEyewearShapeData);
            
            Set<String> selectedSunglassEyewearFrameMaterial= new Set<String>(filters.selectedSunglassEyewearFrameMaterialData);
            
            Set<String> selectedSunglassEyewearLensColour= new Set<String>(filters.selectedSunglassEyewearLensColourData);
            
            Set<String> selectedSunglassEyewearSize= new Set<String>(filters.selectedSunglassEyewearSizeData);
            
            Set<String> selectedSunglassEyewearColour= new Set<String>(filters.selectedSunglassEyewearColourData);
            
            Set<String> selectedSunglassEyewearCollection= new Set<String>(filters.selectedSunglassEyewearCollectionData);
            
            List<Proposal_Tool_Filter__c> filterNotInEyewear = new List<Proposal_Tool_Filter__c>();
            filterNotInEyewear = [Select Label__c , Value__c, Product_Type__c, Type_Of_Filter__c from Proposal_Tool_Filter__c where Product_Type__c=:selectedValue And (Type_Of_Filter__c= 'EyeWear Category Not To Display' OR Type_Of_Filter__c= 'Watches Category Not To Display')];
            
            
            
            
            
            List<ProductDataWrapper> productWrapper = new List<ProductDataWrapper>();
            ProductDataWrapper pw;
            String selectedRecordType = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get(selectedValue).getRecordTypeId();
            
            String jsonDT = '';
            
            //Offset for SOQL
            Integer offset = (filters.pageNumber - 1) * filters.pageSize;
            
            //Total Records
            Integer totalRecords;
            String countQuery = 'SELECT COUNT() FROM Product_Master__c where RecordTypeId =:selectedRecordType';
            
            if(selectedValue=='Eyewear'){
                if(!filterNotInEyewear.isEmpty()){
                    List<String> dataNotToDisplay2 = filterNotInEyewear[0].Label__c.split(';');
                    countQuery +=  ' And attribute_set_name__c NOT IN :dataNotToDisplay2';
                    
                }
                if(searchValue !=''){
                    searchValue = '%'+searchValue+'%';
                    countQuery +=  ' And Name__c Like :searchValue';
                }
                
                if(selectedProductCategory=='Sunglasses'){
                    if(selectedProductCategory != ''){
                        countQuery +=  ' And attribute_set_name__c =: selectedProductCategory';
                    }
                    if(!selectedSunglassEyewearGender.isEmpty()){
                        countQuery +=  ' And frame_gender__c IN : selectedSunglassEyewearGender';
                    }
                    if(!selectedSunglassEyewearRIM.isEmpty()){
                        countQuery +=  ' And frame_type__c IN : selectedSunglassEyewearRIM';
                    }
                    if(!selectedSunglassEyewearBrand.isEmpty()){
                        countQuery +=  ' And brand__c IN : selectedSunglassEyewearBrand';
                    }
                    if(!selectedSunglassEyewearCategory.isEmpty()){//Pending
                        countQuery +=  ' And frame_gender__c IN : selectedGender';
                    }
                    if(!selectedSunglassEyewearShape.isEmpty()){
                        countQuery +=  ' And frame_front_shape__c IN : selectedSunglassEyewearShape';
                    }
                    if(!selectedSunglassEyewearFrameMaterial.isEmpty()){
                        countQuery +=  ' And frame_material__c IN : selectedSunglassEyewearFrameMaterial';
                    }
                    if(!selectedSunglassEyewearLensColour.isEmpty()){//Pending
                        countQuery +=  ' And front_color_user_sunglass__c IN : selectedSunglassEyewearLensColour';
                    }
                    if(!selectedSunglassEyewearSize.isEmpty()){
                        countQuery +=  ' And frame_size__c IN : selectedSunglassEyewearSize';
                    }
                    if(!selectedSunglassEyewearColour.isEmpty()){
                        countQuery +=  ' And front_color__c IN : selectedSunglassEyewearColour';
                    }
                    if(!selectedSunglassEyewearCollection.isEmpty()){
                        countQuery +=  ' And collection__c IN : selectedSunglassEyewearCollection';
                    }
                }else {
                    if(!selectedGender.isEmpty()){
                        countQuery +=  ' And frame_gender__c IN : selectedGender';
                    }
                    
                    if(!selectedColor.isEmpty()){
                        countQuery +=  ' And front_color__c IN : selectedColor';
                    }
                    
                    if(!selectedBrand.isEmpty()){
                        countQuery +=  ' And brand__c IN : selectedBrand';
                    }
                    
                    if(selectedProductCategory != 'All' && selectedProductCategory != ''){
                        countQuery +=  ' And attribute_set_name__c =: selectedProductCategory';
                    }
                }
                
                
                
                
                if(selectedPriceValue !=''){
                    if(selectedPriceValue.containsIgnoreCase('Above')){
                        List<String> priceData2 = new List<String>();
                        priceData2 = selectedPriceValue.split(',');
                        Double maxValue2 = Double.valueOf(priceData2[0]);
                        countQuery +=  ' And (List_Price__c >=: maxValue2)';
                    }else{
                        List<String> priceData2 = new List<String>();
                        priceData2 = selectedPriceValue.split(',');
                        Double firstValue2 = Double.valueOf(priceData2[0]);
                        Double secondValue2 = Double.valueOf(priceData2[1]);
                        countQuery +=  ' And (List_Price__c >=: firstValue2 And List_Price__c <=: secondValue2)';
                    }
                    
                    
                }
                
                countQuery += ' And List_Price__c > 0';
                
                totalRecords = Database.countQuery(countQuery);
                
                
            }else if(selectedValue=='Jewellery'){
                countQuery += ' And Product_To_Show__c = True';
                if(searchValue !=''){
                    searchValue = '%'+searchValue+'%';
                    countQuery +=  ' And (Title__c Like :searchValue Or Sellable_SKU__c Like : searchValue)';
                }
                
                if(!selectedGender.isEmpty()){
                    countQuery +=  ' And Gender__c IN : selectedGender';
                }
                
                
                if(!selectedColor.isEmpty()){
                    countQuery +=  ' And Metal_Color__c IN : selectedColor';
                }
                if(!selectedBrand.isEmpty()){
                    countQuery +=  ' And display_brand__c IN : selectedBrand';
                }
                
                
                if(selectedProductCategory != 'All' && selectedProductCategory != ''){
                    countQuery +=  ' And categories__c  =: selectedProductCategory';
                }
                if(selectedPriceValue !=''){
                    if(selectedPriceValue.containsIgnoreCase('Above')){
                        List<String> priceData1 = new List<String>();
                        priceData1 = selectedPriceValue.split(',');
                        Double maxValueJewel = Double.valueOf(priceData1[0]);
                        
                        
                        //Double secondValue1 = Double.valueOf(priceData1[1]);
                        //System.debug('firstValue-->'+firstValue1);
                        //System.debug('secondValue-->'+secondValue1);
                        
                        countQuery +=  ' And (List_Price__c >=: maxValueJewel)';
                    }else{
                        List<String> priceData1 = new List<String>();
                        priceData1 = selectedPriceValue.split(',');
                        Double firstValue1 = Double.valueOf(priceData1[0]);
                        
                        
                        Double secondValue1 = Double.valueOf(priceData1[1]);
                        System.debug('firstValue-->'+firstValue1);
                        System.debug('secondValue-->'+secondValue1);
                        
                        countQuery +=  ' And (List_Price__c >=: firstValue1 And List_Price__c <=: secondValue1)';
                    }
                    
                    
                }
                Set<String> categories = new Set<String>();
                categories.add('Silver Coin');
                categories.add('Gold Coin');
                countQuery +=  ' And Title__c != NUll And  List_Price__c > 0 And categories__c In : categories';
                
                totalRecords = Database.countQuery(countQuery);
            }else if(selectedValue=='Watches'){
                countQuery += ' And Product_To_Show__c = True';
                if(!filterNotInEyewear.isEmpty()){
                    List<String> dataNotToDisplay = filterNotInEyewear[0].Label__c.split(';');
                    countQuery +=  ' And Product_Category__c NOT IN :dataNotToDisplay';
                    
                }
                
                if(searchValue !=''){
                    searchValue = '%'+searchValue+'%';
                    countQuery +=  ' And (Title__c Like :searchValue Or Sellable_SKU__c Like : searchValue)';
                }
                
                if(selectedProductCategory =='Bags'){
                    if(selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    
                    if(!selectedBagGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedBagGender';
                    }
                    
                    if(!selectedBagBrand.isEmpty()){
                        countQuery +=  ' And display_brand__c IN : selectedBagBrand';
                    }
                    
                    if(!selectedBagColor.isEmpty()){
                        countQuery +=  ' And Color__c IN : selectedBagColor';
                    }
                    
                    if(!selectedBagOccassion.isEmpty()){
                        countQuery +=  ' And Occasion__c IN : selectedBagOccassion';
                    }
                    
                    if(!selectedBagCollection.isEmpty()){
                        countQuery +=  ' And collection__c IN : selectedBagCollection';
                    }
                    
                    if(!selectedBagType.isEmpty()){ 
                        countQuery +=  ' And Type__c IN : selectedBagType';
                    }
                    
                    if(!selectedBagMaterialBody.isEmpty()){
                        countQuery +=  ' And Material_Body__c IN :  selectedBagMaterialBody';
                    }
                    
                    if(!selectedBagMaterialLining.isEmpty()){
                        countQuery +=  ' And Material_Lining__c IN : selectedBagMaterialLining';
                    }
                    
                    if(!selectedBagClosureType.isEmpty()){
                        countQuery +=  ' And Closure_Type__c IN : selectedBagClosureType';
                    }
                }else if(selectedProductCategory =='Belts'){
                    if(selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    
                    if(!selectedBeltGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedBeltGender';
                    }
                    
                    if(!selectedBeltBrand.isEmpty()){
                        countQuery +=  ' And display_brand__c IN : selectedBeltBrand';
                    }
                    
                    if(!selectedBeltColor.isEmpty()){
                        countQuery +=  ' And Color__c IN : selectedBeltColor';
                    }
                    if(!selectedBeltType.isEmpty()){
                        countQuery +=  ' And Type__c IN : selectedBeltType';
                    }
                    
                    if(!selectedBeltDressCode.isEmpty()){
                        countQuery +=  ' And Dress_Code__c IN : selectedBeltDressCode';
                    }
                    
                    if(!selectedBeltLength.isEmpty()){
                        countQuery +=  ' And Total_Length_Inches__c IN : selectedBeltLength';
                    }
                    
                }else if(selectedProductCategory =='Clocks'){
                    if(selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedClockGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedClockGender';
                    }
                    if(!selectedClockBrand.isEmpty()){
                        countQuery +=  ' And Display_Brand__c IN : selectedClockBrand';
                    }
                    if(!selectedClockColor.isEmpty()){
                        countQuery +=  ' And Color__c IN : selectedClockColor';
                    }
                    if(!selectedClockCollection.isEmpty()){
                        countQuery +=  ' And collection__c IN : selectedClockCollection';
                    }
                    if(!selectedClockFunction.isEmpty()){
                        countQuery +=  ' And Function__c IN : selectedClockFunction';
                    }
                    
                }else if(selectedProductCategory =='Earphones'){
                    if(selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    
                    if(!selectedEarPhoneGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedEarPhoneGender';
                    }
                    if(!selectedEarPhoneBrand.isEmpty()){
                        countQuery +=  ' And Display_Brand__c IN : selectedEarPhoneBrand';
                    }
                    if(!selectedEarPhoneColor.isEmpty()){
                        countQuery +=  ' And Color__c IN : selectedEarPhoneColor';
                    }
                    if(!selectedEarPhoneCollection.isEmpty()){
                        countQuery +=  ' And collection__c IN : selectedEarPhoneCollection';
                    }
                }else if(selectedProductCategory =='Fragrances'){
                    if(selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedFragranceType.isEmpty()){
                        countQuery +=  ' And Fragrance_Type__c IN : selectedFragranceType';
                    }
                    if(!selectedFragranceGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedFragranceGender';
                    }
                    if(!selectedFragranceBrand.isEmpty()){
                        countQuery +=  ' And Display_Brand__c IN : selectedFragranceBrand';
                    }
                    if(!selectedFragranceFamily.isEmpty()){
                        countQuery +=  ' And Family__c IN : selectedFragranceFamily';
                    }
                    if(!selectedFragranceCollection.isEmpty()){
                        countQuery +=  ' And collection__c IN : selectedFragranceCollection';
                    }
                    if(!selectedFragranceQuantity.isEmpty()){
                        countQuery +=  ' And Quantity__c IN : selectedFragranceQuantity';
                    }
                    
                    
                    
                }else if(selectedProductCategory =='Sunglasses'){
                    if(selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedSunglassBrand.isEmpty()){
                        countQuery +=  ' And Display_Brand__c IN : selectedSunglassBrand';
                    }
                    if(!selectedSunglassGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedSunglassGender';
                    }
                    if(!selectedSunglassColor.isEmpty()){
                        countQuery +=  ' And Color__c IN : selectedSunglassColor';
                    }
                    if(!selectedSunglassCollection.isEmpty()){
                        countQuery +=  ' And collection__c IN : selectedSunglassCollection';
                    }
                    
                }else if(selectedProductCategory =='Wallets'){
                    if(selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedWalletGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedWalletGender';
                    }
                    
                    if(!selectedWalletBrand.isEmpty()){
                        countQuery +=  ' And display_brand__c IN : selectedWalletBrand';
                    }
                    
                    if(!selectedWalletColor.isEmpty()){
                        countQuery +=  ' And Color__c IN : selectedWalletColor';
                    }
                    if(!selectedWalletType.isEmpty()){
                        countQuery +=  ' And Type__c IN : selectedWalletType';
                    }
                    
                    if(!selectedWalletDressCode.isEmpty()){
                        countQuery +=  ' And Dress_Code__c IN : selectedWalletDressCode';
                    }
                    
                    
                    
                }else if(selectedProductCategory =='Watches'){
                    if(selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedWatchGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedWatchGender';
                    }
                    if(!selectedWatchBrand.isEmpty()){
                        countQuery +=  ' And display_brand__c IN : selectedWatchBrand';
                    }
                    if(!selectedWatchStrapColor.isEmpty()){
                        countQuery +=  ' And Strap_Color__c IN : selectedWatchStrapColor';
                    }
                    if(!selectedWatchStrapMaterial.isEmpty()){
                        countQuery +=  ' And Strap_Material__c IN : selectedWatchStrapMaterial';
                    }
                    if(!selectedWatchDialColor.isEmpty()){
                        countQuery +=  ' And Dial_Color__c IN : selectedWatchDialColor';
                    } 
                    if(!selectedWatchCollection.isEmpty()){
                        countQuery +=  ' And collection__c IN : selectedWatchCollection';
                    } 
                    if(!selectedWatchMovements.isEmpty()){
                        countQuery +=  ' And Movement__c IN : selectedWatchMovements';
                    } 
                    
                }else{
                    if(!selectedGender.isEmpty()){
                        countQuery +=  ' And Gender__c IN : selectedGender';
                    }
                    
                    if(!selectedColor.isEmpty()){
                        countQuery +=  ' And color__c IN : selectedColor';
                    }
                    
                    if(!selectedBrand.isEmpty()){
                        countQuery +=  ' And display_brand__c IN : selectedBrand';
                    }
                    if(selectedProductCategory!='All' && selectedProductCategory!=''){
                        countQuery +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    
                    
                }
                if(selectedPriceValue !=''){
                    if(selectedPriceValue.containsIgnoreCase('Above')){
                        List<String> priceData = new List<String>();
                        priceData = selectedPriceValue.split(',');
                        Double maxValue = Double.valueOf(priceData[0]);
                        //Double secondValue = Double.valueOf(priceData[1]);
                        countQuery +=  ' And (List_Price__c >=: maxValue)';
                    }else{
                        List<String> priceData = new List<String>();
                        priceData = selectedPriceValue.split(',');
                        Double firstValue = Double.valueOf(priceData[0]);
                        Double secondValue = Double.valueOf(priceData[1]);
                        countQuery +=  ' And (List_Price__c >=: firstValue And List_Price__c <=: secondValue)';
                    }
                }
                
                
                
                countQuery +=  ' And Title__c != NUll And List_Price__c >0';
                
                totalRecords = Database.countQuery(countQuery);
            }
            
            
            Integer recordEnd = filters.pageSize * filters.pageNumber;
            
            objDT.pageSize = filters.pageSize;
            objDT.pageNumber = filters.pageNumber;
            objDT.recordStart = offset + 1;
            objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
            objDT.totalRecords = totalRecords;
            
            String query = 'Select Id,Name,Name__c,Sellable_SKU__c,Is_Custom_Image__c,brand__c,price__c,display_brand__c,Max_Offer_Price__c,Offer_Price__c,List_Price__c,Title__c,description__c,Short_Description__c,Long_Description__c,images__c,All_Images__c,(Select Id,sku__c,Offer_price__c,List_Price__c from Product_SKUs1__r where List_Price__c >= 1 Order BY List_Price__c DESC LIMIT 1) from Product_Master__c';
            
            if(selectedValue=='Eyewear'){
                query +=  ' where RecordTypeId =:selectedRecordType';
                if(!filterNotInEyewear.isEmpty()){
                    List<String> dataNotToDisplay1 = filterNotInEyewear[0].Label__c.split(';');
                    query +=  ' And attribute_set_name__c NOT IN :dataNotToDisplay1';
                    
                }
                if(searchValue !=''){
                    searchValue = '%'+searchValue+'%';
                    query +=  ' And Name__c Like :searchValue';
                }
                if(selectedProductCategory=='Sunglasses'){
                    if(selectedProductCategory != ''){
                        query +=  ' And attribute_set_name__c =: selectedProductCategory';
                    }
                    if(!selectedSunglassEyewearGender.isEmpty()){
                        query +=  ' And frame_gender__c IN : selectedSunglassEyewearGender';
                    }
                    if(!selectedSunglassEyewearRIM.isEmpty()){
                        query +=  ' And frame_type__c IN : selectedSunglassEyewearRIM';
                    }
                    if(!selectedSunglassEyewearBrand.isEmpty()){
                        query +=  ' And brand__c IN : selectedSunglassEyewearBrand';
                    }
                    if(!selectedSunglassEyewearCategory.isEmpty()){//Pending
                        query +=  ' And frame_gender__c IN : selectedGender';
                    }
                    if(!selectedSunglassEyewearShape.isEmpty()){
                        query +=  ' And frame_front_shape__c IN : selectedSunglassEyewearShape';
                    }
                    if(!selectedSunglassEyewearFrameMaterial.isEmpty()){
                        query +=  ' And frame_material__c IN : selectedSunglassEyewearFrameMaterial';
                    }
                    if(!selectedSunglassEyewearLensColour.isEmpty()){//Pending
                        query +=  ' And front_color_user_sunglass__c IN : selectedSunglassEyewearLensColour';
                    }
                    if(!selectedSunglassEyewearSize.isEmpty()){
                        query +=  ' And frame_size__c IN : selectedSunglassEyewearSize';
                    }
                    if(!selectedSunglassEyewearColour.isEmpty()){
                        query +=  ' And front_color__c IN : selectedSunglassEyewearColour';
                    }
                    if(!selectedSunglassEyewearCollection.isEmpty()){
                        query +=  ' And collection__c IN : selectedSunglassEyewearCollection';
                    }
                }else{
                    if(!selectedGender.isEmpty()){
                        query +=  ' And frame_gender__c IN : selectedGender';
                    }
                    if(!selectedColor.isEmpty()){
                        query +=  ' And front_color__c IN : selectedColor';
                    }
                    if(!selectedBrand.isEmpty()){
                        query +=  ' And brand__c IN : selectedBrand';
                    }
                    if(selectedProductCategory != 'All' && selectedProductCategory != ''){
                        query +=  ' And attribute_set_name__c =: selectedProductCategory';
                    }
                }
                
                
                if(selectedPriceValue !=''){
                    if(selectedPriceValue.containsIgnoreCase('Above')){
                        List<String> priceData2 = new List<String>();
                        priceData2 = selectedPriceValue.split(',');
                        Double maxValue2 = Double.valueOf(priceData2[0]);
                        //Double secondValue2 = Double.valueOf(priceData2[1]);
                        System.debug('firstValue-->'+maxValue2);
                        //System.debug('secondValue-->'+secondValue2);
                        
                        query +=  ' And (List_Price__c >=: maxValue2)';
                    }else{
                        List<String> priceData2 = new List<String>();
                        priceData2 = selectedPriceValue.split(',');
                        Double firstValue2 = Double.valueOf(priceData2[0]);
                        Double secondValue2 = Double.valueOf(priceData2[1]);
                        System.debug('firstValue-->'+firstValue2);
                        System.debug('secondValue-->'+secondValue2);
                        
                        query +=  ' And (List_Price__c >=: firstValue2 And List_Price__c <=: secondValue2)';
                    }
                    
                }
                
                query += ' And List_Price__c > 0';
                if(sortBy != ''){
                    if(sortBy=='LowtoHigh'){
                        query +=  '  Order BY List_Price__c ASC NULLS LAST LIMIT :pageSize offset:offset';
                        
                    }else if(sortBy=='HightoLow'){
                        query +=  '  Order BY List_Price__c DESC NULLS LAST LIMIT :pageSize offset:offset';
                        
                    }
                    
                }else{
                    query +=  '  Order BY brand__c ASC NULLS LAST LIMIT :pageSize offset:offset';
                    
                }
                
                System.debug('query-->'+query);
            }else if(selectedValue=='Jewellery'){
                query +=  ' where RecordTypeId =:selectedRecordType';
                query += ' And Product_To_Show__c = True';
                
                
                if(searchValue !=''){
                    searchValue = '%'+searchValue+'%';
                    query +=  ' And (Title__c Like :searchValue Or Sellable_SKU__c Like : searchValue)';
                }
                
                if(!selectedGender.isEmpty()){
                    query +=  ' And Gender__c IN : selectedGender';
                }
                
                if(!selectedColor.isEmpty()){
                    query +=  ' And Metal_Color__c IN : selectedColor';
                }
                
                if(!selectedBrand.isEmpty()){
                    query +=  ' And display_brand__c IN : selectedBrand';
                }
                //Pending selectedBrand
                
                if(selectedProductCategory != 'All' && selectedProductCategory != ''){
                    query +=  ' And categories__c =: selectedProductCategory';
                }
                
                if(selectedPriceValue !=''){
                    if(selectedPriceValue.containsIgnoreCase('Above')){
                        List<String> priceData1 = new List<String>();
                        priceData1 = selectedPriceValue.split(',');
                        Double maxValueJewel = Double.valueOf(priceData1[0]);
                        
                        
                        //Double secondValue1 = Double.valueOf(priceData1[1]);
                        //System.debug('firstValue-->'+firstValue1);
                        //System.debug('secondValue-->'+secondValue1);
                        
                        query +=  ' And (List_Price__c >=: maxValueJewel)';
                    }else{
                        List<String> priceData1 = new List<String>();
                        priceData1 = selectedPriceValue.split(',');
                        Double firstValue1 = Double.valueOf(priceData1[0]);
                        
                        
                        Double secondValue1 = Double.valueOf(priceData1[1]);
                        System.debug('firstValue-->'+firstValue1);
                        System.debug('secondValue-->'+secondValue1);
                        
                        query +=  ' And (List_Price__c >=: firstValue1 And List_Price__c <=: secondValue1)';
                    }
                    
                }
                
                Set<String> categories = new Set<String>();
                categories.add('Silver Coin');
                categories.add('Gold Coin');
                query +=  ' And Title__c != NUll And List_Price__c > 0 And categories__c In : categories';               
                if(sortBy != ''){
                    if(sortBy=='LowtoHigh'){
                        query +=  ' Order BY List_Price__c ASC NULLS LAST LIMIT :pageSize offset:offset';
                        
                    }else if(sortBy=='HightoLow'){
                        query +=  ' Order BY List_Price__c DESC NULLS LAST LIMIT :pageSize offset:offset';
                        
                    }
                }else{
                    query +=  ' Order BY display_brand__c ASC NULLS LAST LIMIT :pageSize offset:offset';
                    
                }
                
                
                
            }else if(selectedValue=='Watches'){
                query +=  ' where RecordTypeId =:selectedRecordType';
                query += ' And Product_To_Show__c = True';
                if(!filterNotInEyewear.isEmpty()){
                    List<String> dataNotToDisplay = filterNotInEyewear[0].Label__c.split(';');
                    query +=  ' And Product_Category__c NOT IN :dataNotToDisplay';
                    
                }
                
                
                if(searchValue !=''){
                    searchValue = '%'+searchValue+'%';
                    query +=  ' And (Title__c Like :searchValue Or Sellable_SKU__c Like : searchValue)';
                }
                
                if(selectedProductCategory =='Bags'){
                    if(selectedProductCategory != ''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedBagGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedBagGender';
                    }
                    if(!selectedBagBrand.isEmpty()){
                        query +=  ' And display_brand__c IN : selectedBagBrand';
                    }
                    if(!selectedBagColor.isEmpty()){
                        query +=  ' And Color__c IN : selectedBagColor';
                    }
                    if(!selectedBagOccassion.isEmpty()){
                        query +=  ' And Occasion__c IN : selectedBagOccassion';
                    }
                    if(!selectedBagCollection.isEmpty()){
                        query +=  ' And collection__c IN : selectedBagCollection';
                    }
                    if(!selectedBagType.isEmpty()){
                        query +=  ' And Type__c  IN : selectedBagType';
                    }
                    if(!selectedBagMaterialBody.isEmpty()){
                        query +=  ' And Material_Body__c  IN : selectedBagMaterialBody';
                    }
                    if(!selectedBagMaterialLining.isEmpty()){
                        query +=  ' And Material_Lining__c  IN : selectedBagMaterialLining';
                    }
                    
                    if(!selectedBagClosureType.isEmpty()){
                        query +=  ' And Closure_Type__c   IN : selectedBagClosureType';
                    }
                    
                }else if(selectedProductCategory =='Belts'){
                    if(selectedProductCategory!=''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedBeltGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedBeltGender';
                    }
                    if(!selectedBeltBrand.isEmpty()){
                        query +=  ' And display_brand__c IN : selectedBeltBrand';
                    }
                    if(!selectedBeltColor.isEmpty()){
                        query +=  ' And Color__c IN : selectedBeltColor';
                    }
                    if(!selectedBeltType.isEmpty()){
                        query +=  ' And Type__c IN : selectedBeltType';
                    }
                    if(!selectedBeltDressCode.isEmpty()){
                        query +=  ' And Dress_Code__c IN : selectedBeltDressCode';
                    }
                    if(!selectedBeltLength.isEmpty()){
                        query +=  ' And Total_Length_Inches__c IN : selectedBeltLength';
                    }
                    
                }else if(selectedProductCategory =='Clocks'){
                    if(selectedProductCategory!=''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedClockGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedClockGender';
                    }
                    if(!selectedClockBrand.isEmpty()){
                        query +=  ' And Display_Brand__c IN : selectedClockBrand';
                    }
                    if(!selectedClockColor.isEmpty()){
                        query +=  ' And Color__c IN : selectedClockColor';
                    }
                    if(!selectedClockCollection.isEmpty()){
                        query +=  ' And collection__c IN : selectedClockCollection';
                    }
                    if(!selectedClockFunction.isEmpty()){
                        query +=  ' And Function__c IN : selectedClockFunction';
                    }
                }else if(selectedProductCategory =='Earphones'){
                    if(selectedProductCategory!=''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedEarPhoneGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedEarPhoneGender';
                    }
                    if(!selectedEarPhoneBrand.isEmpty()){
                        query +=  ' And Display_Brand__c IN : selectedEarPhoneBrand';
                    }
                    if(!selectedEarPhoneColor.isEmpty()){
                        query +=  ' And Color__c IN : selectedEarPhoneColor';
                    }
                    if(!selectedEarPhoneCollection.isEmpty()){
                        query +=  ' And collection__c IN : selectedEarPhoneCollection';
                    }
                    
                }else if(selectedProductCategory =='Fragrances'){
                    if(selectedProductCategory!=''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                        
                    }
                    if(!selectedFragranceType.isEmpty()){
                        query +=  ' And Fragrance_Type__c IN : selectedFragranceType';
                    }
                    if(!selectedFragranceGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedFragranceGender';
                    }
                    if(!selectedFragranceBrand.isEmpty()){
                        query +=  ' And Display_Brand__c IN : selectedFragranceBrand';
                    }
                    if(!selectedFragranceFamily.isEmpty()){
                        query +=  ' And Family__c IN : selectedFragranceFamily';
                    }
                    if(!selectedFragranceCollection.isEmpty()){
                        query +=  ' And collection__c IN : selectedFragranceCollection';
                    }
                    if(!selectedFragranceQuantity.isEmpty()){
                        query +=  ' And Quantity__c IN : selectedFragranceQuantity';
                    }
                    
                }else if(selectedProductCategory =='Sunglasses'){
                    if(selectedProductCategory!=''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedSunglassBrand.isEmpty()){
                        query +=  ' And Display_Brand__c IN : selectedSunglassBrand';
                    }
                    if(!selectedSunglassGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedSunglassGender';
                    }
                    if(!selectedSunglassColor.isEmpty()){
                        query +=  ' And Color__c IN : selectedSunglassColor';
                    }
                    if(!selectedSunglassCollection.isEmpty()){
                        query +=  ' And collection__c IN : selectedSunglassCollection';
                    }
                    
                }else if(selectedProductCategory =='Wallets'){
                    if(selectedProductCategory!=''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    
                    if(!selectedWalletGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedWalletGender';
                    }
                    
                    if(!selectedWalletBrand.isEmpty()){
                        query +=  ' And display_brand__c IN : selectedWalletBrand';
                    }
                    
                    if(!selectedWalletColor.isEmpty()){
                        query +=  ' And Color__c IN : selectedWalletColor';
                    }
                    if(!selectedWalletType.isEmpty()){
                        query +=  ' And Type__c IN : selectedWalletType';
                    }
                    
                    if(!selectedWalletDressCode.isEmpty()){
                        query +=  ' And Dress_Code__c IN : selectedWalletDressCode';
                    }                    
                }else if(selectedProductCategory =='Watches'){
                    if(selectedProductCategory!=''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    if(!selectedWatchGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedWatchGender';
                    }
                    if(!selectedWatchBrand.isEmpty()){
                        query +=  ' And display_brand__c IN : selectedWatchBrand';
                    }
                    if(!selectedWatchStrapColor.isEmpty()){
                        query +=  ' And Strap_Color__c IN : selectedWatchStrapColor';
                    }
                    if(!selectedWatchStrapMaterial.isEmpty()){
                        query +=  ' And Strap_Material__c IN : selectedWatchStrapMaterial';
                    }
                    if(!selectedWatchDialColor.isEmpty()){
                        query +=  ' And Dial_Color__c IN : selectedWatchDialColor';
                    } 
                    if(!selectedWatchCollection.isEmpty()){
                        query +=  ' And collection__c IN : selectedWatchCollection';
                    } 
                    if(!selectedWatchMovements.isEmpty()){
                        query +=  ' And Movement__c IN : selectedWatchMovements';
                    } 
                }else{
                    if(!selectedGender.isEmpty()){
                        query +=  ' And Gender__c IN : selectedGender';
                    }
                    if(!selectedColor.isEmpty()){
                        query +=  ' And color__c IN : selectedColor';
                    }
                    if(!selectedBrand.isEmpty()){
                        query +=  ' And display_brand__c IN : selectedBrand';
                    }
                    if(selectedProductCategory!='All' && selectedProductCategory!=''){
                        query +=  ' And Product_Category__c =: selectedProductCategory';
                    }
                    
                    
                }
                if(selectedPriceValue !=''){
                    if(selectedPriceValue.containsIgnoreCase('Above')){
                        List<String> priceData = new List<String>();
                        priceData = selectedPriceValue.split(',');
                        Double maxValue = Double.valueOf(priceData[0]);
                        //Double secondValue = Double.valueOf(priceData[1]);
                        query +=  ' And List_Price__c >=: maxValue';
                        System.debug('selectedPriceValue'+selectedPriceValue);
                    }else{
                        List<String> priceData = new List<String>();
                        priceData = selectedPriceValue.split(',');
                        Double firstValue = Double.valueOf(priceData[0]);
                        Double secondValue = Double.valueOf(priceData[1]);
                        query +=  ' And (List_Price__c >=: firstValue And List_Price__c <=: secondValue)';
                        System.debug('selectedPriceValue'+selectedPriceValue);
                        
                    }
                    
                }
                System.debug('query'+query);
                
                
                
                
                
                query +=  ' And Title__c != NUll And List_Price__c > 0';
                if(sortBy != ''){
                    if(sortBy=='LowtoHigh'){
                        query +=  ' Order BY List_Price__c ASC NULLS LAST LIMIT :pageSize offset:offset';
                        
                    }else if(sortBy=='HightoLow'){
                        query +=  ' Order BY List_Price__c DESC NULLS LAST LIMIT :pageSize offset:offset';
                        
                    }
                    
                }else{
                    query +=  ' Order BY display_brand__c ASC NULLS LAST LIMIT :pageSize offset:offset';
                    
                }
                
            }
            
            List<Product_Master__c> mainList = new List<Product_Master__c>();
            mainList = Database.query(query);
            
            System.debug('mainList-->'+mainList.size());
            for(Product_Master__c master : mainList){
                pw = new ProductDataWrapper();
                pw.productId = master.Id;
                pw.productLongDescription = master.description__c;
                System.debug('master-->'+master);
                if(selectedValue == 'Eyewear' && master.List_Price__c>0){
                    System.debug('master-->'+master);
                    
                    if(master.images__c != null && master.images__c !=''){
                        System.debug('masterName__c-->'+master.Name);
                        
                        pw.productShortDescription = master.Name__c;
                        pw.productBrand = master.brand__c;
                        pw.sellebleSKU = master.Sellable_SKU__c;
                        pw.productListPrice = master.List_Price__c;
                        pw.productOfferPrice = master.Offer_Price__c;
                        Decimal rounded = (master.List_Price__c !=null && master.Offer_Price__c !=null)?((master.List_Price__c-master.Offer_Price__c)/master.List_Price__c)*100:0;
                        pw.percentageValue = rounded.setScale(0, RoundingMode.HALF_UP);
                        if(rounded>0){
                            pw.offerIsThere = true;
                        }
                        if(master.Is_Custom_Image__c){
                            pw.productImages.add(master.images__c.unescapeHTML4());
                            pw.productDisplayImage =master.images__c.unescapeHTML4();
                        }else{
                            pw.productImages=master.images__c.split(',');
                            pw.productDisplayImage = master.images__c.split(',')[0];
                        }
                        productWrapper.add(pw);
                    }
                }
                if(selectedValue == 'Jewellery'){
                    System.debug('master-->'+master.Max_Offer_Price__c);
                    List<Product_SKU__c> pro = new List<Product_SKU__c>();
                    pro.addAll(master.Product_SKUs1__r);
                    
                    if(master.All_Images__c != null && master.All_Images__c !='' && master.Title__c != null){
                        String title =master.Title__c;
                        
                        pw.productShortDescription = title;
                        
                        if(!pro.isEmpty()){
                            pw.sellebleSKU = master.Sellable_SKU__c;
                            
                            pw.productListPrice = master.List_Price__c;
                            pw.productOfferPrice = master.Offer_Price__c;
                            Decimal rounded = (master.List_Price__c !=null && master.Offer_Price__c !=null)?((master.List_Price__c-master.Offer_Price__c)/master.List_Price__c)*100:0;
                            pw.percentageValue = rounded.setScale(0, RoundingMode.HALF_UP);
                            if(rounded>0){
                                pw.offerIsThere = true;
                            }
                        }else{
                            pw.sellebleSKU = 'NA';
                            
                            pw.productListPrice = 0;
                            pw.productOfferPrice = 0;
                            pw.percentageValue = 0;
                            
                        }
                        pw.productBrand = master.display_brand__c;                  
                        if(master.Is_Custom_Image__c){
                            pw.productImages.add(master.All_Images__c.unescapeHTML4());
                            pw.productDisplayImage =master.All_Images__c.unescapeHTML4();
                        }else{
                            pw.productImages=master.All_Images__c.split(',');
                            pw.productDisplayImage = master.All_Images__c.split(',')[0];
                        }
                        productWrapper.add(pw);
                    }
                    
                }
                
                if(selectedValue == 'Watches'){
                    //System.debug('master.Product_SKUs__r-->'+master.Product_SKUs1__r);
                    List<Product_SKU__c> pro = new List<Product_SKU__c>();
                    pro.addAll(master.Product_SKUs1__r);
                    
                    
                    if(master.All_Images__c != null && master.All_Images__c !='' && master.Title__c != null){
                        String title =master.Title__c;
                        
                        pw.productShortDescription = title;
                        
                        pw.productBrand = master.display_brand__c;                  
                        if(!pro.isEmpty()){
                            pw.sellebleSKU = master.Sellable_SKU__c;
                            pw.productListPrice = master.List_Price__c;
                            pw.productOfferPrice = master.Offer_Price__c;
                            Decimal rounded = (master.List_Price__c !=null && master.Offer_Price__c !=null)?((master.List_Price__c-master.Offer_Price__c)/master.List_Price__c)*100:0;
                            pw.percentageValue = rounded.setScale(0, RoundingMode.HALF_UP);
                            if(rounded>0){
                                pw.offerIsThere = true;
                            }
                        }else{
                            pw.productListPrice = 0;
                            pw.productOfferPrice = 0;
                            pw.percentageValue = 0;
                            pw.sellebleSKU = 'NA';
                            
                        }
                        
                        if(master.Is_Custom_Image__c){
                            pw.productImages.add(master.All_Images__c.unescapeHTML4());
                            pw.productDisplayImage =master.All_Images__c.unescapeHTML4();
                        }else{
                            pw.productImages=master.All_Images__c.split(',');
                            pw.productDisplayImage = master.All_Images__c.split(',')[0];
                        }
                        
                        productWrapper.add(pw);
                    }
                    
                }
                
            }
            objDT.productWrapper = productWrapper;        
            
        } catch (Exception e) {
            System.debug('e-->'+e.getLineNumber());
            System.debug('e-->'+e.getMessage());
            
            throw new AuraHandledException(e.getMessage());
        }
        return JSON.serialize(objDT);
    }
    
    @AuraEnabled
    public static String createImageUniqueRecord(String uniqueValueKey){
        try{
            if(uniqueValueKey != '' && uniqueValueKey != null){
                List<Proposals_Images__c> proImages = new List<Proposals_Images__c>();
                proImages = [Select Id,ProductExternalId__c from Proposals_Images__c where ProductExternalId__c =:uniqueValueKey LIMIT 1];
                if(!proImages.isEmpty()){
                    return proImages[0].Id;
                }else{
                    Proposals_Images__c proCustomImages = new Proposals_Images__c();
                    proCustomImages.ProductExternalId__c = uniqueValueKey;
                    insert proCustomImages;
                    return proCustomImages.Id;
                }
            }
            return '';
        }catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    
    @AuraEnabled
    public static String contentVersionProcessToAttachments(List<String> filesIds,String parentId,String selectedProduct){
        
        System.debug('filesIds-->'+filesIds);
        List<String> nameOfFiles = new List<String>();
        List<Attachment> attachmentList = new List<Attachment>();
        List<ContentDocument> contentDocument = new List<ContentDocument>();
        try{
            for(ContentVersion contentVersion : [Select Title,VersionData,ContentDocumentId from ContentVersion where ContentDocumentId =:filesIds]){
                Attachment attachment = new Attachment();
                attachment.Body = contentVersion.VersionData;
                attachment.Name = selectedProduct+'-'+contentVersion.Title;
                attachment.ParentId = parentId; 
                attachmentList.add(attachment);
                contentDocument.add(new ContentDocument(
                    Id = contentVersion.ContentDocumentId
                ));
            }
            if(!attachmentList.isEmpty()){
                insert attachmentList;
            }
            if(!contentDocument.isEmpty()){
                delete contentDocument;
            }
            return JSON.serialize(attachmentList);
            
        }catch(Exception e) {
            System.debug(e.getMessage());
            System.debug(e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    //Method for Generating the Proposals
    @AuraEnabled
    public static String generateProposal(String productsFromCart,String opportunityId,String uniqueIdOfProductImages,Boolean isHidePrice){
        try {
            List<ProposalToolGeneratePDFData.ProductWrapper> mainData = new List<ProposalToolGeneratePDFData.ProductWrapper>();
            mainData = (List<ProposalToolGeneratePDFData.ProductWrapper>)JSON.deserialize(productsFromCart, List<ProposalToolGeneratePDFData.ProductWrapper>.class);
            List<Attachment> attached = new List<Attachment>();
            attached = [Select Id,Name from Attachment where ParentId =: uniqueIdOfProductImages];
            Proposal__c pc = new Proposal__c();
            if(opportunityId != null && opportunityId !=''){
                pc.Opportunity__c =  opportunityId;
            }
            insert pc;
            
            
            Proposal_Products__c  ps;
            List<Proposal_Products__c> products = new List<Proposal_Products__c>();
            Set<String> productIds = new Set<String>();
            for(ProposalToolGeneratePDFData.ProductWrapper proData : mainData){
                ps = new Proposal_Products__c();
                ps.Proposal__c  = pc.Id;
                ps.Product__c = proData.productId;
                ps.Quantity__c  = proData.quantity;
                ps.Images_URL__c = proData.productImage;
                ps.List_Price__c  = proData.price;
                ps.Product_Brand__c = proData.productBrand;
                ps.Sellable_SKU__c = proData.sellebleSKU;
                ps.Product_Full_Name__c = proData.productFullName;
                ps.List_Price__c = proData.productListPrice;
                ps.Offer_Price__c = proData.productOfferPrice;
                ps.Is_Hide_Pride__c = isHidePrice;
                
                if(!attached.isEmpty() && proData.productId != null){
                    for(Attachment attachment : attached){
                        String name = attachment.Name;
                        name = name.subString(0,18);
                        if(name == proData.productId){
                            if(ps.Custom_Images__c == ''||ps.Custom_Images__c == null){
                                ps.Custom_Images__c = '/servlet/servlet.FileDownload?file='+attachment.Id;
                            }else{
                                ps.Custom_Images__c +=',/servlet/servlet.FileDownload?file='+attachment.Id;
                            }
                        }
                    }
                }
                products.add(ps);
            }
            
            if(!products.isEmpty()){
                insert products;
            }
            if(pc.Id != null && !products.isEmpty()){
                Database.executeBatch(new ProposalProductDataProcessInPDFBatch(new Set<String>{pc.Id}),1);
            }
            return String.valueOf(pc.Id);
        } catch (Exception e) {
            System.debug(e.getMessage());
            System.debug(e.getLineNumber());
            
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    
    public static void dynamicFilterCreation(){
        
    }
    
    //Wrapper for the Pagination
    public class MainWrapper{
        @AuraEnabled public Integer pageSize {get;set;}
        @AuraEnabled public Integer pageNumber {get;set;}
        @AuraEnabled public Integer totalRecords {get;set;}
        @AuraEnabled public Integer recordStart {get;set;}
        @AuraEnabled public Integer recordEnd {get;set;}
        @AuraEnabled public List<ProductDataWrapper> productWrapper {get;set;}
    }
    
    //Wrapper for the Product Data
    public class ProductDataWrapper{
        @AuraEnabled public String productId{get;set;}
        @AuraEnabled public List<String> productImages{get;set;}
        @AuraEnabled public String productDisplayImage{get;set;}
        @AuraEnabled public String productShortDescription{get;set;}
        @AuraEnabled public String productBrand{get;set;}
        @AuraEnabled public String productLongDescription{get;set;}
        @AuraEnabled public String productReference{get;set;}      
        @AuraEnabled public String sellebleSKU {get;set;}
        @AuraEnabled public Decimal productListPrice{get;set;}
        @AuraEnabled public Decimal productOfferPrice{get;set;}
        @AuraEnabled public Decimal percentageValue {get;set;}
        @AuraEnabled public Boolean offerIsThere {get;set;}
        public ProductDataWrapper(){
            productImages = new List<String>();
        }
    }    
    
    //Wrapper for the Filters Values
    public class FilterWrapper{
        public Integer pageSize;
        public Integer pageNumber;
        public String selectedValue;
        public String searchName;
        public List<String> selectedGender;
        public List<String> selectedColor;
        public String selectedProductCategory;
        public List<String> selectedBrand;
        public String sortBy;
        public String selectedPriceValue;
        //Bags
        public List<String> selectedBagTypeData;
        public List<String> selectedBagMaterialBodyData;
        public List<String> selectedBagMaterialLiningData;
        public List<String> selectedBagClosureTypeData;
        public List<String> selectedBagGenderData;
        public List<String> selectedBagBrandData;
        public List<String> selectedBagColorData;
        public List<String> selectedBagCollectionData;
        public List<String> selectedBagOccassionData;
        
        //Belts
        public List<String> selectedBeltTypeData;
        public List<String> selectedBeltGenderData;
        public List<String> selectedBeltBrandData;
        public List<String> selectedBeltColorData;
        public List<String> selectedBeltDressCodeData;
        public List<String> selectedBeltLengthData;
        
        //Wallets
        public List<String> selectedWalletGenderData;
        public List<String> selectedWalletBrandData;
        public List<String> selectedWalletColorData;
        public List<String> selectedWalletDressCodeData;
        public List<String> selectedWalletTypeData;
        
        //Fragnance
        public List<String> selectedFragranceTypeData;
        public List<String> selectedFragranceGenderData;
        public List<String> selectedFragranceBrandData;
        public List<String> selectedFragranceFamilyData;
        public List<String> selectedFragranceCollectionData;
        public List<String> selectedFragranceQuantityData;
        
        //EarPhone
        public List<String> selectedEarPhoneGenderData;
        public List<String> selectedEarPhoneBrandData;
        public List<String> selectedEarPhoneColorData;
        public List<String> selectedEarPhoneCollectionData;
        
        //Clock
        public List<String> selectedClockGenderData;
        public List<String> selectedClockBrandData;
        public List<String> selectedClockColorData;
        public List<String> selectedClockCollectionData;
        public List<String> selectedClockFunctionData;
        
        //Sunglasses
        public List<String> selectedSunglassGenderData;
        public List<String> selectedSunglassBrandData;
        public List<String> selectedSunglassColorData;
        public List<String> selectedSunglassCollectionData;
        
        //Watches
        public List<String> selectedWatchGenderData;
        public List<String> selectedWatchBrandData;
        public List<String> selectedWatchStrapColorData;
        public List<String> selectedWatchStrapMaterialData;
        public List<String> selectedWatchDialColorData;
        public List<String> selectedWatchCollectionData;
        public List<String> selectedWatchMovementsData;
        
        
        //EyeWear Sunglasses
        public List<String> selectedSunglassEyewearGenderData;
        public List<String> selectedSunglassEyewearRIMData;
        public List<String> selectedSunglassEyewearBrandData;
        public List<String> selectedSunglassEyewearCategoryData;
        public List<String> selectedSunglassEyewearShapeData;
        public List<String> selectedSunglassEyewearFrameMaterialData;
        public List<String> selectedSunglassEyewearLensColourData;
        public List<String> selectedSunglassEyewearSizeData;
        public List<String> selectedSunglassEyewearColourData;
        public List<String> selectedSunglassEyewearCollectionData;
        
        public FilterWrapper(){
            selectedGender = new List<String>();
            selectedColor = new List<String>();
            //selectedProductCategory = new List<String>();
            selectedBrand = new List<String>();
            //Bags
            selectedBagTypeData = new List<String>();
            selectedBagMaterialBodyData = new List<String>();
            selectedBagMaterialLiningData = new List<String>();
            selectedBagClosureTypeData = new List<String>();
            selectedBagGenderData = new List<String>();
            selectedBagBrandData = new List<String>();
            selectedBagColorData = new List<String>();
            selectedBagOccassionData = new List<String>();
            
            //Belts
            selectedBeltTypeData = new List<String>();
            selectedBeltGenderData = new List<String>();
            selectedBeltBrandData = new List<String>();
            selectedBeltColorData = new List<String>();
            selectedBeltDressCodeData = new List<String>();
            selectedBeltLengthData = new List<String>();
            
            //Wallets
            selectedWalletGenderData = new List<String>();
            selectedWalletBrandData= new List<String>();
            selectedWalletColorData= new List<String>();
            selectedWalletDressCodeData= new List<String>();
            selectedWalletTypeData=new List<String>();
            
            //Fragnance
            selectedFragranceTypeData = new List<String>();
            selectedFragranceGenderData = new List<String>();
            selectedFragranceBrandData = new List<String>();
            selectedFragranceFamilyData = new List<String>();
            selectedFragranceCollectionData = new List<String>();
            selectedFragranceQuantityData = new List<String>();
            
            //EarPhone
            selectedEarPhoneGenderData = new List<String>();
            selectedEarPhoneBrandData = new List<String>();
            selectedEarPhoneColorData = new List<String>();
            selectedEarPhoneCollectionData = new List<String>();
            
            //Clock
            selectedClockGenderData = new List<String>();
            selectedClockBrandData = new List<String>();
            selectedClockColorData = new List<String>();
            selectedClockCollectionData = new List<String>();
            selectedClockFunctionData = new List<String>();
            
            //Sunglasses
            selectedSunglassGenderData = new List<String>();
            selectedSunglassBrandData = new List<String>();
            selectedSunglassColorData = new List<String>();
            selectedSunglassCollectionData = new List<String>();
            
            //Watches
            selectedWatchGenderData = new List<String>();
            selectedWatchBrandData = new List<String>();
            selectedWatchStrapColorData = new List<String>();
            selectedWatchStrapMaterialData = new List<String>();
            selectedWatchDialColorData = new List<String>();
            selectedWatchCollectionData = new List<String>();
            selectedWatchMovementsData = new List<String>();
            
            //EyeWear Sunglasses
            selectedSunglassEyewearGenderData = new List<String>();
            selectedSunglassEyewearRIMData = new List<String>();
            selectedSunglassEyewearBrandData = new List<String>();
            selectedSunglassEyewearCategoryData = new List<String>();
            selectedSunglassEyewearShapeData = new List<String>();
            selectedSunglassEyewearFrameMaterialData = new List<String>();
            selectedSunglassEyewearLensColourData = new List<String>();
            selectedSunglassEyewearSizeData = new List<String>();
            selectedSunglassEyewearColourData = new List<String>();
            selectedSunglassEyewearCollectionData = new List<String>();
            
        }
    }  
}