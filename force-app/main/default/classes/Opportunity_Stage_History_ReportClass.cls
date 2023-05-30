public class Opportunity_Stage_History_ReportClass {
    Public Date startDate {get;Set;}
    Public Date tillDate {get;Set;}
    Public String selectedStage {get;set;}
    Public List<OpportunityHistory> oppHistoryList {get;Set;}
    public Opportunity_Stage_History_ReportClass()
    {
        oppHistoryList = new List<OpportunityHistory>();
    }
    
    public List<SelectOption> getStageName() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None--','--None--'));
        options.add(new SelectOption('Preliminary Opportunity','Preliminary Opportunity'));
        options.add(new SelectOption('Qualified-RFQ study','Qualified-RFQ study'));
        options.add(new SelectOption('Concept Finalization','Concept Finalization'));
        options.add(new SelectOption('Costing','Costing'));
        options.add(new SelectOption('Quote Preparation','Quote Preparation'));
        options.add(new SelectOption('Await Customer Feedback(Quote Submitted)','Await Customer Feedback(Quote Submitted)'));
        options.add(new SelectOption('Revised Quote Submission','Revised Quote Submission'));
        return options;
    }
    
    public void getOpportunityInfo()
    {
        
        string query,dateAsString,endDateString;
        endDateString = String.ValueOf(tillDate)+'T00:00:00Z';
        dateAsString = String.ValueOf(startDate)+'T00:00:00Z';
        
        query = 'SELECT id,createdDate,OpportunityId,Opportunity.Name,Opportunity.Account.Name,StageName,Amount,Opportunity.Member2__r.Name,Opportunity.Electrical_2__r.Name,Opportunity.Electrical_3__r.Name,'+
          '  Opportunity.Member1__r.Name,Opportunity.Mechanical_2__r.Name,Opportunity.Mechanical_3__r.Name from OpportunityHistory where StageName =\''+selectedStage+'\' And createdDate >='+dateAsString+' And createdDate <='+ endDateString;
        oppHistoryList = Database.query(query);
        System.debug(query);
        System.debug('oppHistoryList-->'+oppHistoryList);
    }
    
    
    public pageReference download(){
        pageReference pageRef = new PageReference('/apex/Opportunity_Stage_History_ReportDownload');
        pageRef.getParameters().put('selectedStage',selectedStage);
        pageRef.getParameters().put('startDate',String.ValueOf(startDate));
        pageRef.getParameters().put('tillDate',String.ValueOf(tillDate));
        pageRef.setRedirect(true);
        system.debug('pageRef -->'+pageRef);
        return pageRef;
    }
    
    public void getOpportunityInfoDownLoad()
    {
        string selectedStageDL = ApexPages.currentPage().getParameters().get('selectedStage');
        string startDateDL = ApexPages.currentPage().getParameters().get('startDate');
        string tillDateDL = ApexPages.currentPage().getParameters().get('tillDate');
        string query,dateAsString,endDateString;
        endDateString = String.ValueOf(tillDateDL)+'T00:00:00Z';
        dateAsString = String.ValueOf(startDateDL)+'T00:00:00Z';
        
        query = 'SELECT id,createdDate,OpportunityId,Opportunity.Name,Opportunity.Account.Name,StageName,Amount,Opportunity.Member2__r.Name,Opportunity.Electrical_2__r.Name,Opportunity.Electrical_3__r.Name,'+
          '  Opportunity.Member1__r.Name,Opportunity.Mechanical_2__r.Name,Opportunity.Mechanical_3__r.Name from OpportunityHistory where StageName =\''+selectedStageDL+'\' And createdDate >='+dateAsString+' And createdDate <='+ endDateString;
        oppHistoryList.clear();
        oppHistoryList = Database.query(query);
        System.debug(query);
        System.debug('oppHistoryList-->'+oppHistoryList);
        
    }
}