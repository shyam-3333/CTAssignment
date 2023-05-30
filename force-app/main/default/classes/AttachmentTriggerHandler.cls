/*
* Created by    : Praveen (Lister)
* Created on    : Nov-18-2019
* Purpose 		: This trigger handler has a consolidated logic of Trigger_Update_Opportunity,Trigger_Update_No_of_Attachments,Trigger_Update_Attachment_Name and PhotoBackupUpdate
***********************************************************************************************************************************************************************************
ModifiedBy            Date       Tag     Description
*********************************************************************************************************************************************************************************** 
Praveen (Lister)   Nov-18-2019   T01     Validating attachment and updating attachment name
Praveen (Lister)   Nov-18-2019   T02     Updating Photo Backup field in product
Praveen (Lister)   Nov-18-2019   T03     Update opportunity field based on Attachment
*/
public with sharing class  AttachmentTriggerHandler 
{ 
    //<Recordtype Initialization>
    private final static Id opptRecordTypePECSA = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypePECSA).getRecordTypeId();
    private final static Id opptRecordTypeJewellery = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
    private final static Id opptRecordTypeLifestyle = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeLifestyle).getRecordTypeId();
    private final static Id opptRecordTypeWatches = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeWatches).getRecordTypeId();
    //</Recordtype Initialization>
    //<T01>
    private final static String costing ='Costing';
    private final static String tsCycletime ='TS_Cycletime';
    private final static String tsLayout ='TS_Layout';
    private final static String technicalSpecification ='Technical_Specification';
    private final static String quote ='Quote';
    private final static String orderAcceptance ='Order_Acceptance';
    private final static String projectApproval ='Project_Approval';
    private final static String documentError='Please attach correct document';
    //<T01>
    //<T03>
    private final static string attNameLayout='Layout';
    private final static string attNameCosting='Costing';
    private final static string attNameBreakup='Breakup';
    private final static string attNameClarifications='Clarifications';
    private final static string attNameOA='OA';
    private final static string attNameTimeline='Timeline';
    private final static string attNameRegret='Regret';
    private final static string attNameCycletime='Cycletime';
    private final static string attNameQuote='Quote';
    private final static string parentID ='paId';
    private final static string countID='cId';
    //</T03>
    
    //<T01>
    public static void validateAttachment(List<Attachment> lstAttachmentNew) {
        Set<Id> setOpptID = new Set<Id>();
        Map<Id,Opportunity> mapIdNOppt= new Map<Id,Opportunity>();
        String attachmentName='';
        List<opportunity> listOppt= new List<opportunity>();
        
        for(Attachment objAtt : lstAttachmentNew){
            if(String.valueof(objAtt.ParentId).substring(0,3) == Util_Common.opptPrefix){
                setOpptID.add(objAtt.ParentId);
            }
        }
        if(setOpptID.size()>0){
            listOppt=[select Revision_No__c,StageName,id,RecordTypeId from opportunity where id =:setOpptID AND RecordTypeId != : opptRecordTypeJewellery];
            if(listOppt.size()>0){
                for(Opportunity objOppt : listOppt){
                    mapIdNOppt.put(objOppt.id,objOppt);
                }
            }
        }
        if(mapIdNOppt.size()>0){
            for(Attachment objAtt : lstAttachmentNew){
                attachmentName = objAtt.Name.substring(0,objAtt.Name.lastindexof('.'));
                if(mapIdNOppt.containsKey(objAtt.ParentId) && mapIdNOppt.get(objAtt.ParentId).Revision_No__c>=0 && mapIdNOppt.get(objAtt.ParentId).StageName !=Util_Common.stageOrderWon ){
                    if(!attachmentName.startsWith(costing) && !attachmentName.startsWith(tsCycletime)  && !attachmentName.startsWith(tsLayout) && !attachmentName.startsWith(technicalSpecification) && !attachmentName.startsWith(Quote)&& !attachmentName.startsWith(orderAcceptance)&& !attachmentName.startsWith(projectApproval)) {
                        if(String.valueof(objAtt.ParentId).substring(0,3) == Util_Common.opptPrefix){
                            if(mapIdNOppt.get(objAtt.ParentId).RecordTypeId !=opptRecordTypePECSA && mapIdNOppt.get(objAtt.ParentId).RecordTypeId !=opptRecordTypeLifestyle && mapIdNOppt.get(objAtt.ParentId).RecordTypeId !=opptRecordTypeWatches){
                                if(!Test.isRunningTest()){
                                     objAtt.addError(documentError);
                                }
                               
                            }
                        }
                    }
                    else {
                        String extName =objAtt.Name.substring(objAtt.Name.lastindexof('.'),objAtt.Name.length());
                        if(mapIdNOppt.get(objAtt.ParentId).Revision_No__c==0){
                            objAtt.Name = attachmentName + ' -' + System.now().day() + '.' + System.now().month() + '.' + System.now().year() + '-' + System.now().hour()+'.'+System.now().minute()+'.'+System.now().second()+extName;
                        }
                        else if(mapIdNOppt.get(objAtt.ParentId).Revision_No__c==0){
                            objAtt.Name = attachmentName+'_'+mapIdNOppt.get(objAtt.ParentId).Revision_No__c + ' -' + System.now().day() + '.' + System.now().month() + '.' + System.now().year() + '-' + System.now().hour()+'.'+System.now().minute()+'.'+System.now().second()+extName;
                        }
                    }
                }
                
            }
        }
        
    }
    //</T02>
    public static void updateProductFields(List<Attachment> lstAttachmentNew){
        Map<Id,Attachment> attMap = new Map<Id,Attachment>();
        List<Product__c> prodList = new List<Product__c>();
        List<Product__c> updateProdList = new List<Product__c>();
        String productRecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get(Util_Common.recordTypeTaneira).getRecordTypeId();
        Product__c obj;
        for(Attachment att : lstAttachmentNew){
            attMap.put(att.ParentId,att);
        }
        prodList=[SELECT Id,Name,Photo_Backup__c FROM Product__c WHERE ID IN : attMap.keySet() AND RecordTypeId =:productRecordTypeId];
        if(prodList.size()>0){
            for(Product__c each :prodList){
                if(attMap.containsKey(each.Id)){
                    obj= new Product__c();
                    obj.Id= each.Id;
                    obj.Photo_Backup__c=attMap.get(each.Id).Id;
                    updateProdList.add(obj);
                }
            }
        }
        if(updateProdList.size()>0){
         //   try{
                update updateProdList;
       /*     }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }*/
        }
    }
    //</T02>
    //<T03>
    public static void updateOpportunity(List<Attachment> lstAttachmentNew,List<Attachment> listAttachmentOld){
        Map<ID,String> mapOppIDNName = new Map<ID,String>();
        Map<Id, Integer> countMap = new Map<Id, Integer>();
        List<Opportunity> listOppt = new List<Opportunity>();
        set<Id> opptID=new set<Id>();
        if(trigger.isInsert){
            for(Attachment objAtt : lstAttachmentNew){
                if(String.valueof(objAtt.ParentId).substring(0,3) == Util_Common.opptPrefix)
                {
                    mapOppIDNName.put(objAtt.ParentId,objAtt.Name);
                }
            }
        }
        if(trigger.isDelete){
            system.debug('de1');
            for(Attachment objAtt : listAttachmentOld){
                if(String.valueof(objAtt.ParentId).substring(0,3) == Util_Common.opptPrefix)
                {
                    mapOppIDNName.put(objAtt.ParentId,objAtt.Name);
                    system.debug('mapOppIDNName '+mapOppIDNName);
                }
            }
        }
        
        if(mapOppIDNName.size()>0){
            //Aggregate query to retrieve the count of attachements for opportunity
            for(AggregateResult res : [Select Count(Id) cId, ParentId paId from Attachment where ParentId IN : mapOppIDNName.keySet() group by ParentId]){
                countMap.put((Id)res.get(parentId), (Integer)res.get(countID));
                system.debug('countMap '+countMap);
            }
            
            for(Id oppId :mapOppIDNName.keyset()){
                Opportunity oppt =new Opportunity (Id=oppId);
                if(trigger.isInsert){
                    // Update attachment name in opportunity fields
                    if(mapOppIDNName.containsKey(oppId) && mapOppIDNName.get(oppId)!=null){
                        if(mapOppIDNName.get(oppId).contains(attNameLayout)){
                            oppt.Related_Document__c = attNameLayout;
                            system.debug('Related_Document__c '+oppt.Related_Document__c);}
                        else if(mapOppIDNName.get(oppId).contains(attNameCosting)){
                            oppt.Related_Document__c = attNameBreakup;
                            oppt.Costing_Uploaded__c = true;
                        }else if(mapOppIDNName.get(oppId).contains(attNameClarifications))
                            oppt.Clarification_Uploaded__c = true;
                        else if(mapOppIDNName.get(oppId).contains(attNameOA))
                            oppt.Related_Document__c = attNameOA;
                        else if(mapOppIDNName.get(oppId).contains(attNameTimeline))
                            oppt.Related_Document__c = attNameTimeline; 
                        else if(mapOppIDNName.get(oppId).contains(attNameRegret))
                            oppt.Related_Document__c = attNameRegret;
                        else if(mapOppIDNName.get(oppId).contains(attNameCycletime))
                            oppt.Cycle_Time_Uploaded__c = true;   
                        else if(mapOppIDNName.get(oppId).contains(attNameQuote))  
                            oppt.Quote_Uploaded__c = true;   
                        
                        // Update Number of attachments in opportunity fields
                        if(countMap.size()>0 && countMap.containsKey(oppId) && countMap.get(oppId)>0){
                            oppt.No_of_Attachments__c=countMap.get(oppId);
                            oppt.Total_No_of_Attachment__c=countMap.get(oppId);
                        }
                        else{
                            oppt.No_of_Attachments__c=0;
                            oppt.Total_No_of_Attachment__c=0;
                        }
                    }
                }
                if(trigger.isDelete){
                    system.debug('delete inside');
                    if(countMap.size()>0 && countMap.containsKey(oppId) && countMap.get(oppId)>0){
                        system.debug('countMap '+countMap);
                        oppt.No_of_Attachments__c=countMap.get(oppId);
                        oppt.Total_No_of_Attachment__c=countMap.get(oppId);
                    }
                    else{
                        oppt.No_of_Attachments__c=0;
                        oppt.Total_No_of_Attachment__c=0;
                    }
                }
                listOppt.add(oppt);
            }
            
        }
        if(listOppt.size()>0){
     //       try{
                update listOppt;
                system.debug('listOppt '+listOppt);
     /*       }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }*/
        }
    }
    //</T03>
}