public class TitanMBA_WinlossDashboard {
      
       //variables used for final caluclation
        public List<decimal> proposalChartDivision1{get;set;}
        public List<decimal> proposalChartDivision2{get;set;}
        public List<decimal> ExistingChartDivision1{get;set;}
        public List<decimal> ExistingChartDivision2{get;set;}
        public List<decimal> NewChartDivision1{get;set;}
        public List<decimal> NewChartDivision2{get;set;}
        public List<decimal> ExportChartDivision1{get;set;}
        public List<decimal> ExportChartDivision2{get;set;}
        public List<decimal> DomesticChartDivision1{get;set;}
        public List<decimal> DomesticChartDivision2{get;set;}
      //variables used for picklists
        public List<selectoption> industryOption{get;set;}
        public List<selectoption> accountNameOption{get;set;}
        public List<Selectoption> monthSelectedFilter{get;set;}
    
        //variables used in dependent picklist
      public String accountQueryString{get;set;}
      public String monthSelected{get;set;}
      public Date fromDate{get;set;}
      public Date toDate{get;set;}
      public String selectedAccountName{get;set;}
      public string selectedIndustry{get;set;}
      Id AccountRecordTypeId1;
	  Id AccountRecordTypeId2;
      Id AccountRecordTypeId3;
      Id AccountRecordTypeId4;

       //collection variables used in the code
       public List<Account> accountData{get;set;}
       public Map<id,String> holdRecordType{get;set;}
       public set<String> forOppStages{Get;set;}
       public set<id> OpportunityIds{get;set;}
       public List<Quote> QuoteData{get;set;} 
       public List<String> holdPropsal{Get;set;}
      //variables used in caluclation
       public decimal opportunityonHold{get;set;}
      public decimal opportunityStillActive{get;set;}
      public decimal opportunityReasonLostonCost{get;set;}  
      public decimal opportunityShelved{get;set;}
      public decimal opportunityOrderWon{get;set;}
      public decimal opportunityRegret{get;set;}
      public decimal opportunityStrageticReason{get;set;}
      public decimal opportunityLeadTime{get;set;}
      public decimal opportunityAwardedPO{get;set;}
      public decimal opportunityQuoteSubmitted{get;set;}
     //variables for proposal chart
       public decimal psub010{get;set;}
       public decimal psub1050{get;set;}  
       public decimal psub50150{Get;set;}
         public decimal psub150300{get;set;}
         public decimal psub300700{get;set;}
         public decimal psub700{get;set;}
       public decimal psubtotal{get;set;}
         public decimal pwon010{Get;set;}
         public decimal pwon1050{Get;set;}
         public decimal pwon50150{get;set;}
         public decimal pwon150300{get;set;}
         public decimal pwon300700{get;set;}
         public decimal pwon700{Get;set;}
       public decimal pwontotal{Get;set;}
       //variables for   proposal chart for no.of.projects
         public decimal ptot010{get;set;}
       public decimal ptot1050{get;set;}  
       public decimal ptot50150{Get;set;}
         public decimal ptot150300{get;set;}
         public decimal ptot300700{get;set;}
         public decimal ptot700{get;set;}
       public decimal ptottotal{get;set;}
       
        public decimal pwontot010{Get;set;}
         public decimal pwontot1050{Get;set;}
         public decimal pwontot50150{get;set;}
         public decimal pwontot150300{get;set;}
         public decimal pwontot300700{get;set;}
         public decimal pwontot700{Get;set;}
       public decimal pwontottotal{Get;set;}
    //variables for Existing Customers
     
        public decimal ExCust010{get;set;}
        public decimal ExCust1050{get;set;}
        public decimal ExCust50150{Get;set;}
        public decimal ExCust150300{get;set;}
        public decimal ExCust300700{get;set;}
        public decimal ExCust700{get;set;}
        public decimal ExCustTotal{get;set;}
     
        public decimal ExWon010{get;set;}
        public decimal ExWon1050{get;set;}
        public decimal ExWon50150{get;set;}
        public decimal ExWon151300{get;set;}
        public decimal ExWon300700{Get;set;}
        public decimal ExWon700{Get;set;}
        public decimal ExWonTotal{get;set;} 
    
        public decimal Extot010{get;set;}
        public decimal Extot1050{get;set;}
        public decimal Extot50150{Get;set;}
        public decimal Extot150300{get;set;}
        public decimal Extot300700{get;set;}
        public decimal Extot700{get;set;}
        public decimal ExtotTotal{get;set;}
    
        public decimal ExWontot010{get;set;}
        public decimal ExWontot1050{get;set;}
        public decimal ExWontot50150{get;set;}
        public decimal ExWontot151300{get;set;}
        public decimal ExWontot300700{Get;set;}
        public decimal ExWontot700{Get;set;}
        public decimal ExWontotTotal{get;set;}
       //variables for New Customers
        public decimal new010{get;set;}
        public decimal new1050{Get;set;}
        public decimal new50150{get;set;}
        public decimal new150300{get;set;}
        public decimal new300700{get;set;}
        public decimal new700{get;set;}
        public decimal newtotal{get;set;}
        
        public decimal newWon010{get;set;}
        public decimal newWon1050{get;set;}
        public decimal newWon50150{get;set;}
        public decimal newWon150300{Get;set;}
        public decimal newwon300700{get;set;}
        public decimal newWon700{get;set;}
        public decimal newWonTot{get;set;}
        
        public decimal newtot010{get;set;}
        public decimal newtot1050{Get;set;}
        public decimal newtot50150{Get;set;}
        public decimal newtot150300{Get;set;}
        public decimal newtot300700{get;set;}
        public decimal newtot700{get;set;}
        public decimal newtottotal{Get;set;}
        
        public decimal newWontot010{get;set;}
        public decimal newwontot1050{get;set;}
        public decimal newWontot50150{get;set;}
        public decimal newWontot150300{get;set;}
        public decimal newWontot300700{get;set;}
        public decimal newWontot700{get;set;}
        public decimal newWontottotal{Get;set;}
    //  variables for Export Customers 
        public decimal exp010{get;set;}
        public decimal exp1050{Get;set;}
        public decimal exp50150{get;set;}
        public decimal exp150300{get;set;}
        public decimal exp300700{get;set;}
        public decimal exp700{get;set;}
        public decimal exptotal{get;set;}
        
        public decimal expWon010{get;set;}
        public decimal expWon1050{get;set;}
        public decimal expWon50150{get;set;}
        public decimal expWon150300{Get;set;}
        public decimal expwon300700{get;set;}
        public decimal expWon700{get;set;}
        public decimal expWonTot{get;set;}
        
        public decimal exptot010{get;set;}
        public decimal exptot1050{Get;set;}
        public decimal exptot50150{Get;set;}
        public decimal exptot150300{Get;set;}
        public decimal exptot300700{get;set;}
        public decimal exptot700{get;set;}
        public decimal exptottotal{Get;set;}
        
        public decimal expWontot010{get;set;}
        public decimal expwontot1050{get;set;}
        public decimal expWontot50150{get;set;}
        public decimal expWontot150300{get;set;}
        public decimal expWontot300700{get;set;}
        public decimal expWontot700{get;set;}
        public decimal expWontottotal{Get;set;}
      //variables for Domestic Customers
      public decimal Dom010{get;set;}
public decimal Dom1050{Get;set;}
public decimal Dom50150{get;set;}
public decimal Dom150300{get;set;}
public decimal Dom300700{get;set;}
public decimal Dom700{get;set;}
public decimal Domtotal{get;set;}

public decimal DomWon010{get;set;}
public decimal DomWon1050{get;set;}
public decimal DomWon50150{get;set;}
public decimal DomWon150300{Get;set;}
public decimal Domwon300700{get;set;}
public decimal DomWon700{get;set;}
public decimal DomWonTot{get;set;}

public decimal Domtot010{get;set;}
public decimal Domtot1050{Get;set;}
public decimal Domtot50150{Get;set;}
public decimal Domtot150300{Get;set;}
public decimal Domtot300700{get;set;}
public decimal Domtot700{get;set;}
public decimal Domtottotal{Get;set;}

public decimal DomWontot010{get;set;}
public decimal Domwontot1050{get;set;}
public decimal DomWontot50150{get;set;}
public decimal DomWontot150300{get;set;}
public decimal DomWontot300700{get;set;}
public decimal DomWontot700{get;set;}
public decimal DomWontottotal{Get;set;}
            
      //variables of wrapper classes
        public List<wrapper> Report1{get;set;}
        public List<wrapper> Report2{get;set;}
    public List<wrapper> Report3{get;set;}
      public List<wrapper> Report4{get;set;}
      public List<wrapper> Report5{get;set;}
      public List<wrapper> Report6{get;set;}
      public List<wrapper> Report7{get;set;}
      public List<wrapper> Report8{get;set;}
      public List<wrapper> Report9{get;set;}
       public List<wrapper> Report10{get;set;}
      public List<wrapper> Report11{get;set;}
      Public List<decimal> Reporta2{get;set;}
        public List<String> NamesForStage{get;set;}
        public String convertedJson{get;set;}
        public String bindReportOne{get;set;}
        public String bindReportTwo{get;set;}
        public string holdPropsalString{Get;set;} 
        public string convertedJSON1{get;set;}
      public string convertedJSON2{get;set;}
      public string convertedJSON3{Get;set;}
      public String convertedJSON4{get;set;}
      public String convertedJSON5{get;set;}
      public String convertedJSON6{Get;set;}
      public String convertedJSON7{get;set;}
      public String convertedJSON8{get;set;}
      public String convertedJSON9{Get;set;}
      public String convertedJSON10{Get;set;}
      public string convertedJSONPer1 {get;set;}
      
        public List<decimal> holdDecimalValues{get;set;}
        public List<decimal> holdProposalValues{Get;set;}
        public List<decimal> holdProposalwonValues{get;set;}
      public List<decimal> holdtotProposalValues{get;set;}
      public List<decimal> hodtotProposalwonValues{get;set;}
        public List<decimal> ExistingProposalValues{get;set;}
        public List<decimal> ExistingProposalWonvalues{get;set;}
        public List<decimal> ExistingProposalTotals{get;set;}
        public List<decimal> ExistingProposalWonTotals{get;set;}
      public List<decimal> newProposalValues{get;set;}
      public List<decimal> newProposalWonValues{get;set;}
        public List<decimal> newProposalTotals{get;set;}
        public List<decimal> newProposalWontotals{Get;set;}
      public List<decimal> ExportProposalValues{get;set;}
      public List<decimal> ExportProposalWonValues{get;set;}
      public List<decimal> ExportProposalTotal{get;set;}
      public List<decimal> ExportProposalWonTotal{Get;set;}
        public List<decimal> DomesticProposalValues{get;set;}
      public List<decimal> DomesticProposalWonValues{get;set;}
      public List<decimal> DomesticProposalTotal{get;set;}
      public List<decimal> DomesticProposalWonTotal{Get;set;}
        
    public class wrapper
    {
        public string name{get;set;}
        public List<decimal> data{get;set;}
         public wrapper()
        {
            name=null;
            data=new List<decimal>();
        }
    }
    //constructor of main class
    public TitanMBA_WinlossDashboard()
    {
               
               //intialization of newly created data
               proposalChartDivision1=new List<decimal>();
               proposalchartDivision2=new List<decimal>();
               ExistingChartDivision1=new List<decimal>();
               ExistingChartDivision2=new List<decimal>();
               NewChartDivision1=new List<decimal>();
               NewchartDivision2=new List<decimal>();
               ExportChartDivision1=new List<decimal>();
               ExportChartDivision2=new List<decimal>();
               DomesticChartDivision1=new List<decimal>();
               DomesticChartDivision2=new List<decimal>();
        
              //intitalization of all variables 
              
               accountQueryString=null;
             monthSelected=null;
               fromDate=null;
             toDate=null;
             AccountRecordTypeId1=null;
			 AccountRecordTypeId2=null;
             AccountRecordTypeId3=null;
             AccountRecordTypeId4=null;

             selectedIndustry=null;
             selectedAccountName=null;  
            //collection variables intialization
            ExportProposalValues=new List<decimal>();
          ExportProposalWonValues=new List<decimal>();
          ExportProposalTotal=new List<decimal>();
          ExportProposalWonTotal=new List<decimal>();
            newProposalValues=new List<decimal>();
        newProposalWonValues=new List<decimal>();
          newProposalTotals=new List<decimal>();
          newProposalWontotals=new List<decimal>();
            ExistingProposalValues=new List<Decimal>();
            ExistingProposalWonvalues=new List<Decimal>();
          ExistingProposalTotals=new List<decimal>();
          ExistingProposalWonTotals=new List<decimal>();
      holdtotProposalValues=new List<decimal>();
      hodtotProposalwonValues=new List<decimal>();
            holdProposalValues=new List<decimal>();
            holdProposalwonValues=new List<decimal>();
            accountData=new List<Account>();
            holdRecordType=new Map<id,String>();
            NamesForStage=new List<String>();
            OpportunityIds=new set<id>();
            forOppStages=new set<String>();
            QuoteData=new List<Quote>();
              holdPropsal=new List<string>(); 
              //From here the dependent functionality starts
              industryOption=new List<selectoption>();
              accountNameOption=new List<selectoption>();
              monthSelectedFilter=new List<selectoption>();
             //intialization of wrapper Filters
             Report1=new List<wrapper>();
             Report2=new List<wrapper>();
       Report3=new List<wrapper>();
           Report4=new List<wrapper>();
           Report5=new List<wrapper>();
           Report6=new List<wrapper>();
           Report7=new List<wrapper>();
           Report8=new List<wrapper>();
          Report9=new List<wrapper>();
          Report10=new List<Wrapper>();
          Report11=new List<wrapper>();
          Reporta2 = new List<decimal>();
           NamesForStage=new List<String>();
           convertedJSON=null;
           //holdDecimalValues=new List<decimal>();
           bindReportOne=null;
             //holding Industry Data For Industry Filter
              industryOption.add(new selectoption('None','None'));
              industryOption.add(new selectoption('Automotive','Automotive'));
              industryOption.add(new selectoption('Non-Automotive','Non-Automotive'));
              industryOption.add(new selectoption('Both','Both'));
            //holding Account Filter
              accountNameOption.add(new selectoption('None','None'));
              //This will by default holds all Account Names
              for(Account a:[select id,name from account where RecordType.name='MBA' Order By createdDate DESC LIMIT 999])
              {
                accountNameOption.add(new selectoption(a.name,a.name)); 
              }
               //This Filter will select the duration such as current FY,Previous FY,Last Month,This Month
                monthSelectedFilter=new List<selectoption>();
                monthSelectedFilter.add(new selectoption('0','Select'));
                monthSelectedFilter.add(new selectoption('1','Current FY'));
                monthSelectedFilter.add(new selectoption('2','Previous FY'));
                monthSelectedFilter.add(new selectoption('3','Current FQ'));
                monthSelectedFilter.add(new selectoption('4','Previous FQ'));
                monthSelectedFilter.add(new selectoption('5','This Month'));
                monthSelectedFilter.add(new selectoption('6','Last Month'));
            //holding data of record types
           AccountRecordTypeId1=[select id,name from RecordType where sobjecttype='Account' and recordType.name='MBA'].id;
		   AccountRecordTypeId2=[select id,name from RecordType where sobjecttype='Account' and recordType.name='Consultant_MBA'].id;
		   AccountRecordTypeId3=[select id,name from RecordType where sobjecttype='Account' and recordType.name='Prospect_MBA'].id;
           AccountRecordTypeId4=[select id,name from RecordType where sobjecttype='Account' and recordType.name='Suspect_MBA'].id;

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
    public void runReportChart()
    {
         opportunityonHold=0;
           opportunityStillActive=0;
           opportunityReasonLostonCost=0;  
           opportunityShelved=0;
           opportunityOrderWon=0;
           opportunityRegret=0;
           opportunityStrageticReason=0;
           opportunityLeadTime=0;
           opportunityAwardedPO=0;
           opportunityQuoteSubmitted=0;
               
               psub010=0;
                 psub1050=0;  
                 psub50150=0;
                 psub150300=0;
                 psub300700=0;
                 psub700=0;
                 psubtotal=0;
                 
                 pwon010=0;
             pwon1050=0;
             pwon50150=0;
             pwon150300=0;
             pwon300700=0;
               pwon700=0;
             pwontotal=0;
         
              ptot010=0;
                 ptot1050=0;  
                 ptot50150=0;
                 ptot150300=0;
                 ptot300700=0;
                 ptot700=0;
                 ptottotal=0;
         
                    pwontot010=0;
             pwontot1050=0;
             pwontot50150=0;
             pwontot150300=0;
             pwontot300700=0;
               pwontot700=0;
             pwontottotal=0;
            //INTIALIZATION OF EXISTING CUSTOMER VARIABLES
             ExCust010=0;
      ExCust1050=0;
      ExCust50150=0;
      ExCust150300=0;
      ExCust300700=0;
      ExCust700=0;
      ExCustTotal=0;
        
            Exwon010=0;
      Exwon1050=0;
      ExWon50150=0;
      Exwon151300=0;
      Exwon300700=0;
      Exwon700=0;
      ExWontotal=0;
        
            Extot010=0;
      Extot1050=0;
      Extot50150=0;
      Extot150300=0;
      Extot300700=0;
      Extot700=0;
      ExtotTotal=0;
         
            Exwontot010=0;
      Exwontot1050=0;
      ExWontot50150=0;
      Exwontot151300=0;
      Exwontot300700=0;
      Exwontot700=0;
      ExWontottotal=0;
            //intialization of new variables
            new010=0;
            new1050=0;
            new50150=0;
            new150300=0;
            new300700=0;
            new700=0;
            newtotal=0;
            
            newWon010=0;
            newWon1050=0;
            newWon50150=0;
            newWon150300=0;
            newWon300700=0;
            newWon700=0;
            newWontot=0;
            
            newtot010=0;
            newtot1050=0;
            newtot50150=0;
            newtot150300=0;
            newtot300700=0;
            newtot700=0;
            newtottotal=0;
            
            newWontot010=0;
            newwontot1050=0;
            newWontot50150=0;
            newwontot150300=0;
            newwontot300700=0;
            newWontot700=0;
            newWontottotal=0;
            //intialization of export variables
            exp010=0;
exp1050=0;
exp50150=0;
exp150300=0;
exp300700=0;
exp700=0;
exptotal=0;

expWon010=0;
expWon1050=0;
expWon50150=0;
expWon150300=0;
expWon300700=0;
expWon700=0;
expWontot=0;

exptot010=0;
exptot1050=0;
exptot50150=0;
exptot150300=0;
exptot300700=0;
exptot700=0;
exptottotal=0;

expWontot010=0;
expwontot1050=0;
expWontot50150=0;
expwontot150300=0;
expwontot300700=0;
expWontot700=0;
expWontottotal=0;
//intialization of Domestic variables
Dom010=0;
Dom1050=0;
Dom50150=0;
Dom150300=0;
Dom300700=0;
Dom700=0;
Domtotal=0;

DomWon010=0;
DomWon1050=0;
DomWon50150=0;
DomWon150300=0;
DomWon300700=0;
DomWon700=0;
DomWontot=0;

Domtot010=0;
Domtot1050=0;
Domtot50150=0;
Domtot150300=0;
Domtot300700=0;
Domtot700=0;
Domtottotal=0;

DomWontot010=0;
Domwontot1050=0;
DomWontot50150=0;
Domwontot150300=0;
Domwontot300700=0;
DomWontot700=0;
DomWontottotal=0;        
        //variable intialzation end
              QuoteData.clear();
            OpportunityIds.clear();
              ExportProposalValues.clear();
          ExportProposalWonValues.clear();
          ExportProposalTotal.clear();
          ExportProposalWonTotal.clear();
            newProposalValues.clear();
        newProposalWonValues.clear();
          newProposalTotals.clear();
          newProposalWontotals.clear();
            ExistingProposalValues.clear();
            ExistingProposalWonvalues.clear();
          ExistingProposalTotals.clear();
          ExistingProposalWonTotals.clear();
      holdtotProposalValues.clear();
      hodtotProposalwonValues.clear();
            holdProposalValues.clear();
            holdProposalwonValues.clear();
        //new changes
        proposalChartDivision1.clear();
        proposalChartDivision2.clear();
        ExistingChartDivision1.clear();
        ExistingChartDivision2.clear();
        NewChartDivision1.clear();
        NewChartDivision2.clear();
        ExportChartDivision1.clear();
        ExportChartDivision2.clear();
        DomesticChartDivision1.clear();
        DomesticChartDivision2.clear();
        //valid changes
        
          Report1.clear();
          Report2.clear();
          Report3.clear();
      Report4.clear();
      report5.clear();
      Report6.clear();
      Report7.clear();
      Report8.clear();
          Report9.clear();
          Report10.clear();
          Reporta2.clear();
        
       // variables cleaning
       ExportProposalValues.clear();
       // variable cleaning ends here 
          if((monthSelected!=null&&monthSelected!='0')&&(fromdate==null||todate==null)&&(selectedIndustry==null||selectedIndustry=='None')&&(selectedAccountName==null||selectedAccountName=='None'))
            {
               
                System.debug('---Filter(1)--->'+monthSelected);
                QuoteData=(monthSelected=='1')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=THIS_FISCAL_YEAR]):(monthSelected=='2')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=LAST_FISCAL_YEAR]):(monthSelected=='3')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and Opportunity.First_Quote_Created_Date__c=THIS_FISCAL_QUARTER]):(monthSelected=='4')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=LAST_FISCAL_QUARTER]):(monthSelected=='5')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=THIS_MONTH]):(monthSelected=='6')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=LAST_MONTH ]):null;  
                //System.debug('OppQuoteDatawillReturn='+QuoteData.size()); 
            }
        //checking for the second condition
          System.debug('From Date selected='+fromdate);
           System.debug('To Date selected='+todate);
            if((fromdate!=null&&todate!=null)&&(monthSelected==null||monthSelected=='0')&&(selectedIndustry==null||selectedIndustry=='None')&&
      (selectedAccountName==null||selectedAccountName=='None'))
            { 
                System.debug('Filter-2 for from and month selected');
                QuoteData=[select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c>=:fromDate and Opportunity.First_Quote_Created_Date__c<=:toDate];
              System.debug('Quotedata='+QuoteData);
            }
       //checking for the third condition
        if((selectedIndustry!=null&&selectedIndustry!='None')&&(monthSelected==null||monthSelected=='0')&&(selectedAccountName==null||selectedAccountName=='None')&&(fromdate==null||todate==null))
    {
  System.debug('Iam in Third Filter---3');
  
  QuoteData=(selectedIndustry=='Automotive')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=THIS_FISCAL_YEAR and opportunity.Account.industry='Automotive' ]):(selectedIndustry=='Non-Automotive')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=THIS_FISCAL_YEAR and Opportunity.Account.industry!='Automotive' and Opportunity.Account.industry!=null]):(selectedIndustry=='Both')?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=THIS_FISCAL_YEAR  and Opportunity.Account.industry!=null]):null;
    }  
      //checking for fourth condition
        //4.) check with only Account Name
         if((selectedIndustry==null||selectedIndustry=='None')&&(selectedAccountName!=null&&selectedAccountName!='None')&&(monthSelected=='None'||monthSelected=='0')&&(fromdate==null||todate==null))
        {
               System.debug('*********selectedIndustry(4)**********'+selectedIndustry);
             System.debug('*********selectedIndustry(4)**********'+monthSelected);
             System.debug('*********selectedIndustry(4)**********'+selectedAccountName);
              QuoteData = [select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c=THIS_FISCAL_YEAR  AND  Opportunity.Account.name=:selectedAccountName];
        }  
       //checking for fifth condition
       
    if((selectedIndustry!='None'&&selectedIndustry!=null)&&(selectedAccountName==null||selectedAccountName=='None')&&(monthSelected!=null&&monthSelected!='0'))
      {
         System.debug('Checking from**(5)**Fifth filter'); 
    QuoteData=(selectedIndustry=='Automotive'&&monthSelected=='1')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_YEAR and Opportunity.Account.industry='Automotive']):(selectedIndustry=='Non-Automotive'&&monthSelected=='1')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_YEAR and Opportunity.Account.industry!='Automotive']):(selectedIndustry=='Both'&&monthSelected=='1')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_YEAR and Opportunity.Account.industry!=null]):(selectedIndustry=='Automotive'&&monthSelected=='2')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_YEAR and Opportunity.Account.industry='Automotive']):(selectedIndustry=='Non-Automotive'&&monthSelected=='2')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_YEAR and Opportunity.Account.industry!='Automotive']):(selectedIndustry=='Both'&&monthSelected=='2')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_YEAR and Opportunity.Account.industry!=null]):(selectedIndustry=='Automotive'&&monthSelected=='3')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_QUARTER and Opportunity.Account.industry='Automotive']):(selectedIndustry=='Non-Automotive'&&monthSelected=='3')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_QUARTER and Opportunity.Account.industry!='Automotive']):(selectedIndustry=='Both'&&monthSelected=='3')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_QUARTER and Opportunity.Account.industry!=null]):(selectedIndustry=='Automotive'&&monthSelected=='4')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_QUARTER and Opportunity.Account.industry='Automotive']):(selectedIndustry=='Non-Automotive'&&monthSelected=='4')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_QUARTER and Opportunity.Account.industry!='Automotive']):(selectedIndustry=='Both'&&monthSelected=='4')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_QUARTER and Opportunity.Account.industry!=null]):(selectedIndustry=='Automotive'&&monthSelected=='5')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_MONTH and Opportunity.Account.industry='Automotive']):(selectedIndustry=='Non-Automotive'&&monthSelected=='5')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_MONTH and Opportunity.Account.industry!='Automotive']):(selectedIndustry=='Both'&&monthSelected=='5')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_MONTH and Opportunity.Account.industry!=null]):(selectedIndustry=='Automotive'&&monthSelected=='6')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_MONTH and Opportunity.Account.industry='Automotive']):(selectedIndustry=='Non-Automotive'&&monthSelected=='6')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_MONTH and Opportunity.Account.industry!='Automotive']):(selectedIndustry=='Both'&&monthSelected=='6')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_MONTH and Opportunity.Account.industry!=null]):null;
    }
         //checking here with industry with from and to dates in 6 th filter
      if((selectedIndustry!=null&&selectedIndustry!='None')&&(monthSelected==null||monthSelected=='0')&&(selectedAccountName==null||selectedAccountName=='None')&&(fromdate!=null&&todate!=null))
    {
        System.debug('checking where for(6) filter');
        QuoteData=(selectedIndustry=='Automotive'&&(fromdate!=null&&todate!=null))?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c>=:fromdate and  Opportunity.First_Quote_Created_Date__c<=:todate and Opportunity.Account.industry='Automotive']):(selectedIndustry=='Non-Automotive'&&(fromdate!=null&&todate!=null))?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c>=:fromdate and  Opportunity.First_Quote_Created_Date__c<=:todate and Opportunity.Account.industry!='Automotive']):(selectedIndustry=='Both'&&(fromdate!=null&&todate!=null))?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c>=:fromdate and  Opportunity.First_Quote_Created_Date__c<=:todate and Opportunity.Account.industry!=null]):null;
    }

        
        //checking here for seventh condition
       if((monthSelected!=null&&monthSelected!='0')&&(selectedAccountName!=null&&selectedAccountName!='None')&&(selectedIndustry==null||selectedIndustry=='None')&&(fromdate==null||todate==null))
    {
            System.debug('Iam in 7th filter');
            QuoteData=(monthSelected=='1'&&(selectedAccountName!=null))?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=THIS_FISCAL_YEAR and Opportunity.Account.name=:selectedAccountName ]):(monthSelected=='2'&&(selectedAccountName!=null))?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=LAST_FISCAL_YEAR and Opportunity.Account.name=:selectedAccountName ]):(monthSelected=='3'&&(selectedAccountName!=null))?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=THIS_FISCAL_QUARTER and Opportunity.Account.name=:selectedAccountName ]):(monthSelected=='4'&&(selectedAccountName!=null))?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=LAST_FISCAL_QUARTER and Opportunity.Account.name=:selectedAccountName ]):(monthSelected=='5'&&(selectedAccountName!=null))?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=THIS_MONTH and Opportunity.Account.name=:selectedAccountName ]):(monthSelected=='6'&&(selectedAccountName!=null))?([select id,OpportunityID,createddate,Opportunity.First_Quote_Created_Date__c from Quote where Is_Synched__c='Yes' and (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) and  Opportunity.First_Quote_Created_Date__c=LAST_MONTH and Opportunity.Account.name=:selectedAccountName ]):null;
        }
        //checking for eigth condition
         if((monthSelected==null||monthSelected=='0')&&(selectedAccountName!=null&&selectedAccountName!='None')&&(selectedIndustry==null||selectedIndustry=='None')&&(fromdate!=null&&todate!=null))
    {
            System.debug('Iam in Eigth Filter');
           QuoteData=[select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c>=:fromdate and  Opportunity.First_Quote_Created_Date__c<=:todate and Opportunity.Account.name=:selectedAccountName];
        }
                //checking here for ninth filter
                if((selectedIndustry!=null&&selectedIndustry!='None')&&(selectedAccountName!=null&&selectedAccountName!='None')&&(fromdate==null||todate==null)&&(monthSelected!=null&&monthSelected!='0'))
    {
            System.debug('((((((((((ninth)))))))))))');
      QuoteData=(selectedIndustry=='Automotive'&&monthSelected=='1')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_YEAR and Opportunity.Account.industry='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Non-Automotive'&&monthSelected=='1')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_YEAR and Opportunity.Account.industry!='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Both'&&monthSelected=='1')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_YEAR and Opportunity.Account.industry!=null and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Automotive'&&monthSelected=='2')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_YEAR and Opportunity.Account.industry='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Non-Automotive'&&monthSelected=='2')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_YEAR and Opportunity.Account.industry!='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Both'&&monthSelected=='2')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_YEAR and Opportunity.Account.industry!=null and opportunity.Account.name=:selectedAccountName]):(selectedIndustry=='Automotive'&&monthSelected=='3')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_QUARTER and Opportunity.Account.industry='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Non-Automotive'&&monthSelected=='3')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_QUARTER and Opportunity.Account.industry!='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Both'&&monthSelected=='3')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_FISCAL_QUARTER and Opportunity.Account.industry!=null and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Automotive'&&monthSelected=='4')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_QUARTER and Opportunity.Account.industry='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Non-Automotive'&&monthSelected=='4')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_QUARTER and Opportunity.Account.industry!='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Both'&&monthSelected=='4')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_FISCAL_QUARTER and Opportunity.Account.industry!=null and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Automotive'&&monthSelected=='5')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_MONTH and Opportunity.Account.industry='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Non-Automotive'&&monthSelected=='5')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_MONTH and Opportunity.Account.industry!='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Both'&&monthSelected=='5')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= THIS_MONTH and Opportunity.Account.industry!=null and opportunity.Account.name=:selectedAccountName]):(selectedIndustry=='Automotive'&&monthSelected=='6')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_MONTH and Opportunity.Account.industry='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Non-Automotive'&&monthSelected=='6')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_MONTH and Opportunity.Account.industry!='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Both'&&monthSelected=='6')?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.First_Quote_Created_Date__c= LAST_MONTH and Opportunity.Account.industry!=null and opportunity.Account.name=:selectedAccountName ]):null;
    }
  //checking for tenth filter
                
       if((selectedAccountName!=null&&selectedAccountName!='None')&&(selectedIndustry!=null&&selectedIndustry!='None')&&(monthSelected==null||monthSelected=='0')&&(fromdate==null||todate==null))
        {
            System.debug('Iam in tenth filter');
            QuoteData=(selectedIndustry=='Automotive'&&(selectedAccountName!=null))?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.Account.industry='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Non-Automotive'&&(selectedAccountName!=null))?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.Account.industry!='Automotive' and opportunity.Account.name=:selectedAccountName ]):(selectedIndustry=='Both'&&(selectedAccountName!=null))?([select OpportunityId,CreatedDate from Quote where Is_Synched__c =:'Yes' AND (Opportunity.Account.RecordTypeId=:AccountRecordTypeId1 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId2 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId3 or Opportunity.Account.RecordTypeId=:AccountRecordTypeId4) AND Opportunity.Account.industry!=null and opportunity.Account.name=:selectedAccountName ]):null;
        }        
        // holding the opportunity id's of the query records
         for(Quote q:QuoteData)
            {
                if(!holdRecordType.containsKey(q.OpportunityId))
                {
                OpportunityIds.add(q.opportunityId);
                }
            }    
           System.debug('Size of OpportunityIds='+OpportunityIds.size());
        //Actual Caluclation starts from here
         AggregateResult sr0=[select sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds  ];
         opportunityQuoteSubmitted=(decimal)sr0.get('s');
         opportunityQuoteSubmitted=(opportunityQuoteSubmitted==null?0.01:(opportunityQuoteSubmitted/100).SetScale(2));
         System.debug('opportunityQuoteSubmitted'+opportunityQuoteSubmitted);
       
         AggregateResult sr1=[select sum(Amount_In_Lakhs__c) s from Opportunity where stagename='Opportunity On Hold' and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds];
         opportunityonHold=(decimal)sr1.get('s');   
         opportunityonHold=((opportunityonHold==null||opportunityonHold==0)?0.01:(opportunityonHold/100).SetScale(2));
         System.debug('Opportunity on hold value='+opportunityonHold);
         
         AggregateResult sr2=[select sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Revised Quote Submission' or stagename='Await Customer Feedback(Quote Submitted)' or stagename='Under Negotiation' or stagename='Await Feedback (Under Negotiation)' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds];          
         opportunityStillActive=(decimal)sr2.get('s');
         opportunityStillActive=((opportunityStillActive==null||opportunityStillActive==0)?0.01:(opportunityStillActive/100).SetScale(2));
         System.debug('opportunityStillActive='+opportunityStillActive);
        
        AggregateResult sr3=[select sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds]; 
        opportunityOrderWon=(decimal)sr3.get('s');
        opportunityOrderWon=((opportunityOrderWon==null||opportunityOrderWon==0)?0.01:(opportunityOrderWon/100).SetScale(2));
        System.debug('Opportunity order won='+opportunityOrderWon);
        
         AggregateResult sr4=[select sum(Amount_In_Lakhs__c) s from Opportunity where stagename='Opportunity Lost' and Reason__c='Lost on cost' and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds ];
         opportunityReasonLostonCost=(decimal)sr4.get('s');
         opportunityReasonLostonCost=((opportunityReasonLostonCost==null||opportunityReasonLostonCost==0)?0.01:(opportunityReasonLostonCost/100).SetScale(2));
         System.debug('opportunityReasonLostonCost='+opportunityReasonLostonCost);
        
         AggregateResult sr5=[select sum(Amount_In_Lakhs__c) s from Opportunity where stagename='Opportunity Lost' and Reason__c='Lost on lead time' and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds];
         opportunityLeadTime=(decimal)sr5.get('s');
        opportunityLeadTime=((opportunityLeadTime==null||opportunityLeadTime==0)?0.01:(opportunityLeadTime/100).SetScale(2));     
         System.debug('opportunityLeadTime='+opportunityLeadTime);
        
         AggregateResult sr6=[select sum(Amount_In_Lakhs__c) s from Opportunity where stagename='Opportunity Lost' and Reason__c='Lost on strategic reason' and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds];
         opportunityStrageticReason=(decimal)sr6.get('s');
         opportunityStrageticReason=((opportunityStrageticReason==null||opportunityStrageticReason==0)?0.01:(opportunityStrageticReason/100).SetScale(2));
         System.debug('opportunityStrageticReason='+opportunityStrageticReason);
        
         AggregateResult sr7=[select sum(Amount_In_Lakhs__c) s from Opportunity where stagename='Opportunity Lost' and Reason__c='Regret' and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds]; 
         opportunityRegret=(decimal)sr7.get('s');
         opportunityRegret=((opportunityRegret==null||opportunityRegret==0)?0.01:(opportunityRegret/100).SetScale(2));   
         System.debug('opportunityRegret='+opportunityRegret);
         
         AggregateResult sr8=[select sum(Amount_In_Lakhs__c) s from Opportunity where stagename='Opportunity Lost' and Reason__c='Project Shelved' and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds]; 
         opportunityShelved=(decimal)sr8.get('s');
         opportunityShelved=((opportunityShelved==null||opportunityShelved==0)?0.01:(opportunityShelved/100).SetScale(2));
         System.debug('opportunityShelved='+opportunityShelved);    
         
         AggregateResult sr9=[select sum(Amount_In_Lakhs__c) s from opportunity where (stagename='Project Under Execution' or stagename='Order Won' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' or stagename='Opportunity Lost')  and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and Reason__c!='Project Shelved' ];
         opportunityAwardedPO=(decimal)sr9.get('s');
        opportunityAwardedPO=((opportunityAwardedPO==null||opportunityAwardedPO==0)?0.01:(opportunityAwardedPO/100).SetScale(2));
         System.debug('opportunityAwardedPO='+opportunityAwardedPO);
        
         //Aggreate result for proposal submitted chart
        
        AggregateResult sr10=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L'];
        psub010=(decimal)sr10.get('s');
        psub010=((psub010==null||psub010==0)?0.0001:psub010);
        ptot010=(decimal)sr10.get('i');
        ptot010=((ptot010==null||ptot010==0)?0.0001:ptot010);   
        
        AggregateResult sr11=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L'];
        psub1050=(decimal)sr11.get('s');
        psub1050=((psub1050==null||psub1050==0)?0.0001:psub1050); 
        ptot1050=(decimal)sr11.get('i');
        ptot1050=((ptot1050==null||ptot1050==0)?0.0001:ptot1050);
    
    AggregateResult sr12=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L'  ];
        psub50150=(decimal)sr12.get('s');
        psub50150=((psub50150==null||psub50150==0)?0.0001:psub50150); 
    ptot50150=(decimal)sr12.get('i');
    ptot50150=((ptot50150==null||ptot50150==0)?0.0001:ptot50150);
    
    AggregateResult sr13=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L'  ];
         psub150300=(decimal)sr13.get('s');
         psub150300=(( psub150300==null||psub150300==0)?0.0001: psub150300); 
         ptot150300=(decimal)sr13.get('i');
     ptot150300=((ptot150300==null||ptot150300==0)?0.0001:ptot150300);
     AggregateResult sr14=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L'  ];
         psub300700=(decimal)sr14.get('s');
         psub300700=( (psub300700==null||psub300700==0)?0.0001: psub300700); 
     ptot300700=(decimal)sr14.get('i');
     ptot300700=((ptot300700==null||ptot300700==0)?0.0001:ptot300700);
     
     AggregateResult sr15=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L'  ];
         psub700=(decimal)sr15.get('s');
         psub700=(( psub700==null||psub700==0)?0.0001: psub700);  
     ptot700=(decimal)sr15.get('i');
     ptot700=((ptot700==null||ptot700==0)?0.0001:ptot700);
     
     psubtotal=psub010+psub1050+psub50150+psub150300+psub300700+psub700;
     psubtotal=((psubtotal==null||psubtotal==0)?0.0001:psubtotal);
     ptottotal=ptot010+ptot1050+ptot50150+ptot150300+ptot300700+ptot700;
   ptottotal=((ptottotal==null||ptottotal==0)?0.0001:ptottotal);  
     
     //AggregateResult for proposal submitted with order won
      
      AggregateResult sr16=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L'  ];
          
          pwon010=(decimal)sr16.get('s');
          pwon010=((pwon010==null||pwon010==0)?0.0001:pwon010);      
          pwontot010=(decimal)sr16.get('i');
      pwontot010=((pwontot010==null||pwontot010==0)?0.0001:pwontot010);
        
           AggregateResult sr17=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L'  ];
               pwon1050=(decimal)sr17.get('s');
               pwon1050=( (pwon1050==null||pwon1050==0)?0.0001: pwon1050);
         pwontot1050=(decimal)sr17.get('i');
         pwontot1050=((pwontot1050==null||pwontot1050==0)?0.0001:pwontot1050);

        AggregateResult sr18=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' ];
        pwon50150=(decimal)sr18.get('s');
        pwon50150=(( pwon50150==null||pwon50150==0)?0.0001: pwon50150);
    pwontot50150=(decimal)sr18.get('i');
    pwontot50150=((pwontot50150==null||pwontot50150==0)?0.0001:pwontot50150);
         
         AggregateResult sr19=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L'  ];
         pwon150300=(decimal)sr19.get('s');
         pwon150300=( (pwon150300==null||pwon150300==0)?0.0001: pwon150300);
     pwontot150300=(decimal)sr19.get('i');
     pwontot150300=((pwontot150300==null||pwontot150300==0)?0.0001:pwontot150300);
        AggregateResult sr20=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L'  ];
         pwon300700=(decimal)sr20.get('s');
          pwon300700=( (pwon300700==null||pwon300700==0)?0.0001:  pwon300700);
         pwontot300700=(decimal)sr20.get('i');
     pwontot300700=((pwontot300700==null||pwontot300700==0)?0.0001:pwontot300700);
         AggregateResult sr21=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' ];
    
         pwon700=(decimal)sr21.get('s');
         pwon700=((pwon700==null||pwon700==0)?0.0001: pwon700);
     pwontot700=(decimal)sr21.get('i');
     pwontot700=((pwontot700==null||pwontot700==0)?0.0001:pwontot700);
         

         pwontotal=pwon010+pwon1050+pwon50150+pwon150300+pwon300700+pwon700;
         pwontotal=((pwontotal==null||pwontotal==0)?0.0001:pwontotal);
     
     ptottotal=ptot010+ptot1050+ptot50150+ptot150300+ptot300700+ptot700;
     ptottotal=((ptottotal==null||ptottotal==0)?0.0001:ptottotal);
     
     pwontottotal=pwontot010+pwontot1050+pwontot50150+pwontot150300+pwontot300700+pwontot700;
     pwontottotal=((pwontottotal==null||pwontottotal==0)?0.0001:pwontottotal);
     
       // this list is for holding the second dashboard data

           holdPropsal=new List<String>{'0-10L','10-50L','51-150L','151-350L','351-700L','700L','Total'};

           bindReportTwo=JSON.serializePretty(holdPropsal);
   
           holdProposalwonValues=new List<decimal>{pwon010,pwon1050,pwon50150,pwon150300,pwon300700,pwon700,pwontotal}; 

           holdProposalValues=new List<decimal>{psub010,psub1050,psub50150,psub150300,psub300700,psub700,psubtotal};
       
     //this list is for holding the third dashboard data
          holdtotProposalValues=new List<decimal>{ptot010,ptot1050,ptot50150,ptot150300,ptot300700,ptot700,ptottotal};
      hodtotProposalwonValues=new List<decimal>{pwontot010,pwontot1050,pwontot50150,pwontot150300,pwontot300700,pwontot700,pwontottotal};  
         
         // this list is holding the first dashboard data
           NamesForStage=new List<string>{'Quote Submitted','Still Active','Opportunity on Hold','Project Shelved','Awarded PO by Customer','Order Won','Lost on Cost','Lost on Lead Time','Lost on Strategic Reasons','Regret'};
          holdDecimalValues=new List<Decimal>{opportunityQuoteSubmitted,opportunityStillActive,opportunityonHold,opportunityShelved,opportunityAwardedPO,opportunityOrderWon,opportunityReasonLostonCost,opportunityLeadTime,opportunityStrageticReason,opportunityRegret};   
             
             
         bindReportOne=JSON.serializePretty(NamesForStage);
         System.debug('====>'+bindReportOne);
        
         holdPropsalString=JSON.serializePretty(holdPropsal);
         
        //instantiation for First Wrapper Report
        wrapper one=new wrapper();
        one.name='Opportunity Value';
        one.data=holdDecimalValues;
        Report1.add(one);
        convertedJSON=JSON.serializePretty(Report1);
        System.debug('***************'+convertedJSON);

        wrapper two=new wrapper();
        two.name='Proposal Submitted';
        two.data=holdProposalValues;
        Reporta2.addall(two.data);
        system.debug('***data**'+two.data);
        Report2.add(two);
        
        

        wrapper three=new wrapper();
        three.name='Order Won';
        three.data=holdProposalwonValues;
        system.debug('**third data**'+three.data);
        Report2.add(three);
        
        convertedJSON1=JSON.serializePretty(Report2);
    
    wrapper four=new wrapper();
    four.name='Proposal Submitted';
    four.data=holdtotProposalValues;
    Report3.add(four);
    wrapper five=new wrapper();
    five.name='Order Won';
    five.data=hodtotProposalwonValues;
    Report3.add(five);
    
    convertedJSON2=JSON.serializePretty(Report3);  
    
        //CALUCLATION OF EXISTING PROPOSALS
         AggregateResult sr22=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L' and Customer_Type__c='Existing Customer'];
         ExCust010=(decimal)sr22.get('s');
     ExCust010=((ExCust010==null||ExCust010==0)?0.0001:ExCust010);
         System.debug('Ei----->'+ExCust010);
          Extot010=(decimal)sr22.get('i');
     Extot010=((Extot010==null||Extot010==0)?0.0001:Extot010);
     
    AggregateResult sr23=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L' and Customer_Type__c='Existing Customer'];
     
         ExCust1050=(decimal)sr23.get('s');
     ExCust1050=((ExCust1050==null||ExCust1050==0)?0.0001:ExCust1050);
        System.debug('----------------'+ExCust1050);
     Extot1050=(decimal)sr23.get('i');
     Extot1050=((Extot1050==null||Extot1050==0)?0.0001:Extot1050);
     
    AggregateResult sr24=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' and Customer_Type__c='Existing Customer'];
       
       ExCust50150=(decimal)sr24.get('s');
       ExCust50150=((ExCust50150==null||ExCust50150==0)?0.0001:ExCust50150);
           System.debug('=====>'+ExCust50150);
       Extot50150=(decimal)sr24.get('i');
       Extot50150=((Extot50150==null||Extot50150==0)?0.0001:Extot50150);
       
        AggregateResult sr25=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L' and Customer_Type__c='Existing Customer'];
      
      ExCust150300=(decimal)sr25.get('s');
      ExCust150300=((ExCust150300==null||ExCust150300==0)?0.0001:ExCust150300);
          System.debug('000000000'+ExCust150300);
      Extot150300=(decimal)sr25.get('i');
      Extot150300=((Extot150300==null||Extot150300==0)?0.0001:Extot150300);
      
      AggregateResult sr26=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L' and Customer_Type__c='Existing Customer'];
        
        ExCust300700=(decimal)sr26.get('s');
        ExCust300700=((ExCust300700==null||ExCust300700==0)?0.0001:ExCust300700);
        Extot300700=(decimal)sr26.get('i');
        Extot300700=((Extot300700==null||Extot300700==0)?0.0001:Extot300700);
        
         AggregateResult sr27=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' and Customer_Type__c='Existing Customer'];
         
         ExCust700=(decimal)sr27.get('s');
         ExCust700=((ExCust700==null||ExCust700==0)?0.0001:ExCust700);
         Extot700=(decimal)sr27.get('i');
         Extot700=((Extot700==null||Extot700==0)?0.0001:Extot700);
        
               

        //for Existing OrderWonValue*******************************
          AggregateResult sr28=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' )  and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L' and Customer_Type__c='Existing Customer'];
     
     Exwon010=(decimal)sr28.get('s');
     Exwon010=((Exwon010==null||Exwon010==0)?0.0001:Exwon010);
         ExWontot010=(decimal)sr28.get('i');
         ExWontot010=((ExWontot010==null||ExWontot010==0)?0.0001:ExWontot010);
     
      AggregateResult sr29=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L' and Customer_Type__c='Existing Customer'];
     
         Exwon1050=(decimal)sr29.get('s');
     Exwon1050=(Exwon1050==null?0.0001:Exwon1050);
         Exwontot1050=(decimal)sr29.get('i');
         Exwontot1050=((Exwontot1050==null||Exwontot1050==0)?0.0001:Exwontot1050);
     
       AggregateResult sr30=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' and Customer_Type__c='Existing Customer'];
       
       ExWon50150=(decimal)sr30.get('s');
       ExWon50150=((ExWon50150==null||ExWon50150==0)?0.0001:ExWon50150);
           ExWontot50150=(decimal)sr30.get('i');
           ExWontot50150=((ExWontot50150==null||ExWontot50150==0)?0.0001:ExWontot50150);
       
        AggregateResult sr31=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L' and Customer_Type__c='Existing Customer'];
      
      ExWon151300=(decimal)sr31.get('s');
      ExWon151300=((ExWon151300==null||ExWon151300==0)?0.0001:ExWon151300);
          Exwontot151300=(decimal)sr31.get('i');
          Exwontot151300=((Exwontot151300==null||Exwontot151300==0)?0.0001:Exwontot151300);
      
        AggregateResult sr32=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L' and Customer_Type__c='Existing Customer'];
        
        ExWon300700=(decimal)sr32.get('s');
        ExWon300700=((ExWon300700==null||ExWon300700==0)?0.0001:ExWon300700);
           Exwontot300700=(decimal)sr32.get('i');
             Exwontot300700=((Exwontot300700==null||Exwontot300700==0)?0.0001:Exwontot300700);
        
         AggregateResult sr33=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' and Customer_Type__c='Existing Customer'];
         
         ExWon700=(decimal)sr33.get('s');
         ExWon700=((ExWon700==null||ExWon700==0)?0.0001:ExWon700);
               Exwontot700=(decimal)sr33.get('i');
             Exwontot700=((Exwontot700==null||Exwontot700==0)?0.0001:Exwontot700);   
        
        ExCustTotal=ExCust010+ExCust1050+ExCust50150+ExCust150300+ExCust300700+ExCust700;
        ExCustTotal=((ExCustTotal==null||ExCustTotal==0)?0.0001:ExCustTotal);
              
              ExtotTotal=Extot010+Extot1050+Extot50150+Extot150300+Extot300700+Extot700;
            ExtotTotal=((ExtotTotal==null||ExtotTotal==0)?0.0001:ExtotTotal);
        
              ExWontotal=ExWon010+ExWon1050+ExWon50150+ExWon151300+ExWon300700+ExWon700;
              ExWontotal=((ExWontotal==null||ExWontotal==0)?0.0001:ExWontotal);
              
              ExWontotTotal=ExWontot010+Exwontot1050+ExWontot50150+Exwontot151300+Exwontot300700+Exwontot700;
            ExWontotTotal=((ExWontotTotal==null||ExWontotTotal==0)?0.0001:ExWontotTotal);  
              
            ExistingProposalValues=new List<decimal>{ExCust010,ExCust1050,ExCust50150,ExCust150300,ExCust300700,ExCust700,ExCustTotal};              
              ExistingProposalWonvalues=new List<decimal>{ExWon010,ExWon1050,ExWon50150,ExWon151300,ExWon300700,ExWon700,ExWontotal};
              ExistingProposalTotals=new List<decimal>{Extot010,Extot1050,Extot50150,Extot150300,Extot300700,Extot700,ExtotTotal};
              ExistingProposalWonTotals=new List<decimal>{ExWontot010,Exwontot1050,ExWontot50150,Exwontot151300,Exwontot300700,Exwontot700,ExWontotTotal};
       
              wrapper six=new wrapper();
            six.name='Proposal Submitted';
            six.data=ExistingProposalValues;
            Report4.add(six);
              
              wrapper seven=new wrapper();
            seven.name='Order Won';
            seven.data=ExistingProposalWonvalues;
              Report4.add(seven);
              convertedJSON3=JSON.serializePretty(Report4);
              wrapper eight=new wrapper();
            eight.name='Proposal Submitted';
            eight.data=ExistingProposalTotals;
            Report5.add(eight);
            wrapper nine=new wrapper();
            nine.name='Order Won';
            nine.data=ExistingProposalWonTotals;
            Report5.add(nine);
              convertedJSON4=JSON.serializePretty(Report5);
           //caluclation of new customers data
        AggregateResult sr34=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L' and Customer_Type__c='New'];
     
     new010=(decimal)sr34.get('s');
     new010=((new010==null||new010==0)?0.0001:new010);
     newtot010=(decimal)sr34.get('i');
     newtot010=((newtot010==null||newtot010==0)?0.0001:newtot010);
        
          AggregateResult sr35=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L' and Customer_Type__c='New'];
     
         new1050=(decimal)sr35.get('s');
     new1050=((new1050==null||new1050==0)?0.0001:new1050);
     newtot1050=(decimal)sr35.get('i');
     newtot1050=((newtot1050==null||newtot1050==0)?0.0001:newtot1050);
    
          AggregateResult sr36=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' and Customer_Type__c='New'];
       
       new50150=(decimal)sr36.get('s');
       new50150=((new50150==null||new50150==0)?0.0001:new50150);
       newtot50150=(decimal)sr36.get('i');
       newtot50150=((newtot50150==null||newtot50150==0)?0.0001:newtot50150);
        
           AggregateResult sr37=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L' and Customer_Type__c='New'];
      
      new150300=(decimal)sr37.get('s');
      new150300=((new150300==null||new150300==0)?0.0001:new150300);
      newtot150300=(decimal)sr37.get('i');
      newtot150300=((newtot150300==null||newtot150300==0)?0.0001:newtot150300);
        
             AggregateResult sr38=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L' and Customer_Type__c='New'];
        
        new300700=(decimal)sr38.get('s');
        new300700=((new300700==null||new300700==0)?0.0001:new300700);
        newtot300700=(decimal)sr38.get('i');
        newtot300700=((newtot300700==null||newtot300700==0)?0.0001:newtot300700);
        
                     AggregateResult sr39=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' and Customer_Type__c='New'];
         
         new700=(decimal)sr39.get('s');
         new700=((new700==null||new700==0)?0.0001:new700);
         newtot700=(decimal)sr39.get('i');
         newtot700=((newtot700==null||newtot700==0)?0.0001:newtot700);
        
              AggregateResult sr40=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' )  and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L' and Customer_Type__c='New'];
     
     newwon010=(decimal)sr40.get('s');
     newwon010=((newwon010==null||newwon010==0)?0.0001:newwon010);
     newWontot010=(decimal)sr40.get('i');
     newWontot010=((newWontot010==null||newWontot010==0)?0.0001:newWontot010);
        
        AggregateResult sr41=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L' and Customer_Type__c='New'];
     
         newwon1050=(decimal)sr41.get('s');
     newwon1050=((newwon1050==null||newwon1050==0)?0.0001:newwon1050);
      newwontot1050=(decimal)sr41.get('i');
     newwontot1050=((newwontot1050==null||newwontot1050==0)?0.0001:newwontot1050);
        
        
       AggregateResult sr42=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' and Customer_Type__c='New'];
       
      newwon50150=(decimal)sr42.get('s');
     newwon50150=((newwon50150==null||newwon50150==0)?0.0001:newwon50150);
      newwontot50150=(decimal)sr42.get('i');
     newwontot50150=((newwontot50150==null||newwontot50150==0)?0.0001:newwontot50150);
       
        AggregateResult sr43=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L' and Customer_Type__c='New'];
      
      newWon150300=(decimal)sr43.get('s');
      newWon150300=((newWon150300==null||newWon150300==0)?0.0001:newWon150300);
      newWontot150300=(decimal)sr43.get('i');
      newWontot150300=((newWontot150300==null||newWontot150300==0)?0.0001:newWontot150300);
        
             AggregateResult sr44=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L' and Customer_Type__c='New'];
        
        newWon300700=(decimal)sr44.get('s');
        newWon300700=((newWon300700==null||newWon300700==0)?0.0001:newWon300700);
        newWontot300700=(decimal)sr44.get('i');
      newWontot300700=((newWontot300700==null||newWontot300700==0)?0.0001:newWontot300700);
        
         AggregateResult sr45=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' and Customer_Type__c='New'];
         
          newWon700=(decimal)sr45.get('s');
        newWon700=((newWon700==null||newWon700==0)?0.0001:newWon700);
        newWontot700=(decimal)sr45.get('i');
      newWontot700=((newWontot700==null||newWontot700==0)?0.0001:newWontot700);
           
             newtotal=new010+new1050+new50150+new150300+new300700+new700;
       newtotal=((newtotal==null||newtotal==0)?0.0001:newtotal);
       newtottotal=newtot010+newtot1050+newtot50150+newtot150300+newtot300700+newtot700;
       newtottotal=((newtottotal==null||newtottotal==0)?0.0001:newtottotal); 
        
              newWontot=newWon010+newWon1050+newWon50150+newWon150300+newWon300700+newWon700;
       newWontot=((newWontot==null||newWontot==0)?0.0001:newWontot);
       newWontottotal=newWontot010+newwontot1050+newWontot50150+newWontot150300+newWontot300700+newWontot700;
       newWontottotal=((newWontottotal==null||newWontottotal==0)?0.0001:newWontottotal);
        
            newProposalValues=new List<decimal>{new010,new1050,new50150,new150300,new300700,new700,newtotal};
             newProposalWonValues=new List<decimal>{newWon010,newWon1050,newWon50150,newWon150300,newWon300700,newWon700,newWontot};      
             newProposalTotals=new List<decimal>{newtot010,newtot1050,newtot50150,newtot150300,newtot300700,newtot700,newtottotal};  
             newProposalWontotals=new List<decimal>{newWontot010,newwontot1050,newWontot50150,newWontot150300,newWontot300700,newWontot700,newWontottotal}; 
    
             Wrapper ten=new wrapper();
           ten.name='Proposal Submitted';
           ten.data=newProposalValues;
           Report6.add(ten);
             wrapper eleven=new wrapper();
             eleven.name='Order Won';
             eleven.data=newProposalWonValues;
           Report6.add(eleven);
           convertedJSON5=JSON.serializePretty(Report6);
        
           wrapper twelve=new wrapper();
           twelve.name='Proposal Submitted';
           twelve.data=newProposalTotals;
           Report7.add(twelve);
            
             wrapper thirteen=new wrapper();
           thirteen.name='Order Won';
           thirteen.data=newProposalWontotals;
             Report7.add(thirteen);
             convertedJSON6=JSON.serializePretty(Report7);
            //caluclation of export customers
    AggregateResult sr46=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L' and Project_Type__c='Export'];
     
     exp010=(decimal)sr46.get('s');
     exp010=((exp010==null||exp010==0)?0.0001:exp010);
     exptot010=(decimal)sr46.get('i');
      exptot010=((exptot010==null||exptot010==0)?0.0001:exptot010);
     
      AggregateResult sr47=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L' and Project_Type__c='Export'];
     
             exp1050=(decimal)sr47.get('s');
     exp1050=((exp1050==null||exp1050==0)?0.0001:exp1050);
     exptot1050=(decimal)sr47.get('i');
     exptot1050=((exptot1050==null||exptot1050==0)?0.0001:exptot1050);
     
       AggregateResult sr48=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' and Project_Type__c='Export'];
       
       exp50150=(decimal)sr48.get('s');
       exp50150=((exp50150==null||exp50150==0)?0.0001:exp50150);
       exptot50150=(decimal)sr48.get('i');
       exptot50150=((exptot50150==null||exptot50150==0)?0.0001:exptot50150);
       
        AggregateResult sr49=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L' and Project_Type__c='Export'];
      
      exp150300=(decimal)sr49.get('s');
      exp150300=((exp150300==null||exp150300==0)?0.0001:exp150300);
      exptot150300=(decimal)sr49.get('i');
      exptot150300=((exptot150300==null||exptot150300==0)?0.0001:exptot150300);
      
        AggregateResult sr50=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L' and Project_Type__c='Export'];
        
        exp300700=(decimal)sr50.get('s');
        exp300700=((exp300700==null||exp300700==0)?0.0001:exp300700);
        exptot300700=(decimal)sr50.get('i');
        exptot300700=((exptot300700==null||exptot300700==0)?0.0001:exptot300700);
        
         AggregateResult sr51=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' and Project_Type__c='Export'];
         
         exp700=(decimal)sr51.get('s');
         exp700=((exp700==null||exp700==0)?0.0001:exp700);
         exptot700=(decimal)sr51.get('i');
         exptot700=((exptot700==null||exptot700==0)?0.0001:exptot700);
         
         exptotal=exp010+exp1050+exp50150+exp150300+exp300700+exp700;
         exptotal=((exptotal==null||exptotal==0)?0.0001:exptotal);
         exptottotal=exptot010+exptot1050+exptot50150+exptot150300+exptot300700+exptot700;
         exptottotal=((exptottotal==null||exptottotal==0)?0.0001:exptottotal);
             ExportProposalValues=new List<decimal>{exp010,exp1050,exp50150,exp150300,exp300700,exp700,exptotal};
               ExportProposalTotal=new List<decimal>{exptot010,exptot1050,exptot50150,exptot150300,exptot300700,exptot700,exptottotal};
         
//for order won of export customers

 AggregateResult sr52=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L' and Project_Type__c='Export'];
     
     expwon010=(decimal)sr52.get('s');
     expwon010=((expwon010==null||expwon010==0)?0.0001:expwon010);
     expwontot010=(decimal)sr52.get('i');
     expwontot010=((expwontot010==null||expwontot010==0)?0.0001:expwontot010);
     
      AggregateResult sr53=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L' and Project_Type__c='Export'];
     
         expWon1050=(decimal)sr53.get('s');
     expWon1050=((expWon1050==null||expWon1050==0)?0.0001:expWon1050);
      expwontot1050=(decimal)sr53.get('i');
     expwontot1050=((expwontot1050==null||expwontot1050==0)?0.0001:expwontot1050);
     
       AggregateResult sr54=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' and Project_Type__c='Export'];
       
      expWon50150=(decimal)sr54.get('s');
     expWon50150=((expWon50150==null||expWon50150==0)?0.0001:expWon50150);
      expwontot50150=(decimal)sr54.get('i');
     expwontot50150=((expwontot50150==null||expwontot50150==0)?0.0001:expwontot50150);
       
        AggregateResult sr55=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L' and Project_Type__c='Export'];
      
      expWon150300=(decimal)sr55.get('s');
      expWon150300=((expWon150300==null||expWon150300==0)?0.0001:expWon150300);
      expwontot150300=(decimal)sr55.get('i');
      expwontot150300=((expwontot150300==null||expwontot150300==0)?0.0001:expwontot150300);
    
      
        AggregateResult sr56=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L' and Project_Type__c='Export'];
        
        expWon300700=(decimal)sr56.get('s');
        expWon300700=((expWon300700==null||expWon300700==0)?0.0001:expWon300700);
        expWontot300700=(decimal)sr56.get('i');
      expWontot300700=((expWontot300700==null||expWontot300700==0)?0.0001:expWontot300700);
        
         AggregateResult sr57=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' and Project_Type__c='Export'];
         
          expwon700=(decimal)sr57.get('s');
        expwon700=((expwon700==null||expwon700==0)?0.0001:expwon700);
        expwontot700=(decimal)sr57.get('i');
      expwontot700=((expwontot700==null||expwontot700==0)?0.0001:expwontot700);

       expWontot=expWon010+expWon1050+expWon50150+expWon150300+expWon300700+expWon700;
       expWontot=((expWontot==null||expWontot==0)?0.0001:expWontot);
       expwontottotal=expwontot010+expwontot1050+expWontot50150+expWontot150300+expwontot300700+expwontot700;
       expwontottotal=((expwontottotal==null||expwontottotal==0)?0.0001:expwontottotal);
            
          ExportProposalWonValues=new List<decimal>{expWon010,expWon1050,expWon50150,expWon150300,expWon300700,expWon700,expWontot};
            ExportProposalWonTotal=new List<decimal>{expwontot010,expwontot1050,expWontot50150,expWontot150300,expwontot300700,expwontot700,expwontottotal};
            
            wrapper fourteen=new wrapper();
          fourteen.name='Proposal Submitted';
          fourteen.data=ExportProposalValues;
            Report8.add(fourteen);
            wrapper fifteen=new wrapper();
          fifteen.name='Order Won';
          fifteen.data=ExportProposalWonValues;
          Report8.add(fifteen);
            
            convertedJSON7=JSON.serializePretty(Report8);
        
            wrapper sixteen=new wrapper();
          sixteen.name='Proposal Submitted';
          sixteen.data=ExportProposalTotal;
          Report9.add(sixteen);
            
            wrapper seventn=new wrapper();
          seventn.name='Order Won';
          seventn.data=ExportProposalWonTotal;
          Report9.add(seventn);
            
            convertedJSON8=JSON.serializePretty(Report9);
            // caluclation of domestic variables
   AggregateResult sr58=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L' and Project_Type__c='Domestic'];
     
     Dom010=(decimal)sr58.get('s');
     Dom010=((Dom010==null||Dom010==0)?0.0001:Dom010);
     Domtot010=(decimal)sr58.get('i');
      Domtot010=((Domtot010==null||Domtot010==0)?0.0001:Domtot010);
     
      AggregateResult sr59=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L' and Project_Type__c='Domestic'];
     
             Dom1050=(decimal)sr59.get('s');
     Dom1050=((Dom1050==null||Dom1050==0)?0.0001:Dom1050);
     Domtot1050=(decimal)sr59.get('i');
     Domtot1050=((Domtot1050==null||Domtot1050==0)?0.0001:Domtot1050);
     
       AggregateResult sr60=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' and Project_Type__c='Domestic'];
       
       Dom50150=(decimal)sr60.get('s');
       Dom50150=((Dom50150==null||Dom50150==0)?0.0001:Dom50150);
       Domtot50150=(decimal)sr60.get('i');
       Domtot50150=((Domtot50150==null||Domtot50150==0)?0.0001:Domtot50150);
       
        AggregateResult sr61=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L' and Project_Type__c='Domestic'];
      
      Dom150300=(decimal)sr61.get('s');
      Dom150300=((Dom150300==null||Dom150300==0)?0.0001:Dom150300);
      Domtot150300=(decimal)sr61.get('i');
      Domtot150300=((Domtot150300==null||Domtot150300==0)?0.0001:Domtot150300);
      
        AggregateResult sr62=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L' and Project_Type__c='Domestic'];
        
        Dom300700=(decimal)sr62.get('s');
        Dom300700=((Dom300700==null||Dom300700==0)?0.0001:Dom300700);
        Domtot300700=(decimal)sr62.get('i');
        Domtot300700=((Domtot300700==null||Domtot300700==0)?0.0001:Domtot300700);
        
         AggregateResult sr63=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where stagename in:forOppStages and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' and Project_Type__c='Domestic'];
         
         Dom700=(decimal)sr63.get('s');
         Dom700=((Dom700==null||Dom700==0)?0.0001:Dom700);
         Domtot700=(decimal)sr63.get('i');
         Domtot700=((Domtot700==null||Domtot700==0)?0.0001:Domtot700);
         
         Domtotal=Dom010+Dom1050+Dom50150+Dom150300+Dom300700+Dom700;
         Domtotal=((Domtotal==null||Domtotal==0)?0.0001:Domtotal);
         Domtottotal=Domtot010+Domtot1050+Domtot50150+Domtot150300+Domtot300700+Domtot700;
         Domtottotal=((Domtottotal==null||Domtottotal==0)?0.0001:Domtottotal);

            
//for order won of Domestic customers

 AggregateResult sr64=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='0-10L' and Project_Type__c='Domestic'];
     
     DomWon010=(decimal)sr64.get('s');
     DomWon010=((DomWon010==null||DomWon010==0)?0.0001:DomWon010);
     DomWontot010=(decimal)sr64.get('i');
     DomWontot010=((DomWontot010==null||DomWontot010==0)?0.0001:DomWontot010);
     
      AggregateResult sr65=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='10-50L' and Project_Type__c='Domestic'];
     
         DomWon1050=(decimal)sr65.get('s');
     DomWon1050=((DomWon1050==null||DomWon1050==0)?0.0001:DomWon1050);
      DomWontot1050=(decimal)sr65.get('i');
     DomWontot1050=((DomWontot1050==null||DomWontot1050==0)?0.0001:DomWontot1050);
     
       AggregateResult sr66=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='51-150L' and Project_Type__c='Domestic'];
       
      DomWon50150=(decimal)sr66.get('s');
     DomWon50150=((DomWon50150==null||DomWon50150==0)?0.0001:DomWon50150);
      DomWontot50150=(decimal)sr66.get('i');
     DomWontot50150=((DomWontot50150==null||DomWontot50150==0)?0.0001:DomWontot50150);
       
        AggregateResult sr67=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='151-350L' and Project_Type__c='Domestic'];
      
      DomWon150300=(decimal)sr67.get('s');
      DomWon150300=((DomWon150300==null||DomWon150300==0)?0.0001:DomWon150300);
      Domwontot150300=(decimal)sr67.get('i');
      Domwontot150300=((Domwontot150300==null||Domwontot150300==0)?0.0001:Domwontot150300);
    
      
        AggregateResult sr68=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='351-700L' and Project_Type__c='Domestic'];
        
        DomWon300700=(decimal)sr68.get('s');
        DomWon300700=((DomWon300700==null||DomWon300700==0)?0.0001:DomWon300700);
        DomWontot300700=(decimal)sr68.get('i');
      DomWontot300700=((DomWontot300700==null||DomWontot300700==0)?0.0001:DomWontot300700);
        
         AggregateResult sr69=[select count(id) i,sum(Amount_In_Lakhs__c) s from Opportunity where (stagename='Order Won' or stagename='Project Under Execution' or stagename='Project Closed' or stagename='Project Cancelled' or stagename='Project On Hold' ) and RecordTypeId not in:holdRecordType.keySet() and id in:OpportunityIds and  Cost_band__c='Greater than 700 L' and Project_Type__c='Domestic'];
         
          DomWon700=(decimal)sr69.get('s');
        DomWon700=((DomWon700==null||DomWon700==0)?0.0001:DomWon700);
        Domwontot700=(decimal)sr69.get('i');
      Domwontot700=((Domwontot700==null||Domwontot700==0)?0.0001:Domwontot700);

       DomWontot=DomWon010+DomWon1050+DomWon50150+DomWon150300+DomWon300700+DomWon700;
       DomWontot=((DomWontot==null||DomWontot==0)?0.0001:DomWontot);
       Domwontottotal=Domwontot010+Domwontot1050+DomWontot50150+DomWontot150300+Domwontot300700+Domwontot700;
       Domwontottotal=((Domwontottotal==null||Domwontottotal==0)?0.0001:Domwontottotal);
           
         DomesticProposalValues=new List<decimal>{Dom010,Dom1050,Dom50150,Dom150300,Dom300700,Dom700,Domtotal};
         System.debug('Domestic proposal values='+DomesticProposalValues);    
         DomesticProposalTotal=new List<decimal>{Domtot010,Domtot1050,Domtot50150,Domtot150300,Domtot300700,Domtot700,Domtottotal};
         
          DomesticProposalWonValues=new List<decimal>{DomWon010,DomWon1050,DomWon50150,DomWon150300,DomWon300700,DomWon700,DomWontot};
         System.debug('Domestic proposal won values='+DomesticProposalWonValues); 
         DomesticProposalWonTotal=new List<decimal>{DomWontot010,DomWontot1050,DomWontot50150,Domwontot150300,DomWontot300700,Domwontot700,Domwontottotal};
             
            wrapper eighteen=new wrapper();
            eighteen.name='Proposal Submitted';
            eighteen.data=DomesticProposalValues;
            Report10.add(eighteen);
            wrapper ninteen=new wrapper();
            ninteen.name='Order Won';
            ninteen.data=DomesticProposalWonValues;
            Report10.add(ninteen);
            
          convertedJSON9=JSON.serializePretty(Report10);
        
            wrapper twenty=new wrapper();
          twenty.name='Proposal Submitted';
          twenty.data=DomesticProposalTotal;
          Report11.add(twenty);
            
            wrapper twentyone=new wrapper();
          twentyone.name='Order Won';
          twentyone.data=DomesticProposalWonTotal;
          Report11.add(twentyone);
            
            convertedJSON10=JSON.serializePretty(Report11);    
  //1.      
  proposalChartDivision1=new List<decimal>{MATH.ROUND(pwon010/psub010*100),MATH.ROUND((pwon1050/psub1050)*100),MATH.ROUND((pwon50150/psub50150)*100),
MATH.ROUND((pwon150300/psub150300)*100),MATH.ROUND((pwon300700/psub300700)*100),MATH.ROUND((pwon700/psub700)*100),
MATH.ROUND((pwontotal/psubtotal)*100)};
convertedJSONPer1 = JSON.serializePretty(proposalChartDivision1);
proposalChartDivision2=new List<decimal>{MATH.ROUND((pwontot010/ptot010)*100),MATH.ROUND((pwontot1050/ptot1050)*100),MATH.ROUND((pwontot50150/ptot50150)*100),MATH.ROUND((pwontot150300/ptot150300)*100),MATH.ROUND((pwontot300700/ptot300700)*100),MATH.ROUND((pwontot700/ptot700)*100),
MATH.ROUND((pwontottotal/ptottotal)*100)};
 //2.
   ExistingChartDivision1=new List<decimal>{MATH.ROUND((ExWon010/ExCust010)*100),MATH.ROUND((ExWon1050/ExCust1050)*100),MATH.ROUND((ExWon50150/ExCust50150)*100),MATH.ROUND((ExWon151300/ExCust150300)*100),MATH.ROUND((ExWon300700/ExCust300700)*100),MATH.ROUND((ExWon700/ExCust700)*100),MATH.ROUND((ExWonTotal/ExCustTotal)*100)};
   ExistingChartDivision2=new List<decimal>{MATH.ROUND((ExWontot010/Extot010)*100),MATH.ROUND((Exwontot1050/Extot1050)*100),MATH.ROUND((ExWontot50150/Extot50150)*100),MATH.ROUND((Exwontot151300/Extot150300)*100),MATH.ROUND((ExWontot300700/Extot300700)*100),MATH.ROUND((ExWontot700/Extot700)*100),MATH.ROUND((ExWontotTotal/ExtotTotal)*100)};    
 //3.
 NewChartDivision1=new List<decimal>{MATH.ROUND((newWon010/new010)*100),MATH.ROUND((newWon1050/new1050)*100),MATH.ROUND((newWon50150/new50150)*100),MATH.ROUND((newWon150300/new150300)*100),MATH.ROUND((newWon300700/new300700)*100),MATH.ROUND((newWon700/new700)*100),MATH.ROUND((newWontot/newtotal)*100)};
 NewChartDivision2=new List<decimal>{MATH.ROUND((newWontot010/newtot010)*100),MATH.ROUND((newWontot1050/newtot1050)*100),MATH.ROUND((newWontot50150/newtot50150)*100),MATH.ROUND((newWontot150300/newtot150300)*100),MATH.ROUND((newWontot300700/newtot300700)*100),MATH.ROUND((newWontot700/newtot700)*100),MATH.ROUND((newwontottotal/newtottotal)*100)};
 //4.
 ExportChartDivision1=new List<decimal>{MATH.ROUND((expWon010/exp010)*100),MATH.ROUND((expWon1050/exp1050)*100),MATH.ROUND((expWon50150/exp50150)*100),MATH.ROUND((expWon150300/exp150300)*100),MATH.ROUND((expWon300700/exp300700)*100),MATH.ROUND((expwon700/exp700)*100),MATH.ROUND((expWontot/exptotal)*100)};
ExportChartDivision2=new List<decimal>{MATH.ROUND((expwontot010/exptot010)*100),MATH.ROUND((expWontot1050/exptot1050)*100),MATH.ROUND((expWontot50150/exptot50150)*100),MATH.ROUND((expWontot150300/exptot150300)*100),MATH.ROUND((expWontot300700/exptot300700)*100),MATH.ROUND((expwontot700/exptot700)*100),MATH.ROUND((expwontottotal/exptottotal)*100)};   
 //5.
 DomesticChartDivision1=new List<decimal>{MATH.ROUND((DomWon010/Dom010)*100),MATH.ROUND((DomWon1050/Dom1050)*100),MATH.ROUND((DomWon50150/Dom50150)*100),MATH.ROUND((DomWon150300/Dom150300)*100),MATH.ROUND((DomWon300700/Dom300700)*100),MATH.ROUND((DomWon700/Dom700)*100),MATH.ROUND((DomWontot/Domtotal)*100)};

DomesticChartDivision2=new List<decimal>{MATH.ROUND((DomWontot010/Domtot010)*100),MATH.ROUND((DomWontot1050/Domtot1050)*100),MATH.ROUND((DomWontot50150/Domtot50150)*100),MATH.ROUND((DomWontot150300/Domtot150300)*100),MATH.ROUND((DomWontot300700/Domtot300700)*100),MATH.ROUND((DomWontot700/Domtot700)*100),MATH.ROUND((DomWontottotal/Domtottotal)*100)};
    }
    public void changeOnIndustrySelection()
    {
          accountData.clear(); 
           accountNameOption.clear();
           
           accountNameOption.add(new selectoption('None','None'));
           System.debug('selectedIndustryHere='+selectedIndustry);
        
           if(selectedIndustry=='Automotive')
           {
               
              System.debug('selectedIndustryHere in automotive='+selectedIndustry);
                /* for(Account a:[select id,name from Account where RecordType.name='MBA' and industry='Automotive' ])
                 {
                     accountNameOption.add(new selectoption(a.name,a.name));
                 }
        */
              accountQueryString='select id,name from Account where RecordType.Name=\'MBA\''+' and industry=\'Automotive\' ORDER by name ASC';
           }
           else if(selectedIndustry=='Non-Automotive')
           {
               
               
              System.debug('selectedIndustryHere in noon automotive='+selectedIndustry);
                /*for(Account a:[select id,name from Account where RecordType.name='MBA' and industry!='Automotive' ])
                 {
                     accountNameOption.add(new selectoption(a.name,a.name));
                 }
        */
               
               accountQueryString='select id,name from Account where RecordType.Name=\'MBA\''+' and industry!=\'Automotive\' ORDER by name ASC';
              System.debug(accountQueryString);
                
           }
           else if(selectedIndustry=='Both')
           {
               
               System.debug('selectedIndustryHere in='+selectedIndustry);
               /*for(Account a:[select id,name from Account where RecordType.name='MBA' and industry!=null ])
               {
                   accountNameOption.add(new selectoption(a.name,a.name));
               }
        */
                accountQueryString='select id,name from Account where RecordType.Name=\'MBA\''+' and industry!=null ORDER by name ASC';
           }
             if(accountQueryString!=Null){
             accountData=Database.query(accountQueryString);
             }
             for(Account a:accountData)
             {
                 accountNameOption.add(new selectoption(a.name,a.name));
             }
        
    }
}