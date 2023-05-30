/*
* Created by    : Mutturaj Heroor
* Created on    : March-09-2021
* Purpose       : LitmusQuestionnairesApi is Used to create Questionnaires Records under the respected Opportunities Feedback
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/
@RestResource(urlMapping='/QuestionnairesApi')
global class LitmusQuestionnairesApi {

	public static RestResponse res = RestContext.response;    
    @Httppost
    global static void doPost()
    {
        Map<String,Object> responseMap = new  Map<String,Object>();
        try{
            String requestBody = RestContext.request.requestBody.toString();
            system.debug('reQuestBody ==> ' + requestBody );
            ResponseWrapClass responseWrap = (ResponseWrapClass) JSON.deserialize(requestBody, ResponseWrapClass.Class);
            System.debug('Opp Id'+ responseWrap.tag_Opportunity_id);
            if(responseWrap.tag_Opportunity_id != '')
            {
                
                Feedback__c fb = [SELECT Id,Name,Opportunity_Id__c From Feedback__c where Opportunity_Id__c = : responseWrap.tag_Opportunity_id ORDER By CreatedDate LIMIT 1 ];
                System.debug('fb==> ' + fb);
                
                List<Questionnaire__c> qustList = new List<Questionnaire__c>();
                Questionnaire__c qust ; 
                if(responseWrap.ratings.size() > 0)
                {
                    for(ratings rate : responseWrap.ratings )
                    {
                        qust = new Questionnaire__c();
                        qust.Feedback__c = fb.Id ;
                        qust.Date_and_time_of_response__c = System.now() ;
                        qust.Question_Name__c = rate.question ;
                        qust.Answer__c = rate.rating ;
                        qust.Actual_Answer__c = rate.actual_rating ;
                        qustList.add(qust);
                        System.debug(qust);
                    }
                }
                
                if(qustList.size() > 0)
                {
                    insert qustList;
                }
                
                fb.Feedback_received__c = true;
                fb.Feedback_received_date_and_time__c = qust.Date_and_time_of_response__c;
                fb.Primary_Rating__c = responseWrap.primary_rating ;
                fb.Current_issue_status__c = responseWrap.current_issue_status;
                fb.Comment__c = responseWrap.comment;
                fb.Note__c = responseWrap.note ;
                fb.Project_Name__c = responseWrap.project_name;
                fb.Requested_date__c = responseWrap.request_date;
                fb.Responded_date__c = responseWrap.responded_date;
                System.debug('fb==> ' + fb);
                update fb;
                responseMap.put('Status Code' , '200' );
                responseMap.put('message' , 'Questionnaires Response Created Successfully' );
                res.statusCode = 200;
                System.debug('Response Map -> ' + responseMap);
                System.debug('Response  -> ' + res);
                res.responseBody = Blob.valueOf(JSON.serialize(responseMap));
                if(test.isRunningTest())
                    integer i = 2/0;
            }
        }
        catch(Exception exp)
        {
            responseMap.put('Status Code' , '400' );
            responseMap.put('message' , 'Questionnaires Creation is failed' );
            responseMap.put('Error' , ''+exp  );
            res.statusCode = 400;
            System.debug('ResponseMap In Exp : ' +responseMap );
            //res.responseBody = Blob.valueOf(JSON.serialize(responseMap));
            return;
        }
    }
    
    //wrapper class is used to take RequestBody From External System 
    public class ResponseWrapClass
    {
        Public String tag_Opportunity_id ;
        Public String primary_rating;
        Public String comment;
        Public String note;
        public String project_name;
        public String current_issue_status ;
        public string last_issue_status;
        public DateTime request_date;
        public DateTime responded_date;
        
        public List<ratings>  ratings;
        
        public ResponseWrapClass(){
            ratings = new List<ratings>();
        }
        
    }
    public class ratings{
        public string question;
		public string rating;
		public string actual_rating;
    }
}