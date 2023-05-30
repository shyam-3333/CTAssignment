public class ProposalProductDataProcessInPDFBatch implements Database.Batchable<sObject>{
    public Set<String> proposalIds;
    
    public ProposalProductDataProcessInPDFBatch(Set<String> proposalIds){
        this.proposalIds = proposalIds;
    }
    
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'Select Id,Opportunity__r.Name from Proposal__c where Id In : proposalIds';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Proposal__c> proposalsList) {
        // process each batch of records default size is 200
        
        
        for(Proposal__c ps : proposalsList){
            PageReference pg = Page.ProposalToolPDFGeneration;
            pg.getParameters().put('proposalToolId',String.valueOf(ps.Id));
            pg.setRedirect(true);
            Blob reportPdf;
            if(Test.isRunningTest()){
                reportPdf = BLOB.valueOf('Test');
            }else{
                reportPdf = pg.getContent();
            }
            ContentVersion cVersion = new ContentVersion();
            cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
            cVersion.PathOnClient = 'Proposal - '+ system.Now() + ' .pdf';//File name with extention
            cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
            cVersion.Title = (ps.Opportunity__r.Name != null)? ps.Opportunity__r.Name + ' - Proposal - '+ system.Today() + ' .pdf':'Proposal - '+ system.Today() + ' .pdf';//Name of the file
            cVersion.VersionData = reportPdf;//File content
            //attchContentVerMap.put( mapOfUsers.get(userIds).Id , cVersion );
            System.debug('cVersion'+cVersion);
            insert cVersion;
            
            List<ContentVersion> conDocument = [ SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id ];//.ContentDocumentId;;
            
            
            ContentDocumentLink cDocLink = new ContentDocumentLink();
            cDocLink.ContentDocumentId = conDocument[0].ContentDocumentId;//Add ContentDocumentId
            cDocLink.LinkedEntityId = String.valueOf(ps.Id);//Add attachment parentId
            cDocLink.ShareType = 'V';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
            cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
            insert cDocLink;
        }
        
        try {
            
        } catch(Exception e) {
            System.debug(e);
        }
        
    }   
    
    public void finish(Database.BatchableContext BC) {
    }
}