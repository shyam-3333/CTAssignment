global class Titan_SendMailForOrdenWonOpp implements Database.Batchable<sObject>{
    
      String query;
    global Database.querylocator start(Database.BatchableContext BC){ 
        string strMba = 'MBA';
        query='Select o.Titan_OrderWonDate__c,o.RecordType.Name, o.Opportunity_Tracking_ID__c,o.Opportunity_ID__c ,o.Name,o.id,o.StageName From Opportunity o ';
         return Database.getQueryLocator(query); 
    }
    
     global void execute(Database.BatchableContext BC, List<Opportunity> scope){
        Date dateValueThree = system.today().adddays(-3);
        list<string>lstStrEmail = new list<string>();
        Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
        for(Opportunity obj :scope){
            system.debug('dateValueThree'+dateValueThree);
             system.debug('dateValueThree'+obj.RecordType.Name);
            system.debug('Order_Won_Date__c'+obj.Titan_OrderWonDate__c);
            system.debug('obj.Titan_OrderWonDate__c <= dateValueThree'+(obj.Titan_OrderWonDate__c <= dateValueThree));
            //list<string>lstStrEmail = new list<string>();
            if(obj.Titan_OrderWonDate__c <= dateValueThree && obj.StageName =='Order won' && (obj.RecordType.name == 'MBA'|| obj.RecordType.name =='Spares & Services Record Type'|| obj.RecordType.name =='Initial Record type'||obj.RecordType.name =='Allocated Record Type'||obj.RecordType.name =='Await Feedback Record Type'||obj.RecordType.name =='Layout Record Type'||obj.RecordType.name =='MBA Services Allocated'||obj.RecordType.name =='MBA Services Final'||obj.RecordType.name =='MBA Spares Final'||obj.RecordType.name =='Quote Submitted Record Type'||obj.RecordType.name =='Quote Submitted Services'||obj.RecordType.name =='Quote Submitted Spares'||obj.RecordType.name =='Regret MBA Record Type')){
                String  strUserEmail ='mohammad.naved@kvpcorp.com';
                String strOpportunityName = obj.name;
                String strOpportunityTrackId =obj.Opportunity_ID__c ; 
                //Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
                email1.setToAddresses(new String[] {'harie@titan.co.in'});
                //email1.setSubject('Opportunity Need to change');
                //email1.setPlainTextBody('Opportunity name ='+strOpportunityName+'\n\n'+'Opportunity Tracking no ='+strOpportunityTrackId);
                //List<Messaging.SendEmailResult> results1 = 
                //Messaging.sendEmail(new Messaging.Email[] { email1 });
                lstStrEmail.add('Opportunity name ='+strOpportunityName+'\n\n'+'Opportunity Tracking no ='+strOpportunityTrackId);
            
            
            }
        }
        string strEmail;
        for(string str :lstStrEmail){
            if(strEmail == null){
                strEmail =str;
            
            }
            else{
            strEmail  +='\n\n'+str;
            
            }
        
        }
        string strMessage ='Dear All'+'\n\n'+'Following are the opportunity which are in "Order Won" stage for more than 3 days,'+'\n'+strEmail+'\n'+'Request you to kindly follow up Product Approval,Order Accepted,Kick-off-Requirement for above mention opportunities and ensure that the opportunities are closed on time'+'\n\n\n'+'Thanks & Regards'+'\n\n'+'Salesforce Admin';
        email1.setSubject('Opportunity Need to change');
        email1.setPlainTextBody(strMessage );
                
        List<Messaging.SendEmailResult> results1 =          
         Messaging.sendEmail(new Messaging.Email[] { email1 });
     }
     global void finish(Database.BatchableContext info){     
     }
    
}