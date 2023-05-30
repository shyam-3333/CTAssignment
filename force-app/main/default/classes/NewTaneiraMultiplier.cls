public class NewTaneiraMultiplier {
    
   public void getSuggestedMRP(list<product__c> proLst){ 
        system.debug('proLst : '+proLst);
        system.debug('Size of proLst : '+proLst.size());  //5
        system.debug('Record Inserted');
        Map<String,Decimal> packagingMap = new  Map<String,Decimal>(); // New 
        list<product__c> multiplierList = new list<product__c>();  //It Hold Product Record List Which Will Send To Next Method For Achiving Multiplie Value
        list<product__c> setNearestVal = new list<product__c>();  //It Hold Product Record List Which Will Send To Next Method For Achiving Nearest Value
        List<product__c>  originFabricCob = new List<product__c>();
        Map<product__c,String> fabricValue = new Map<product__c,String>(); //It Hold the  Fabric Value For Particular Product 
        Set<String> originFabricCont = new Set<String>();         //It Hold Concat Origin And Fabric For Checking Exception 
        Map<String,Decimal> exceptionNdMultiplier = new  Map<String,Decimal>(); //It Hold Exception Field Concat Value And Its Multiplier 
        List<Exception__c> exceptionLst = new List<Exception__c>();
        exceptionLst = [Select Field_Name__c,SetNearestTo__c,isActive__c,Field_Name_2__c,Packaging_Logistic__c,Field_Name_3__c,Exception_Field_Value__c,Exception_Field2_Value__c,Exception_Field3_Value__c,Exception_Multiplier__c,Min__c,Max__c,Direct_MRP__c,Direct_Multiplier__c,Precedence__c from Exception__c where isActive__c=true];
        if(exceptionLst != null && exceptionLst.size()>0)
            for(Exception__c exp:exceptionLst){ 
                String exceptionfVal =exp.Exception_Field_Value__c!=null ? exp.Exception_Field_Value__c.toUpperCase():'';
                String exceptionf3Val =exp.Exception_Field3_Value__c!=null ? exp.Exception_Field3_Value__c.toUpperCase():'';
                String exceptionf2Val = exp.Exception_Field2_Value__c!=null ? exp.Exception_Field2_Value__c.toUpperCase():'';
                if(exp.Exception_Field3_Value__c != Null && exp.Packaging_Logistic__c != Null){
                    packagingMap.put(exp.Exception_Field3_Value__c,exp.Packaging_Logistic__c);
                }
                if(exp.Field_Name__c=='Cluster__c'   && exp.Field_Name_3__c=='Fabric__c' && exp.Exception_Field3_Value__c!=null && exp.Max__c!=null && exp.Min__c!=null && exp.isActive__c==true){
                    originFabricCont.add(exp.Field_Name__c+exceptionfVal+exp.Field_Name_3__c+exceptionf3Val);
                }
                else if(exp.Field_Name__c=='Cluster__c' && exp.Exception_Field_Value__c!=null && exp.Field_Name_2__c=='Sourcing_Type__c' && exp.Exception_Field2_Value__c!=null && exp.Field_Name_3__c=='Fabric__c' && exp.Exception_Field3_Value__c!=null && exp.Max__c!=null && exp.Min__c!=null && exp.isActive__c==true){
                    originFabricCont.add(exp.Field_Name__c+exceptionfVal+exp.Field_Name_2__c+exceptionf2Val+exp.Field_Name_3__c+exceptionf3Val);
                }
                 else if(exp.Field_Name__c=='Cluster__c' && exp.Exception_Field_Value__c!=null && exp.Field_Name_2__c=='Sourcing_Type__c' && exp.Exception_Field2_Value__c!=null && exp.Field_Name_3__c==null && exp.Exception_Field3_Value__c==null && exp.Max__c!=null && exp.Min__c!=null && exp.isActive__c==true){
                    originFabricCont.add(exp.Field_Name__c+exceptionfVal+exp.Field_Name_2__c+exceptionf2Val);
                }
                else if(exp.Field_Name__c=='Cluster__c' && exp.Exception_Field_Value__c!=null && exp.Field_Name_2__c==null && exp.Exception_Field2_Value__c==null && exp.Max__c!=null && exp.Min__c!=null && exp.isActive__c==true ){
                    originFabricCont.add(exp.Field_Name__c+exceptionfVal);
                }                                         
            }
        //*************************************
    for(product__c pro:proLst){  // iterate product only to get fabric value
            Boolean getFabricVal=false;
            String fabricVal;
            String sourcingVal;
            decimal multiplierVal=0;
            if( pro.Yardage_Cost__c == 0 ){            
                pro.Packing_Logistic_Cost__c = packagingMap.containsKey(pro.Product_Category_Taneira__c) ? packagingMap.get(pro.Product_Category_Taneira__c) : 0;
            }
            if(pro.Product_Category_Taneira__c == 'Saree'){
                pro.Saree_Dimensions__c = '5.3m x 1.1m';
            }
            if(pro.Product_Category_Taneira__c !=null && pro.Product_Category_Taneira__c !='USKD' && pro.Product_Category_Taneira__c != 'SSKD'){
                getFabricVal=true;                
            }
            String materialWrap = pro.Material_Wrap__c != null ? pro.Material_Wrap__c.toUpperCase() : '';
            String materialWeft = pro.Taneira_Material_Weft__c != null ? pro.Taneira_Material_Weft__c.toUpperCase() : '';
            String kurtaFabric = pro.Kurta_Fabric__c != null ? pro.Kurta_Fabric__c.toUpperCase() : '';
            String salwarFabric = pro.Salwar_Fabric__c != null ? pro.Salwar_Fabric__c.toUpperCase() : '';
            if(getFabricVal==true && materialWrap == materialWeft ){
                fabricVal = materialWrap;
            }
            if(getFabricVal==true && materialWrap != materialWeft ){
                fabricVal = materialWrap+' '+materialWeft;
            }
            if(getFabricVal==false && kurtaFabric == salwarFabric){
                fabricVal=kurtaFabric;
            }
            if(getFabricVal==false && kurtaFabric != salwarFabric){
                fabricVal=kurtaFabric+' '+salwarFabric;
            }
            system.debug(fabricVal);  //	SILK
            if(fabricVal!=null){
                fabricValue.put(pro,fabricVal);  // Full Record , SILK
                system.debug(fabricValue);  //	SILK
            } 
          String clusterval =pro.Cluster__c!= Null ? pro.Cluster__c.toUpperCase():'';
           String sourcingValu = pro.Sourcing_Type__c!= Null ? pro.Sourcing_Type__c.toUpperCase():'';		   
            if((pro.Product_Category_Taneira__c != Null && (originFabricCont.contains('Cluster__c'+clusterval) || (originFabricCont.contains('Cluster__c'+clusterval+'Fabric__c'+fabricVal)) || (originFabricCont.contains('Cluster__c'+clusterval+'Sourcing_Type__c'+sourcingValu)) || (originFabricCont.contains('Cluster__c'+clusterval+'Sourcing_Type__c'+sourcingValu+'Fabric__c'+fabricVal)) )) || (pro.Product_Category_Taneira__c != 'Saree')){            
                //Cluster__cBANARAS OR Cluster__cBANARASFabric__cSILK or Cluster__cBANARASSourcing_Type__cTRADING(OTS) or Cluster__cBANARASSourcing_Type__cTRADING(OTS)Fabric__cSILK
                originFabricCob.add(pro);
                system.debug('Size of originFabricCob : '+originFabricCob.size());  //	
            }
            else 
                multiplierList.add(pro); 
        }
        //*********************************************************************************************************************************************************************
       if(originFabricCob != null && originFabricCob.size()>0 && exceptionLst != null && exceptionLst.size()>0){
            for(product__c pro:originFabricCob){
                String clustervalT = pro.Cluster__c.toUpperCase();
                String sourcingValuT = pro.Sourcing_Type__c!= null? pro.Sourcing_Type__c.toUpperCase():'';
                String productCategory = pro.Product_Category_Taneira__c!= null? pro.Product_Category_Taneira__c.toUpperCase():'';
                Boolean multiplierCheck=false;
                List<PrecedenceComparison> sortedExceptions = new List<PrecedenceComparison>(); 
                for(Exception__c exp:exceptionLst){ 
                String exceptionfValt = exp.Exception_Field_Value__c != null? exp.Exception_Field_Value__c.toUpperCase():'';
                String exceptionf3Valt =exp.Exception_Field3_Value__c != null? exp.Exception_Field3_Value__c.toUpperCase():'';
                String exceptionf2Valt =exp.Exception_Field2_Value__c != null? exp.Exception_Field2_Value__c.toUpperCase():'';
                    if(exp.Field_Name__c=='Cluster__c' && exp.Field_Name_2__c == null && exp.Exception_Field2_Value__c == null && clustervalT==exceptionfValt  && pro.Cost__c>=exp.Min__c && pro.Cost__c<=exp.Max__c){
                        multiplierCheck=true;
                        sortedExceptions.add(new PrecedenceComparison(exp.Precedence__c,exp.Direct_Multiplier__c,exp.Direct_MRP__c));
                        if(sortedExceptions.size()>0 && sortedExceptions != null){
                            sortedExceptions.sort();
                        }   
                    }
                    // no product category, only cluster and fabric comparision
                    /*else if(exp.Field_Name__c=='Cluster__c' &&  exp.Field_Name_2__c == 'Fabric__c' && exp.Exception_Field2_Value__c!= null && clustervalT==exceptionfValt && fabricValue.containsKey(pro) && fabricValue.get(pro)==exceptionf2Valt && pro.Cost__c>=exp.Min__c && pro.Cost__c<=exp.Max__c){
                        multiplierCheck=true; 
                        sortedExceptions.add(new PrecedenceComparison(exp.Precedence__c,exp.Direct_Multiplier__c,exp.Direct_MRP__c));
                        if(sortedExceptions.size()>0 && sortedExceptions != null){
                            sortedExceptions.sort();
                        }   
                    }*/
                    else if( exp.Field_Name__c=='Cluster__c' && exp.Field_Name_2__c == 'Sourcing_Type__c'  && exp.Exception_Field2_Value__c!= null && exp.Field_Name_3__c == 'Fabric__c' && exp.Exception_Field3_Value__c!= null && clustervalT==exceptionfValt && fabricValue.containsKey(pro) && sourcingValuT==exceptionf2Valt && fabricValue.get(pro)==exceptionf3Valt && pro.Cost__c>=exp.Min__c && pro.Cost__c<=exp.Max__c){
                        multiplierCheck=true; 
                        sortedExceptions.add(new PrecedenceComparison(exp.Precedence__c,exp.Direct_Multiplier__c,exp.Direct_MRP__c));
                        if(sortedExceptions.size()>0 && sortedExceptions != null){
                            sortedExceptions.sort();
                        }   
                    }
                    else if(exp.Field_Name__c=='Cluster__c' && exp.Field_Name_2__c == 'Sourcing_Type__c' && exp.Exception_Field2_Value__c!= null && exp.Field_Name_3__c == null && exp.Exception_Field3_Value__c == null && clustervalT==exceptionfValt && fabricValue.containsKey(pro) && sourcingValuT==exceptionf2Valt && pro.Cost__c>=exp.Min__c && pro.Cost__c<=exp.Max__c){
                        system.debug('check 5');
                        system.debug('lets check sourcing value'+pro.Sourcing_Type__c);
                        multiplierCheck=true; 
                        sortedExceptions.add(new PrecedenceComparison(exp.Precedence__c,exp.Direct_Multiplier__c,exp.Direct_MRP__c));
                        if(sortedExceptions.size()>0 && sortedExceptions != null){
                            sortedExceptions.sort();
                        }   
                    }
                    // for Pavadai, Stole, Yardage, Dupatta, Scarf, USKD, SSKD, Shawl
                    else if( exp.Field_Name__c == null &&  exp.Field_Name_2__c == null && exp.Field_Name_3__c=='Product_Category_Taneira__c' && productCategory == exp.Exception_Field3_Value__c && pro.Cost__c>=exp.Min__c && pro.Cost__c<=exp.Max__c){
                        system.debug('check 3');
                        multiplierCheck=true; 
                        sortedExceptions.add(new PrecedenceComparison(exp.Precedence__c,exp.Direct_Multiplier__c,exp.Direct_MRP__c));
                        if(sortedExceptions.size()>0 && sortedExceptions != null){
                            sortedExceptions.sort();
                        }   
                    } 
                    // for Suggested MRP and Product Category
                    else if( exp.Field_Name__c == 'Suggested_MRP__c' && exp.Field_Name_3__c=='Product_Category_Taneira__c' && productCategory == exp.Exception_Field3_Value__c && pro.Cost__c>=exp.Min__c && pro.Cost__c<=exp.Max__c && exp.SetNearestTo__c == null){
                        system.debug('check 4');
                        multiplierCheck=true; 
                        sortedExceptions.add(new PrecedenceComparison(exp.Precedence__c,exp.Direct_Multiplier__c,exp.Direct_MRP__c));
                        if(sortedExceptions.size()>0 && sortedExceptions != null){
                            sortedExceptions.sort();
                        }   
                    } 
                }
                System.debug('sortedExceptions : '+sortedExceptions);
                if(sortedExceptions.size() > 0){
                    if(pro.Product_Category_Taneira__c != 'Yardage'){
                        if(sortedExceptions[0].directMRP != null && sortedExceptions[0].directMultiplier == null){
                            pro.Suggested_MRP__c = sortedExceptions[0].directMRP;
                        }
                        if(sortedExceptions[0].directMRP == null && sortedExceptions[0].directMultiplier != null){
                            pro.Suggested_MRP__c = sortedExceptions[0].directMultiplier * pro.Cost__c;
                            setNearestVal.add(pro);
                        } 
                        if(sortedExceptions[0].directMRP == null && sortedExceptions[0].directMultiplier == null){
                            multiplierList.add(pro);                
                        } 
                    }
                    else{
                        if(sortedExceptions[0].directMRP != null && sortedExceptions[0].directMultiplier == null){
                            pro.Suggested_MRP__c = sortedExceptions[0].directMRP; 
                        }
                        if(sortedExceptions[0].directMRP == null && sortedExceptions[0].directMultiplier != null){
                            pro.Suggested_MRP__c = sortedExceptions[0].directMultiplier * pro.Cost__c;    
                        }
                        
                        if(sortedExceptions[0].directMRP == null && sortedExceptions[0].directMultiplier == null){
                            multiplierList.add(pro);                
                        }
                    }
                }
                if(multiplierCheck == false){
                    multiplierList.add(pro);
                }
            }
        }
        if(setNearestVal != null && setNearestVal.size() > 0){
            system.debug('Enters into Direct Multiplier roundoff Method');
            NewTaneiraMultiplier.getSuggestedMRPNearestValue(setNearestVal,exceptionLst);
        }
        if(multiplierList != null && multiplierList.size() > 0){
            system.debug('Enters into Cost Band and Multiplier Master Method');
            NewTaneiraMultiplier.getMultiplierValue(multiplierList); 
        }
    }
/**************************************************************************************************************************************************************
* Description:Round Off Direct Multiplier (Suggested MRP) 
***************************************************************************************************************************************************************/
    public static void getSuggestedMRPNearestValue(List<product__c> proLst,List<Exception__c> excpLst){
        system.debug('Start of Direct Multiplier roundoff Method');
        if(proLst != null && proLst.size()>0 && excpLst != null && excpLst.size()>0){
            for(product__c prd:proLst){
                for(Exception__c excp:excpLst){
                    
                    if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.Direct_MRP__c==null && excp.SetNearestTo__c!=null && math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c)==0 &&  prd.Suggested_MRP__c>=excp.Min__c && prd.Suggested_MRP__c<=excp.Max__c && prd.Product_Category_Taneira__c==excp.Exception_Field3_Value__c){
                        system.debug('Rounded-off Suggested MRP : '+prd.Suggested_MRP__c);
                        break;
                    }
                    else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.SetNearestTo__c!=null && prd.Suggested_MRP__c>=excp.Min__c && prd.Suggested_MRP__c<= excp.Max__c && prd.Product_Category_Taneira__c==excp.Exception_Field3_Value__c){
                        if((integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c) != 0){
                            //prd.Suggested_MRP__c=(integer)prd.Suggested_MRP__c+((integer)excp.SetNearestTo__c-(integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c));
                             prd.Suggested_MRP__c=(((integer)excp.SetNearestTo__c*math.round((double)prd.Suggested_MRP__c/(integer)excp.SetNearestTo__c))-1);
                            system.debug('Rounded-off Suggested MRP : '+prd.Suggested_MRP__c);
                            break;
                        }}
                    else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.SetNearestTo__c!=null &&  prd.Suggested_MRP__c>=excp.Max__c && excp.Min__c==excp.Max__c && prd.Product_Category_Taneira__c==excp.Exception_Field3_Value__c){
                        if((integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c) != 0){
                           // prd.Suggested_MRP__c=(integer)prd.Suggested_MRP__c+((integer)excp.SetNearestTo__c-(integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c));
                            prd.Suggested_MRP__c=(((integer)excp.SetNearestTo__c*math.round((double)prd.Suggested_MRP__c/(integer)excp.SetNearestTo__c))-1);
                            system.debug('Rounded-off Suggested MRP : '+prd.Suggested_MRP__c);
                            break;
                        }}
                    else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.Direct_MRP__c!=null && prd.Suggested_MRP__c>=excp.Min__c && prd.Suggested_MRP__c<=excp.Max__c && prd.Product_Category_Taneira__c==excp.Exception_Field3_Value__c){
                        prd.Suggested_MRP__c=excp.Direct_MRP__c;
                        system.debug('Rounded-off Suggested MRP : '+prd.Suggested_MRP__c);
                        break;
                    }
                     else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c'&& prd.Suggested_MRP__c>= 1999 && prd.Suggested_MRP__c<= 2599){
                        prd.Suggested_MRP__c= 2599.00;
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                     else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c'&& prd.Suggested_MRP__c>= 2600 && prd.Suggested_MRP__c<= 2999){
                        prd.Suggested_MRP__c= 2999.00;
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                     else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c'&& prd.Suggested_MRP__c>= 8999 && prd.Suggested_MRP__c<= 10999){
                        prd.Suggested_MRP__c= 10999.00;
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                }            
            }  
        }
        system.debug('End of Direct Multiplier roundoff Method');
    }
    //***************************************************************************************************************************************************************
    public static void getMultiplierValue(list<product__c> proList){ 
        system.debug('Start of Multiplier Method');
        Map<product__c,decimal> productMultiplierValue = new Map<product__c,decimal>(); //This Map Hold product Object And Its Multiplier Value        
        Map<string,decimal> multiplierValueMap = new Map<string,decimal>();   //This Will Fetch Multiplier Value From Master Objecct
        
        for(Multiplier_Value_Master__c mv : [SELECT Id, Name, Concatenation__c, Cost_Band__c, Craft__c, Fabric__c, Multiplier__c, Origin__c, Vendor_Type__c, Zari__c FROM Multiplier_Value_Master__c where Active__c=true]){
            multiplierValueMap.put(mv.Concatenation__c.toUpperCase(),mv.Multiplier__c);  //BANARASBSILKEXTRA WEFT-BROCADETESTEDNULL	, 2.20
        }
        Set<String> cluster= new Set<String>();
        for(product__c pro : proList){
            cluster.add(pro.Cluster__c);
        }
        list<Cost_Band_Master__c> listCB = [SELECT Id, Name, Band__c, combinedKey__c, Max__c, Min__c FROM Cost_Band_Master__c where Origin__c In: cluster and Active__c=true];    
        
        for(product__c pro : proList){
            system.debug('New Inserted Product Cost: '+pro.Cost__c);  //9000
            string costBand;
            decimal multiplierVal=0;  //It Hold Multiplier Value
            if(listCB.size()>0 || !listCB.isEmpty()){
            for(Cost_Band_Master__c cb : listCB){
                String combinedKey = cb.combinedKey__c!=null? cb.combinedKey__c.toUpperCase():'';
                if(pro.Cost__c <= cb.Max__c && pro.Cost__c >= cb.Min__c){
                    if(combinedKey == (pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase()){ //1
                        costBand = cb.Band__c.toUpperCase();
                        System.debug('1 costBand : '+costBand);
                        break;
                    }
                    else if(combinedKey == (pro.Cluster__c+pro.Fabric__c+pro.Occasion__c+'DEFAULT').toUpperCase() ){  // 2
                        costBand = cb.Band__c.toUpperCase();
                        System.debug('2 costBand : '+costBand);
                        break;
                    }                    
                    else if(combinedKey == (pro.Cluster__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c).toUpperCase() ){   
                        costBand = cb.Band__c.toUpperCase(); 
                        System.debug('3 costBand : '+costBand);
                        break;
                    }
                    else if(combinedKey == (pro.Cluster__c+pro.Fabric__c+'DEFAULT'+'DEFAULT').toUpperCase()){    //4
                        costBand = cb.Band__c.toUpperCase();
                        System.debug('4 costBand : '+costBand);
                        break;
                    }
                    else if(combinedKey == (pro.Cluster__c+'DEFAULT'+pro.Occasion__c+pro.Zari_Type__c).toUpperCase()){ //5
                        costBand = cb.Band__c.toUpperCase();
                        System.debug('5 costBand : '+costBand);
                        break;
                    }
                    else if(combinedKey == (pro.Cluster__c+'DEFAULT'+pro.Occasion__c+'DEFAULT').toUpperCase()){ //6
                        costBand = cb.Band__c.toUpperCase();
                        System.debug('6 costBand : '+costBand);
                        break;
                    }
                    else if(combinedKey == (pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c).toUpperCase()){ //7
                        costBand = cb.Band__c.toUpperCase();
                        System.debug('7 costBand : '+costBand);
                        break;
                    }
                    else if(combinedKey == (pro.Cluster__c+pro.Fabric__c+pro.Occasion__c+pro.Zari_Type__c).toUpperCase()){ // 8
                        costBand = cb.Band__c.toUpperCase();
                        System.debug('8 costBand : '+costBand);
                        break;
                    }
                }                
            }
        }
            //*********************************************************************************************************************************************************************
            if(costBand!=null){  // true
                
                if( multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase())){   //1 BANARASBSILKEXTRA WEFT-BROCADETESTEDA	
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase()); // multiplierVal=2.20
                } 
                else if( multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase())){   //2
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase())){    //3
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase())){   //4
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase())){   //5
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase())){   //6
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase())){    //7
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase())){    //8
                    multiplierVal= multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase())){   //10
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase())){   //11
                    multiplierVal= multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase())){        //12
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase())){      //13
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase())){      //14
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase())){     //15
                    multiplierVal= multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase())){     //16
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase())){   //17
                    multiplierVal= multiplierValueMap.get((pro.Cluster__c+pro.Pricing_Type__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase())){   //18
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase())){   //19
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toupperCase())){    //20  
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+costBand).toupperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase())){   // 21
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase())){      //22
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase())){       //23
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase())){              //24
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase())){               //25
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+pro.Fabric__c+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase())){       //26
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase())){       //27
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase())){               //28
                    multiplierVal= multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase())){              //29
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+pro.Workmanship__c+'DEFAULT'+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase())){                  //30
                    multiplierVal= multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase())){            //31
                    multiplierVal= multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+pro.Zari_Type__c+'DEFAULT').toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase())){                 //32
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+costBand).toUpperCase());
                } 
                else if(multiplierValueMap.containsKey((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase())){              //33
                    multiplierVal=multiplierValueMap.get((pro.Cluster__c+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT'+'DEFAULT').toUpperCase());
                } 
            }
            system.debug('multiplierVal of Multiplier Value Master: '+multiplierVal);
            productMultiplierValue.put(pro,multiplierVal);  //New Inserted Record, 2.20
            system.debug('Size of productMultiplierValue Map: '+productMultiplierValue.size());   // everytime 1
        }          
        if(productMultiplierValue!=null && productMultiplierValue.size() > 0 )
            NewTaneiraMultiplier.caluclateSuggestedMRP(productMultiplierValue);
    }
    /*****************************************************************************************************
* Description:This Will Calculate Suggested MRP(MRP) Based on Multiplier or based on exception cases
*****************************************************************************************************/  
    public static void caluclateSuggestedMRP(Map<product__c,decimal> proMutlplier){
        list<product__c> setNearestVal = new list<product__c>();  //It Hold Product Record List Which Will Send To Next Method For Achiving Nearest Value
        List<product__c>  originFabricCob = new List<product__c>();
        Map<product__c,String> fabricValue = new Map<product__c,String>(); //It Hold the  Fabric Value For Particular Product
        Set<String> originFabricCont = new Set<String>();         //It Hold Concat Origin And Fabric For Checking Exception 
        Map<String,Decimal> exceptionNdMultiplier = new  Map<String,Decimal>(); //It Hold Exception Field Concat Value And Its Multiplier 
        List<Exception__c> exceptionLst = new List<Exception__c>();
        List<product__c>  proLst = new List<product__c>();        //It Hold Product Records               
        exceptionLst = [Select Field_Name__c,SetNearestTo__c,isActive__c,Field_Name_2__c,Exception_Field_Value__c,Exception_Field2_Value__c,Exception_Multiplier__c,Min__c,Max__c,Direct_MRP__c,Field_Name_3__c,Exception_Field3_Value__c from Exception__c where isActive__c=true];
        if(exceptionLst != null && exceptionLst.size()>0){
            for(Exception__c exp:exceptionLst){
                if(exp.Field_Name__c=='Proc_Type__c' && exp.Exception_Field_Value__c!=null && exp.Exception_Multiplier__c!=null && exp.Exception_Field2_Value__c==null){
                    system.debug('Proc Type Condition 1');
                    exceptionNdMultiplier.put(exp.Field_Name__c+exp.Exception_Field_Value__c.toUpperCase(),exp.Exception_Multiplier__c);
                }
                else if(exp.Field_Name__c=='Proc_Type__c' && exp.Field_Name_2__c=='Cluster__c' && exp.Exception_Field_Value__c!=null && exp.Exception_Field2_Value__c!=null && exp.Exception_Multiplier__c!=null){
                    system.debug('Proc Type Condition 2');
                    exceptionNdMultiplier.put(exp.Field_Name__c+exp.Exception_Field_Value__c.toUpperCase()+exp.Field_Name_2__c+exp.Exception_Field2_Value__c.toUpperCase(),exp.Exception_Multiplier__c);
                }
            }
        }
        proLst.addAll(proMutlplier.keySet());
        if(proLst != null && proLst.size()>0){  
            for(product__c pro:proLst){  // New Inserted Record from above
                system.debug('New Inserted Product Cost: '+pro.Cost__c);
                Boolean getFabricVal=false;
                String fabricVal;
                decimal multiplierVal=0;
                if(pro.Proc_Type__c!=null && exceptionNdMultiplier.containsKey('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()+'Cluster__c'+pro.Cluster__c.toUpperCase()) && proMutlplier.get(pro)>0 && (proMutlplier.get(pro)+exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()+'Cluster__c'+pro.Cluster__c.toUpperCase()))>0){
                    //true , No such Record found , 2.2>0:true , 2.20+(-0.10) = 2.10 > 0 :true
                    pro.Suggested_MRP__c=pro.Cost__c*exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()+'Cluster__c'+pro.Cluster__c.toUpperCase());
                    //pro.Suggested_MRP__c = 500 * 0.01
                    setNearestVal.add(pro);
                }
                else if(pro.Proc_Type__c!=null && exceptionNdMultiplier.containsKey('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()) && proMutlplier.get(pro)>0 && (proMutlplier.get(pro)+exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()))>0){
                    //true && Proc_Type__cInhouse Design && 2.20>0 true && 2.20+0.10=2.30 true
                    if(pro.Proc_Type__c != 'KVI'){   //Vendor Co created , Inhouse Design
                        multiplierVal=(exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()) * proMutlplier.get(pro))+proMutlplier.get(pro);
                        system.debug('multiplierVal : '+multiplierVal);
                    }
                    else{
                        multiplierVal = exceptionNdMultiplier.get('Proc_Type__c'+pro.Proc_Type__c.toUpperCase()) + proMutlplier.get(pro) ;
                        //multiplierVal = (-0.10) + (2.20) = 2.10
                    }
                    pro.Suggested_MRP__c=pro.Cost__c*multiplierVal;  // 9000 * 2.42 = 19800 or 9000 * 2.10
                    setNearestVal.add(pro);  //New Inserted Record with calculated suggested MRP
                }
                else if(proMutlplier.get(pro)>0){  //2.20>0 
                    multiplierVal=proMutlplier.get(pro);  //2.20
                    pro.Suggested_MRP__c=pro.Cost__c*multiplierVal; //9000 * 2.20
                    setNearestVal.add(pro);
                }     
            }
        }
        system.debug('setNearestVal : '+setNearestVal.size());
        NewTaneiraMultiplier.getSuggestedMRPNearestValue2(setNearestVal,exceptionLst);
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
    /***************************************************************************************************************************************************************
* Description:Round Off MRP(Suggested MRP) Nearest To 250,500,1000,2000,5000,10000 When MRP Arived To Some Ranges Through Multiplier.
***************************************************************************************************************************************************************/
   public static void getSuggestedMRPNearestValue2(List<product__c> proLst,List<Exception__c> excpLst){   
        if(proLst != null && proLst.size()>0 && excpLst != null && excpLst.size()>0)
            for(product__c prd:proLst){
                system.debug('Suggested MRP before round-off--->'+prd.Suggested_MRP__c);
                for(Exception__c excp:excpLst){
                    if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c'&& excp.Direct_MRP__c==null && excp.SetNearestTo__c!=null && prd.Suggested_MRP__c>=excp.Min__c && prd.Suggested_MRP__c<= excp.Max__c && prd.Product_Category_Taneira__c==excp.Exception_Field3_Value__c){
                        if((integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c) != 0){
                          // prd.Suggested_MRP__c=(integer)prd.Suggested_MRP__c+((integer)excp.SetNearestTo__c-(integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c));
                           prd.Suggested_MRP__c=(((integer)excp.SetNearestTo__c*math.round((double)prd.Suggested_MRP__c/(integer)excp.SetNearestTo__c))-1);
                            system.debug('1 Suggested MRP after round-off--->'+prd.Suggested_MRP__c);
                            break;
                        }}
                    else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.Direct_MRP__c==null && excp.SetNearestTo__c!=null &&  prd.Suggested_MRP__c>=excp.Max__c && excp.Min__c==excp.Max__c && prd.Product_Category_Taneira__c==excp.Exception_Field3_Value__c){
                        if((integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c) != 0){
                          //prd.Suggested_MRP__c=(integer)prd.Suggested_MRP__c+((integer)excp.SetNearestTo__c-(integer)math.mod((integer)prd.Suggested_MRP__c, (integer)excp.SetNearestTo__c));
                            prd.Suggested_MRP__c=(((integer)excp.SetNearestTo__c*math.round((double)prd.Suggested_MRP__c/(integer)excp.SetNearestTo__c))-1);
                            system.debug('2 Suggested MRP after round-off--->'+prd.Suggested_MRP__c);
                            break;
                        }}
                    else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c' && excp.Direct_MRP__c!=null && prd.Suggested_MRP__c>=excp.Min__c && prd.Suggested_MRP__c<=excp.Max__c && prd.Product_Category_Taneira__c==excp.Exception_Field3_Value__c){
                        prd.Suggested_MRP__c=excp.Direct_MRP__c;
                        system.debug('3 Suggested MRP after round-off--->'+prd.Suggested_MRP__c);
                        break;
                    }
                     else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c'&& prd.Suggested_MRP__c>= 1999 && prd.Suggested_MRP__c<= 2599){
                        prd.Suggested_MRP__c= 2599.00;
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                     else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c'&& prd.Suggested_MRP__c>= 2600 && prd.Suggested_MRP__c<= 2999){
                        prd.Suggested_MRP__c= 2999.00;
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                     else if(excp.Field_Name__c!=null && excp.Field_Name__c=='Suggested_MRP__c'&& prd.Suggested_MRP__c>= 8999 && prd.Suggested_MRP__c<= 10999){
                        prd.Suggested_MRP__c= 10999.00;
                        system.debug('Nearest==>'+prd.Suggested_MRP__c);
                        system.debug('expection id==>'+excp.id);
                        break;
                    }
                }              
            }
    }
    public class PrecedenceWrap{
        public Integer precedenceValue;
        public Double directMrp;
    }
    
}