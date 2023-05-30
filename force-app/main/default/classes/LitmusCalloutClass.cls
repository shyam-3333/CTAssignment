/*
* Created by    : Mutturaj Heroor
* Created on    : March-09-2021
* Purpose       : FeedbackCreationClass is Used to create new Feedback Record under the opportunity and send Feedbabak request to Litmus system 
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/
public class LitmusCalloutClass {
    
    // This Method is used to Create Feedback record while Opoortunity is Updated to Close Won Or Close Lost and send Feedbabak request to Litmus system
    @future(callout = true)
    Public static void sendFeedBackRequestToLitmus(String newOppListstr,String oldOppMapstr )
    {
        try
        {         
            System.debug( newOppListstr );
            // Deserialize Trigger new List and Old Map
            List<Opportunity> newOppList = (List<Opportunity>) JSON.deserialize(newOppListstr, List<Opportunity>.class);
            Map<Id,Opportunity> oldOppMap = (Map<Id,Opportunity>) JSON.deserialize(oldOppMapstr, Map<Id,Opportunity>.class);
            if( newOppList.size() > 0 )
            {
                Set<Id> OppIdSet = new Set<Id>();
                Set<Id> accIdSet = new Set<Id>();
                Map<String,String> oppidOwnerIdMap=new Map<String,String>();
                List<String>ownerIdList=new List<String>();
                Map<String,String>ownerManagerNameMap=new Map<String,String>();
                List<Feedback__c> feedbackList = new List<Feedback__c>();
                List<Feedback__c> feedbackList2 = new List<Feedback__c>();
                Map<Id,Opportunity> oppRegionMap = new Map<Id,Opportunity>();
                // Fetching the StageNames From Custom Label to check the Condition
                List<String> oppStageNameLabel = label.Opportunity_Stages_to_send_Feedback.split(',');
                System.debug('oppStageNameLabel => ' + oppStageNameLabel);
                Feedback__c feedback ;
                //fetching Account record type Id
                List<Id> oppRecordTypeIdList = new List<Id>();
                String jewelleryRecordTypeId=Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
                oppRecordTypeIdList.add( Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId());
                oppRecordTypeIdList.add( Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Watches').getRecordTypeId());
                oppRecordTypeIdList.add( Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Lifestyle').getRecordTypeId());
                for(Opportunity opp : newOppList )
                {
                    System.debug('opp.Account.RecordTypeId ==>' + opp.Account.RecordTypeId + '  opp.StageName => '+ opp.StageName);
                    if( oppRecordTypeIdList.contains( opp.RecordTypeId )  && (oppStageNameLabel.contains(opp.StageName) && opp.StageName != oldOppMap.get(opp.Id).StageName) && opp.Gift_Card_Transaction_Date__c==Null )
                    {
                        OppIdSet.add(opp.Id);
                        accIdSet.add(opp.AccountId);
                        feedback = new Feedback__c();
                        feedback.Opportunity_Id__c = opp.Id;
                        feedback.Opportunity_name__c = opp.Name ;
                        feedback.AccountId__c = opp.AccountId;
                        feedbackList.add( feedback );
                        oppRegionMap.put( opp.Id, opp);
                        system.debug('feedback ==> '+ feedback );
                        ownerIdList.add(opp.Ownerid);
                        oppidOwnerIdMap.put(opp.id, opp.Ownerid);
                    }
                    else if(opp.RecordTypeId == jewelleryRecordTypeId  && !oppStageNameLabel.contains(opp.StageName) && (opp.Gift_Card_Transaction_Date__c!=Null && oldOppMap.get(opp.Id).Gift_Card_Transaction_Date__c ==Null )  )
                    {
                        OppIdSet.add(opp.Id);
                        accIdSet.add(opp.AccountId);
                        feedback = new Feedback__c();
                        feedback.Opportunity_Id__c = opp.Id;
                        feedback.Opportunity_name__c = opp.Name ;
                        feedback.AccountId__c = opp.AccountId;
                        feedbackList2.add( feedback );
                        oppRegionMap.put( opp.Id, opp);
                        system.debug('feedback2 ==> '+ feedback );
                        ownerIdList.add(opp.Ownerid);
                        oppidOwnerIdMap.put(opp.id, opp.Ownerid);
                    }
                }
                if(feedbackList.size() > 0 )
                {
                    System.debug( 'feedbackList :'+feedbackList );
                    System.debug('running from stages part');
                    // mapOfContact Is used to strore related Primary Contact of the opportunity 
                  /*  Map<Id,Contact> mapOfContact = new Map<Id,Contact>();
                    for(Contact cont : [SELECT Id,Name,Email,MobilePhone,AccountId,Account.Name FROM Contact where Inactive__c = false And AccountId =:accIdSet ])
                    {
                        if(!mapOfContact.containskey(cont.AccountId))
                        {
                            mapOfContact.put( cont.AccountId ,cont);
                            system.debug(mapOfContact.get(cont.AccountId));
                        }
                    }*/
                    
                    // mapOfQuote Is used to strore related recent Quote of the opportunity
                    Map<Id,Quote> mapOfQuote = new Map<Id,Quote>();
                    for(Quote qt : [SELECT Id,Name,QuoteNumber,INSTI_Order_Reference__c,OpportunityId,AccountId,Account.Name,Account.BillingCity,ContactId,Contact.Name,Contact.Email,Contact.MobilePhone FROM Quote where OpportunityId =: OppIdSet Order By CreatedDate Desc ])
                    {
                        if( !mapOfQuote.ContainsKey(qt.OpportunityId) )
                        {
                            mapOfQuote.put( qt.OpportunityId , qt);
                        }
                    }
                    //getting the manager name if the opportunity owner
                    List<User> uList=[select userName,ID,manager.name from user where id =: ownerIdList];
                    if(uList.size()>0)
                    {
                        for(User u:uList)
                        {
                            ownerManagerNameMap.put(u.id,u.manager.name);
                        }
                    }
    
                    
                    // Assigning Quote and Contact Details to respected Feedback record
                    for(Feedback__c fb : feedbackList)
                    {
                        fb.Contact_name__c = mapOfQuote.get(fb.Opportunity_Id__c)?.Contact.Name;//mapOfContact.get(fb.AccountId__c)?.Name;
                        fb.Contact_Email__c = mapOfQuote.get(fb.Opportunity_Id__c)?.Contact.Email;//mapOfContact.get(fb.AccountId__c)?.Email;
                        fb.Contact_Mobile_Number__c = mapOfQuote.get(fb.Opportunity_Id__c)?.Contact.MobilePhone;//mapOfContact.get(fb.AccountId__c)?.MobilePhone;
                        fb.Quote_number__c = mapOfQuote.get(fb.Opportunity_Id__c)?.QuoteNumber;
                        fb.Insti_order_number__c = mapOfQuote.get(fb.Opportunity_Id__c)?.INSTI_Order_Reference__c;
                    }
                    
                    // senf Feed back request to Litmus System 
                    List<LitmusApiOnRegion__c> apiRegionList = [SELECT Id,Name,Region__c FROM LitmusApiOnRegion__c];
                    User headCorpUser = [SELECT Id,Name FROM User where Profile.Name ='Head corp profile' LIMIT 1];
                    System.debug('headCorpUser' + headCorpUser.Name);
                    Map<String,String> apiRegionMap = new Map<String,String>();
                    for(LitmusApiOnRegion__c apiRegion : apiRegionList )
                    {
                        apiRegionMap.put( apiRegion.Region__c , apiRegion.Name);
                    }
                    
                    feedBackWrap fbWrap = new feedBackWrap();
                    System.debug('feedbacklistvalues==>'+feedbackList[0]);
                    fbWrap.app_id = oppRegionMap.Containskey( feedbackList[0].Opportunity_Id__c ) ? apiRegionMap.get( oppRegionMap.get( feedbackList[0].Opportunity_Id__c )?.Region_Picklist__c ) : 'bm9d_east'; // 'yp0q_test'; 
                    //fbWrap.app_id=System.label.LitmusIntegrationAppId;
                    fbWrap.user_phone = feedbackList[0].Contact_Mobile_Number__c ;
                    fbWrap.user_email = feedbackList[0].Contact_Email__c ;
                    fbWrap.name = feedbackList[0].Contact_name__c ;
                    fbWrap.tag_company_name = mapOfQuote.get(feedbackList[0].Opportunity_Id__c)?.Account.Name;//mapOfContact.get(feedbackList[0].AccountId__c)?.Account.Name;
                    fbWrap.tag_custodian = headCorpUser.Name ;
                    fbWrap.tag_region = oppRegionMap.get( feedbackList[0].Opportunity_Id__c )?.Region_Picklist__c ;
                    fbWrap.tag_stagename = oppRegionMap.get( feedbackList[0].Opportunity_Id__c )?.StageName ;
                    fbWrap.tag_status_of_lead = oppRegionMap.get( feedbackList[0].Opportunity_Id__c )?.StageName ;
                    fbWrap.tag_opportunity_id = feedbackList[0].Opportunity_Id__c ;
                    //New addition
                    fbWrap.tag_city=mapOfQuote.get(feedbackList[0].Opportunity_Id__c)?.Account.BillingCity;
                    fbWrap.tag_rbm=ownerManagerNameMap.get(oppidOwnerIdMap.get(feedbackList[0].Opportunity_Id__c));
                    fbWrap.tag_transaction_date=oppRegionMap.get( feedbackList[0].Opportunity_Id__c )?.Gift_Card_Transaction_Date__c;
                    
                    System.debug('city :'+fbWrap.tag_city+'tag_transaction_date '+fbWrap.tag_transaction_date);
                    String requestBody = JSON.serialize( fbWrap) ;
                    //Json Data
                    List<String> jsoncheck=requestBody.split(',');
                    for(String s:jsoncheck)
                    {
                        System.debug(s);
                    }
                    
                    Http http = new Http();
                    
                    System.debug('requestBody ==> ' + requestBody );
                    HttpRequest request = new HttpRequest();
                    request.setMethod('POST');
                    request.setEndpoint(System.label.LitmusIntegrationEndPoint);
                    request.setHeader('Content-Type','application/json');
                    request.setBody(requestBody);
                    
                    HttpResponse response = http.send(request);
                    if(response.getStatusCode() == 200)
                    {
                        System.debug('FeedBack is Submitted Successfully');
                        System.debug('Status : ' + response.getStatusCode());
                        System.debug('message : ' + response.getBody());
                        
                        /*Opportunity newOp=new Opportunity();
                        newOp.Integration_done__c=true;
                        newOp.Id=feedbackList[0].Opportunity_Id__c;
                        Update newOp;*/
                    }
                    else{
                        System.debug('FeedBack is Not Submited');
                        System.debug('Status : ' + response.getStatusCode());
                        System.debug('message : ' + response.getBody());
                    }
                   
                    Insert feedbackList[0];
                }
                else if(feedbackList2.size() > 0 )
                {
                    System.debug( 'feedbackList2 :'+feedbackList2 );
                    System.debug('running giftcard traction part');
                    // mapOfContact Is used to strore related Primary Contact of the opportunity 
                  /*  Map<Id,Contact> mapOfContact = new Map<Id,Contact>();
                    for(Contact cont : [SELECT Id,Name,Email,MobilePhone,AccountId,Account.Name FROM Contact where Inactive__c = false And AccountId =:accIdSet ])
                    {
                        if(!mapOfContact.containskey(cont.AccountId))
                        {
                            mapOfContact.put( cont.AccountId ,cont);
                            system.debug(mapOfContact.get(cont.AccountId));
                        }
                    }*/
                    
                    // mapOfQuote Is used to strore related recent Quote of the opportunity
                    Map<Id,Quote> mapOfQuote = new Map<Id,Quote>();
                    for(Quote qt : [SELECT Id,Name,QuoteNumber,INSTI_Order_Reference__c,OpportunityId,AccountId,Account.Name,Account.BillingCity,ContactId,Contact.Name,Contact.Email,Contact.MobilePhone FROM Quote where OpportunityId =: OppIdSet Order By CreatedDate Desc ])
                    {
                        if( !mapOfQuote.ContainsKey(qt.OpportunityId) )
                        {
                            mapOfQuote.put( qt.OpportunityId , qt);
                        }
                    }
                    
                    //getting the manager name if the opportunity owner
                    List<User> uList=[select userName,ID,manager.name from user where id =: ownerIdList];
                    if(uList.size()>0)
                    {
                        for(User u:uList)
                        {
                            ownerManagerNameMap.put(u.id,u.manager.name);
                        }
                    }
                    
                    // Assigning Quote and Contact Details to respected Feedback record
                    for(Feedback__c fb : feedbackList2)
                    {
                        fb.Contact_name__c = mapOfQuote.get(fb.Opportunity_Id__c)?.Contact.Name;//mapOfContact.get(fb.AccountId__c)?.Name;
                        fb.Contact_Email__c = mapOfQuote.get(fb.Opportunity_Id__c)?.Contact.Email;//mapOfContact.get(fb.AccountId__c)?.Email;
                        fb.Contact_Mobile_Number__c = mapOfQuote.get(fb.Opportunity_Id__c)?.Contact.MobilePhone;//mapOfContact.get(fb.AccountId__c)?.MobilePhone;
                        fb.Quote_number__c = mapOfQuote.get(fb.Opportunity_Id__c)?.QuoteNumber;
                        fb.Insti_order_number__c = mapOfQuote.get(fb.Opportunity_Id__c)?.INSTI_Order_Reference__c;
                    }
                    
                    // senf Feed back request to Litmus System 
                    List<LitmusApiOnRegion__c> apiRegionList = [SELECT Id,Name,Region__c FROM LitmusApiOnRegion__c];
                    User headCorpUser = [SELECT Id,Name FROM User where Profile.Name ='Head corp profile' LIMIT 1];
                    System.debug('headCorpUser' + headCorpUser.Name);
                    Map<String,String> apiRegionMap = new Map<String,String>();
                    for(LitmusApiOnRegion__c apiRegion : apiRegionList )
                    {
                        apiRegionMap.put( apiRegion.Region__c , apiRegion.Name);
                    }
                    
                    feedBackWrap fbWrap = new feedBackWrap();
                    
                    fbWrap.app_id = oppRegionMap.Containskey( feedbackList2[0].Opportunity_Id__c ) ? apiRegionMap.get( oppRegionMap.get( feedbackList2[0].Opportunity_Id__c )?.Region_Picklist__c ) : 'bm9d_east'; // 'yp0q_test'; 
                    //fbWrap.app_id=label.LitmusIntegrationAppId;
                    fbWrap.user_phone = feedbackList2[0].Contact_Mobile_Number__c ;
                    fbWrap.user_email = feedbackList2[0].Contact_Email__c ;
                    fbWrap.name = feedbackList2[0].Contact_name__c ;
                    fbWrap.tag_company_name = mapOfQuote.get(feedbackList2[0].Opportunity_Id__c)?.Account.Name;//mapOfContact.get(feedbackList2[0].AccountId__c)?.Account.Name;
                    fbWrap.tag_custodian = headCorpUser.Name ;
                    fbWrap.tag_region = oppRegionMap.get( feedbackList2[0].Opportunity_Id__c )?.Region_Picklist__c ;
                    fbWrap.tag_stagename = 'Order Closed' ;
                    fbWrap.tag_status_of_lead = 'Order Closed' ;
                    fbWrap.tag_opportunity_id = feedbackList2[0].Opportunity_Id__c ;
                    //New addition
                    fbWrap.tag_city=mapOfQuote.get(feedbackList2[0].Opportunity_Id__c)?.Account.BillingCity;
                    fbWrap.tag_rbm=ownerManagerNameMap.get(oppidOwnerIdMap.get(feedbackList2[0].Opportunity_Id__c));
                    fbWrap.tag_transaction_date=oppRegionMap.get( feedbackList2[0].Opportunity_Id__c )?.Gift_Card_Transaction_Date__c;
                    
                    System.debug('city :'+fbWrap.tag_city+'tag_transaction_date '+fbWrap.tag_transaction_date);
                    String requestBody = JSON.serialize( fbWrap) ;
                    
                    //Json Data
                    List<String> jsoncheck=requestBody.split(',');
                    for(String s:jsoncheck)
                    {
                        System.debug(s);
                    }
                    
                    Http http = new Http();
                    
                    System.debug('requestBody ==> ' + requestBody );
                    HttpRequest request = new HttpRequest();
                    request.setMethod('POST');
                    request.setEndpoint(System.label.LitmusIntegrationEndPoint);
                    request.setHeader('Content-Type','application/json');
                    request.setBody(requestBody);
                    
                    HttpResponse response = http.send(request);
                    if(response.getStatusCode() == 200)
                    {
                        System.debug('FeedBack is Submitted Successfully');
                        System.debug('Status : ' + response.getStatusCode());
                        System.debug('message : ' + response.getBody());
                        
                        /*Opportunity newOp=new Opportunity();
                        newOp.Integration_done__c=true;
                        newOp.Id=feedbackList2[0].Opportunity_Id__c;
                        Update newOp;*/
                    }
                    else{
                        System.debug('FeedBack is Not Submited');
                        System.debug('Status : ' + response.getStatusCode());
                        System.debug('message : ' + response.getBody());
                    }
                   
                    Insert feedbackList2[0];
                }
            }               
        }
        catch(Exception e)
        {
            System.debug('Error==> '+e.getMessage());
            System.debug('ERROR Line==> '+e.getLineNumber());
        }
    }
    
    // wrapper class is used to prepare request body to send to litmus system
    public Class feedBackWrap
    {
        public String app_id;
        public String user_phone;// used to assign contact phone number
        public String user_email;// used to assign contact Email Id
        public String name; // used to assign contact Name
        public String tag_company_name; // used to assign contact's Account Name
        public String tag_custodian; // used to assign name of Head corp profile user
        public String tag_region; // used to assign Opportunity Region
        public String tag_status_of_lead; // used to assign Opportunity Satage
        public String tag_stagename; // used to assign Opportunity Satage
        public String tag_opportunity_id; // used to assign Opportunity Id
        public Date tag_transaction_date;
        public String tag_rbm;
        public String tag_city;
    }
}