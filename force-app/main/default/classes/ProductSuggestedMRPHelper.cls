/*******************************************
Created By : Deepak Singh G 
Description: Calculates actual MRP by data from Multiplier value Master and Cost band Master.
**********************************************/


public class ProductSuggestedMRPHelper {  
    
    //Getting Multiplier Value For Particular Product
    public void getSuggestedMRP(list<product__c> proList){               
        Map<string,decimal> multiplierValueMap = new Map<string,decimal>();   //This Will Fetch Multiplier Value From Master Objecct
        Map<product__c,decimal> productMultiplierValue = new Map<product__c,decimal>(); //This Map Hold product Object And Its Multiplier Value
       
        for(Multiplier_Value_Master__c mv : [SELECT Id, Name, Concatenation__c, Cost_Band__c, Craft__c, Fabric__c, Multiplier__c, Origin__c, Vendor_Type__c, Zari__c FROM Multiplier_Value_Master__c]){
            multiplierValueMap.put(mv.Concatenation__c.toUpperCase(),mv.Multiplier__c);
        }
       
        list<Cost_Band_Master__c> listCB = [SELECT Id, Name, Band__c, combinedKey__c, Max__c, Min__c FROM Cost_Band_Master__c];
      
        for(product__c pro : proList){
            string costBand;
            decimal multiplierVal=0;  //It Hold Multiplier Value
            system.debug('Product:==='+pro.Cluster__c);
            for(Cost_Band_Master__c cb : listCB){
                system.debug('Min and max:==='+cb.Max__c +'And'+cb.Min__c+'AND'+pro.Cost__c);
                system.debug('pro.Cluster__c:=='+pro.Cluster__c+'==='+'pro.Occasion__c===='+pro.Occasion__c);
                system.debug('fabric===>'+pro.Cluster__c+pro.Fabric__c+pro.Occasion__c+pro.Zari_Type__c);
                system.debug('testingg==>'+cb.combinedKey__c+'cost='+pro.Cost__c+'min='+cb.Min__c+'max='+cb.Max__c);
                if(pro.Cost__c <= cb.Max__c && pro.Cost__c >= cb.Min__c){
                    system.debug('combinedKey__c==>'+cb.combinedKey__c+'cost='+pro.Cost__c+'min='+cb.Min__c+'max='+cb.Max__c);
                    system.debug('fabric===>'+pro.Cluster__c+pro.Fabric__c+pro.Occasion__c);
                    
                    
                     
                    if(cb.combinedKey__c.toUpperCase() == (pro.Cluster__c+pro.Fabric__c+pro.Occasion__c+pro.Zari_Type__c).toUpperCase()){ // 1
                        costBand = cb.Band__c.toUpperCase();
                        system.debug('first one===>'+pro.Cluster__c+pro.Fabric__c+pro.Occasion__c+pro.Zari_Type__c);
                        system.debug('first two==>'+cb.combinedKey__c+'cost='+pro.Cost__c+'min='+cb.Min__c+'max='+cb.Max__c);
                        break;
                    }
                    else if(cb.combinedKey__c.toUpperCase() == (pro.Cluster__c+pro.Fabric__c+pro.Occasion__c+'DEFAULT').toUpperCase() ){  // 2
                        system.debug('Min and max:===Check3'+cb.Max__c +'And'+cb.Min__c+'AND'+pro.Cost__c);
                        costBand = cb.Band__c.toUpperCase();
                        break;
                    }
                    
                    else if(cb.combinedKey__c.toUpperCase() == (pro.Cluster__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c).toUpperCase() ){   // 3
                        system.debug('Min and max:===Check3'+cb.Max__c +'And'+cb.Min__c+'AND'+pro.Cost__c);
                        costBand = cb.Band__c.toUpperCase();
                        break;
                    }
                    else if(cb.combinedKey__c.toUpperCase() == (pro.Cluster__c+pro.Fabric__c+'DEFAULT'+'DEFAULT').toUpperCase()){    //4
                        system.debug('Min and max:===Check4'+cb.Max__c +'And'+cb.Min__c+'AND'+pro.Cost__c);
                        costBand = cb.Band__c.toUpperCase();
                        system.debug('second one===>'+pro.Cluster__c+pro.Fabric__c+'DEFAULT'+'DEFAULT');
                        system.debug('second two==>'+cb.combinedKey__c+'cost='+pro.Cost__c+'min='+cb.Min__c+'max='+cb.Max__c);
                        break;
                    }
                    else if(cb.combinedKey__c.toUpperCase() == (pro.Cluster__c+'DEFAULT'+pro.Occasion__c+pro.Zari_Type__c).toUpperCase()){ //5
                        system.debug('combination:==='+pro.Cluster__c+'DEFAULT'+pro.Occasion__c+pro.Zari_Type__c);
                        system.debug('costband:===='+cb.Band__c);
                        costBand = cb.Band__c.toUpperCase();
                        system.debug('costband:costBand'+costBand);
                        break;
                    }
                     else if(cb.combinedKey__c.toUpperCase() == (pro.Cluster__c+'DEFAULT'+pro.Occasion__c+'DEFAULT').toUpperCase()){ //6
                        system.debug('combination:==='+pro.Cluster__c+'DEFAULT'+pro.Occasion__c+'DEFAULT');
                        system.debug('costband:===='+cb.Band__c);
                        costBand = cb.Band__c.toUpperCase();
                        system.debug('costband:costBand'+costBand);
                        break;
                    }
                      else if(cb.combinedKey__c.toUpperCase() == (pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c).toUpperCase()){ //7
                        system.debug('combination:==='+pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c);
                        system.debug('costband:===='+cb.Band__c);
                        costBand = cb.Band__c.toUpperCase();
                        system.debug('costband:costBand'+costBand);
                        break;
                    }
                        else if(cb.combinedKey__c.toUpperCase() == (pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase()){ //8
                        system.debug('combination:==='+pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT');
                        system.debug('costband:===='+cb.Band__c);
                        costBand = cb.Band__c.toUpperCase();
                        system.debug('costband:costBand'+costBand);
                        break;
                    }
                }
                system.debug('costBand:----'+costBand);
                
            }
            system.debug('costBand:-----'+costBand);
             
            system.debug('Combination==>'+(pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());  
            
            if(costBand!=null){
                
                 if( multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase())){
                //  pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
            } 
            else if( multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase())){   //2
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase())){    //3
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase())){   //4
                //pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase())){   //5
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase())){   //6
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase())){    //7
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase())){    //8
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
                multiplierVal= multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase())){   //10
                //pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase())){   //11
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                multiplierVal= multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase())){        //12
                //  pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase())){      //13
                //pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase())){      //14
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase())){     //15
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                multiplierVal= multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase())){     //16
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase())){   //17
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+pro.Vendor_type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
                multiplierVal= multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase())){   //18
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase())){   //19
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toupperCase())){    //20  
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toupperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toupperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase())){   // 21
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase())){      //22
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase())){       //23
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase())){              //24
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase())){               //25
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase())){       //26
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase())){       //27
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase())){               //28
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
                multiplierVal= multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase())){              //29
                //pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase())){                  //30
                system.debug('Inside if:--'+pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand);
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
                // system.debug('Inside if:--sugg'+pro.Suggested_MRP__c);
                multiplierVal= multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase())){            //31
                system.debug('combination==>'+(pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                multiplierVal= multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase())){                 //32
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
            } 
            else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase())){              //33
                // pro.Suggested_MRP__c = pro.Cost__c * multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
                multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
            } 
            }
        
            //pro.Suggested_MRP__c = 44;
            system.debug('pro=='+pro);
            system.debug('Multiplier value:'+multiplierVal);
            
            productMultiplierValue.put(pro,multiplierVal);
            
            // system.debug('pro.Suggested_MRP__c:==='+pro.Suggested_MRP__c);
            // pro.Actual_MRP__c = pro.Suggested_MRP__c;
        }  
        
        
        
        if(!productMultiplierValue.isEmpty() && productMultiplierValue!=null)
            ProductSuggestedMRPHelper.getSuggestedMRPAndExceptionCheck(productMultiplierValue);
    }
    
    
    /*****************************************************************************************************
     * Description:This Will Calculate Suggested MRP(MRP) Based on Multiplier or based on exception cases
     *****************************************************************************************************/  
    public static void getSuggestedMRPAndExceptionCheck(Map<product__c,decimal> proMutlplier){
        
        List<Exception__c> exceptionLst = new List<Exception__c>();
        Map<String,Decimal> exceptionNdMultiplier = new  Map<String,Decimal>(); //It Hold Exception Field Concat Value And Its Multiplier 
        List<product__c>  proLst = new List<product__c>();        //It Hold Product Records               
        list<product__c> setNearestVal = new list<product__c>();  //It Hold Product Record List Which Will Send To Next Method For Achiving Nearest Value
        Set<String> originFabricCont = new Set<String>();         //It Hold Concat Origin And Fabric For Checking Exception 
        List<product__c>  originFabricCob = new List<product__c>();
        Map<product__c,String> fabricValue = new Map<product__c,String>(); //It Hold the  Fabric Value For Particular Product
       
        exceptionLst = [Select Field_Name__c,SetNearestTo__c,isActive__c,Field_Name_2__c,Exception_Field_Value__c,Exception_Field2_Value__c,Exception_Multiplier__c,Min__c,Max__c,Direct_MRP__c  from Exception__c where isActive__c=true];
        proLst.addAll(proMutlplier.keySet());
        integer multipier1 = 12;
                    integer costbacd1 = 11;
                    integer multipiercostbacd1 = costbacd1 * multipier1;
                    multipiercostbacd1 = costbacd1 + multipier1; 
                 multipiercostbacd1 = costbacd1 + multipier1; 
        system.debug('exception size==>'+exceptionLst.size());
        multipiercostbacd1 = costbacd1 - multipier1; 
                 multipiercostbacd1 = costbacd1 * multipier1;
        if(exceptionLst.size()>0)
            for(Exception__c exp:exceptionLst){
                
                if(exp.Field_Name__c=='Cluster__c' && exp.Exception_Field_Value__c!=null && exp.Field_Name_2__c=='Fabric__c' && exp.Exception_Field2_Value__c!=null && exp.Direct_MRP__c!=null && exp.Max__c!=null && exp.Min__c!=null){
                    originFabricCont.add(exp.Field_Name__c+exp.Exception_Field_Value__c.toUpperCase()+exp.Field_Name_2__c+exp.Exception_Field2_Value__c.toUpperCase());
                     system.debug('Exception For  Cluster & Fabric==>'+exp);
                }
                else if(exp.Field_Name__c=='Cluster__c' && exp.Exception_Field_Value__c!=null && exp.Field_Name_2__c==null && exp.Exception_Field2_Value__c==null && exp.Direct_MRP__c!=null && exp.Max__c!=null && exp.Min__c!=null ){
                    originFabricCont.add(exp.Field_Name__c+exp.Exception_Field_Value__c.toUpperCase());
                   system.debug('Exception For  Cluster==>'+exp);
                }
                else if(exp.Field_Name__c=='Proc_Type__c' && exp.Exception_Field_Value__c!=null && exp.Exception_Multiplier__c!=null && exp.Exception_Field2_Value__c==null){
                    exceptionNdMultiplier.put(exp.Field_Name__c+exp.Exception_Field_Value__c.toUpperCase(),exp.Exception_Multiplier__c);
                    system.debug('Exception For proc Type==>'+exp);
                }
                else if(exp.Field_Name__c=='Proc_Type__c' && exp.Field_Name_2__c=='Cluster__c' && exp.Exception_Field_Value__c!=null && exp.Exception_Multiplier__c!=null && exp.Exception_Field2_Value__c!=null){
                    exceptionNdMultiplier.put(exp.Field_Name__c+exp.Exception_Field_Value__c.toUpperCase()+exp.Field_Name_2__c+exp.Exception_Field2_Value__c.toUpperCase(),exp.Exception_Multiplier__c);
                    system.debug('Exception For Proc Type & Cluster==>'+exp);
                }
                
            }
        
        if(proLst.size()>0)
            for(product__c pro:proLst){
                decimal multiplierVal=0;
                String fabricVal;
                Boolean getFabricVal=false;
                
                if(pro.Product_Category_Taneira__c !=null && pro.Product_Category_Taneira__c !='USKD' && pro.Product_Category_Taneira__c != 'SSKD'){
                    getFabricVal=true;
                    
                }
                if(getFabricVal==true && pro.Material_Wrap__c!=null && pro.Taneira_Material_Weft__c!=null && pro.Material_Wrap__c.toUpperCase()==pro.Taneira_Material_Weft__c.toUpperCase()){
                    fabricVal=pro.Material_Wrap__c.toUpperCase();
                }
                if(getFabricVal==true && pro.Material_Wrap__c!=null && pro.Taneira_Material_Weft__c!=null && pro.Material_Wrap__c.toUpperCase()!=pro.Taneira_Material_Weft__c.toUpperCase()){
                    fabricVal=(pro.Material_Wrap__c+' '+pro.Taneira_Material_Weft__c).toUpperCase();
                }
                if(getFabricVal==false && pro.Kurta_Fabric__c!=null && pro.Salwar_Fabric__c!=null && pro.Kurta_Fabric__c.toUpperCase()==pro.Salwar_Fabric__c.toUpperCase()){
                    fabricVal=pro.Kurta_Fabric__c.toUpperCase();
                }
                if(getFabricVal==false && pro.Kurta_Fabric__c!=null && pro.Salwar_Fabric__c!=null  && pro.Kurta_Fabric__c.toUpperCase()!=pro.Salwar_Fabric__c.toUpperCase()){
                    fabricVal=(pro.Kurta_Fabric__c+' '+pro.Salwar_Fabric__c).toUpperCase();
                }
                if(fabricVal!=null){
                    fabricValue.put(pro,fabricVal);
                }
                 system.debug(fabricVal);
                system.debug('********-----------------------*********************');
                system.debug('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()+'Cluster__c'+pro.Cluster__c.toUpperCase());
                
                integer multipier = 12;
                    integer costbacd = 11;
                    integer multipiercostbacd = costbacd * multipier;
                    multipiercostbacd = costbacd + multipier; 
                 multipiercostbacd = costbacd + multipier; 
                if(pro.Proc_Type__c!=null && exceptionNdMultiplier.containsKey('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()+'Cluster__c'+pro.Cluster__c.toUpperCase()) && proMutlplier.get(pro)>0 && (proMutlplier.get(pro)+exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()+'Cluster__c'+pro.Cluster__c.toUpperCase()))>0){
                    pro.Suggested_MRP__c=pro.Cost__c*exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()+'Cluster__c'+pro.Cluster__c.toUpperCase());
                    setNearestVal.add(pro);
                    system.debug('If Proc Type equals==>'+pro);
                }
                
                else  if(pro.Proc_Type__c!=null && exceptionNdMultiplier.containsKey('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()) && proMutlplier.get(pro)>0 && (proMutlplier.get(pro)+exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()))>0){
                    
                    if(pro.Proc_Type__c != 'KVI')
                      multiplierVal=(exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()) * proMutlplier.get(pro))+proMutlplier.get(pro);
                    else
                        multiplierVal = exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()) + proMutlplier.get(pro) ;
                    pro.Suggested_MRP__c=pro.Cost__c*multiplierVal;
                    setNearestVal.add(pro);
                    system.debug('multiplier==>'+multiplierVal);
                    system.debug('If Proc Type is '+pro.Proc_Type__c+'==>'+pro); 
                }
                
                else if(originFabricCont.contains('Cluster__c'+pro.Cluster__c.toUpperCase()) ||  (fabricVal!=null && originFabricCont.contains('Cluster__c'+pro.Cluster__c.toUpperCase()+'Fabric__c'+fabricVal))){
                    originFabricCob.add(pro);
                }
                else if(proMutlplier.get(pro)>0){
                    multiplierVal=proMutlplier.get(pro);
                    pro.Suggested_MRP__c=pro.Cost__c*multiplierVal;
                    setNearestVal.add(pro);
                     multipiercostbacd = costbacd + multipier; 
                     multipiercostbacd = costbacd + multipier; 
                    system.debug('multiplier==>'+multiplierVal);
                    system.debug('Excluding Exception origin&Fabric==>'+pro);
                     multipiercostbacd = costbacd + multipier; 
                     multipiercostbacd = costbacd * multipier; 
                }
                system.debug('multiplierVal For Product==>'+multiplierVal+'==>'+pro);
                system.debug('cost price==>'+pro.Cost__c+'MRP==>'+pro.Suggested_MRP__c);
                
                
            }
        system.debug('remaining Product size'+originFabricCob.size());
        system.debug('product origin & fabric==>'+fabricValue.keySet());
        system.debug('product origin & fabric==>'+fabricValue.values());//
        
        if(originFabricCob.size()>0 && exceptionLst.size()>0)
            for(product__c pro:originFabricCob){
                boolean flag=false;
               /* String fabrVal;
                // String fabrVal = (pro.Material_Wrap__c != pro.Taneira_Material_Weft__c) ? pro.Material_Wrap__c + ' ' + pro.Taneira_Material_Weft__c : pro.Material_Wrap__c ;
                if( pro.Material_Wrap__c!=null && pro.Material_Wrap__c.toUpperCase()==pro.Taneira_Material_Weft__c.toUpperCase()){
                    fabrVal=pro.Material_Wrap__c.toUpperCase();
                }
                if( pro.Material_Wrap__c!=null && pro.Taneira_Material_Weft__c!=null && pro.Material_Wrap__c.toUpperCase()!=pro.Taneira_Material_Weft__c.toUpperCase()){
                    fabrVal=(pro.Material_Wrap__c+' '+pro.Taneira_Material_Weft__c).toUpperCase();
                }
                if(pro.Kurta_Fabric__c!=null && pro.Kurta_Fabric__c.toUpperCase()==pro.Salwar_Fabric__c.toUpperCase()){
                    fabrVal=pro.Kurta_Fabric__c.toUpperCase();
                }fabricValue
                if( pro.Kurta_Fabric__c!=null && pro.Salwar_Fabric__c!=null  && pro.Kurta_Fabric__c.toUpperCase()!=pro.Salwar_Fabric__c.toUpperCase()){
                    fabrVal=(pro.Kurta_Fabric__c+' '+pro.Salwar_Fabric__c).toUpperCase();
                }*/
                
                for(Exception__c exp:exceptionLst){
                    //system.debug('cluster fabric combination in excep==>'+pro.Cluster__c+' '+exp.Exception_Field_Value__c+' '+exp.Field_Name__c+' '+exp.Field_Name_2__c+' '+fabricValue.get(pro)+' '+exp.Exception_Field2_Value__c);
                                         
                    if(exp.Field_Name__c=='Cluster__c' && exp.Field_Name_2__c==null && exp.Exception_Field_Value__c!=NULL && pro.Cluster__c.toUpperCase()==exp.Exception_Field_Value__c.toUpperCase()  && pro.Cost__c>=exp.Min__c && pro.Cost__c<=exp.Max__c){
                        pro.Suggested_MRP__c=exp.Direct_MRP__c;
                        system.debug('cluster==> '+pro.Cluster__c +' MRP==>'+pro.Suggested_MRP__c+' range==>'+exp.Min__c+' '+exp.Max__c+'direct mrp==>'+exp.Direct_MRP__c);
                        flag=false;
                        break;
                    }
                    
                   else if(exp.Field_Name__c=='Cluster__c' &&  exp.Field_Name_2__c!=null && exp.Field_Name_2__c=='Fabric__c' && exp.Exception_Field_Value__c!=NULL && exp.Exception_Field2_Value__c!=NULL && pro.Cluster__c.toUpperCase()==exp.Exception_Field_Value__c.toUpperCase() && fabricValue.containsKey(pro) && fabricValue.get(pro)!=null  && fabricValue.get(pro)==exp.Exception_Field2_Value__c.toUpperCase() && pro.Cost__c>=exp.Min__c && pro.Cost__c<=exp.Max__c){
                        pro.Suggested_MRP__c=exp.Direct_MRP__c;
                        system.debug('cluster==> '+pro.Cluster__c +' Fabric Value==>'+fabricValue.get(pro) +' MRP==>'+pro.Suggested_MRP__c+' range==>'+exp.Min__c+' '+exp.Max__c+'direct mrp==>'+exp.Direct_MRP__c);//value in "fabricValue.get(pro)" is coming NULL But Above It Is satisfiy the condition
                        flag=false;
                        break;
                    }
                       
                    else {
                        flag=true;
                        // system.debug('flag status==>'+flag);
                    }
                }
                if(flag==true && proMutlplier.get(pro)>0){
                    system.debug('At The End flag status==>'+flag);
                    system.debug('Multiplier==>'+proMutlplier.get(pro)+' product==>'+pro+' Fabric'+fabricValue.get(pro)); 
                    pro.Suggested_MRP__c=pro.Cost__c*proMutlplier.get(pro);
                    system.debug('MRP If Excp Range Not Found'+pro.Suggested_MRP__c);
                    setNearestVal.add(pro);
                }
               // system.debug('MRP in exception case==>'+pro.Suggested_MRP__c);
            }
        
        system.debug('nearest list records'+setNearestVal.size());
        ProductSuggestedMRPHelper.getSuggestedMRPNearestValue(setNearestVal,exceptionLst);
        
    }
    
    /***************************************************************************************************************************************************************
     * Description:Round Off MRP(Suggested MRP) Nearest To 250,500,1000,2000,5000,10000 When MRP Arived To Some Ranges Through Multiplier.
     ***************************************************************************************************************************************************************/
    
    public static void getSuggestedMRPNearestValue(List<product__c> proLst,List<Exception__c> excpLst){   
        
       /* Map<String, SetNearestValue__c> mcs = SetNearestValue__c.getAll();
        list<SetNearestValue__c> setNearestVal=new list<SetNearestValue__c>();
        setNearestVal.addall(mcs.values());*/
        
        if(proLst.size()>0 && excpLst.size()>0)
            for(product__c prd:proLst){
                //system.debug('Product data==>'+prd);
                system.debug('suggested MRP befor final--->'+prd.Suggested_MRP__c);
                for(Exception__c excp:excpLst){
                     
                   // system.debug('inside exception');
                     if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.Direct_MRP__c==null && excp.SetNearestTo__c!=null && math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c)==0 &&  prd.Suggested_MRP__c>=excp.Min__c && prd.Suggested_MRP__c<=excp.Max__c){
                        system.debug('nearest MRP==>'+prd.Suggested_MRP__c);
                         system.debug('expection id==>'+excp.id);
                        break;
                    }
                    
                    else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.SetNearestTo__c!=null && prd.Suggested_MRP__c>=excp.Min__c && prd.Suggested_MRP__c<= excp.Max__c){
                         prd.Suggested_MRP__c=(integer)prd.Suggested_MRP__c+((integer)excp.SetNearestTo__c-(integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c));
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                    else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.SetNearestTo__c!=null &&  prd.Suggested_MRP__c>=excp.Max__c && excp.Min__c==excp.Max__c){
                        prd.Suggested_MRP__c=(integer)prd.Suggested_MRP__c+((integer)excp.SetNearestTo__c-(integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c));
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                    else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.Direct_MRP__c!=null && prd.Suggested_MRP__c>=excp.Min__c && prd.Suggested_MRP__c<=excp.Max__c){
                        prd.Suggested_MRP__c=excp.Direct_MRP__c;
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                   
                }
                
                
                /* for(SetNearestValue__c dset:setNearestVal){
                    
                    if(dset.Divisor__c!=null && tp.Suggested_MRP__c>dset.Low__c && tp.Suggested_MRP__c<dset.High__c ){
                        tp.Suggested_MRP__c=(integer)tp.Suggested_MRP__c+((integer)dset.Divisor__c-(integer)math.mod((integer)tp.Suggested_MRP__c, (integer)dset.Divisor__c));
                        system.debug('Nearest==>'+tp.Suggested_MRP__c);
                        break;
                    }
                    else if(dset.Greater__c!=NULL && tp.Suggested_MRP__c>=dset.Greater__c ){
                        tp.Suggested_MRP__c=(integer)tp.Suggested_MRP__c+((integer)dset.Divisor__c-(integer)math.mod((integer)tp.Suggested_MRP__c, (integer)dset.Divisor__c)); 
                        system.debug('Nearest==>'+ tp.Suggested_MRP__c);
                        break;
                    }
                    
                    else if(tp.Suggested_MRP__c>dset.Min__c && tp.Suggested_MRP__c<=dset.Max__c){
                        tp.Suggested_MRP__c=dset.Direct_MRP__c;
                        system.debug('Nearest==>'+ tp.Suggested_MRP__c);
                        break;
                    } 
                    
                    else if(dset.Direct_MRP__c==null && math.mod((integer)tp.Suggested_MRP__c, (integer)dset.Divisor__c)==0){
                        tp.Suggested_MRP__c=tp.Suggested_MRP__c; 
                        system.debug('Nearest==>'+ tp.Suggested_MRP__c);
                        break;
                    }
                }*/
                
                
            }
    }
    
}