@isTest
public class TitanMBA_WinlossReportTest {
    @isTest
    public static void testmember1()
    {
        Id AccountRecordTypeId=[select id,name from RecordType where sobjecttype='Account' and recordType.name='MBA'].id;
        
        Id opp1RecordTypeId = [select id,name from RecordType where sobjecttype='Opportunity' and RecordType.developerName='MBA_Services_Allocated' ].id;
        Id opp2RecordTypeId = [select id,name from RecordType where sobjecttype='Opportunity' and RecordType.developerName='MBA_Services_Final' ].id;
        Id opp3RecordTypeId = [select id,name from RecordType where sobjecttype='Opportunity' and RecordType.developerName='MBA_Spares_Final' ].id;
        Id opp4RecordTypeId = [select id,name from RecordType where sobjecttype='Opportunity' and RecordType.developerName='PECSA' ].id;
        Id opp5RecordTypeId = [select id,name from RecordType where sobjecttype='Opportunity' and RecordType.developername='Regret_MBA_Record_Type' ].id;
        Id opp6RecordTypeId = [select id,name from RecordType where sobjecttype='Opportunity' and RecordType.developername='Spares_Services_Record_Type'].id;
        
        Account acc1 = new Account();
        acc1.Name = 'Acc1';
        acc1.Industry = 'Automotive';
        acc1.RecordTypeId = AccountRecordTypeId ;
        acc1.BillingPostalCode  = '586203';
        
        insert acc1;
       
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Opp1';
        opp1.AccountId = acc1.Id;
        opp1.RecordTypeId = opp1RecordTypeId ;
        opp1.CloseDate = system.today() ;
        
        opp1.StageName = 'Await Customer Feedback(Quote Submitted)' ;
        insert opp1;
        
        Quote qt = new Quote();
        qt.OpportunityId = opp1.Id;
        qt.Name = 'Quote 1';
        insert qt;
        System.debug( 'Muttu'+qt);
        
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Opp1';
        opp2.AccountId = acc1.Id;
        opp2.RecordTypeId = opp1RecordTypeId ;
        opp2.CloseDate = system.today() ;
        opp2.StageName = 'Revised Quote Submission' ;
        insert opp2;
        
        Opportunity opp3 = new Opportunity();
        opp3.Name = 'Opp1';
        opp3.AccountId = acc1.Id;
        opp3.RecordTypeId = opp1RecordTypeId ;
        opp3.CloseDate = system.today() ;
        opp3.StageName = 'Still Active' ;
        insert opp3;
        
        Opportunity opp4 = new Opportunity();
        opp4.Name = 'Opp1';
        opp4.AccountId = acc1.Id;
        opp4.RecordTypeId = opp1RecordTypeId ;
        opp4.CloseDate = system.today() ;
        opp4.StageName = 'Opportunity on Hold' ;
        insert opp4;
        
        TitanMBA_WinlossReport winlossReport = new TitanMBA_WinlossReport();
        winlossReport.selectedIndustry = 'Automotive';
        winlossReport.selectedStageName = 'All';
        winlossReport.selectedReason = 'All';
        winlossReport.selectedPrjType = 'All';
        winlossReport.selectedFY = 'Current FY';
        winlossReport.fromDate = date.newInstance(2018,01,01);
        winlossReport.toDate = date.today();
        winlossReport.runReportChart();
        winlossReport.download();
        
        TitanMBA_WinlossReport winlossReport1 = new TitanMBA_WinlossReport();
        winlossReport1.selectedIndustry = 'Automotive';
        winlossReport1.selectedStageName = 'All';
        winlossReport1.selectedReason = 'All';
        winlossReport1.selectedPrjType = 'All';
        winlossReport1.selectedFY = 'Current FY';
        winlossReport1.fromDate = date.newInstance(2018,01,01);
        winlossReport1.toDate = date.today();
        winlossReport1.runReportChart();
        winlossReport1.download();
        
        TitanMBA_WinlossReport winlossReport2 = new TitanMBA_WinlossReport();
        Test.setCurrentPageReference(new PageReference('Page.TitanMBA_WinlossReportDownload'));
        System.currentPageReference().getParameters().put('selectedIndustry','None');
        System.currentPageReference().getParameters().put('selectedStageName','All');
        System.currentPageReference().getParameters().put('selectedReason','All');
        System.currentPageReference().getParameters().put('selectedPrjType','Domestic');
        System.currentPageReference().getParameters().put('selectedFY' , 'Current FY');
        System.currentPageReference().getParameters().put('fromdate',String.ValueOf(date.newInstance(2018,01,01)));
        System.currentPageReference().getParameters().put('todate',String.ValueOf(date.today()));
        
		winlossReport1.downloadOppDetails();
        
        TitanMBA_WinlossReport winlossReport3 = new TitanMBA_WinlossReport();
        winlossReport3.selectedIndustry = 'None';
        winlossReport3.selectedStageName = 'Order Won';
        winlossReport3.selectedReason = 'Lost on cost';
        winlossReport3.selectedPrjType = 'Export';
        winlossReport3.selectedFY = 'Previous FY';
        winlossReport3.fromDate = date.newInstance(2018,01,01);
        winlossReport3.toDate = date.today();
        winlossReport3.runReportChart();
        winlossReport3.download();
        
        TitanMBA_WinlossReport winlossReport4 = new TitanMBA_WinlossReport();
        Test.setCurrentPageReference(new PageReference('Page.TitanMBA_WinlossReportDownload'));
        System.currentPageReference().getParameters().put('selectedIndustry','None');
        System.currentPageReference().getParameters().put('selectedStageName','Order Won');
        System.currentPageReference().getParameters().put('selectedReason','Lost on cost');
        System.currentPageReference().getParameters().put('selectedPrjType','Domestic');
        System.currentPageReference().getParameters().put('selectedFY' , 'Previous FY');
        System.currentPageReference().getParameters().put('fromdate',String.ValueOf(date.newInstance(2018,01,01)));
        System.currentPageReference().getParameters().put('todate',String.ValueOf(date.today()));
        
		winlossReport4.downloadOppDetails();
        
        
        TitanMBA_WinlossReport winlossReport5 = new TitanMBA_WinlossReport();
        winlossReport5.selectedIndustry = 'None';
        winlossReport5.selectedStageName = 'All';
        winlossReport5.selectedReason = 'Lost on cost';
        winlossReport5.selectedPrjType = 'All';
        winlossReport5.selectedFY = 'Previous FY';
        winlossReport5.fromDate = date.newInstance(2018,01,01);
        winlossReport5.toDate = date.today();
        winlossReport5.runReportChart();
        winlossReport5.download();
        
        TitanMBA_WinlossReport winlossReport6 = new TitanMBA_WinlossReport();
        Test.setCurrentPageReference(new PageReference('Page.TitanMBA_WinlossReportDownload'));
        System.currentPageReference().getParameters().put('selectedIndustry','None');
        System.currentPageReference().getParameters().put('selectedStageName','All');
        System.currentPageReference().getParameters().put('selectedReason','Lost on cost');
        System.currentPageReference().getParameters().put('selectedPrjType','All');
        System.currentPageReference().getParameters().put('selectedFY' , 'Current FY');
        System.currentPageReference().getParameters().put('fromdate',String.ValueOf(date.newInstance(2018,01,01)));
        System.currentPageReference().getParameters().put('todate',String.ValueOf(date.today()));
        
		winlossReport6.downloadOppDetails();
        
       TitanMBA_WinlossReport winlossReport7 = new TitanMBA_WinlossReport();
        winlossReport7.selectedIndustry = 'Automotive';
        winlossReport7.selectedStageName = 'Order Won';
        winlossReport7.selectedReason = 'All';
        winlossReport7.selectedPrjType = 'All';
        winlossReport7.selectedFY = 'Current FY';
        winlossReport7.fromDate = date.newInstance(2018,01,01);
        winlossReport7.toDate = date.today();
        winlossReport7.runReportChart();
        winlossReport7.download();
        
        TitanMBA_WinlossReport winlossReport8 = new TitanMBA_WinlossReport();
        Test.setCurrentPageReference(new PageReference('Page.TitanMBA_WinlossReportDownload'));
        System.currentPageReference().getParameters().put('selectedIndustry','Automotive');
        System.currentPageReference().getParameters().put('selectedStageName','Order Won');
        System.currentPageReference().getParameters().put('selectedReason','All');
        System.currentPageReference().getParameters().put('selectedPrjType','All');
        System.currentPageReference().getParameters().put('selectedFY' , 'Current FY');
        System.currentPageReference().getParameters().put('fromdate',String.ValueOf(date.newInstance(2018,01,01)));
        System.currentPageReference().getParameters().put('todate',String.ValueOf(date.today()));
        
		winlossReport8.downloadOppDetails();
        TitanMBA_WinlossReport.oppWrapper ow = new TitanMBA_WinlossReport.oppWrapper();
        ow.oppName = 'opp1';
        ow.AccName = 'Acc1';
        ow.oppAmount = 100;
        ow.oppStageName = 'Order Won';
        ow.oppRecordTypeName = 'MBA';
        ow.oppAccIndustry = 'Automotive';
        ow.oppPrjType = 'Domestic';
        ow.oppLostReason = 'Lost on cost';
        ow.createdDate = System.today();
        ow.mechanicalLead = 'Mohammed Ismail';
        ow.electricalLead = 'A Gopalakrishnan';
        
    }
    
}