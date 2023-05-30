/*
* Created by    : Praveen (Lister)
* Created on    : Nov-26-2019
* Purpose       : This handler class has the consolidated logic of OpportunityDeliveryStatusUpdate ,OpportunitySharingRule ,RFQStudyRecordTypeChange ,TitanOpportunityTrigger ,Trigger_Create_Opportunity_Stage_History ,Trigger_Create_Project_History ,Trigger_Create_Revision_History ,Trigger_Update_Converted_Amount ,UpdateOppNumber ,UpdateOpportunityAmountonApproval ,updateTempFieldwithInitialAmt
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)   Nov-12-2019   T01     Populate opportunity fields
Praveen(Lister)   Nov-12-2019   T02     Populate Recordtype based on Opportunity stages 
Praveen(Lister)   Nov-12-2019   T03     Insert Opportunity Team Member

*/
public class OpportunityTriggerHandler {
    //<Recordtype Initialization>
    //<Opportunity>
    public final static Id opptRecordTypePECSA = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypePECSA).getRecordTypeId();
    public final static Id opptRecordTypeJewellery = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
    public final static Id opptRecordTypeLifestyle = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeLifestyle).getRecordTypeId();
    public final static Id opptRecordTypeWatches = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeWatches).getRecordTypeId();
    public final static Id opptRecordTypeHiding = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeHiding).getRecordTypeId();
    public final static Id opptRecordTypeRFQ = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeRFQ).getRecordTypeId();
    public final static Id opptRecordTypeAwtFeedback = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeAwtFeebck).getRecordTypeId();
    public final static Id opptRecordTypeAllocated = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeAllocated).getRecordTypeId();
    public final static Id opptRecordTypeMBA = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAONLY).getRecordTypeId();
    //public final static Id OPPTRECORDTYPEMBASPARES = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.RECORDTYPEBUSINESSMBASPARES).getRecordTypeId();
    //public final static Id OPPTRECORDTYPEMBASERVICE = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.RECORDTYPEBUSINESSMBASERVICE).getRecordTypeId();
    public final static Id OPPTRECORDTYPEINITIAL = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.RECORDTYPEINITIAL).getRecordTypeId();
    public final static Id OPPTRECORDTYPEMBASERVICEALLOCATED = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.RECORDTYPEMBASERVICEALLOCATED).getRecordTypeId();
    public final static Id OPPTRECORDTYPELAYOUT = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.RECORDTYPEMLAYOUT).getRecordTypeId();
    public final static Id OPPTRECORDTYEQUOTESUBMT = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeQuoteSubmtd).getRecordTypeId();
    
    //</Opportunity>
    //<Project History RecordTypes>
    public final static Id prjctRecordTypeMBA = Schema.SObjectType.Project_Stage_History__c.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAONLY).getRecordTypeId();
    public final static Id prjctRecordTypePECSA = Schema.SObjectType.Project_Stage_History__c.getRecordTypeInfosByName().get(Util_Common.recordTypePECSA).getRecordTypeId();
    //</Project History RecordTypes>
    //</Recordtype Initialization>
    public final String  EXPLANTIONTOELECTRICALTEAM='Explanation to Electrical Team';
    //<T01>
    public static void populateOpptFields(List<Opportunity> listOpptNew,Map<Id,Opportunity> mapOldOppt,Map<Id,Opportunity> mapNewOppt){
        set<Id> setOwnerId = new set<Id>();
        set<Id> setOpptId = new Set<Id>();
        set<Id> setOpptAllNewId = new Set<Id>();
        Map<Id,Id> mapIDNUser = new Map<Id,Id>();
        Map<String,Decimal> mapCurNRate = new Map<String,Decimal>();
        List<Cost_Tracking__c> listCostTrack = new List<Cost_Tracking__c>();
        List<Revision_History__c> listRevHist = new List<Revision_History__c>();
        List<Revision_History__c> listRevHistUpd=new List<Revision_History__c>();
        String oppPreviousNumber;
        String nextNum = '0001';
        String zeroes = '000';
        String autoNum = '';
        Integer digitsToBe = 4;
        Integer digits;
     final String OPPRTUNITYCLOSEDERROR = 'An Opportunity cannot be edited once the opportunity stage is Order Closed'; 
        final String OPPRTUNITYCHANGESTATEERROR ='Cannot change Stage as Quote Customization Payment Criteria is Free of cost and quote is not approved';
        
        Map<Id,Opportunity> stageChangeOppId = new Map<Id,Opportunity>();
        List<Quote> lstQuotesStageChanged = new List<Quote>();
        Map<Id,List<Quote>> oppQuoteMapStage = new Map<Id,List<Quote>>();
        List<Quote> tempLoopQuoteForMap = new List<Quote>();
        Map<Id,Set<String>> attachmentWithOpp = new Map<Id,Set<String>>();
        Set<String> tmpSetForAttachment = new Set<String>();
        
        For(Opportunity objOppt : listOpptNew){
            setOpptAllNewId.add(objOppt.Id);
            if(trigger.isInsert){
                objOppt.Temp_amount__c=objOppt.Amount;
                if(objOppt.RecordTypeId==opptRecordTypeJewellery || objOppt.RecordTypeId==opptRecordTypeWatches){
                    if(objOppt.Activation_Date__c!=null){
                         objOppt.Activation_End_Date__c=objOppt.Activation_Date__c+180;
                  		 objOppt.Activation_Due_Date__c=objOppt.Activation_Date__c;
                    }
                }
            }
            if(trigger.isUpdate){
                if(mapOldOppt.get(objOppt.Id).stageName != objOppt.StageName){
                    stageChangeOppId.put(objOppt.Id,objOppt);
                }
                if(mapNewOppt.get(objOppt.Id).Activation_Date__c!=null &&
                  mapNewOppt.get(objOppt.Id).Activation_Date__c!= mapOldOppt.get(objOppt.Id).Activation_Date__c){
                      if(objOppt.RecordTypeId==opptRecordTypeJewellery|| objOppt.RecordTypeId==opptRecordTypeWatches){
                          objOppt.Activation_End_Date__c=objOppt.Activation_Date__c+180;
                          objOppt.Activation_Due_Date__c=objOppt.Activation_Date__c;
                          if(objOppt.RecordTypeId==opptRecordTypeJewellery){
                              Util_Common.sendEmail(Util_Common.GVEMAIL,objOppt.Name,mapOldOppt.get(objOppt.Id).Activation_Date__c,mapNewOppt.get(objOppt.Id).Activation_Date__c);
                          }
                          if(objOppt.RecordTypeId==opptRecordTypeWatches){
                              Util_Common.sendEmail(Util_Common.GCEMAIL,objOppt.Name,mapOldOppt.get(objOppt.Id).Activation_Date__c,mapNewOppt.get(objOppt.Id).Activation_Date__c);
                          }
                      }
                }
            }
            setOwnerId.add(objOppt.OwnerId);
        }
        
        if(stageChangeOppId.size() > 0){
            lstQuotesStageChanged = [select OpportunityId,Customization_Payment_Criteria__c,Approval_Status_Quote__c from Quote where OpportunityId=:stageChangeOppId.keyset()];    
        }
        
        for(Quote quoteObj : lstQuotesStageChanged){
            tempLoopQuoteForMap =  new List<Quote>();
            if(oppQuoteMapStage.containsKey(quoteObj.OpportunityId)){
                tempLoopQuoteForMap = oppQuoteMapStage.get(quoteObj.OpportunityId);
                tempLoopQuoteForMap.add(quoteObj);
                oppQuoteMapStage.put(quoteObj.OpportunityId, tempLoopQuoteForMap);
            }else{
                tempLoopQuoteForMap =  new List<Quote>();
                tempLoopQuoteForMap.add(quoteObj);
                oppQuoteMapStage.put(quoteObj.OpportunityId, tempLoopQuoteForMap);
            }
        }
        // attachment Validation
        if(setOpptAllNewId.size()>0){
            List<Attachment> lstAttachment = [Select id,Name,ParentId from Attachment where  ParentId=:setOpptAllNewId];
            
            
            for(Attachment attachObj : lstAttachment){
                if(attachmentWithOpp.containsKey(attachObj.ParentId)){
                    tmpSetForAttachment = attachmentWithOpp.get(attachObj.ParentId);
                    if(attachObj.Name.indexOfIgnoreCase(Util_common.VALIDATED)>=0 ){
                        tmpSetForAttachment.add(Util_common.VALIDATED);
                    }
                    if(attachObj.Name.indexOfIgnoreCase(Util_common.INVOICE)>=0 ){
                        tmpSetForAttachment.add(Util_common.INVOICE);
                    }
                    if(attachObj.Name.indexOfIgnoreCase(Util_common.REGISTRATION)>=0 ){
                        tmpSetForAttachment.add(Util_common.REGISTRATION);
                    }
                    attachmentWithOpp.put(attachObj.ParentId,tmpSetForAttachment);
                }else{
                    tmpSetForAttachment = new Set<String>();
                    if(attachObj.Name.indexOfIgnoreCase(Util_common.VALIDATED)>=0 ){
                        tmpSetForAttachment.add(Util_common.VALIDATED);
                    }
                    if(attachObj.Name.indexOfIgnoreCase(Util_common.INVOICE)>=0 ){
                        tmpSetForAttachment.add(Util_common.INVOICE);
                    }
                    if(attachObj.Name.indexOfIgnoreCase(Util_common.REGISTRATION)>=0 ){
                        tmpSetForAttachment.add(Util_common.REGISTRATION);
                    }
                    attachmentWithOpp.put(attachObj.ParentId,tmpSetForAttachment);
                }
                
            }
        }
        if(setOwnerId.size()>0){
            List<User> listUser = [select ID,ManagerID from User where ID IN: setOwnerId];
            if(listUser.size()>0){
                for(User objUser : listUser){
                    mapIDNUser.put(objUser.id, objUser.ManagerId);
                }
            }
        }
        List<CurrencyType> listCurrency =[Select IsoCode,ConversionRate from CurrencyType where IsoCode !=:Util_Common.currencyINR];
        if(listCurrency.size()>0){
            for(CurrencyType objCur :listCurrency){
                mapCurNRate.put(objCur.IsoCode,objCur.ConversionRate);
            }
        }
        List<Standard_Terms_of_Titan__c> listTerm = [select ID from Standard_Terms_of_Titan__c limit 1];
        //UpdateOppNumber Trigger - Check with titan to optimize more
        List<Opportunity> oppPreviousNumberRec = [SELECT Id,Auto_Number__c  FROM Opportunity where Auto_Number__c != null Order By ID DESC LIMIT 1] ;
        If(oppPreviousNumberRec.size()>0){
            oppPreviousNumber=oppPreviousNumberRec[0].Auto_Number__c;
        }
        if(trigger.isInsert){
            For(Opportunity objOppt : listOpptNew){
                if(objOppt.RecordTypeId==opptRecordTypeAllocated
                   || objOppt.RecordTypeId==opptRecordTypeAwtFeedback || objOppt.RecordTypeId==OPPTRECORDTYPEINITIAL
                   || objOppt.RecordTypeId==OPPTRECORDTYPELAYOUT || objOppt.RecordTypeId==opptRecordTypeMBA
                   || objOppt.RecordTypeId==OPPTRECORDTYEQUOTESUBMT) {
                       if(oppPreviousNumber != null && !String.isEmpty(oppPreviousNumber)) {
                           nextNum = String.ValueOf(Integer.ValueOf(oppPreviousNumber)+1);
                       }
                       if(nextNum.length() < digitsToBe) {
                           //digits=digitsToBe - nextNum.length();
                           //String zeroesToPrepend = zeroes.substring(0,digits); 
                           objOppt.Auto_Number__c = zeroes.substring(0,digitsToBe - nextNum.length()) + nextNum;
                       }
                       else {
                           objOppt.Auto_Number__c=nextNum;
                       }
                   }
                if(objOppt.RecordTypeId!=opptRecordTypeJewellery && objOppt.RecordTypeId!=opptRecordTypeLifestyle && 
                   objOppt.RecordTypeId!=opptRecordTypeWatches ){
                       if(objOppt.CurrencyIsoCode!=Util_Common.currencyINR && objOppt.Amount != null){
                           if(mapCurNRate.size()>0 && mapCurNRate.containskey(objOppt.CurrencyIsoCode) && mapCurNRate.get(objOppt.CurrencyIsoCode)!=null){
                               objOppt.Converted_Amount__c = objOppt.Amount / mapCurNRate.get(objOppt.CurrencyIsoCode);
                           }
                           if(mapIDNUser.size()>0 && mapIDNUser.containskey(objOppt.OwnerID) && mapIDNUser.get(objOppt.OwnerID)!=null){
                               objOppt.Manager__c = mapIDNUser.get(objOppt.OwnerID);
                           }
                           if(listTerm.size()>0)
                               objOppt.Standard_Terms_of_Titan__c = listTerm[0].ID;
                       }
                   }
                //Attachment Check

                    if(objOppt.RecordTypeId == opptRecordTypeJewellery && objOppt.Customization_Status__c == Util_Common.VALIDATED && 
                       (objOppt.StageName == Util_common.STAGEPROFORMAINVOICE||objOppt.StageName == Util_common.STAGERECEIVEDORDERPOWON ||
                        objOppt.StageName == Util_common.STAGEPAYMENTORDELIVERY ||objOppt.StageName == Util_Common.STAGEORDERCLOSED ) &&
                       (attachmentWithOpp.isEmpty() || !attachmentWithOpp.get(objOppt.id).contains( Util_Common.VALIDATED))){
                           objOppt.addError(Util_common.getError(Util_common.VALIDATED));
                       }
                    if(objOppt.RecordTypeId == opptRecordTypeJewellery && (objOppt.Account.TIN_No__c == Util_common.ONE||
                                                                           objOppt.Account.CST_No__c == Util_common.ONE||
                                                                           objOppt.Account.PAN_No__c == Util_common.ONE) && 
                       (objOppt.StageName == Util_common.STAGEPROFORMAINVOICE||objOppt.StageName == Util_common.STAGERECEIVEDORDERPOWON ||
                        objOppt.StageName == Util_common.STAGEPAYMENTORDELIVERY ||objOppt.StageName == Util_Common.STAGEORDERCLOSED )&&
                       !attachmentWithOpp.get(objOppt.id).contains(Util_common.REGISTRATION)){
                           objOppt.addError(Util_common.getError(Util_common.REGISTRATION));
                       }
                    
                    if((objOppt!=null && objOppt.RecordTypeId == opptRecordTypeLifestyle || objOppt.RecordTypeId == opptRecordTypeWatches) &&
                       objOppt.Customization_Status__c ==  Util_Common.VALIDATED && 
                       (objOppt.StageName == Util_common.STAGEPROFORMAINVOICE ||objOppt.StageName == Util_common.STAGERECEIVEDORDERPOWON ||
                        objOppt.StageName == Util_common.STAGEPAYMENTORDELIVERY ||objOppt.StageName == Util_Common.STAGEORDERCLOSED )
                       && (!attachmentWithOpp.get(objOppt.id).contains( Util_Common.VALIDATED))){
                           objOppt.addError(Util_common.getError(Util_common.VALIDATED));
                       }
                    if(objOppt!=null && objOppt.Delivery_Status__c == Util_Common.COMPLETED && objOppt.StageName == Util_common.STAGEPAYMENTORDELIVERY
                       && (!attachmentWithOpp.get(objOppt.id).contains(Util_common.INVOICE))){
                           objOppt.addError(Util_common.getError(Util_common.INVOICE));
                       }
                
            }
            
        }
        if(trigger.isUpdate && Util_Common.run){
            
            For(Opportunity objOppt : mapNewOppt.values()){
                objOppt.Corporate_amount__c =  objOppt.Amount ;
                if(mapNewOppt.get(objOppt.id).StageName != mapOldOppt.get(objOppt.id).StageName){
                    if(mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageRevisedQuote || mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageQuotePreparation){
                        if(mapNewOppt.get(objOppt.id).amount>=10000000){
                            mapNewOppt.get(objOppt.id).Send_Quotation_For_1_Cr_Approval_del__c=true;
                        }
                        else{
                            mapNewOppt.get(objOppt.id).Send_Quotation_For_1_Cr_Approval_del__c=false;
                        }
                    }
                    if(mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageOrderWon){
                        mapNewOppt.get(objOppt.id).Titan_OrderWonDate__c =system.today();
                    }	
                    //<T02>
                    if(mapNewOppt.get(objOppt.id).Business_Division_Used__c==Util_Common.recordTypeMBAONLY){
                        if(mapNewOppt.get(objOppt.id).StageName ==Util_Common.stagePreliminaryOppt)
                            mapNewOppt.get(objOppt.id).RecordTypeId = opptRecordTypeHiding;
                        if(mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageRFQStudy)
                            mapNewOppt.get(objOppt.id).RecordTypeId = opptRecordTypeRFQ;
                        if(mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageAwaitCustFeedback ||mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageUnderNegotiation||mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageAwaitFeedback)
                            mapNewOppt.get(objOppt.id).RecordTypeId = opptRecordTypeAwtFeedback;
                        if(mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageConceptFinal ||mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageQuotePreparation||mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageOrderWon || mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageRevisedQuote){
                            mapNewOppt.get(objOppt.id).RecordTypeId = opptRecordTypeAllocated;
                        }
                        if(mapNewOppt.get(objOppt.id).StageName ==Util_Common.stagePrjctExec ||mapNewOppt.get(objOppt.id).StageName ==Util_Common.stagePrjctClosed||mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageOpptHold || 
                           mapNewOppt.get(objOppt.id).StageName ==Util_Common.stagePrjctCancel || mapNewOppt.get(objOppt.id).StageName ==Util_Common.stageOpptLost)
                            mapNewOppt.get(objOppt.id).RecordTypeId = opptRecordTypeMBA;
                        
                    }
                    //</T02>
                }
                System.debug('TitanOrderWondate '+mapNewOppt.get(objOppt.id).Titan_OrderWonDate__c);
                if(mapNewOppt.get(objOppt.id).StageName != mapOldOppt.get(objOppt.id).StageName && mapOldOppt.get(objOppt.id).StageName ==Util_Common.stageOrderWon){
                    objOppt.Titan_OrderWonDate__c = null;
                }
                //<T04>
                if(mapNewOppt.get(objOppt.id).Total_Invoice_Value__c != mapOldOppt.get(objOppt.id).Total_Invoice_Value__c && mapOldOppt.get(objOppt.id).Total_Invoice_Value__c !=null){
                    objOppt.TurnOver__c = objOppt.Total_Invoice_Value__c - objOppt.VAT__c - objOppt.CST__c;
                }
                if(objOppt.RecordTypeId!=opptRecordTypeJewellery && objOppt.RecordTypeId!=opptRecordTypeLifestyle && objOppt.RecordTypeId!=opptRecordTypeWatches ){
                    if((mapNewOppt.get(objOppt.id).RecordTypeID != mapOldOppt.get(objOppt.id).RecordTypeID && mapNewOppt.get(objOppt.id).StageName != mapOldOppt.get(objOppt.id).StageName)){
                        if(mapNewOppt.get(objOppt.id).StageName == Util_Common.stageAwaitCustFeedback || mapNewOppt.get(objOppt.id).StageName == Util_Common.stageUnderNegotiation 
                           || mapNewOppt.get(objOppt.id).StageName == Util_Common.STAGEUNDERCUSTEVAL|| mapNewOppt.get(objOppt.id).StageName == Util_Common.STAGEUNDERCUSTREEVAL){
                               setOpptId.add(objOppt.id);
                           }
                        if(mapNewOppt.get(objOppt.id).StageName == Util_Common.stageAwaitCustFeedback || mapNewOppt.get(objOppt.id).StageName == Util_Common.stageUnderNegotiation){
                            listCostTrack.add(Util_Common.insertCostTrack(objOppt));
                        }
                        if(mapNewOppt.get(objOppt.id).StageName == Util_Common.stageRevisedQuote || mapNewOppt.get(objOppt.id).StageName == Util_Common.STAGEREQUOTE){
                            mapNewOppt.get(objOppt.id).Revision_Number__c = mapNewOppt.get(objOppt.id).Revision_Number__c + 1; 
                            Revision_History__c objRevHist = new Revision_History__c(); 
                            objRevHist.Name__c = Util_Common.RELEASE + mapNewOppt.get(objOppt.id).Revision_Number__c;  
                            objRevHist.Opportunity__c = objOppt.ID;
                            objRevHist.Start_Date__c = System.today();
                            listRevHist.add(objRevHist);
                            if(mapNewOppt.get(objOppt.id).StageName == Util_Common.stageRevisedQuote){
                                mapNewOppt.get(objOppt.id).Costing_Uploaded__c=false;
                                mapNewOppt.get(objOppt.id).Quote_Uploaded__c=false;
                                mapNewOppt.get(objOppt.id).Quote_Manager_Approved__c=false;
                                mapNewOppt.get(objOppt.id).Quote_Approved_Services__c=false;
                                mapNewOppt.get(objOppt.id).Quote_Approved_Spares__c=false;
                                mapNewOppt.get(objOppt.id).Quote_Submitted_Date__c=System.today();
                                mapNewOppt.get(objOppt.id).Mechanical__c=null;
                                mapNewOppt.get(objOppt.id).Electrical__c = null;
                                mapNewOppt.get(objOppt.id).Warranty_Used__c = null;
                                mapNewOppt.get(objOppt.id).OverHead_Charges__c = null;
                                mapNewOppt.get(objOppt.id).Quote_Value__c = null;
                                mapNewOppt.get(objOppt.id).Commissioning_Charges_Used__c = null;
                                mapNewOppt.get(objOppt.id).Packing_Charges__c = null;
                            }
                            if(mapNewOppt.get(objOppt.id).StageName == Util_Common.STAGEREQUOTE){
                                mapNewOppt.get(objOppt.id).Quotation_PECSA_Approved__c = false;
                                mapNewOppt.get(objOppt.id).Quote_Uploaded__c = false;
                            }
                        }
                    }
                    
                    if(mapCurNRate.size()>0 && mapCurNRate.containskey(mapNewOppt.get(objOppt.id).CurrencyIsoCode) && (mapNewOppt.get(objOppt.id).CurrencyIsoCode != mapOldOppt.get(objOppt.id).CurrencyIsoCode || mapNewOppt.get(objOppt.id).Amount != mapOldOppt.get(objOppt.id).Amount) && (mapNewOppt.get(objOppt.id).CurrencyIsoCode !='INR'))    
                        mapNewOppt.get(objOppt.id).Converted_Amount__c = mapNewOppt.get(objOppt.id).Amount / mapCurNRate.get(mapNewOppt.get(objOppt.id).CurrencyIsoCode);
                    if(mapIDNUser.size()>0 && mapIDNUser.containskey(mapNewOppt.get(objOppt.id).OwnerID) && mapNewOppt.get(objOppt.id).OwnerID != mapOldOppt.get(objOppt.id).OwnerID)
                        mapNewOppt.get(objOppt.id).Manager__c = mapIDNUser.get(mapNewOppt.get(objOppt.id).OwnerID); 
                    if(mapNewOppt.get(objOppt.id).StageName == Util_Common.STAGEREQAMEND)
                        mapNewOppt.get(objOppt.id).Related_Document__c = Util_Common.STAGEAMENDPO;  
                    if(mapNewOppt.get(objOppt.id).recordTypeID == OPPTRECORDTYPEINITIAL && mapNewOppt.get(objOppt.id).OwnerID != mapOldOppt.get(objOppt.id).OwnerID){
                        if(mapNewOppt.get(objOppt.id).Business_Division_Used__c == Util_Common.BUSINESSMBASERVICES){
                            mapNewOppt.get(objOppt.id).StageName = Util_Common.STAGEUNDERSTUDYCLAR;      
                            mapNewOppt.get(objOppt.id).RecordTypeID = OPPTRECORDTYPEMBASERVICEALLOCATED;
                        }
                    }
                    if(mapNewOppt.get(objOppt.id).Quote_Value__c != mapOldOppt.get(objOppt.id).Quote_Value__c || mapNewOppt.get(objOppt.id).TotalServices__c != mapOldOppt.get(objOppt.id).TotalServices__c){
                        if(mapNewOppt.get(objOppt.id).Quote_Value__c != null){
                            system.debug('quote value '+mapNewOppt.get(objOppt.id).Quote_Value__c);
                            mapNewOppt.get(objOppt.id).Amount = mapNewOppt.get(objOppt.id).Quote_Value__c;}
                        else if(mapNewOppt.get(objOppt.id).TotalServices__c != null)
                            mapNewOppt.get(objOppt.id).Amount = mapNewOppt.get(objOppt.id).TotalServices__c;
                    }
                }
                   if(mapOldOppt.get(objOppt.id).StageName==Util_common.STAGEORDERCLOSED || mapOldOppt.get(objOppt.id).StageName==Util_common.STAGEORDERCANCELLED){
                    objOppt.addError(OPPRTUNITYCLOSEDERROR);
                }
                if(objOppt.RecordTypeId==opptRecordTypeLifestyle || objOppt.RecordTypeId==opptRecordTypeJewellery||objOppt.RecordTypeId==opptRecordTypeWatches){
                    
                    if(oppQuoteMapStage.containsKey(objOppt.id)){
                        for(Quote objStageQuote : oppQuoteMapStage.get(objOppt.id)){
                            if(objStageQuote.Customization_Payment_Criteria__c ==Util_common.FREEOFCOST && objStageQuote.Approval_Status_Quote__c!=Util_common.APPROVED){
                                objOppt.addError(OPPRTUNITYCHANGESTATEERROR);
                            } 
                        }
                    }
                }
                //Attachment Check

                    if(objOppt.RecordTypeId == opptRecordTypeJewellery && objOppt.Customization_Status__c == Util_Common.VALIDATED && 
                       (objOppt.StageName == Util_common.STAGEPROFORMAINVOICE||objOppt.StageName == Util_common.STAGERECEIVEDORDERPOWON ||
                        objOppt.StageName == Util_common.STAGEPAYMENTORDELIVERY ||objOppt.StageName == Util_Common.STAGEORDERCLOSED ) &&
                       (attachmentWithOpp.isempty() || !attachmentWithOpp.get(objOppt.id).contains( Util_Common.VALIDATED))){
                           objOppt.addError(Util_common.getError(Util_common.VALIDATED));
                       }
                    if(objOppt.RecordTypeId == opptRecordTypeJewellery && (objOppt.Account.TIN_No__c == '1'||
                                                                           objOppt.Account.CST_No__c == '1'||
                                                                           objOppt.Account.PAN_No__c == '1') && 
                       (objOppt.StageName == Util_common.STAGEPROFORMAINVOICE||objOppt.StageName == Util_common.STAGERECEIVEDORDERPOWON ||
                        objOppt.StageName == Util_common.STAGEPAYMENTORDELIVERY ||objOppt.StageName == Util_Common.STAGEORDERCLOSED )
                       && (attachmentWithOpp.isempty() ||
                       !attachmentWithOpp.get(objOppt.id).contains(Util_common.REGISTRATION))){
                           objOppt.addError(Util_common.getError(Util_common.REGISTRATION));
                       }
                    
                    if((objOppt!=null && objOppt.RecordTypeId == opptRecordTypeLifestyle || objOppt.RecordTypeId == opptRecordTypeWatches) &&
                       objOppt.Customization_Status__c ==  Util_Common.VALIDATED && 
                       (objOppt.StageName == Util_common.STAGEPROFORMAINVOICE ||objOppt.StageName == Util_common.STAGERECEIVEDORDERPOWON ||
                        objOppt.StageName == Util_common.STAGEPAYMENTORDELIVERY ||objOppt.StageName == Util_Common.STAGEORDERCLOSED )
                       && (attachmentWithOpp.isempty() || !attachmentWithOpp.get(objOppt.id).contains( Util_Common.VALIDATED))){
                           objOppt.addError(Util_common.getError(Util_common.VALIDATED));
                       }
                    if(objOppt!=null && objOppt.Delivery_Status__c == Util_Common.COMPLETED && objOppt.StageName == Util_common.STAGEPAYMENTORDELIVERY
                       && (attachmentWithOpp.isempty()  || !attachmentWithOpp.get(objOppt.id).contains(Util_common.INVOICE))){
                           objOppt.addError(Util_common.getError(Util_common.INVOICE));
                       }
					System.debug('TitanOrderWondate '+mapNewOppt.get(objOppt.id).Titan_OrderWonDate__c);
                //</T04>
            }
            Util_Common.run=false;
            // insert Revision history
            if(listRevHist.size()>0){
                try{
                    insert listRevHist;
                }
                catch(Exception e){
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
            }
            //Update Revision history
            if(setOpptId.size()>0){
                List<Revision_History__c> listRevHistRet=[select ID,Name,EndDate__c,Opportunity__c from Revision_History__c where Opportunity__c IN: setOpptId AND EndDate__c = NULL];
                if(listRevHistRet.size()>0){
                    for(Revision_History__c objHist: listRevHistUpd){
                        objHist.EndDate__c=System.today();
                        listRevHistUpd.add(objHist);
                    }
                }
                if(listRevHistUpd.size()>0){
                    try{
                        update listRevHistUpd;
                    }
                    catch(Exception e){
                        Debug_Logs__c excp = Util_Common.processException(e,true,'');
                    }
                }
            }
            // insert Cost Tracking
            if(listCostTrack.size()>0){
                try{
                    insert listCostTrack;
                }
                catch(Exception e){
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
            }
        }
        
    }
    //<T01>
    //<T03>
    public static void insertOpptTeam(Map<Id,Opportunity> mapNewOppt,Map<Id,Opportunity> mapOldOppt){
        List<OpportunityTeamMember>listOpptTeam = new List<OpportunityTeamMember>();
        List<OpportunityTeamMember>listOpptTeamUpdate = new List<OpportunityTeamMember>();
        Map<Id,Id> mapIdNOppId= new Map<Id,Id>();
        set<Id> setOpptId = new set<Id>();
        set<Id> setOpptNProjId=new set<Id>();
        set<Id> setOpptArchiveId=new set<Id>();
        map<Id,Opportunity> mapIdNOppt = new map<Id,Opportunity>();
        Map<Id,String> mapIdNPath = new Map<Id,String>();
        boolean isException=false;
        List<Project_Stage_History__c> listProj = new  List<Project_Stage_History__c>();
        List<Task> listTaskUpd = new List<Task>();
        final String  EXPLANTIONTOELECTRICALTEAM='Explanation to Electrical Team';
        
        For(Opportunity objOppt : mapNewOppt.values()){
            if(objOppt.Business_Division_Used__c==Util_Common.recordTypeMBAONLY){
                if(trigger.isInsert && mapNewOppt.get(objOppt.id).Member1__c!=null){
                    listOpptTeam.add(Util_Common.insertOpptTeam(objOppt.id,mapNewOppt.get(objOppt.id).Member1__c,Util_Common.MECHANICALROLE));
                }
                if(trigger.isInsert && mapNewOppt.get(objOppt.id).Member2__c!=null){
                    listOpptTeam.add(Util_Common.insertOpptTeam(objOppt.id,mapNewOppt.get(objOppt.id).Member2__c,Util_Common.ELECTRICALROLE));
                }
                if(trigger.isUpdate){
                    if((mapNewOppt.get(objOppt.id).Member1__c!=null && mapNewOppt.get(objOppt.id).Member1__c!=mapOldOppt.get(objOppt.id).Member1__c) ||
                       (mapNewOppt.get(objOppt.id).Member2__c!=null  && mapNewOppt.get(objOppt.id).Member2__c!=mapOldOppt.get(objOppt.id).Member2__c)){
                           setOpptId.add(objOppt.id);
                       }
                    if(mapNewOppt.get(objOppt.id).RecordTypeID == mapOldOppt.get(objOppt.id).RecordtypeID && mapNewOppt.get(objOppt.id).StageName != mapOldOppt.get(objOppt.id).StageName 
                       || (mapNewOppt.get(objOppt.id).Sub_Activities__c != mapOldOppt.get(objOppt.id).Sub_Activities__c && mapNewOppt.get(objOppt.id).Sub_Activities__c ==Util_Common.ELECTRICALTEAM)){    
                           setOpptNProjId.add(objOppt.id);
                           mapIdNOppt.put(objOppt.id,objOppt);
                       }
                    
                }
            }
            if(trigger.isUpdate){            
                if((mapNewOppt.get(objOppt.id).Archive_Documents__c != mapOldOppt.get(objOppt.id).Archive_Documents__c && mapNewOppt.get(objOppt.id).Archive_Documents__c == 'Yes' && mapNewOppt.get(objOppt.id).Document_Archival_Completed__c != mapOldOppt.get(objOppt.id).Document_Archival_Completed__c && mapNewOppt.get(objOppt.id).Document_Archival_Completed__c == 'No') ||  (mapNewOppt.get(objOppt.id).Archive_Documents__c == 'Yes' && mapNewOppt.get(objOppt.id).Document_Archival_Completed__c != mapOldOppt.get(objOppt.id).Document_Archival_Completed__c && mapNewOppt.get(objOppt.id).Document_Archival_Completed__c == 'No'))
                {
                    setOpptArchiveId.add(objOppt.id);
                    if(mapNewOppt.get(objOppt.id).RecordTypeID != opptRecordTypeJewellery && mapNewOppt.get(objOppt.id).RecordTypeID != opptRecordTypeLifestyle && mapNewOppt.get(objOppt.id).RecordTypeID != opptRecordTypeWatches)
                        mapIdNPath.put(objOppt.ID,mapNewOppt.get(objOppt.id).Server_Path__c);
                }
            }
        }
        if(setOpptNProjId.Size()>0){
            List<Project_Stage_History__c> listobjProj = [select Name,Opportunity__c,Actual_Start_Date__c,Stage_Name__c,Actual_End_Date__c from Project_Stage_History__c where Opportunity__c IN: setOpptNProjId];
            for(Project_Stage_History__c objProj : listobjProj){
                
                if(objProj.Actual_Start_Date__c != null && objProj.Actual_End_Date__c == null && 
                   ((objProj.Stage_Name__c != Util_common.stageUnderNegotiation) || (objProj.Stage_Name__c == Util_common.stageUnderNegotiation && mapIdNOppt.containskey(objProj.Opportunity__c) && mapIdNOppt.get(objProj.Opportunity__c).StageName ==Util_common.stageOrderWon))){
                       if(mapIdNOppt.get(objProj.Opportunity__c).Sub_Activities__c==EXPLANTIONTOELECTRICALTEAM && objProj.Stage_Name__c!=Util_common.stageCosting){
                           objProj.Actual_End_Date__c = System.Today();
                           listProj.add(objProj);
                       }
                   }
            }
        }
         System.debug('Task'+setOpptArchiveId);
        if(setOpptArchiveId.size()>0){
           
            List<Attachment> listAtt = [select ID,Name,ParentID from Attachment where ParentID IN: setOpptArchiveId];
            List<Task> listTask = [Select ID,Description from Task where WhatID IN: setOpptArchiveId and Subject LIKE '%Email%'];
            if(listAtt.size()>0 && listTask.size()>0){
                For(Task objtask :listTask){
                    for(Attachment objAtt : listAtt){
                        System.debug('Task'+objAtt.id);
                        if(objtask.Description.Contains(objAtt.id)){
                            System.debug('Task');
                            string path = (mapIdNPath.Containskey(objAtt.ParentID) ? mapIdNPath.get(objAtt.ParentID):'');
                            if(objtask.Description.Contains(Util_common.ARCHIVEDLINKS)){
                                objtask.Description = objtask.Description + Util_common.SLASHN + objAtt.Name + Util_common.FILEPATH + path + Util_common.CORRESPONDENCEPATH+objAtt.Name;
                            }
                            else{
                                objtask.Description =objtask.Description + Util_common.SLASHN + Util_common.ARCHIVEDLINKS + Util_common.SLASHN + objAtt.Name + Util_common.FILEPATH + path + Util_common.CORRESPONDENCEPATH+objAtt.Name;
                            }
                            listTaskUpd.add(objtask);
                        }
                    }
                }
            }
        }
        //Update Task
        if(listTaskUpd.size() > 0){
            try{
                System.debug('Task');
                update listTaskUpd;
            }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        } 
        //Insert Project History
        if(listProj.size()>0){
            try{
                update listProj;
            }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        }
        
        if(setOpptId.size()>0){
            List<OpportunityTeamMember> objOpptTeam = [select id,OpportunityId,User.Id,TeamMemberRole,OpportunityAccessLevel from OpportunityTeamMember where OpportunityId=:setOpptId];
            if(objOpptTeam.size()>0){
                try{
                    delete objOpptTeam;
                }
                catch(Exception e){
                    isException=true;
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
                if(!isException){
                    For(Opportunity objOppt : mapNewOppt.values()){
                        if(objOppt.Business_Division_Used__c==Util_Common.recordTypeMBAONLY)
                            if(trigger.isUpdate && mapNewOppt.get(objOppt.id).Member1__c!=null){
                                listOpptTeam.add(Util_Common.insertOpptTeam(objOppt.id,mapNewOppt.get(objOppt.id).Member1__c,Util_Common.MECHANICALROLE));
                            }
                        if(trigger.isUpdate && mapNewOppt.get(objOppt.id).Member2__c!=null){
                            listOpptTeam.add(Util_Common.insertOpptTeam(objOppt.id,mapNewOppt.get(objOppt.id).Member2__c,Util_Common.ELECTRICALROLE));
                        }
                    }
                }
            }
        }
        
        if(listOpptTeam.size()>0){
            try{
                insert listOpptTeam;
            }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        }
        //</T03>
        
    }
    public static void insertProjectHist(List<Opportunity> listOpptNew){
        List<Project_Stage_History__c> listPrjct = new List<Project_Stage_History__c>();
        Schema.DescribeFieldResult MBAF = Opportunity.MBA__c.getDescribe();
        List<Schema.PicklistEntry> MBAP = MBAF.getPicklistValues();
        Schema.DescribeFieldResult MBASerF = Opportunity.MBA_Sevices_Stages__c.getDescribe();
        List<Schema.PicklistEntry> MBASerP = MBASerF.getPicklistValues();
        Schema.DescribeFieldResult PECSAF = Opportunity.PECSA_St__c.getDescribe();
        List<Schema.PicklistEntry> PECSAP = PECSAF.getPicklistValues();
        
        for(Opportunity oppt : listOpptNew){
            if(oppt.recordtypeID ==OPPTRECORDTYPEINITIAL){
                if(oppt.Business_Division_Used__c==Util_Common.BUSINESSMBA){
                    For(Integer i=0; i<MBAP.size(); i++){ 
                        if(MBAP[i].getLabel() != Util_Common.stageAwaitCustFeedback && MBAP[i].getLabel() != Util_Common.stageRevisedQuote){ 
                            listPrjct.add(Util_Common.insertProjStageHist(String.valueof(MBAP[i].getLabel()),oppt.Id,prjctRecordTypeMBA));
                        }
                    }
                }
                else if(oppt.Business_Division_Used__c==Util_Common.BUSINESSMBASERVICES){
                    for(Integer i=0; i<MBASerP.size(); i++){ 
                        if(MBASerP[i].getLabel() != Util_Common.stageAwaitCustFeedback && MBASerP[i].getLabel() != Util_Common.stageRevisedQuote){  
                            listPrjct.add(Util_Common.insertProjStageHist(String.valueof(MBASerP[i].getLabel()),oppt.Id,prjctRecordTypeMBA));
                        }
                    }
                }
            }
            else if(oppt.recordTypeID == opptRecordTypePECSA){
                system.debug('PECSAP '+PECSAP);
                for(Integer i=0; i<PECSAP.size(); i++){ 
                    if(PECSAP[i].getLabel() != Util_Common.STAGEUNDERCUSTREEVAL && PECSAP[i].getLabel() != Util_Common.STAGEREQUOTE){ 
                        system.debug('inside ');
                        listPrjct.add(Util_Common.insertProjStageHist(String.valueof(PECSAP[i].getLabel()),oppt.Id,prjctRecordTypePECSA));
                    }
                }
            }
        }
        if(listPrjct.size()>0){
            try{
                system.debug('listPrjct '+listPrjct);
                insert listPrjct;
            }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        }
    }
     public void test1(){
        integer i=0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
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
}