/******************************************************************************************
* Created By : Anindwita Raj
* Created on : 12/5/2020
* Description: This class is to extract and export all the related Opportunities along with Quote and its Quote Line Items of an Account.
* Test Class: accountOpportunityExportTest
* **********************************************************************************************/
public class accountOpportunityExportClass {
    public Id accId {get;set;}
    public Map<id,String> holdRecordType{get;set;}
    public set<String> forOppStages{get;set;}
    public List<wrapperOpp> wrapOppList {get;set;}
    public List<wrapperQuote> wrapQuoteList;
    
    
    public accountOpportunityExportClass(ApexPages.StandardController controller){
        holdRecordType=new Map<id,String>();
        forOppStages=new set<String>();
        wrapOppList = new List<wrapperOpp>();
        accOppDetails();
    }
    
    public void accOppDetails(){
        accId = ApexPages.currentPage().getParameters().get('id');
        list<Quote> quoteList = new List<Quote>();
        Set<Id> quoteId = new Set<Id>();
        
        //holding record types for checking the names.
        for(RecordType R:[select id,name from RecordType where sobjecttype='Opportunity' AND 
                          (RecordType.developerName='MBA_Services_Allocated' or RecordType.developerName='MBA_Services_Final' 
                           OR RecordType.developerName='MBA_Spares_Final' or RecordType.developerName='PECSA' 
                           OR RecordType.developername='Regret_MBA_Record_Type' or RecordType.developername='Spares_Services_Record_Type' 
                           OR RecordType.developername ='Jewellery' OR RecordType.developername ='Watches')])    
        {
            holdRecordType.put(R.id,R.name);
        }
        //checking on other set of record types
        forOppStages.add('Await Customer Feedback(Quote Submitted)');
        forOppStages.add('Revised Quote Submission');
        forOppStages.add('Under Negotiation');
        forOppStages.add('Await Feedback (Under Negotiation)');
        forOppStages.add('Order Won');  
        forOppStages.add('Project Under Execution');
        forOppStages.add('Project Closed');
        forOppStages.add('Opportunity On Hold');
        forOppStages.add('Opportunity Lost');
        forOppStages.add('Project Cancelled');
        forOppStages.add('Project On Hold'); 
        
        List<Opportunity> oppList = [SELECT Id,Quote_Type__c,Project_Type__c,Name,Amount,
                                     StageName,Record_Type_Name__c,Account.Name,Member1__r.Name,Member2__r.Name, (SELECT Id,Name, CreatedDate FROM Quotes Order By CreatedDate DESC LIMIT 1) FROM Opportunity 
                                     WHERE AccountId = :accId AND stagename IN :forOppStages and RecordTypeId NOT IN :holdRecordType.keySet()];
        
        system.debug('--------oppList-----------'+oppList.size());
        
        
        for(Opportunity opp : oppList){
            wrapQuoteList = new List<wrapperQuote>();
            wrapperOpp wrap = new wrapperOpp();
            wrap.accountName = opp.Account.Name;
            wrap.oppName = opp.Name;
            wrap.quoteType = opp.Quote_Type__c;
            wrap.projectType = opp.Project_Type__c;
            wrap.stageName = opp.StageName;
            wrap.amount = opp.Amount;
            wrap.mechanical = opp.Member1__r.Name;
            wrap.electrical = opp.Member2__r.Name;
            for(Quote q : opp.Quotes){
                wrapperQuote wrapp = new wrapperQuote();
                wrapp.quoteDate = Date.valueOf(q.CreatedDate);
                wrapQuoteList.add(wrapp);
            }
            wrap.wrapQList = wrapQuoteList;
            wrapOppList.add(wrap);
            
            
        }
        
    }
    
    public class wrapperOpp{
        public String accountName {get;set;}
        public String oppName {get;set;}
        public String quoteType {get;set;}
        public String projectType {get;set;}
        public String stageName {get;set;}
        public Decimal amount {get;set;}
        public String mechanical{get;set;}
        public String electrical {get;set;}
        public List<wrapperQuote> wrapQList {get;set;}
        
        
    }
    public class wrapperQuote{
        public Date quoteDate {get;set;}
        
    }
    
    
}