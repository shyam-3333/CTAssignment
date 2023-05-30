/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 30/05/2019
* Description: Trigger helper to send an email reminder to the opportunity owner to send survey to the respective user.
*******************************************************************************/
public class OppStgWonLostSurvy_CreatRvsnHistry_Helpr {
    //OpportunityStageWonOrLostSurvey_CreateRevisionHistory_Helper
    public static void OpportunitySurvey(List<Opportunity> Opps, Map<id,Opportunity> OldOpps){ 
        // Map<id,user> userMap = new Map<id,user>([SELECT Id, Email, Name FROM User]);
        Map<id,user> userMap = new Map<id,user>();
        for(user usr: [SELECT ID,ManagerID,Email,Name FROM User]){
            userMap.put(usr.Id,usr);
        }
            string str = label.OppStgWonLostSurvy_CreatRvsnHistry_Helpr;
            system.debug('string:'+str);
            if(str == 'True'){
                for(Opportunity opp: Opps ){
                    string OppUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/' + Opp.Id;
                    string TealLogo =  '<html><body><img src="https://newdev-ped.cs91.force.com/servlet/servlet.ImageServer?id=0152F0000000xHw&oid=00D2F0000000UZi&lastMod=1555913835000" /><br/></body></html>';
                    if(Opp.StageName == 'Order Won' && Opp.SurveyReminderEmailSentDate__c == null){
                        List<string> emailIterationList = new List<string>();
                        system.debug('userMap.get(opp.Member1__c).Email :'+userMap.get(opp.Member1__c).Email );
                        if(userMap.get(opp.Member1__c).Email != null){
                            emailIterationList.add(userMap.get(opp.Member1__c).Email);
                            // customer label email address is Email addresses to test
                            emailIterationList.addAll(Label.Email_address.split(','));
                            system.debug('emailIterationList:'+emailIterationList);
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                            mail.setToAddresses(emailIterationList);
                            mail.setSubject(Opp.Name+'-Voice of customer: Project Won');
                            mail.setHtmlBody('Hi '+ userMap.get(opp.Member1__c).Name+',<br/>'+ 'Congratulation for winning the project.<br/>'+ 'To know the customer feedback regarding the opportunity '+Opp.Name+', <br/>Kindly send the Voice of customer: Project Won survey to the customer.<br/>Please click the below link to go to the survey.<br/><br/>'+ 'https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017YD5M&sfdc.override=1&OppId='+Opp.Id+'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');               
                            mail.setUseSignature(false);
                            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                            system.debug('OwnerId+++++++++:'+Opp.OwnerId);
                        }
                        emailIterationList.clear();
                        Opp.SurveyReminderEmailSentDate__c = system.today();
                    }
                    if((Opp.StageName == 'Opportunity Lost' && Opp.SurveyReminderEmailSentDate__c == null) || (Opp.StageName == 'Opportunity Lost' && OldOpps.get(Opp.Id).StageName == 'Order Won')){
                        List<string> emailIterationList = new List<string>();
                        system.debug('userMap.get(opp.Member1__c).Email :'+userMap.get(opp.Member1__c).Email );
                        if(userMap.get(opp.Member1__c).Email != null){
                            emailIterationList.add(userMap.get(opp.Member1__c).Email);  
                            emailIterationList.addAll(Label.Email_address.split(','));
                            system.debug('emailIterationList:'+emailIterationList);
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                            mail.setToAddresses(emailIterationList);
                            mail.setSubject(Opp.Name+'- Voice of customer: Project Lost');
                            mail.setHtmlBody('Hi '+ userMap.get(opp.Member1__c).Name+',<br/>'+ 'To know the customer feedback regarding the opportunity '+Opp.Name+', Kindly send the Voice of customer: Project Lost survey to the customer.<br/>Please click the below link to go to the survey.<br/><br/>'+ 'https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017YD5R&sfdc.override=1&OppId='+Opp.Id+'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');               
                            mail.setUseSignature(false);
                            Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                            system.debug('OwnerId+++++++++:'+Opp.OwnerId);
                        }
                        emailIterationList.clear();
                        Opp.SurveyReminderEmailSentDate__c = system.today();
                    }
                    
                }
            }
            /**********************************************************************************/ 
            
        
        if(TriggerStatus__c.getInstance('OpportunityTrigger') != NULL && TriggerStatus__c.getInstance('OpportunityTrigger').Active__c){
            Map<String,Schema.RecordTypeinfo> rec = Opportunity.SobjectType.getDescribe().getRecordTypeInfosByName();
            Map<String,Schema.RecordTypeinfo> rectype = Cost_Tracking__c.SobjectType.getDescribe().getRecordTypeInfosByName();
            List<Revision_History__c> insert_rh = new List<Revision_History__c>();
            List<Revision_History__c> update_rh = new List<Revision_History__c>();
            List<Revision_History__c> updaterh = new List<Revision_History__c>();
            List<Opportunity> curropp = new List<Opportunity>();
            List<Cost_Tracking__c> ctupdate = new List<Cost_Tracking__c>();
            Set<ID> oppid = new Set<ID>();
            Set<ID> ownerID1= new Set<ID>();
            Map<Id,ID> user_owner = new Map<ID,ID>();
            Map<String,Decimal> curr_conv = new Map<String,Decimal>();
            
            boolean tempstr = checkRecursive.runOnce();
            system.debug('*******'+tempstr);
            //checking Recursion written by Mohit Dwivedi(KVP Business Solution) to control recursion on 12/2/2018.
            if(checkRecursive.runOnce() || Test.isrunningTest())
            {
                system.debug('***************************************************');
                if(Opps[0].Record_Type_Name__c != 'Jewellery' && Opps[0].Record_Type_Name__c != 'Lifestyle' && Opps[0].Record_Type_Name__c != 'Watches')
                {
                    List<CurrencyType> CurrencyList = new List<CurrencyType>(); //Rakesh 02-02/Feb
                    CurrencyList = [Select IsoCode,ConversionRate from CurrencyType where IsoCode !='INR' limit 99]; //Rakesh 02-02/Feb
                    for(CurrencyType ct :CurrencyList){
                        curr_conv.put(ct.IsoCode,ct.ConversionRate);
                    }   
                }
                for(Opportunity o : Opps){
                    
                    Opportunity oldopp = new Opportunity(ID = o.ID);
                    ownerID1.add(o.OwnerID);
                    if(oldopp.Total_Invoice_Value__c != o.Total_Invoice_Value__c && o.Total_Invoice_Value__c != null)
                        o.TurnOver__c = o.Total_Invoice_Value__c - o.VAT__c - o.CST__c;
                }
                List<User> UserList = new List<User>(); // Changed by madan (Because its giving error 101)
                // UserList = [select ID,ManagerID from User where ID IN: ownerID1];
                for(Id ids:ownerID1){
                    UserList.add(userMap.get(ids));
                }
                system.debug('query user List:'+[select ID,ManagerID from User where ID IN: ownerID1]);
                system.debug('Map user List:'+UserList);
                for(User u :UserList){
                    user_owner.put(u.ID,u.ManagerID);
                }
                for(Opportunity o : Opps){
                    if(o.Record_Type_Name__c != 'Jewellery' && o.Record_Type_Name__c != 'Lifestyle' && o.Record_Type_Name__c != 'Watches')
                    {    
                        Opportunity old = OldOpps.get(o.ID);
                        System.debug('--->'+user_owner.get(o.OwnerID));
                        System.debug('--->'+o.OwnerID);
                        System.debug('--->'+old.OwnerID);
                        System.debug('--->'+old.OwnerID+'..............'+o.RecordTypeID+'...........'+old.RecordTypeID);
                        
                        if((o.RecordTypeID == old.RecordTypeID && o.StageName != old.StageName) || (Test.IsRunningTest())){
                            System.debug('The values here 1 is:' +o.StageName+'..........................'+o.Business_Division_Used__c+'.......'+o.Type);
                            System.debug('The values here 2 is:' +old.StageName);
                            //if(o.StageName == 'Quotation(offline)' || o.StageName == 'Quote & Submission (Release 1)'){
                            //    o.Revision_Number__c = 1; 
                            //    o.Quote_Submitted_Date__c = System.Today();
                            //    Revision_History__c revhis = new Revision_History__c(); 
                            //    revhis.Name__c = 'Release 1.0';  
                            //    revhis.Opportunity__c = o.ID;
                            //    revhis.Start_Date__c = System.today();
                            //   insert_rh.add(revhis);
                            // }
                            if(o.StageName == 'Await Customer Feedback(Quote Submitted)' || o.StageName == 'Under Negotiation' || o.StageName == 'Under Customer Evaluation' || o.StageName == 'Under Customer Re- Evaluation'){
                                oppid.add(o.ID);
                                if(o.StageName == 'Await Customer Feedback(Quote Submitted)' || o.StageName == 'Under Negotiation'){
                                    Cost_Tracking__c ct = new Cost_Tracking__c();
                                    ct.Opportunity__c = o.ID;
                                    ct.Release_Version__c = 'Release ' + o.Revision_Number__c;
                                    if(o.Business_Division_Used__c == 'MBA' || (o.Business_Division_Used__c == 'MBA Services' && o.Type == 'Spares')){
                                        ct.Mechanical__c = o.Mechanical__c;
                                        ct.Electrical__c = o.Electrical__c;
                                        ct.Warranty__c = o.Warranty_Used__c;
                                        ct.OverHeads_Charges__c = o.OverHead_Charges__c;
                                        ct.Quote_Value__c = o.Quote_Value__c; 
                                        ct.Commissioning_Charges__c = o.Commissioning_Charges_Used__c;
                                        ct.Packing_Charges__c = o.Packing_Charges__c;
                                        // ct.Transport_Charges__c = o.Transport_Charges__c;
                                        ct.Final__c = true;
                                        ct.RecordTypeID = rectype.get('MBA and Spares').getRecordTypeId(); 
                                    }else if(o.Business_Division_Used__c == 'MBA Services' && o.Type != 'Spares'){
                                        ct.Number_of_Days__c = o.Number_of_Days__c;
                                        ct.Number_of_People__c = o.Number_of_People__c;
                                        ct.Per_Man_Day_Cost__c = o.Per_Man_Day_Cost__c;
                                        ct.Mockup_on_Cost__c = o.Mockup_on_Cost__c;
                                        ct.To_Fro_Charges__c = o.To_Fro_Charges__c;
                                        ct.Final__c = true;
                                        ct.RecordTypeID = rectype.get('MBA Service').getRecordTypeId(); 
                                    }
                                    ctupdate.add(ct);
                                }
                            }
                            if(o.StageName == 'Revised Quote Submission' || o.StageName == 'Re quote'){
                                o.Revision_Number__c = o.Revision_Number__c + 1; 
                                Revision_History__c revhis = new Revision_History__c(); 
                                revhis.Name__c = 'Release ' + o.Revision_Number__c;  
                                revhis.Opportunity__c = o.ID;
                                revhis.Start_Date__c = System.today();
                                insert_rh.add(revhis);
                                if(o.StageName == 'Revised Quote Submission'){
                                    o.Costing_Uploaded__c = false;
                                    o.Quote_Uploaded__c = false;
                                    o.Quote_Manager_Approved__c = false;
                                    o.Quote_Approved_Services__c = false;
                                    o.Quote_Approved_Spares__c = false;
                                    o.Quote_Submitted_Date__c = System.today();
                                    o.Mechanical__c = null;
                                    o.Electrical__c = null;
                                    o.Warranty_Used__c = null;
                                    o.OverHead_Charges__c = null;
                                    o.Quote_Value__c = null;
                                    o.Commissioning_Charges_Used__c = null;
                                    o.Packing_Charges__c = null;
                                    // o.Transport_Charges__c = null;
                                } 
                                if(o.StageName == 'Re quote'){
                                    o.Quotation_PECSA_Approved__c = false;
                                    o.Quote_Uploaded__c = false;
                                }
                            }
                        }
                        if((o.CurrencyIsoCode != old.CurrencyIsoCode || o.Amount != old.Amount) && (o.CurrencyIsoCode !='INR'))    
                            o.Converted_Amount__c = o.Amount / curr_conv.get(o.CurrencyIsoCode);
                        if(o.OwnerID != old.OwnerID)
                            o.Manager__c = user_owner.get(o.OwnerID); 
                        if(o.StageName == 'Request for Amendment')
                            o.Related_Document__c = 'Amended PO';      
                        if(o.recordTypeID == rec.get('Initial Record type').getRecordTypeId() && o.OwnerID != old.OwnerID){
                            //   o.Opportunity_Allocation_Status__c = 'Allocated'; //   ---- old
                            //   o.Opportunity_Allocation_Status__c = 'Not Allocated'; //  --- new 
                            if(o.Business_Division_Used__c == 'MBA Services'){
                                o.StageName = 'Under Study and Clarifications';     
                                o.RecordTypeID = rec.get('MBA Services Allocated').getRecordTypeId();
                            }
                        }
                        if(o.Quote_Value__c != old.Quote_Value__c || o.TotalServices__c != old.TotalServices__c)
                            if(o.Quote_Value__c != null)
                            o.Amount = o.Quote_Value__c;
                        else if(o.TotalServices__c != null)
                            o.Amount = o.TotalServices__c;
                    }}
                update_rh = [select ID,Name,EndDate__c,Opportunity__c from Revision_History__c where Opportunity__c IN: oppid AND EndDate__c = NULL];
                
                for(Revision_History__c rh : update_rh){
                    Revision_History__c rh1 = new Revision_History__c(ID = rh.ID);
                    if(rh.EndDate__c == null)
                        rh1.EndDate__c = System.today();
                    updaterh.add(rh1);
                }
                
                if(insert_rh.size() > 0)
                    Insert insert_rh;
                
                if(updaterh.size() > 0)
                    Update updaterh;
                
                if(ctupdate.size() > 0)
                    Insert ctupdate;
                
                insert_rh.clear();
                updaterh.clear();
                ctupdate.clear(); 
                
            } //end of checkRecursive().
        }
        
        
    }
}