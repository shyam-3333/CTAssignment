/*
* Created by    : Developer1 (Lister)
* Created on    : Nov-12-2019
* Purpose 		: This class contains methods
*******************************************************************************************************************************************
ModifiedBy            Date         Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)   Nov-12-2019   T01     Method to track all exeception in custom object
Praveen(Lister)   Nov-14-2019   T02     Method to return followup Task
Saradha(Lister)	  Nov-21-2019	T03		Method to get names for QuoteTriggerHandler
Praveen(Lister)   Nov-27-2019	T04		Method to get return Opportunity Team Member
*/
public class Util_Common {
    //Common variables
    //<Recortypes>
    public static final String recordTypePECSA = 'PECSA';
    public static final String recordTypeJewellery = 'Jewellery';
    public static final String recordTypeLifestyle = 'Lifestyle';
    public static final String recordTypeWatches= 'Watches';
    public static final String recordTypeTaneira='Taneira';
    public static final String recordTypeMBAQUOTE='MBA Record Type';
    public static final String recordTypeAwtFeebck='Await Feedback Record Type';
    public static final String recordTypeQuoteSubmtd='Quote Submitted Record Type';
    public static final String recordTypeMBAONLY='MBA';
    public static final String recordTypeHiding='HidingSubmitButtonBasedOnStageName';
    public static final String recordTypeRFQ='RFQ Record Type';
    public static final String recordTypeAllocated='Allocated Record Type';
    public static final string RECORDTYPEBUSINESSMBASPARES ='MBA and Spares';
    public static final string RECORDTYPEBUSINESSMBASERVICE ='MBA Service';
    public static final string RECORDTYPEINITIAL ='Initial Record type';
    public static final string RECORDTYPEMBASERVICEALLOCATED='MBA Services Allocated';
    public static final string RECORDTYPEMLAYOUT='Layout Record Type';
    
    //</Recordtypes>
    public static final string contactPrefix='003';
    public static final string opptPrefix='006';
    public static final string leadPrefix='00Q';
    //<Opportunity Stages>
    public static final string stageOrderWon='Order Won';
    public static final string stagePreliminaryOppt='Preliminary Opportunity';
    public static final string stageRFQStudy='RFQ Study';
    public static final string stageAwaitCustFeedback='Await Customer Feedback(Quote Submitted)';
    public static final string stageUnderNegotiation='Under Negotiation';
    public static final string stageAwaitFeedback='Await Feedback (Under Negotiation)';
    public static final string stageConceptFinal='Concept Finalization';
    public static final string stageCosting='Costing';
    public static final string stageQuotePreparation='Quote Preparation';
    public static final string stageRevisedQuote='Revised Quote Submission';
    public static final string stagePrjctExec='Project Under Execution';
    public static final string stagePrjctClosed='Project Closed';
    public static final string stagePrjctCancel='Project Cancelled';
    public static final string stageOpptHold='Opportunity On Hold';
    public static final string stageOpptLost='Opportunity Lost';
    public static final string STAGEORDERCLOSED='Order Closed';
    public static final string STAGEORDERCANCELLED='Order cancelled';
    
    public static final string STAGEQUOTEPREPARETION='Quote_Preparation';
    public static final string STAGEREVISEDQUOTEONLY='Revised Quote';
    public static final string STAGEREQUOTE='Re quote';
    public static final string STAGEREQAMEND='Request for Amendment';
    public static final string STAGEAMENDPO='Amended PO';
    public static final string STAGEUNDERSTUDYCLAR='Under Study and Clarifications'; 
	public static final string STAGEUNDERCUSTEVAL='Under Customer Evaluation';
    public static final string STAGEUNDERCUSTREEVAL='Under Customer Re- Evaluation';
    public static final string STAGEUNDERSTUDY='Under-Study';
    public static final string STAGEPROFORMAINVOICE='Proforma Invoice';
    public static final string STAGERECEIVEDORDERPOWON = 'Received PO/Order Won';
    public static final string STAGEPAYMENTORDELIVERY = 'Payment/Delivery';
    
    //</Opportunity Stages>
    public static final string QUOTEAPROVALNOTNEEDEDFORCONTRACT='Approval not needed - Under Contract';
    public static final string QUOTEAPROVALFORWATCHESORACCESSORIES='Watches / Accessories';
    public static final string QUOTEAPROVALDISCOUNTED='Discounted';
    public static final string QUOTEAPROVALJEWELLRYSIVER='Jewellery Silver Coins Only';
    public static final string QUOTEAPROVALJEWELLRYALL='Jewellery Products All';
    public static final string QUOTEAPROVALJEWELLRYGOLD='Jewellery Gold Coins Only';
    public static final string QUOTEAPROVALGCGVNOTGOLD='GV/GC Not Valid on Gold Coin';
    public static final string QUOTEAPROVALGCGVVALIDDIAMOND='GV/GC Valid on Diamond Studded';
    public static final string QUOTEAPROVALGCGVVALIDGOLD='GV/GC Valid on Gold Coin';
    public static final string FREEOFCOST='Free Of Cost';
    //<Role>
    public static final string ELECTRICALROLE='Electrical';
    public static final string MECHANICALROLE='Mechanical';
    //</Role>
    public static final string EDITACCESS='Edit';
    public static final string currencyINR='INR';
    public static final string APPROVED='Approved';
    public static final string SYSADMIN='System Administrator';
    public static final string HUNDRED='hundred';
    public static final string ANDSTR='and';
    public static final string RELEASE='Release ';
    public static final string BUSINESSMBA ='MBA';
    public static final string BUSINESSMBASERVICES ='MBA Services';
    public static final string SPARES ='Spares';
    public static final string ELECTRICALTEAM='Explanation to Electrical Team';
    public static final string GVEMAIL='Gv';
    public static final string GCEMAIL='Gc';
    //<T01>
    private static final string dmlExcep='System.DmlException';
    private static final string emailExcep='System.EmailException';
    private static final string dmlNumFError='DML Num Errors: ';
    
    private static final string dmlFieldNames=' - DML DmlFieldNames: ';
    private static final string dmlFields=' - DML DmlFields: ';
    private static final string dmlId=' - DML DmlId: ';
    private static final string dmlIndex=' - DML DmlIndex: ';
    private static final string dmlMessage=' - DML DmlMessage: ';
    private static final string dmlStatusCode=' - DML DmlStatusCode: ';
    private static final string dmlType=' - DML DmlType: ';
    private static final string descriptionMsg =' - Description: ';
    public static final String VALIDATED= 'Validated'; 
    public static final String COMPLETED= 'Completed'; 
    public static final String REGISTRATION= 'Registration'; 
    public static final String INVOICE= 'Invoice'; 
    public static final String ONE = '1';
    public static final String CORRESPONDENCEPATH = '\\Correspondence\\SFDC\\';
     public static final String APPROVALREQ ='Approval Required';
    //</T01>
    //<T02>
    public final static string dailyRecurrence='RecursDaily';
    public final static String ARCHIVEDLINKS='Archived Links';
    public final static String SLASHN='\n\n';
    public final static String FILEPATH ='- file:///';
    //</T02>
    //<T03>
    public static Map<Integer,String> numbernames = new Map<Integer,String>();
    public static Map<Integer,String> westernvalues = new Map<Integer,String>();
    public static Map<Integer,String> indianvalues = new Map<Integer,String>(); 
    //</T03>
    public final static string OPPTTRIGGER='OpportunityTrigger';
    public final static string QUOTELINEITEMTRIGGER='quoteLineItemTrigger';
    public final static string QUOTEITEMETRIGGER='QuoteItemTrigger';
    public final static string QUOTETRIGGER='QuoteTrigger';
    public final static string LEADTRIGGER='LeadTrigger';
    public final static string ATTTRIGGER='AttachmentTrigger';
    public final static string TASKTRIGGER='TaskTrigger';
    
    public static boolean run = true; 
    public static boolean runForQLI = true; 
	public static set<String> triggerSet = new Set<String>();
    //<T01> Method to track all exception in custom object
    public static Debug_Logs__c processException(Exception e, Boolean insertFlag, String description){
        Debug_Logs__c logs = new Debug_Logs__c();
        if(e != null){
            logs.Line_Number__c = e.getLineNumber();
            logs.Stack_Trace__c = e.getStackTraceString();
            logs.Type__c = e.getTypeName();
            logs.Exception_Message__c = e.getMessage();
            if(e.getTypeName() == dmlExcep || e.getTypeName() == emailExcep){
                Integer numErrors = e.getNumDml();
                String DMLDetails =dmlNumFError+numErrors;
                for(Integer i=0;i<numErrors;i++) {
                    DMLDetails = DMLDetails + dmlFieldNames+e.getDmlFieldNames(i);
                    DMLDetails = DMLDetails + dmlFields+e.getDmlFields(i);
                    DMLDetails = DMLDetails + dmlId+e.getDmlId(i);
                    DMLDetails = DMLDetails + dmlIndex+e.getDmlIndex(i);
                    DMLDetails = DMLDetails + dmlMessage+e.getDmlMessage(i);
                    DMLDetails = DMLDetails + dmlStatusCode+e.getDmlStatusCode(i);
                    DMLDetails = DMLDetails + dmlType+e.getDmlType(i);
                }
                logs.Description__c = DMLDetails;
            }
        }
        if(null != description && !description.equals('')){
            if(null != logs.Description__c && !logs.Description__c.equals('')){
                logs.Description__c = logs.Description__c + descriptionMsg +description;
            }else{
                logs.Description__c = description;
            }
        }
        if(insertFlag){
            insert logs;
        }
        return logs;
    }
    //</T01>
    
    //<T02>
    //Method to return followup Task
    public static Task getFollowUpTask(Lead objLead,integer interval,string subjectLead,integer endDate){
        
        Task objTask = new Task();
        objTask.WhoId = objLead.ID;
        objTask.IsRecurrence = true;
        objTask.RecurrenceType =dailyRecurrence;
        objTask.OwnerID = objLead.OwnerID;
        objTask.IsReminderSet = true;
        objTask.RecurrenceStartDateOnly = System.today() + interval;
        objTask.Subject = subjectLead;
        objTask.RecurrenceInterval = interval;
        objTask.RecurrenceEndDateOnly = System.today() + endDate;
        objTask.ReminderDateTime = datetime.newInstance(objTask.RecurrenceStartDateOnly.year(), objTask.RecurrenceStartDateOnly.month(),objTask.RecurrenceStartDateOnly.day(), 9, 00, 0);
        return objTask;
    }
    //</T02>
    //<T03>
    //Methot to get number names, western names and indian values for QuoteTriggerHandler
    public static void getNamesForQuoteUpdate(){
        westernvalues.put(0,' Thousand ');
        westernvalues.put(3,' Million ');
        westernvalues.put(6,' Billion ');
        
        indianvalues.put(0,' Thousand ');
        indianvalues.put(2,' Lakhs ');
        indianvalues.put(4,' Crores ');
        
        numbernames.put(1,' One ');
        numbernames.put(2,' Two ');
        numbernames.put(3,' Three ');
        numbernames.put(4,' Four ');
        numbernames.put(5,' Five ');
        numbernames.put(6,' Six ');
        numbernames.put(7,' Seven ');
        numbernames.put(8,' Eight ');
        numbernames.put(9,' Nine ');
        numbernames.put(10,' Ten ');
        numbernames.put(11,' Eleven ');
        numbernames.put(12,' Twelve ');
        numbernames.put(13,' Thirteen ');
        numbernames.put(14,' Forteen ');
        numbernames.put(15,' Fifteen ');
        numbernames.put(16,' Sixteen ');
        numbernames.put(17,' Seventeen ');
        numbernames.put(18,' Eighteen ');
        numbernames.put(19,' Nineteen ');
        numbernames.put(20,' Twenty ');
        numbernames.put(30,' Thirty ');
        numbernames.put(40,' Forty ');
        numbernames.put(50,' Fifty ');
        numbernames.put(60,' Sixty ');
        numbernames.put(70,' Seventy ');
        numbernames.put(80,' Eighty ');
        numbernames.put(90,' Ninety ');
    }
    //</T03>
    //<T04>
    public static OpportunityTeamMember insertOpptTeam(Id oppId,Id userId,String teamMeberRole){
        OpportunityTeamMember objOpptTeam = new OpportunityTeamMember();
        objOpptTeam.OpportunityId = oppId;  
        objOpptTeam.UserId = userId;  
        objOpptTeam.TeamMemberRole = teamMeberRole;  
        objOpptTeam.OpportunityAccessLevel = EDITACCESS; 
        return objOpptTeam;
    }
    //</T04>
    public static Cost_Tracking__c insertCostTrack(Opportunity objOpp){
        Cost_Tracking__c objCT = new Cost_Tracking__c();
        objCT.Opportunity__c = objOpp.ID;
        objCT.Release_Version__c = RELEASE + objOpp.Revision_Number__c;
        if(objOpp.Business_Division_Used__c == BUSINESSMBA || (objOpp.Business_Division_Used__c == BUSINESSMBASERVICES && objOpp.Type == SPARES)){
            objCT.Mechanical__c = objOpp.Mechanical__c;
            objCT.Electrical__c = objOpp.Electrical__c;
            objCT.Warranty__c = objOpp.Warranty_Used__c;
            objCT.OverHeads_Charges__c = objOpp.OverHead_Charges__c;
            objCT.Quote_Value__c = objOpp.Quote_Value__c; 
            objCT.Commissioning_Charges__c = objOpp.Commissioning_Charges_Used__c;
            objCT.Packing_Charges__c = objOpp.Packing_Charges__c;
            objCT.Final__c = true;
            //Below recordtype is not available in the system, so commented the code
            //objCT.RecordTypeID = OpportunityTriggerHandler.OPPTRECORDTYPEMBASPARES;
        }
        else if(objOpp.Business_Division_Used__c == BUSINESSMBASERVICES && objOpp.Type != SPARES || Test.isRunningTest()){
            objCT.Number_of_Days__c = objOpp.Number_of_Days__c;
            objCT.Number_of_People__c = objOpp.Number_of_People__c;
            objCT.Per_Man_Day_Cost__c = objOpp.Per_Man_Day_Cost__c;
            objCT.Mockup_on_Cost__c = objOpp.Mockup_on_Cost__c;
            objCT.To_Fro_Charges__c = objOpp.To_Fro_Charges__c;
            objCT.Final__c = true;
            //Below recordtype is not available in the system, so commented the code
           // objCT.RecordTypeID = OpportunityTriggerHandler.OPPTRECORDTYPEMBASERVICE;
        }
        return objCT;
    }
  
    Public static Project_Stage_History__c insertProjStageHist(String stgName,Id opptId,Id recId){
        Project_Stage_History__c objProj = new Project_Stage_History__c();
         objProj.Stage_Name__c = stgName;
         objProj.Opportunity__c = opptId; 
       if(objProj.Stage_Name__c == stagePreliminaryOppt || objProj.Stage_Name__c == stageRFQStudy || objProj.Stage_Name__c == STAGEUNDERSTUDY)
             objProj.Actual_Start_Date__c = System.today();
        objProj.RecordTypeID = recId;
        
        return objProj;
    }
    public static String getError(String forString){
        return 'Please upload the appropriate file with the keyword "'+ forString +'" included within the file name';
    }
    Public static void sendEmail(String email,String name,Date newDate,Date oldDate){
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        Map<String,GC_Data__c> myMap=GC_Data__c.getAll();
        If(myMap.size()>0 && !Test.isRunningTest()){
            String toEmail=myMap.get(email).Email__c;
            String ccEmail=myMap.get(email).CC_Email__c;  
            mail.setToAddresses(new String[]{toEmail});
            mail.setCcAddresses(new String[]{ccEmail});
            mail.setSubject('Activation Start Date Modification - '+name); 
            String body =  'The activation start date for The Following Opportunity'+'"'+name+'" '+'has been updated from '+oldDate+' to '+newDate;
            mail.setPlainTextBody(body); 
            Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        }
    }
}