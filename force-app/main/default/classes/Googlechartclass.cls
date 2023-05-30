/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Developer2(Lister)  11/13/2019   T01		T01- Dynamic retrieval of report names & Ids from custom metadata (googlechartForTotalMetaDataType__mdt)
*/
public class Googlechartclass
{
    public Decimal QuotesSubmitted{get;set;}
    public Decimal ProSubmittedUnderConsideration{get;set;}
    public Double  Awarded{get;set;}
    public Decimal ProjectsShelved{get;set;}
    public Decimal OrdersWon{get;set;}
    public Decimal LostOnCost{get;set;}
    public Decimal LostOnStrategicReason{get;set;}
    public Decimal lostOnLeadTime{get;set;}
    public set<ID> OpIdList = new set<ID>();
    public set<ID> OpIdlist1 = new set<ID>();
    public List<opportunity> oplisttemp{get;set;}
    
    //<T01>
    public static List<ReportLinkWrapper> getReportLinksForGoogleChart(){
        
        List<ReportLinkWrapper> reportIdsForUrlList = new List<ReportLinkWrapper>();
        Map<String,String> reportNamesMap = new Map<String,String>();
        List<googlechartMetaDataType__mdt> googleMetaList = [select label,Link_Name__c from googlechartMetaDataType__mdt];
        for(googlechartMetaDataType__mdt lbl : googleMetaList){
            reportNamesMap.put(lbl.label,lbl.Link_Name__c);
        }
        
        reportIdsForUrlList = ReportLinkWrapper.getURLForReports(reportNamesMap,reportIdsForUrlList);
        return reportIdsForUrlList;
    }
    //</T01>
    public Googlechartclass() {
        QuotesSubmitted=0;
        ProSubmittedUnderConsideration=0;
        Awarded=0000000000000000.00;
        ProjectsShelved=0;
        OrdersWon=0;
        LostOnCost=0;
        LostOnStrategicReason=0;
        lostOnLeadTime=0;
        
        oplisttemp=new List<opportunity>();
        
        
        
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
        List<Quote> QuoteList = [select OpportunityId from Quote where Is_Synched__c =:'yes' AND (CreatedDate=THIS_FISCAL_YEAR)];
        for(Quote Q : QuoteList)
        {
            OpIdList.add(Q.OpportunityId); 
        }
        List<opportunity> oplist =[select id,name,RecordType.Name, StageName,Converted_Amount__c ,RecordTypeId,Account.RecordTypeId,Amount,Reason__c,SyncedQuoteId  from opportunity where (id in : OpIdList)];
        system.debug(oplist);
        for(Opportunity op : oplist)
        {              
            
            /*--------------------------calculating Proposals submitted-Under consideration------*/
            if((op.Account.RecordTypeId==RtAccountMBA) && (op.StageName=='Await Customer Feedback(Quote Submitted)' || 
                                                           op.StageName=='Under Negotiation') &&(op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                                                                                                 && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType)) 
            {
                oplisttemp.add(op);
                if(op.Amount != null)
                {
                    ProSubmittedUnderConsideration = ProSubmittedUnderConsideration+op.Amount;
                }
            }
            
            /*---------------------------calculating Awarded----------------------------------*/             
            if((op.Account.RecordTypeId==RtAccountMBA) && (op.StageName=='Order Won' ||
                                                           op.StageName=='Opportunity Lost' || op.StageName=='Project Under Execution' || 
                                                           op.StageName=='Project Closed')&& (op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                                                                                              && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType))
            {
                
                if(op.Amount != null)
                {
                    Awarded=Awarded+op.amount;
                }
                
            }
            
            /*--------------------------------Calculating Projects Shelved-------------------------------*/
            if((op.Account.RecordTypeId==RtAccountMBA) && (op.StageName=='Opportunity On Hold') && (op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                                                                                                    && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType))
            {
                if(op.Amount != null)
                {
                    ProjectsShelved=ProjectsShelved+op.amount;
                }    
            }
            
            /*-----------------------------------calculating LostOnCost-----------------------------------------------------*/
            
            if((op.Account.RecordTypeId==RtAccountMBA) && (op.StageName=='Opportunity Lost') && (op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                                                                                                 && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType) && (op.Reason__c == 'Lost on cost'))
            {
                
                if(op.Amount != null)
                {
                    LostOnCost = LostOnCost+op.Amount;
                }
            }
            
            /*---------------------------------------calculating LostOnStrategicReason------------------------------------------*/
            if((op.Account.RecordTypeId==RtAccountMBA)&& (op.StageName=='Opportunity Lost') && (op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                                                                                                && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType) && (op.Reason__c == 'Lost on strategic reason'))
            {
                
                if(op.Amount != null)
                {
                    LostOnStrategicReason= LostOnStrategicReason+op.Amount;
                }
            }
            /*-----------------------------------------calculating lost on lead time---------------------------------------------*/ 
            if((op.Account.RecordTypeId==RtAccountMBA)&& (op.StageName=='Opportunity Lost') && (op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                                                                                                && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType) && (op.Reason__c == 'Lost on lead time'))
            {
                
                if(op.Amount != null)
                {
                    lostOnLeadTime= lostOnLeadTime+op.Amount;
                }
            }   
            
            
        } 
        
        
        List<Quote> QuoteList1 = [select OpportunityId from Quote where Is_Synched__c =:'yes' AND (CreatedDate=THIS_FISCAL_YEAR)];
        for(Quote Q : QuoteList1)
        {
            OpIdList1.add(Q.OpportunityId); 
        }           
        
        
        /*---------------------------calculating QuotesSubmitted---------------------------------------*/
        List<opportunity> oplistAll =[select id,StageName,Converted_Amount__c ,RecordTypeId,Account.RecordTypeId,Amount,Reason__c,SyncedQuoteId  from opportunity where (id in : OpIdList1)];
        for(Opportunity op : oplistAll)
        {
            if((op.Account.RecordTypeId==RtAccountMBA) && (op.StageName=='Await Customer Feedback(Quote Submitted)' || 
                                                           op.StageName=='Revised Quote Submission' || op.StageName=='Under Negotiation' || op.StageName == 'Await Feedback (Under Negotiation)'
                                                           || op.StageName=='Order Won' || op.StageName=='Project Under Execution' || op.StageName=='Project Closed') && 
               (op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType)) 
            {
                if(op.Amount!= null)
                {
                    QuotesSubmitted=QuotesSubmitted+op.Amount;
                }
            }
        }
        /*--------------------------------------------------Calculating Orders Won------------------------------------------------------------*/
        List<opportunity> oplistForOrdersWon =[select id,StageName,Converted_Amount__c ,RecordTypeId,Account.RecordTypeId,Amount from opportunity where 
                                               (LOI_Date__c = THIS_FISCAL_YEAR OR PO_Date__c = THIS_FISCAL_YEAR) AND (Customer_Type__c !='Internal Customer') AND (id in : OpIdList1) ]; 
        for(Opportunity op : oplistForOrdersWon )
        {
            if((op.Account.RecordTypeId==RtAccountMBA) && (op.StageName=='Order Won' || op.StageName=='Project Under Execution' || op.StageName=='Project Closed') && 
               (op.RecordTypeId != RtIdMBAServicesAllocated && op.RecordTypeId != RtIdMBAServicesFinal && op.RecordTypeId != RtIdMBASparesFinal
                && op.RecordTypeId != RtIdPECSA && op.RecordTypeId != RtIdRegretMBARecordType && op.RecordTypeId !=RtIdSpareServicesRecordType))
            {
                if(op.Amount != null)
                {
                    OrdersWon=OrdersWon+op.Amount;
                }
            }
        } 
        
        
    }
    
}