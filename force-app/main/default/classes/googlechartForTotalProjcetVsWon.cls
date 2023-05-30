/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Developer2(Lister)  11/13/2019   T01		T01- Dynamic retrieval of report names & Ids from custom metadata (googlechartForTotalMetaDataType__mdt)
*/
Public class googlechartForTotalProjcetVsWon
{
    public Decimal QuotesSubmitted{get;set;}
    public Decimal OrdersWon{get;set;}
    public Decimal OrdersWon0_25L{get;set;}
    public Decimal OrdersWon25_80L{get;set;}
    public Decimal OrdersWon_80_350L{get;set;}
    public Decimal OrdersWonGreaterThan350L{get;set;}
    public Decimal QuotesSubmitted0_25L{get;set;}
    public Decimal QuotesSubmitted25_80L{get;set;}
    public Decimal QuotesSubmitted_80_350L{get;set;}
    public Decimal QuotesSubmittedGreaterThan350L{get;set;}
    public List<opportunity> oplisttemp{get;set;}
    
    public Decimal TotanNumberOfProjects0_25L{get;set;}
    public Decimal TotanNumberOfProjects25_80L{get;set;}
    public Decimal TotanNumberOfProjects_80_350L{get;set;}
    public Decimal TotanNumberOfProjectsGreaterThan350L{get;set;}
    
    public Decimal TotanNumberOfProjectsWon0_25L{get;set;}
    public Decimal TotanNumberOfProjectsWon25_80L{get;set;}
    public Decimal TotanNumberOfProjectsWon_80_350L{get;set;}
    public Decimal TotanNumberOfProjectsWonGreaterThan350L{get;set;}
    
    public Decimal TotanNumberOfProjects{get;set;}
    public Decimal TotanNumberOfProjectsWon{get;set;}
    public set<ID> OpIdList = new set<ID>();
     //<T01>
    public static List<ReportLinkWrapper> getTotalValueWonData(){
        
       List<ReportLinkWrapper> reportIdsForUrlList = new List<ReportLinkWrapper>();
        Map<String,String> reportNamesMap = new Map<String,String>();
        List<googlechartForTotalMetaDataType__mdt> googleMetaList = [select label,Link_Name__c from googlechartForTotalMetaDataType__mdt];
        for(googlechartForTotalMetaDataType__mdt lbl : googleMetaList){
            reportNamesMap.put(lbl.label,lbl.Link_Name__c);
        }
        
    	reportIdsForUrlList = ReportLinkWrapper.getURLForReports(reportNamesMap,reportIdsForUrlList);
        return reportIdsForUrlList;
    }
    public static List<ReportLinkWrapper> getTotalProjectWonData(){
       
       List<ReportLinkWrapper> reportIdsForUrlList = new List<ReportLinkWrapper>();
        Map<String,String> reportNamesMap = new Map<String,String>();
        List<googlechartForTotalProjectMetaDataType__mdt> googleMetaList = [select label,Link_Name__c from googlechartForTotalProjectMetaDataType__mdt];
        for(googlechartForTotalProjectMetaDataType__mdt lbl : googleMetaList){
            reportNamesMap.put(lbl.label,lbl.Link_Name__c);
        }
        
        reportIdsForUrlList = ReportLinkWrapper.getURLForReports(reportNamesMap,reportIdsForUrlList);
        return reportIdsForUrlList;
    }
     //</T01>
    public googlechartForTotalProjcetVsWon () {
       
        QuotesSubmitted=0;
        OrdersWon=0;
        OrdersWon0_25L=0;
        OrdersWon25_80L=0;
        OrdersWon_80_350L=0;
        OrdersWonGreaterThan350L=0;
        QuotesSubmitted0_25L=0;
        QuotesSubmitted25_80L=0;
        QuotesSubmitted_80_350L=0;
        QuotesSubmittedGreaterThan350L=0;
        oplisttemp=new List<opportunity>();
        
        
        TotanNumberOfProjects=0;
        TotanNumberOfProjectsWon=0;
        
        
        
        TotanNumberOfProjects0_25L=0;
        TotanNumberOfProjects25_80L=0;
        TotanNumberOfProjects_80_350L=0;
        TotanNumberOfProjectsGreaterThan350L=0;
        
        TotanNumberOfProjectsWon0_25L=0;
        TotanNumberOfProjectsWon25_80L=0;
        TotanNumberOfProjectsWon_80_350L=0;
        TotanNumberOfProjectsWonGreaterThan350L=0;
        
        TotanNumberOfProjects=0;
        TotanNumberOfProjectsWon=0;
        
        /*-------------------------fatching Record type id for Account and opportunity-------------------------*/
        ID RtAccountMBA;
        ID RtIdAllocatedRecordType;
        ID RtIdAwaitFeedbackRecordType;
        ID RtIdInitialRecordtype;
        ID RtIdLayoutRecordType;
        ID RtIdMBA;
        ID RtIdMBAServicesAllocated;
        ID RtIdMBAServicesFinal;
        ID RtIdMBASparesFinal;
        ID RtIdPECSA;
        ID RtIdQuoteSubmittedRecordType;
        ID RtIdQuoteSubmittedServices;
        ID RtIdQuoteSubmittedSpares;
        ID RtIdRegretMBARecordType;
        ID RtIdSpareServicesRecordType;
        /*----------------------------------fatching account record type id------------------------------------------------*/
        List<RecordType> AccountRt = [select name,id from RecordType where Sobjecttype='Account'];
        for(RecordType ActRt: AccountRt)
        {
            if(ActRt.name=='MBA')
            {
                RtAccountMBA=ActRt.id;
                system.debug('1-------'+RtAccountMBA);
            }
            
        }
        
        /*--------------------------------------------fatching opportunity reocrdtype id------------------------------------*/
        List<RecordType> Rt = [select name,id from RecordType where Sobjecttype='Opportunity'];  
        system.debug('ganesh-------'+Rt.size());
        for(RecordType Rtype : Rt)
        {
            
            if(Rtype.name=='Allocated Record Type')
            {
                RtIdAllocatedRecordType = Rtype.id;
                system.debug('2-------'+RtIdAllocatedRecordType );
            }
            if(Rtype.name=='Await Feedback Record Type')
            {
                RtIdAwaitFeedbackRecordType = Rtype.id;
                system.debug('3-------'+RtIdAwaitFeedbackRecordType);
            }
            if(Rtype.name=='Initial Record type')
            {
                RtIdInitialRecordtype = Rtype.id;
                system.debug('4-------'+RtIdInitialRecordtype );
            }
            if(Rtype.name=='Layout Record Type')
            {
                RtIdLayoutRecordType = Rtype.id;
                system.debug('5-------'+RtIdLayoutRecordType );
            }
            if(Rtype.name=='MBA')
            {
                RtIdMBA = Rtype.id;
                system.debug('6-------'+RtIdMBA );
            }
            if(Rtype.name=='MBA Services Allocated')
            {
                RtIdMBAServicesAllocated = Rtype.id;
                system.debug('7-------'+RtIdMBAServicesAllocated );
            }
            if(Rtype.name=='MBA Services Final')
            {
                RtIdMBAServicesFinal = Rtype.id;
                system.debug('8-------'+RtIdMBAServicesFinal );
            }
            if(Rtype.name=='MBA Spares Final')
            {
                RtIdMBASparesFinal = Rtype.id;
                system.debug('9-------'+RtIdMBASparesFinal );
            }
            if(Rtype.name=='PECSA')
            {
                RtIdPECSA = Rtype.id;
                system.debug('10-------'+RtIdPECSA );
            }
            if(Rtype.name=='Quote Submitted Record Type')
            {
                RtIdQuoteSubmittedRecordType = Rtype.id; 
                system.debug('11-------'+RtIdQuoteSubmittedRecordType );
            }
            if(Rtype.name=='Quote Submitted Services')
            {
                RtIdQuoteSubmittedServices = Rtype.id;
                system.debug('13-------'+RtIdQuoteSubmittedServices);
            }
            if(Rtype.name=='Quote Submitted Spares')
            {
                RtIdQuoteSubmittedSpares = Rtype.id;
                system.debug('14-------'+RtIdQuoteSubmittedSpares );
            }
            if(Rtype.name=='Regret MBA Record Type')
            {
                RtIdRegretMBARecordType = Rtype.id;
                system.debug('15-------'+RtIdRegretMBARecordType );
            }
            if(Rtype.name=='Spares & Services Record Type')
            {
                RtIdSpareServicesRecordType = Rtype.id;
                system.debug('16-------'+RtIdSpareServicesRecordType);
            }
        }
        List<Quote> QuoteList = [select OpportunityId from Quote where Is_Synched__c =:'yes' AND CreatedDate = THIS_FISCAL_YEAR];
        for(Quote Q : QuoteList)
        {
            OpIdList.add(Q.OpportunityId); 
        }
        List<opportunity> oplist =[select id,StageName,name,Converted_Amount__c ,RecordTypeId,RecordType.Name,Account.RecordTypeId,Amount,Reason__c,Cost_band__c from opportunity where (id in : OpIdList)];
        system.debug('OPLIST '+oplist +' Record typr '+oplist[0].RecordTypeId);
        for(Opportunity op : oplist)
        {
            /*---------------------------calculating QuotesSubmitted(Proposals Submitted - Win loss)---------------------------------------*/
            if((op.Account.RecordTypeId==RtAccountMBA) && (op.StageName=='Await Customer Feedback(Quote Submitted)' || 
                                                           op.StageName=='Revised Quote Submission' || op.StageName=='Under Negotiation' || op.StageName == 'Await Feedback (Under Negotiation)'
                                                           || op.StageName=='Order Won' || op.StageName=='Project Under Execution' || op.StageName=='Project Closed') && 
               (op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType))
            {
                
                TotanNumberOfProjects=TotanNumberOfProjects+1;
                if(op.Amount!= null)
                {
                    QuotesSubmitted=QuotesSubmitted+op.Amount;
                }
                if(op.Cost_band__c=='0-25L')
                {   
                    TotanNumberOfProjects0_25L=TotanNumberOfProjects0_25L+1;
                    if(op.amount != null)
                    {
                        QuotesSubmitted0_25L = QuotesSubmitted0_25L + op.Amount;
                    }     
                }         
                if(op.Cost_band__c=='25-80L')
                {
                    TotanNumberOfProjects25_80L=TotanNumberOfProjects25_80L+1;
                    if(op.Amount != null)
                    {
                        QuotesSubmitted25_80L = QuotesSubmitted25_80L + op.Amount;
                    }
                }
                if(op.Cost_band__c=='80-350L')
                {
                    TotanNumberOfProjects_80_350L=TotanNumberOfProjects_80_350L+1;
                    if(op.Amount != Null)
                    {
                        QuotesSubmitted_80_350L = QuotesSubmitted_80_350L + op.Amount;
                    }
                }
                if(op.Cost_band__c=='greater than 350L')
                {
                    TotanNumberOfProjectsGreaterThan350L=TotanNumberOfProjectsGreaterThan350L+1;
                    if(op.Amount != null)
                    {
                        QuotesSubmittedGreaterThan350L = QuotesSubmittedGreaterThan350L + op.Amount;
                    }    
                }
            }
            
        }
        /*--------------------------------------------------Calculating Orders Won------------------------------------------------------------*/
        List<opportunity> oplistForOrdersWon =[select id,name,StageName,Converted_Amount__c ,RecordTypeId,RecordType.Name,Account.RecordTypeId,Amount, Cost_band__c from opportunity where 
                                               (LOI_Date__c = THIS_FISCAL_YEAR OR PO_Date__c = THIS_FISCAL_YEAR) AND (Customer_Type__c !='Internal Customer')AND (Account.RecordTypeId=:RtAccountMBA) AND (StageName=:'Order Won' OR StageName=:'Project Under Execution' OR StageName=:'Project Closed') AND 
                                               (RecordTypeId !=: RtIdMBAServicesAllocated AND RecordTypeId !=: RtIdMBAServicesFinal AND
                                                RecordTypeId !=: RtIdMBASparesFinal AND RecordTypeId !=: RtIdPECSA AND RecordTypeId !=: RtIdRegretMBARecordType AND
                                                RecordTypeId !=: RtIdSpareServicesRecordType) AND (id in : OpIdList) ]; 
        System.debug('Check '+oplistForOrdersWon);
        for(Opportunity op : oplistForOrdersWon )
        {
            oplisttemp.add(op);
            TotanNumberOfProjectsWon=TotanNumberOfProjectsWon+1;
            if(op.Cost_band__c=='0-25L')
            {   
                TotanNumberOfProjectsWon0_25L=TotanNumberOfProjectsWon0_25L+1;
                if(op.amount != null)
                {
                    OrdersWon0_25L = OrdersWon0_25L + op.Amount;
                }     
            }         
            if(op.Cost_band__c=='25-80L')
            {
                TotanNumberOfProjectsWon25_80L=TotanNumberOfProjectsWon25_80L+1;
                if(op.Amount != null)
                {
                    OrdersWon25_80L = OrdersWon25_80L + op.Amount;
                }
            }
            if(op.Cost_band__c=='80-350L')
            {
                TotanNumberOfProjectsWon_80_350L=TotanNumberOfProjectsWon_80_350L+1;
                if(op.Amount != Null)
                {
                    OrdersWon_80_350L = OrdersWon_80_350L + op.Amount;
                }
            }
            if(op.Cost_band__c=='greater than 350L')
            {
                TotanNumberOfProjectsWonGreaterThan350L=TotanNumberOfProjectsWonGreaterThan350L+1;
                if(op.Amount != null)
                {
                    OrdersWonGreaterThan350L = OrdersWonGreaterThan350L + op.Amount;
                }    
            }
            if(op.Amount != null)
            {
                OrdersWon = OrdersWon + op.Amount;
            }    
        }
    }
}