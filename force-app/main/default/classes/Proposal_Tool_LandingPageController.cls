/*Created By : KVP- Chakresh Verma
*Name : Proposal_Tool_LandingPageController
*Created on : 25 Nov 2021
*Description : This Class is controller for thr Product Landing Component and Used to Generate Filters based on the Selected Record Type
*/

public class Proposal_Tool_LandingPageController {
    //This Method is used to fetch the filters from Static resource and return the data based on the selected Record Type
    @AuraEnabled
    public static String fetchFiltersValues(String selectedFilters){
        Map<String,List<String>> mapOfValues = new Map<String,List<String>>();
        try{
            StaticResource filtersCSVStaticResource ;
            List<Proposal_Tool_Filter__c> filterValue = new List<Proposal_Tool_Filter__c>();
            if(selectedFilters=='Eyewear'){
                filterValue = [Select Label__c , Value__c, Product_Type__c, Type_Of_Filter__c from Proposal_Tool_Filter__c where Product_Type__c=:selectedFilters];
            }else if(selectedFilters=='Watches'){
                filterValue = [Select Label__c , Value__c, Product_Type__c, Type_Of_Filter__c from Proposal_Tool_Filter__c where Product_Type__c=:selectedFilters];
            }else if(selectedFilters=='Jewellery'){
                filterValue = [Select Label__c , Value__c, Product_Type__c, Type_Of_Filter__c from Proposal_Tool_Filter__c where Product_Type__c=:selectedFilters];
            } 
            
            for(Proposal_Tool_Filter__c productFilter: filterValue){
                if(productFilter.Type_Of_Filter__c == 'Product Category'){
                    String values = productFilter.Label__c;
                    values = values.replace('\r','');
                    mapOfValues.put('ProductCategoryLabel',values.split(';'));
                }else if(productFilter.Type_Of_Filter__c == 'Color'){
                    String values = productFilter.Label__c;
                    values = values.replace('\r','');
                    mapOfValues.put('ColorLabel',values.split(';'));
                    
                }else if(productFilter.Type_Of_Filter__c == 'Gender'){
                    String values = productFilter.Label__c;
                    values = values.replace('\r','');
                    mapOfValues.put('GenderLabel',values.split(';'));
                    
                }else if(productFilter.Type_Of_Filter__c == 'Brand'){
                    String values = productFilter.Label__c;
                    values = values.replace('\r','');
                    mapOfValues.put('BrandLabel',values.split(';'));
                    
                }else if(productFilter.Product_Type__c == 'Watches'){
                    
                    //Bags Filters
                    if(productFilter.Type_Of_Filter__c == 'Bag Type'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagType',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Bag Material (Body)'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagMaterialBody',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Bag Material (Lining)'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagMaterialLining',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Bag Closure Type'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagClosureType',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Bags Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagsGender',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Bags Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagsBrand',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Bags Color'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagsColor',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Bags Collection'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagsCollection',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Bags Occasion'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BagsOccassion',values.split(';'));
                    }
                    //Belt Filters
                    else if(productFilter.Type_Of_Filter__c == 'Belt Type'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BeltsType',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Belts Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BeltsGender',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Belts Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BeltsBrand',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Belts Color'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BeltsColor',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Belts Dress Code'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BeltsDressCode',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Belts Length'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('BeltsLength',values.split(';'));
                    }
                    
                    //Wallets  Filters
                    else if(productFilter.Type_Of_Filter__c == 'Wallets Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WalletsGender',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Wallets Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WalletsBrand',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Wallets Color'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WalletsColor',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Wallets Dress Code'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WalletsDressCode',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Wallets Type'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WalletsType',values.split(';'));
                    }
                    //Fragrances Filters
                    else if(productFilter.Type_Of_Filter__c == 'Fragrances Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('FragrancesGender',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Fragrances Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('FragrancesBrand',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Fragrances Collection'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('FragrancesCollection',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Fragrances Fragrance Type'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('FragrancesFragranceType',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Fragrances Family'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('FragrancesFamily',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Fragrances Quantity'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('FragrancesQuantity',values.split(';'));
                    }
                    
                    //Earphones Filters
                    else if(productFilter.Type_Of_Filter__c == 'Earphones Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('EarphonesGender',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Earphones Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('EarphonesBrand',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Earphones Color'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('EarphonesColor',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Earphones Collection'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('EarphonesCollection',values.split(';'));
                    }
                    
                    //Clocks filters
                    else if(productFilter.Type_Of_Filter__c == 'Clocks Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('ClocksGender',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Clocks Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('ClocksBrand',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Clocks Color'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('ClocksColor',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Clocks Collection'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('ClocksCollection',values.split(';'));
                    }//-----------------------------------------------------------------------------------------------------------
                    else if(productFilter.Type_Of_Filter__c == 'Clocks Function'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('ClocksFunction',values.split(';'));
                    }
                    //SunGlasses Filters
                    else if(productFilter.Type_Of_Filter__c == 'SunGlasses Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesGender',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesBrand',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Color'){
                        //String values = productFilter.Label__c;
                        //values = values.replace('\r','');
                        //mapOfValues.put('SunGlassesColor',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'SunGlasses Collection'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesCollection',values.split(';'));
                    }
                    //Watches Filters
                    else if(productFilter.Type_Of_Filter__c == 'Watches Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WatchesGender',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Watches Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WatchesBrand',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Watches Collection'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WatchesCollection',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Watches Strap Color'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WatchesStrapColor',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'Watches Strap Material'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WatchesStrapMaterial',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Watches Dial Color'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WatchesDialColor',values.split(';'));
                    }
                    else if(productFilter.Type_Of_Filter__c == 'Watches Movements'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('WatchesMovements',values.split(';'));
                    }
                    
                }else if(productFilter.Product_Type__c=='Eyewear'){
                    if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Gender'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearGender',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear RIM'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearRIM',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Brand'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearBrand',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Category'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearCategory',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Shape'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearShape',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Collection'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearCollection',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Frame Material'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearEyewearFrameMaterial',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Lens Colour'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearLensColour',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Size'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearSize',values.split(';'));
                    }else if(productFilter.Type_Of_Filter__c == 'SunGlasses Eyewear Colour'){
                        String values = productFilter.Label__c;
                        values = values.replace('\r','');
                        mapOfValues.put('SunGlassesEyewearColour',values.split(';'));
                    }
                }
            }
        }catch (Exception e) {
            System.debug(e.getLineNumber());
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
        return JSON.serialize(mapOfValues);
    }
    
}