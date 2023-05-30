/**********************************************************************************************
**Creadeted By : Vijayavardan Reddy.
**Modified By  : Vijayavardan reddy.
**Created Date : 29-Jun-2014.
**Description  : Checking the model number with the existence values while inserting or updating.
Change History
********************************************************************************************************************
SCRUM/Jira  		ModifiedBy      Date    		 Description                             Tag
Orgrefact           Ranjani N       18/05/2020  To call following 
classesProductSuggestedMRPHelper,            T01
ProductUpdateFieldsByOriginalFields,
ProductQRCodeCallOutHelper,
ProductQRCodeWithSKUCallOutHelper



*************************************************************************************************/   

trigger ProductDuplicatechecking on Product__c (before insert,before update,after insert,after update) {

    if(TriggerExecutionController__c.getInstance('ProdDuplicateCheck') !=NULL && TriggerExecutionController__c.getInstance('ProdDuplicateCheck').TriggerIsActive__c){
        if(trigger.isInsert && Trigger.IsBefore){
            system.debug('**insert**');
             RP_ProductTriggerHandler.updateL1_L5(Trigger.new); // RangePlan Trigger
             new TaneiraMMLogic().TaneiraMMLogicmethod(trigger.new);
            if( TriggerExecutionController__c.getInstance('ProductSuggestedMRPHelper').TriggerIsActive__c){ 
                system.debug('Trigger enters');
                //new NewTaneiraMultiplier().getSuggestedMRP(trigger.new);
                Database.executeBatch(new TaneiraMultiplierBatch(trigger.new),10);
            }
            ProductTriggerHandler.beforeInsertProduct(trigger.new);
            String prodKey;
            DateTime now = System.now();
            for(Product__c prod: Trigger.New) {
                
                prodKey = (String.valueOf(now).substring(0,19).trim()+prod.vendor_custom__c+prod.Product_Category_Taneira__c+prod.Cluster__c+prod.Offline_Username__c).trim();
                prodKey = prodKey.replaceAll( '\\s+', '');
                prod.Product_Key_Finder__c = prodKey;
                prod.Updated_in_TaneiraView__c=true;
            } 
            
            //<T01>
            
            if(system.label.product_update_fields_trigger_enable == 'true'){
                new ProductUpdateFieldsByOriginalFields().updateFields(trigger.new);
                //<T01>
            }
            
        }
        if(trigger.isBefore && Trigger.IsUpdate){
            system.debug('**update**');
            if(Recursivecheck.runOnce())
            {
                 RP_ProductTriggerHandler.updateL1_L5(Trigger.new); // RangePlan Trigger
                 if( TriggerExecutionController__c.getInstance('ProductSuggestedMRPHelper').TriggerIsActive__c){ 
                         
                     new NewTaneiraMultiplier().getSuggestedMRP(trigger.new); 
                     ProductTriggerHandler.beforeUpdateProduct(trigger.new,trigger.oldMap);
                 } 
            }
            // new NewTaneiraMultiplier().getSuggestedMRP(trigger.new);
          //  ProductTriggerHandler.beforeUpdateProduct(trigger.new,trigger.oldMap);
        }
        if(trigger.isAfter && Trigger.IsUpdate){
            ProductTriggerHandler.afterInsertUpdateProduct(trigger.newMap,trigger.oldMap,true);
            if(Recursivecheck.runOnce()){
            RP_ProductTriggerHandler.updateTotalValueInMaster(Trigger.new); // RangePlan Trigger
            }
             for(Product__c p : trigger.new){
                if(p.RE_ORDER__c == True){
                    SyncProductToTaneiraView.reorder(trigger.new);
                }         
             }
        }
        
        if(trigger.isAfter && trigger.isInsert){
            RP_ProductTriggerHandler.updateTotalValueInMaster(Trigger.new); // RangePlan Trigger
            ProductTriggerHandler.afterInsertUpdateProduct(trigger.newMap,null,false);
            SyncProductToTaneiraView.fetchProdData(Trigger.New);
            //To call When MM is created
            Set<Id> pid = trigger.newMap.keySet();
    		TaneiraSendMMToSapApi.sendMMToSap(pid);
        ProductEmailTriggerHandler.afterInserProduct(JSON.serialize(Trigger.New));    // Handler for new mail trigger
            
            //<T01>
            if(trigger.isAfter && trigger.isInsert && TriggerExecutionController__c.getInstance('QRcodeAPI').TriggerIsActive__c){
                
                    ProductQRCodeCallOutHelper.QRCodePostCallOut(Trigger.new);
                    ProductQRCodeWithSKUCallOutHelper.QRCodePostCallOut(Trigger.new);  
            }
        }
    
    }//end of if(custom setting)
    if(Trigger.isUpdate && Trigger.isAfter){
        
   SendProcurementCostUpdateEmailHandler procurement= new SendProcurementCostUpdateEmailHandler();//To send mail when Procurement cost has been changed in category stage
         procurement.sendProcurementCostUpdateEmail(Trigger.new,Trigger.oldMap);
    }
}//End of trigger