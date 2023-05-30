({
    getCompNamePickList : function(component, event, helper,fieldName) {
        debugger;
        var action = component.get("c.getPickListValue");
        action.setParams({
            'objectApiName':'Competitor_Product_Jew__c',
            'pickListFieldApiName':fieldName
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            debugger;
            if(state === "SUCCESS")
            {
                
                var result = response.getReturnValue();
                var pickVal = [];
                for(var i = 0; i<result.length; i++){//{key: key, value: result[key]}
                    pickVal.push({label:result[i],value:result[i]});
                }
            if(fieldName == 'Color_of_the_metal_Physical_analysis__c'){
                component.set("v.colorOfMetalPickList2",pickVal);
                              }
                /*if(fieldName == 'Competitor_name__c'){                   
                    component.set("v.competitorNamePicklist",pickVal);//cityPicklist
                }*/
                else if(fieldName == 'Setting_Type_PA__c'){
                    component.set("v.SettingType",pickVal);
                }
                    /*else if(fieldName == 'City__c'){
                        component.set("v.cityPicklist",pickVal);
                    }*/
                        else if(fieldName == 'Product_Category__c'){
                            component.set("v.ProdCategoryPickList",pickVal);
                        }
                            else if(fieldName == 'Product_Group__c'){
                                component.set("v.ProdGroupPickList",pickVal);
                            }
                                else if(fieldName == 'Metal__c'){
                                    component.set("v.metalPickList",pickVal);
                                }
                                    else if(fieldName == 'Manufacturing_route__c'){
                                        component.set("v.manufaRoutePickList",pickVal);
                                    }
                                        else if(fieldName == 'Purchased_Department__c'){
                                            component.set("v.purchaseDepPickList",pickVal);
                                        }
                                            else if(fieldName == 'Color_of_the_metal__c'){
                                                component.set("v.colorOfMetalPickList",pickVal);
                                            }
                                                else if(fieldName == 'Purity_Competitor_Billing__c'){
                                                    component.set("v.purityPickList",pickVal);
                                                }
                                                    else if(fieldName == 'Stone_Detail_Competitor_Billing__c'){
                                                        component.set("v.stoneDetailPickList",pickVal);
                                                    }
                                                        else if(fieldName == 'Colour__c'){
                                                            component.set("v.colorPickList",pickVal);
                                                        }
                                                            else if(fieldName == 'Setting_Type__c'){
                                                                component.set("v.settingTypePA",pickVal);
                                                            }
                                                                else if(fieldName == 'Attachment__c'){
                                                                    component.set("v.attachmentPickList",pickVal);
                                                                }
                                                                    else if(fieldName == 'Finish_Competitor_Billing__c'){
                                                                        component.set("v.finishBillingList",pickVal);
                                                                    }
                                                                        else if(fieldName == 'Finish_Physical_analysis1__c'){
                                                                            component.set("v.finishPAList",pickVal);
                                                                        }                                                                    
                                                                            else if(fieldName == 'Stone_Detail__c'){
                                                                                component.set("v.stoneDetailPickList2",pickVal);
                                                                            }
                                                                                else if(fieldName == 'Color_of_the_metal_Physical_analysis__c'){
                                                                                    component.set("v.colorOfMetalPickList2",pickVal);
                                                                                }
                                                                                
            }
            
        });
        $A.enqueueAction(action);
    },
    saveRecordHelper : function(component, event, helper){
        
        var finalRec = component.get("v.CompetitorProduct");
        var action = component.get("c.saveRecord");
        var recTypeName = component.get("v.recTypeName");
        
        finalRec.Gold_Rate_per_Gram_Conclusion__c = JSON.stringify( finalRec.Gold_Rate_per_Gram_Equalent_at_Tanishq__c - finalRec.Gold_Rate_Gram_Competitor_Billing__c );
        finalRec.Gold_price_Conclusion__c = JSON.stringify( finalRec.Gold_price_Equalent_at_Tanishq__c - finalRec.Gold_price_Competitor__c ) ;
        finalRec.Stone_price_Conclusion__c = JSON.stringify( finalRec.Stone_price_Equalent_at_Tanishq__c - finalRec.Stone_price_Competitor__c ) ;
        finalRec.Making_charge_Conclusion__c = JSON.stringify( finalRec.Making_charges_Equalent_at_Tanishq__c - finalRec.Making_charges_Competitor__c ) ;
        finalRec.Total_amount_paid_Conclusion__c = JSON.stringify( finalRec.Total_amount_paid_Equalent_at_Tanishq__c - finalRec.Total_amount_paid_Competitor__c ) ;
        component.set("v.CompetitorProduct",finalRec);
        
        action.setParams({
            'comProdStr':JSON.stringify(finalRec),
            'recTypeName':recTypeName
            
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            debugger;
            if(state === "SUCCESS")
            {
                var result = response.getReturnValue();
                var rec = JSON.parse(JSON.stringify(component.get("v.CompetitorProduct")));
                if( result != null || result != '' ){
                    var recValues = result.split(",");
                    rec.Id = recValues[0];
                    component.set("v.CompetitorProduct",rec);
                    component.set("v.recId",recValues[0]);
                    component.set("v.CompetitorProduct.Name",recValues[1]);
                }
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "type": "Success",
                    "message": "The record has been inserted successfully."
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchRecordDetails : function(component,event,helper){
        debugger;
        var recId = component.get("v.recId");
        var action = component.get("c.fetchProduct");
        action.setParams({
            'recId':recId
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var result = response.getReturnValue();
                console.log(result);
                component.set("v.CompetitorProduct",result);
                //options
            }
        });
        $A.enqueueAction(action);
    },
    updateRecord : function(component,event,helper){
        debugger;
        var rec = JSON.parse(JSON.stringify(component.get("v.CompetitorProduct")));
        var action = component.get("c.updateCompRec");
        
        rec.Gold_Rate_per_Gram_Conclusion__c = JSON.stringify( rec.Gold_Rate_per_Gram_Equalent_at_Tanishq__c - rec.Gold_Rate_Gram_Competitor_Billing__c );
        rec.Gold_price_Conclusion__c = JSON.stringify( rec.Gold_price_Equalent_at_Tanishq__c - rec.Gold_price_Competitor__c)  ;
        rec.Stone_price_Conclusion__c = JSON.stringify( rec.Stone_price_Equalent_at_Tanishq__c - rec.Stone_price_Competitor__c ) ;
        rec.Making_charge_Conclusion__c = JSON.stringify( rec.Making_charges_Equalent_at_Tanishq__c - rec.Making_charges_Competitor__c ) ;
        rec.Total_amount_paid_Conclusion__c = JSON.stringify( rec.Total_amount_paid_Equalent_at_Tanishq__c - rec.Total_amount_paid_Competitor__c ) ;
        component.set("v.CompetitorProduct",rec);
        
        action.setParams({
            'compRec':JSON.stringify(rec)
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "type": "Success",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchAttachments : function(component,event,helper){
        debugger;
        var recId = component.get("v.recId");
        var action = component.get("c.getContentDocs");
        action.setParams({
            'arecordId' : recId
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS') {
                
                var data = response.getReturnValue();
                if(data != null){
                    component.set("v.attachmentList",JSON.parse(JSON.stringify(data)));
                }
                component.set("v.newAttach",false);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    sendEmail : function(component,event,helper){
        debugger;
        var compProdId = component.get("v.recId");
        var emailAdd = component.get("v.CompetitorProduct").Email__c;
        var recType = component.get("v.recTypeName");
        var action = component.get("c.sendEmailTo");
        action.setParams({
            'recId':compProdId,
            'emailAddress':emailAdd,
            'recTypeName':recType
            
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "type": "Success",
                    "message": "Email sent successfully."
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
        component.set("v.sendPDF",false);
    }
})