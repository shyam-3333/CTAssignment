/*
* Class Name   : OpportunityToFeedback
* Created By   : Madhushree H J
* Created Date : 09-08-2022
* Description  :this class is used to create a feedback records with primary contact details and used to send mail to primary contact mail Id.
*/
public without sharing class OpportunityToFeedback 
{
     
    List<Customer_Feedback__c> feedbackList=new List<Customer_Feedback__c>();
    
    Set<Id> contactId=new Set<Id>();
    Set<String> emailId=new Set<String>();
    Set<Id> accId=new Set<Id>();
    Map<id,Contact> relatedContact=new Map<id,Contact>();
    Map<id,String> recordTypeIdMap=new Map<Id,String>();
    Map<Id,String> accNameId=new Map<Id,String>();
    Map<Id,String> oppNameId=new Map<Id,String>();
    Map<Id,Id> oppId=new Map<Id,Id>();
    Map<Id,Id> oppAccId=new Map<Id,Id>();
    public Id recIdWon;
    public Id recIdLost;
    Map<Id, opportunity> opptyMap = new Map<Id, opportunity>();
    /*
      * @description demo() this method is used to create and send mail to primary contact when ever  feedback is created.
      * @return void
      */
    public  void demo(List<Opportunity> oppList,Map<Id,Opportunity> oldMap)
    {
       
        for(Opportunity opp:oppList)
        {    //checking wheather the stage name is closed won /closed lost and primary contact is not equal to null
            //oldMap.get(opp.Id).StageName!=opp.StageName &&
            if(oldMap.get(opp.Id).StageName!=opp.StageName && opp.Record_Type_Name__c=='MBA'  && (opp.StageName=='Project Closed'||opp.StageName=='Project Under Execution'||opp.StageName=='Opportunity Lost'||opp.StageName=='Project Cancelled'))
            {  
               
                oppNameId.put(opp.Id,opp.Name);
                if(opp.StageName=='Project Closed'||opp.StageName=='Project Under Execution')
                {
                    recordTypeIdMap.put(opp.id,'won');
                }
                else if(opp.StageName=='Opportunity Lost'||opp.StageName=='Project Cancelled')
                {
                    recordTypeIdMap.put(opp.id,'lost');
                }
                
                if(opp.AccountId!=null)
                {
                    accId.add(opp.AccountId);
                    oppAccId.put(opp.id,opp.AccountId);
                }
                if(opp.Customer_Primary_Contact__c!=null)
                {
                    //adding the related contact id to set
                    contactId.add(opp.Customer_Primary_Contact__c);
                    oppId.put(opp.Customer_Primary_Contact__c, opp.Id);  //OppNameId
                    
                }
                if(opp.Technical_Influencer__c!=null)
                {
                    contactId.add(opp.Technical_Influencer__c);
                    oppId.put(opp.Technical_Influencer__c, opp.Id);
                }
                if(opp.Technical_Decision_Maker__c!=null)
                {
                    contactId.add(opp.Technical_Decision_Maker__c);
                    oppId.put(opp.Technical_Decision_Maker__c, opp.Id);
                }
                if(opp.Commercial_Influencer__c!=null)
                {
                    contactId.add(opp.Commercial_Influencer__c);
                    oppId.put(opp.Commercial_Influencer__c, opp.Id);
                }
                if(opp.Commercial_Decision_Maker__c!=null)
                {
                    contactId.add(opp.Commercial_Decision_Maker__c);
                    oppId.put(opp.Commercial_Decision_Maker__c, opp.Id);
                }
                opptyMap.put(opp.Id, opp);
            }
        }
        List<Account> acc=[Select Id,Name From Account Where Id in:accId ];
        for(Account a:acc)
        {
            accNameId.put(a.Id,a.Name);
        }
        RecordType rtWon = [SELECT Id,Name FROM RecordType WHERE Name = 'Closed Won Feedback' ];
        recIdWon=rtWon.Id;
        RecordType rt = [SELECT Id,Name FROM RecordType WHERE Name = 'Closed Lost Feedback' ];
        recIdLost=rt.Id;
        
        for(Contact c:[Select Id,Name,AccountId,MobilePhone,Email,Designation__c From Contact Where id In : contactId ])
        {
            if(!emailId.contains(c.Email))
            {
                emailId.add(c.Email);
                
                Customer_Feedback__c feedback=new Customer_Feedback__c();
                if(oppId.containsKey(c.Id) )
                {
                    
                    feedback.Opportunity__c=oppId.get(c.Id);
                    feedback.Opportunity_Owner_Email__c=opptyMap.containsKey(oppId.get(c.Id)) ? opptyMap.get(oppId.get(c.Id)).Opportunity_Owner_Email__c : '';
                }
                if(recordTypeIdMap.containsKey(oppId.get(c.Id))&&recordTypeIdMap.get(oppId.get(c.Id))=='won')
                {
                    feedback.RecordTypeId=recIdWon;
                    feedback.Feedback_Types__c='Closed Won Feedback';
                }
                else if(recordTypeIdMap.containsKey(oppId.get(c.Id))&&recordTypeIdMap.get(oppId.get(c.Id))=='lost')
                {
                    feedback.RecordTypeId=recIdLost;
                    feedback.Feedback_Types__c='Closed Lost Feedback';
                }
                
                
                
                
                feedback.Name=c.Name;
                feedback.Contact_Name__c=c.Id;
                feedback.Email__c=c.Email;
                feedback.Phone__c=c.MobilePhone;
                feedback.FeedBack_Sent_Date__c=System.now();
                //  feedback.Opportunity_Owner_Email__c=opptyMap.get(oppAccId.get(oppId.get(c.Id))).Opportunity_Owner_Email__c;
                feedback.Feedback_Status__c='Sent';
                feedback.Organization__c=accNameId.get(oppAccId.get(oppId.get(c.Id)));
                feedback.Designation__c=c.Designation__c;
                feedback.Project_Name__c=oppNameId.get(oppId.get(c.Id));
                feedbackList.add(feedback);
            }
        }
        
        
        
        
        //Checking the closed won  empty or not if not inserting the feedback records.
        try
      {
            if(feedbackList.size()>0)
            {
                insert feedbackList;
            }
      }
        catch(System.DmlException e)
        {
            
      }
        
        
        
    }
     /*
      * @description updateOpportunity() this method is used for update functionality.when ever user selects a new contact  we creating a customer feedback for that particular contact.
      * @return void
      */
    
    public  void updateOpportunity(List<Opportunity> oppList,Map<Id,Opportunity> oldMap)
    {
        
        for(Opportunity opp:oppList)
        {    //checking wheather the stage name is closed won /closed lost and primary contact is not equal to null
            //oldMap.get(opp.Id).StageName!=opp.StageName &&
            if(opp.Record_Type_Name__c=='MBA' && (opp.StageName=='Project Closed'||opp.StageName=='Project Under Execution'||opp.StageName=='Opportunity Lost'||opp.StageName=='Project Cancelled'))
            {  
                
                oppNameId.put(opp.Id,opp.Name);
                if(opp.StageName=='Project Closed'||opp.StageName=='Project Under Execution')
                {
                    recordTypeIdMap.put(opp.id,'won');
                }
                else if(opp.StageName=='Opportunity Lost'||opp.StageName=='Project Cancelled')
                {
                    recordTypeIdMap.put(opp.id,'lost');
                }
                
                if(opp.AccountId!=null)
                {
                    accId.add(opp.AccountId);
                    oppAccId.put(opp.id,opp.AccountId);
                }
                if(oldMap.get(opp.Id).Customer_Primary_Contact__c!=opp.Customer_Primary_Contact__c)
                {
                    contactId.add(opp.Customer_Primary_Contact__c);
                    oppId.put(opp.Customer_Primary_Contact__c, opp.Id);
                }
                
                if(oldMap.get(opp.Id).Technical_Influencer__c!=opp.Technical_Influencer__c)
                {
                    contactId.add(opp.Technical_Influencer__c);
                    oppId.put(opp.Technical_Influencer__c, opp.Id);
                }
                if(oldMap.get(opp.Id).Technical_Decision_Maker__c!=opp.Technical_Decision_Maker__c)
                {
                    contactId.add(opp.Technical_Decision_Maker__c);
                    oppId.put(opp.Technical_Decision_Maker__c, opp.Id);
                }
                if(oldMap.get(opp.Id).Commercial_Influencer__c!=opp.Commercial_Influencer__c)
                {
                    contactId.add(opp.Commercial_Influencer__c);
                    oppId.put(opp.Commercial_Influencer__c, opp.Id);
                }
                if(oldMap.get(opp.Id).Commercial_Decision_Maker__c!=opp.Commercial_Decision_Maker__c)
                {
                    contactId.add(opp.Commercial_Decision_Maker__c);
                    oppId.put(opp.Commercial_Decision_Maker__c, opp.Id);
                }
                opptyMap.put(opp.Id, opp);
            }
        }
        List<Account> acc=[Select Id,Name From Account Where Id in:accId];
        for(Account a:acc)
        {
            accNameId.put(a.Id,a.Name);
        }
        RecordType rtWon = [SELECT Id,Name FROM RecordType WHERE Name = 'Closed Won Feedback' ];
        recIdWon=rtWon.Id;
        RecordType rt = [SELECT Id,Name FROM RecordType WHERE Name = 'Closed Lost Feedback' ];
        recIdLost=rt.Id;
        
        for(Contact c:[Select Id,Name,AccountId,MobilePhone,Email,Designation__c From Contact Where id In : contactId ])
        {
            if(!emailId.contains(c.Email))
            {
                emailId.add(c.Email);
                
                Customer_Feedback__c feedback=new Customer_Feedback__c();
                if(oppId.containsKey(c.Id) )
                {
                   
                    feedback.Opportunity__c=oppId.get(c.Id);
                    feedback.Opportunity_Owner_Email__c=opptyMap.containsKey(oppId.get(c.Id)) ? opptyMap.get(oppId.get(c.Id)).Opportunity_Owner_Email__c : '';
                }
                if(recordTypeIdMap.containsKey(oppId.get(c.Id))&&recordTypeIdMap.get(oppId.get(c.Id))=='won')
                {
                    feedback.RecordTypeId=recIdWon;
                    feedback.Feedback_Types__c='Closed Won Feedback';
                }
                else if(recordTypeIdMap.containsKey(oppId.get(c.Id))&&recordTypeIdMap.get(oppId.get(c.Id))=='lost')
                {
                    feedback.RecordTypeId=recIdLost;
                    feedback.Feedback_Types__c='Closed Lost Feedback';
                }
                
                
                
                
                feedback.Name=c.Name;
                feedback.Contact_Name__c=c.Id;
                feedback.Email__c=c.Email;
                feedback.Phone__c=c.MobilePhone;
                feedback.FeedBack_Sent_Date__c=System.now();
                feedback.Feedback_Status__c='Sent';
                feedback.Organization__c=accNameId.get(oppAccId.get(oppId.get(c.Id)));
                feedback.Designation__c=c.Designation__c;
                feedback.Project_Name__c=oppNameId.get(oppId.get(c.Id));
                System.debug('Feedback'+feedback);
                feedbackList.add(feedback);
            }
        }
        
        //Checking the closed won  empty or not if not inserting the feedback records.
     try
      {
            if(feedbackList.size()>0)
            {
                insert feedbackList;
            }
        }
       catch(System.DmlException e)
        {
            
       }
        
        
        
    }
}