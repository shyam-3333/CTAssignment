public class TitanMBA_WinlossReport {
    public List<selectoption> industryOption{get;set;}
    public List<selectoption> stagesOption{get;set;}
    public List<selectoption> dateOption{get;set;}
    public List<selectoption> FYOption{get;set;}
    public List<selectoption> ReasonOption{get;set;}  
    public List<selectoption> projectTypeOption{get;set;}
    public Date fromDate{get;set;}
    public Date toDate{get;set;}
    public string selectedIndustry{get;set;}
    public string selectedStageName{get;set;}
    public string selecteddateOption{get;set;}
    public string selectedFY{get;set;}
    public string selectedReason{get;set;}
    public string selectedPrjType{get;set;}
    Id AccountRecordTypeId;
    public Map<id,String> holdRecordType{get;set;}
    public set<String> forOppStages{Get;set;}
    public List<Quote> QuoteData{get;set;} 
    public List<quoteWrapper> wrapperList{get;set;}
    public List<oppWrapper> oppWrapperList{get;set;}
    public boolean dateFlag {get;set;} 
    List<String> lst;
    Set<Id> mechLeadId1 = new Set<Id>();
    Set<Id> elecLeadId1 = new Set<Id>();
    Set<Id> mechLeadId2 = new Set<Id>();
    Set<Id> elecLeadId2 = new Set<Id>();

    Map<Id,String> leadName = new Map<Id,String>();

    
    public TitanMBA_WinlossReport(){
        fromDate=null;
        toDate=null;
        selectedIndustry=null;
        selectedStageName= NULL;
        selecteddateOption= NULL;
        FYOption = NULL;
        selectedReason = Null;
        selectedPrjType = Null;
        dateFlag = false;
        AccountRecordTypeId=null;
        holdRecordType=new Map<id,String>();
        forOppStages=new set<String>();
        industryOption=new List<selectoption>();
        stagesOption = new List<selectoption>();
        dateOption = new List<selectoption>();
        FYOption = new List<selectoption>();
        ReasonOption = new List<selectoption>();
        projectTypeOption = new List<selectoption>();
        QuoteData=new List<Quote>();
        lst = new List<String>{'MBA','Consultant_MBA','Prospect_MBA','Suspect_MBA'};
        //holding Industry Data For Industry Filter
        industryOption.add(new selectoption('None','None'));
        industryOption.add(new selectoption('Automotive','Automotive'));
        industryOption.add(new selectoption('Non-Automotive','Non-Automotive'));
        industryOption.add(new selectoption('Both','Both'));
        
        //holding Stage Names of Opportunity pipeline
        stagesOption.add(new selectoption('All','All'));
        stagesOption.add(new selectoption('Preliminary Opportunity','Preliminary Opportunity'));
        stagesOption.add(new selectoption('Qualified-RFQ study','Qualified-RFQ study'));
        stagesOption.add(new selectoption('Concept Finalization','Concept Finalization'));
        stagesOption.add(new selectoption('Costing','Costing'));
        stagesOption.add(new selectoption('Quote Preparation','Quote Preparation'));
        stagesOption.add(new selectoption('Await Customer Feedback(Quote Submitted)','Await Customer Feedback(Quote Submitted)'));
        stagesOption.add(new selectoption('Revised Quote Submission','Revised Quote Submission'));
        stagesOption.add(new selectoption('Under Negotiation','Under Negotiation'));
        stagesOption.add(new selectoption('Await Feedback (Under Negotiation)','Await Feedback (Under Negotiation)'));
        stagesOption.add(new selectoption('Order Won','Order Won'));  
        stagesOption.add(new selectoption('Project Under Execution','Project Under Execution'));
        stagesOption.add(new selectoption('Project Closed','Project Closed'));
        stagesOption.add(new selectoption('Opportunity On Hold','Opportunity On Hold'));
        stagesOption.add(new selectoption('Opportunity Lost','Opportunity Lost'));
        stagesOption.add(new selectoption('Project Cancelled','Project Cancelled'));
        stagesOption.add(new selectoption('Project On Hold','Project On Hold'));
        
        dateOption.add(new selectoption('','--None--'));
        dateOption.add(new selectoption('Custom','Custom'));
        dateOption.add(new selectoption('Fiscal Year','Fiscal Year'));
        
        FYOption.add(new selectoption('','--None--'));
        FYOption.add(new selectoption('Current FY','Current FY'));
        FYOption.add(new selectoption('Previous FY','Previous FY'));
        
        ReasonOption.add(new selectoption('All','All'));
        ReasonOption.add(new selectoption('Lost on cost','Lost on cost'));
        ReasonOption.add(new selectoption('Lost on lead time','Lost on lead time'));
        ReasonOption.add(new selectoption('Lost on strategic reason','Lost on strategic reason'));
        ReasonOption.add(new selectoption('Project Shelved','Project Shelved'));
        ReasonOption.add(new selectoption('Lost on competency','Lost on competency'));
        
        projectTypeOption.add(new selectoption('All','All'));
        projectTypeOption.add(new selectoption('Domestic','Domestic'));
        projectTypeOption.add(new selectoption('Export','Export'));
        //holding data of record types
        AccountRecordTypeId=[select id,name from RecordType where sobjecttype='Account' and recordType.name='MBA'].id;
        
        //holding record types for checking the names.
        for(RecordType R:[select id,name from RecordType where sobjecttype='Opportunity' and (RecordType.developerName='MBA_Services_Allocated' or RecordType.developerName='MBA_Services_Final' or RecordType.developerName='MBA_Spares_Final' or RecordType.developerName='PECSA' or RecordType.developername='Regret_MBA_Record_Type' or RecordType.developername='Spares_Services_Record_Type')])    
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
        
    }
    
    public void runReportChart(){
        wrapperList = new List<quoteWrapper>();
        system.debug('-------selectedFY-------'+selectedFY);
        Integer year = (System.today()).year();
        Integer month = (System.today()).month();
        system.debug( 'Current Year--> ' + year);
        system.debug( 'Current Month--> ' + month);
        if( selectedFY == 'Current FY')
        {
            if(month >= 4)
            {
                fromdate = Date.newInstance(year, 4, 1);
                todate = Date.newInstance(year+1, 3, 31);
            }
            else{
                fromdate = Date.newInstance(year-1, 4, 1);
                todate = Date.newInstance(year, 3, 31);
            }
        }
        else if( selectedFY == 'Previous FY' )
        {
            year--;
            if(month >= 4)
            {
                fromdate = Date.newInstance(year, 4, 1);
                todate = Date.newInstance(year+1, 3, 31);
            }
            else{
                fromdate = Date.newInstance(year-1, 4, 1);
                todate = Date.newInstance(year, 3, 31);
            }
        }
        system.debug('-------selectedStageName-------'+selectedStageName);
        system.debug('--------fromdate----------'+fromdate);
        system.debug('-----------todate-------'+todate);
        system.debug('---------selectedIndustry---------'+selectedIndustry);
        system.debug('---------selectedPrjType---------'+selectedPrjType); 
        system.debug('---------selectedReason---------'+selectedReason); 
        if(selectedStageName == 'All')
        {
            if( selectedPrjType == 'All')
            {
                if( selectedReason == 'All')
                {
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name , Opportunity.StageName, Opportunity.Reason__c,Opportunity.Project_Type__c, Opportunity.Account.Industry ,Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c,  Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate   AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName  , Opportunity.Reason__c,  Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null ]):null;
                    }
                }
                else{
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Reason__c =: selectedReason ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Reason__c =: selectedReason ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Reason__c =: selectedReason ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Reason__c =: selectedReason]):null;
                    }
                }                
            }
            else{
                if( selectedReason == 'All')
                {
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Project_Type__c =:selectedPrjType ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =: selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Project_Type__c =:selectedPrjType]):null;
                    }
                }
                else{
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Reason__c =: selectedReason  And Opportunity.Project_Type__c =:selectedPrjType];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName  , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Reason__c =: selectedReason And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName, Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate   AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Reason__c =: selectedReason And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Reason__c =: selectedReason   And Opportunity.Project_Type__c =:selectedPrjType ]):null;
                    }
                }
            }
            
            
         }
        else
         {
            if( selectedPrjType == 'All')
            {
                if( selectedReason == 'All')
                {
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null ]):null;
                    }
                }
                else{
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Reason__c =: selectedReason ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate  AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Reason__c =: selectedReason ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Reason__c =: selectedReason ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry ,  Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Reason__c =: selectedReason]):null;
                    }
                }                
            }
            else{
                if( selectedReason == 'All')
                {
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Project_Type__c =:selectedPrjType ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null  And Opportunity.Project_Type__c =:selectedPrjType]):null;
                    }
                }
                else{
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Name,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry,  Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Reason__c =: selectedReason  And Opportunity.Project_Type__c =:selectedPrjType];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Reason__c =: selectedReason And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Reason__c =: selectedReason And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Reason__c =: selectedReason   And Opportunity.Project_Type__c =:selectedPrjType ]):null;
                    }
                }
            }
         }
    
        system.debug('------QuoteData--------'+QuoteData.size());
        for(Quote q : QuoteData){
            if(q.Opportunity.Member1__c != null){
                mechLeadId1.add(q.Opportunity.Member1__c);
            }
            if(q.Opportunity.Member2__c != null){
                elecLeadId1.add(q.Opportunity.Member2__c);
            }        
        }
        for(User u : [Select Id,Name from User where Id IN :mechLeadId1 OR Id IN :elecLeadId1]){
            leadName.put(u.Id,u.Name);
        }
        for(Quote q : QuoteData){
            quoteWrapper wrap = new quoteWrapper();
            wrap.oppName = q.Opportunity.Name;
            wrap.AccName = q.Opportunity.Account.Name;
            wrap.oppStageName = q.Opportunity.StageName;
            wrap.oppAccIndustry = q.Opportunity.Account.Industry;
            wrap.oppPrjType = q.Opportunity.Project_Type__c;
            wrap.oppLostReason = q.Opportunity.Reason__c;
            wrap.oppRecordTypeName = q.Opportunity.Record_Type_Name__c;
            wrap.oppAmount = q.Opportunity.Amount;
            wrap.createdDate = Date.valueOf(q.CreatedDate);
            wrap.mechanicalLead = leadName.containsKey(q.Opportunity.Member1__c) ? leadName.get(q.Opportunity.Member1__c)  : '';
            wrap.electricalLead = leadName.containsKey(q.Opportunity.Member2__c) ? leadName.get(q.Opportunity.Member2__c)  : '';

            wrapperList.add(wrap);
        }
        
        system.debug('-----------wrapperList----------'+wrapperList);
    }
    
    public class quoteWrapper {
        public String oppName{get;set;}
        public String AccName{get;set;}
        public String oppStageName{get;set;}
        public String oppAccIndustry{get;set;}
        public String oppPrjType{get;set;}
        public String oppLostReason{get;set;}
        public String oppRecordTypeName{get;set;}
        public Decimal oppAmount{get;set;}
        public Date createdDate{get;set;}
        public String mechanicalLead{get;set;}
        public String electricalLead{get;set;}
    }
    
     public pageReference download(){
         
         system.debug('-------selectedFY-------'+selectedFY);
        Integer year = (System.today()).year();
        Integer month = (System.today()).month();
        system.debug( 'Current Year--> ' + year);
        system.debug( 'Current Month--> ' + month);
        if( selectedFY == 'Current FY')
        {
            if(month >= 4)
            {
                fromdate = Date.newInstance(year, 4, 1);
                todate = Date.newInstance(year+1, 3, 31);
            }
            else{
                fromdate = Date.newInstance(year-1, 4, 1);
                todate = Date.newInstance(year, 3, 31);
            }
        }
        else if( selectedFY == 'Previous FY' )
        {
            year--;
            if(month >= 4)
            {
                fromdate = Date.newInstance(year, 4, 1);
                todate = Date.newInstance(year+1, 3, 31);
            }
            else{
                fromdate = Date.newInstance(year-1, 4, 1);
                todate = Date.newInstance(year, 3, 31);
            }
        }
        system.debug('-------selectedStageName-------'+selectedStageName);
        system.debug('--------fromdate----------'+fromdate);
        system.debug('-----------todate-------'+todate);
        system.debug('---------selectedIndustry---------'+selectedIndustry);
        system.debug('---------selectedPrjType---------'+selectedPrjType); 
        system.debug('---------selectedReason---------'+selectedReason); 
         
         
        pageReference pageRef = new PageReference('/apex/TitanMBA_WinlossReportDownload');
        pageRef.getParameters().put('selectedStageName',selectedStageName);
        pageRef.getParameters().put('selectedIndustry',selectedIndustry);
        pageRef.getParameters().put('selectedPrjType',selectedPrjType); 
        pageRef.getParameters().put('selectedReason',selectedReason); 
        pageRef.getParameters().put('fromdate',String.ValueOf(fromdate));
        pageRef.getParameters().put('todate',String.ValueOf(todate));
        pageRef.setRedirect(true);
        system.debug('pageRef -->'+pageRef);
        return pageRef;
    }
    
    public void downloadOppDetails(){
        oppWrapperList = new List<oppWrapper>();
        string selectedStageName = ApexPages.currentPage().getParameters().get('selectedStageName');
        string selectedIndustry = ApexPages.currentPage().getParameters().get('selectedIndustry');
        string selectedPrjType = ApexPages.currentPage().getParameters().get('selectedPrjType');
        string selectedReason = ApexPages.currentPage().getParameters().get('selectedReason');
        String fromDateMap = ApexPages.currentPage().getParameters().get('fromdate');
        String toDateMap = ApexPages.currentPage().getParameters().get('todate');
        Date fromdate = Date.valueOf(fromDateMap);
        Date todate = Date.valueOf(toDateMap);
        system.debug('------selectedStageNameDown----------'+selectedStageName);
        system.debug('-------selectedIndustryDown---------'+selectedIndustry);
        system.debug('--------fromDateMap--------'+fromDateMap);
        system.debug('---------toDateMap-------'+toDateMap);
        
        
        if(selectedStageName == 'All')
        {
            if( selectedPrjType == 'All')
            {
                if( selectedReason == 'All')
                {
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name , Opportunity.StageName, Opportunity.Reason__c,Opportunity.Project_Type__c, Opportunity.Account.Industry ,Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c,  Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate   AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName  , Opportunity.Reason__c,  Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null ]):null;
                    }
                }
                else{
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Reason__c =: selectedReason ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Reason__c =: selectedReason ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Reason__c =: selectedReason ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Reason__c =: selectedReason]):null;
                    }
                }                
            }
            else{
                if( selectedReason == 'All')
                {
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Project_Type__c =:selectedPrjType ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =: selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Project_Type__c =:selectedPrjType]):null;
                    }
                }
                else{
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Reason__c =: selectedReason  And Opportunity.Project_Type__c =:selectedPrjType];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName  , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Reason__c =: selectedReason And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName, Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate   AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Reason__c =: selectedReason And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Reason__c =: selectedReason   And Opportunity.Project_Type__c =:selectedPrjType ]):null;
                    }
                }
            }
            
            
         }
        else
         {
            if( selectedPrjType == 'All')
            {
                if( selectedReason == 'All')
                {
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null ]):null;
                    }
                }
                else{
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Reason__c =: selectedReason ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate  AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Reason__c =: selectedReason ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Reason__c =: selectedReason ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry ,  Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Reason__c =: selectedReason]):null;
                    }
                }                
            }
            else{
                if( selectedReason == 'All')
                {
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Project_Type__c =:selectedPrjType ];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null  And Opportunity.Project_Type__c =:selectedPrjType]):null;
                    }
                }
                else{
                    if((fromdate!=null || todate!=null)&&(selectedIndustry==null || selectedIndustry=='None')){
                        QuoteData=[SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry,  Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst And Opportunity.Reason__c =: selectedReason  And Opportunity.Project_Type__c =:selectedPrjType];
                    }
                    if((fromdate!=null || todate!=null) && (selectedIndustry!=null && selectedIndustry!='None')){
                        QuoteData=(selectedIndustry=='Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name, Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry, Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry = 'Automotive' And Opportunity.Reason__c =: selectedReason And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Non-Automotive')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name, Opportunity.StageName , Opportunity.Reason__c, Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate  AND Opportunity.StageName =:selectedStageName AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null And Opportunity.Reason__c =: selectedReason And Opportunity.Project_Type__c =:selectedPrjType ]):(selectedIndustry=='Both')?([SELECT OpportunityId,Opportunity.Member1__c,Opportunity.Member2__c,Opportunity.Name,Opportunity.Account.Name,  Opportunity.StageName , Opportunity.Reason__c , Opportunity.Project_Type__c, Opportunity.Account.Industry , Opportunity.Record_Type_Name__c, Opportunity.Amount, CreatedDate FROM Quote WHERE Opportunity.First_Quote_Created_Date__c >= :fromdate AND Opportunity.First_Quote_Created_Date__c <= :todate AND Opportunity.StageName =:selectedStageName  AND Opportunity.Record_Type_Name__c NOT IN:holdRecordType.keySet() AND Is_Synched__c = 'Yes' AND Opportunity.Account.RecordType.Name IN :lst AND Opportunity.Account.industry !=null And Opportunity.Reason__c =: selectedReason   And Opportunity.Project_Type__c =:selectedPrjType ]):null;
                    }
                }
            }
         }
        system.debug('------QuoteData--------'+QuoteData.size());
        for(Quote q : QuoteData){
            if(q.Opportunity.Member1__c != null){
                mechLeadId2.add(q.Opportunity.Member1__c);
            }
            if(q.Opportunity.Member2__c != null){
                elecLeadId2.add(q.Opportunity.Member2__c);
            }        
        }
        for(User u : [Select Id,Name from User where Id IN:mechLeadId2 OR Id IN:elecLeadId2]){
            leadName.put(u.Id,u.Name);
        }
        for(Quote q : QuoteData){
            oppWrapper wrap = new oppWrapper();
            wrap.oppName = q.Opportunity.Name;
            wrap.AccName = q.Opportunity.Account.Name;
            wrap.oppStageName = q.Opportunity.StageName;
            wrap.oppAccIndustry = q.Opportunity.Account.Industry;
            wrap.oppPrjType = q.Opportunity.Project_Type__c;
            wrap.oppLostReason = q.Opportunity.Reason__c;
            wrap.oppRecordTypeName = q.Opportunity.Record_Type_Name__c;
            wrap.oppAmount = q.Opportunity.Amount;
            wrap.createdDate = Date.valueOf(q.CreatedDate);
            wrap.mechanicalLead = leadName.containsKey(q.Opportunity.Member1__c) ? leadName.get(q.Opportunity.Member1__c)  : '';
            wrap.electricalLead = leadName.containsKey(q.Opportunity.Member2__c) ? leadName.get(q.Opportunity.Member2__c)  : '';

            oppWrapperList.add(wrap);
        }
        
        system.debug('-----------oppWrapperList----------'+oppWrapperList);
    }
    
    public class oppWrapper {
        public String oppName{get;set;}
        public String AccName{get;set;}
        public String oppStageName{get;set;}
        public String oppAccIndustry{get;set;}
        public String oppPrjType{get;set;}
        public String oppLostReason{get;set;}
        public String oppRecordTypeName{get;set;}
        public Decimal oppAmount{get;set;}
        public Date createdDate{get;set;}
        public String mechanicalLead{get;set;}
        public String electricalLead{get;set;}
    
    }
    
}