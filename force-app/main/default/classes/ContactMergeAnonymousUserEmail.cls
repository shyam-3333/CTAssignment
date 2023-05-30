/********************************************************
Created by: Vinoth Kumar A
Created on: 16/04/2019
Description: This class is created for survey force application to merge the anonymous user email with the respective contacts created
*******************************************************/
global class ContactMergeAnonymousUserEmail {
    webservice static void ContactMerge(){
        map<string,id> EmailContId = new map<string,id>();
        List<string> AnonymousEmail = new List<string>();
        for(SurveyTaker__c st : [SELECT Id, Email__c, Contact__c FROM SurveyTaker__c WHERE Contact__c = NULL]){
            AnonymousEmail.add(st.Email__c);
        }
        system.debug('AnonymousEmail:++++'+AnonymousEmail);
        for(contact con : [	SELECT Id, Email FROM Contact WHERE Email in : AnonymousEmail]){
            EmailContId.put(con.Email, con.Id);
        }
        system.debug('EmailContId:========='+EmailContId);
       List<SurveyTaker__c> stObj = new List<SurveyTaker__c>();
        for(SurveyTaker__c st : [SELECT Id, Email__c, Contact__c FROM SurveyTaker__c WHERE Contact__c = NULL]){
            st.Contact__c = EmailContId.get(st.Email__c);
            stObj.add(st);
        }
        system.debug('stObj:----------'+stObj);
        if(!stObj.isempty()){
            Update stObj;
        }
        
    }
}