/**************************************************************************************************************
* Created by: Vinoth kumar A
* Crated on : 04/10/2019
* Description: This trigger helper sends an email alert to the Opportunity/visit owner when the survey is taken by the customer.
**************************************************************************************************************/
public class SurveyTakenEmailAlertHelper {
    public static void SurveyTakenEmailAlert(List<SurveyTaker__c> SurveyTakenList){
        List<string> OppOwnerEmailList = new List<string>();
        List<string> visitOwnerEmailList = new List<string>();
        For(SurveyTaker__c st :SurveyTakenList){
            //Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, st.OppId__c+ ' --->outside '+st.VisitId__c));
            
            if(st.VisitId__c != null && st.VisitId__c != 'null'){
                Visit__c visit = [SELECT Id, name, owner.email, owner.name, Account__r.Name, Account__c FROM Visit__c WHERE Id=:st.VisitId__c limit 1];
                String ContactName = [SELECT Id, name FROM Contact WHERE AccountId =: visit.Account__c AND email =: st.Email__c limit 1].Name;
                String SurveyName = [SELECT Id, name FROM Survey__c WHERE Id =:st.Survey__c ].Name;
                visitOwnerEmailList.add(visit.owner.email);
                visitOwnerEmailList.addAll(Label.Email_address.split(','));
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(visitOwnerEmailList);
                mail.setSubject('Email Alert:Survey taken by '+ContactName+' For a visit '+visit.name);
                mail.setPlainTextBody('Hi '+visit.owner.name+',\n The survey "'+SurveyName+'" for a visit "'+visit.Name+'" with the account '+visit.Account__r.Name+' is taken by '+ContactName);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            } else if(st.OppId__c != null && st.OppId__c != 'null'){
                Opportunity Opp = [SELECT Id, name, owner.email, owner.name, Account.Name, AccountId FROM Opportunity WHERE Id=:st.OppId__c limit 1];
                String ContactName = [SELECT Id, name FROM Contact WHERE AccountId =: Opp.AccountId AND email =: st.Email__c limit 1].Name;
                String SurveyName = [SELECT Id, name FROM Survey__c WHERE Id =:st.Survey__c ].Name;
                OppOwnerEmailList.add(Opp.owner.email);
                OppOwnerEmailList.addAll(Label.Email_address.split(','));
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(OppOwnerEmailList);
                mail.setSubject('Email Alert:Survey taken by '+ContactName+' For an opportunity '+Opp.name);
                mail.setPlainTextBody('Hi '+Opp.owner.name+',\n The survey "'+SurveyName+'" for an opportunity "'+Opp.Name+'" with the account '+Opp.Account.Name+' is taken by '+ContactName);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            } 
        }
    }
    
    public static void SurveyTakenTrackInSurveySent(List<SurveyTaker__c> SurveyTakenList){
        List<Survey_Sent__c> ssList = new List<Survey_Sent__c>();
        Id AccId = null;
        for(SurveyTaker__c st : SurveyTakenList ){
            if(st.Email__c!=null && st.Survey__c != null && (st.OppId__c != null || st.VisitId__c!= null || st.Contact__c != null)){
                if(st.Contact__c != null && st.OppId__c == 'null' && st.VisitId__c == 'null'){
                   AccId = [SELECT Id, AccountId FROM Contact WHERE Id =:st.Contact__c ].AccountId;
                }
                for(Survey_Sent__c ss : [SELECT Id,Survey_Taken__c FROM Survey_Sent__c WHERE Email__c=:st.Email__c AND Surveys__c=:st.Survey__c AND (Opportunity__c=:st.OppId__c OR Visit__c =:st.VisitId__c OR Account__c =: AccId)]){
                    ss.Survey_Taken__c = st.id;
                    ssList.add(ss);
                }  
            }
        }
        if(!ssList.isempty()){
            update ssList;
        }
    }
}