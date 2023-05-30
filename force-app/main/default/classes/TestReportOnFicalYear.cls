@isTest(SeeAllData=true)
Private Class TestReportOnFicalYear{
    Static testmethod void customReportMethod(){
        
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
        acc.Industry='Automotive';
        acc.Lead_Source__c='Internet';
        String rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].id;
        //acc.recordtype.developername=rtId ;
        acc.recordtypeid = rtId ;
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Customer_Type__c='Existing Customer';
            opp.Manager_s_Probability__c=50;
            opp.StageName='Under Negotiation';
            insert opp;
         ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
        String selectReportType;
         testAccPlan.selectReportType='NEXT_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        system.debug('****1****'+testAccPlan.accountOppListForNew);
        opp.Manager_s_Probability__c=70;
        update opp;
        testAccPlan.generateReport();
        opp.Manager_s_Probability__c=90;
        update opp;
        testAccPlan.generateReport();
        
        
    } 
    Static testmethod void customReportMethodProbbility1(){
       
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
        acc.Industry='Automotive';
        acc.Lead_Source__c='Internet';
        Id rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].Id;
        
        acc.recordtypeid = rtId ;
        //acc.Industry='Automotive';
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Manager_s_Probability__c=50;
            opp.StageName='Under Negotiation';
           // opp.Account.Industry ='Automotive';
            opp.Customer_Type__c='New';
           
            insert opp;
         ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
         String selectReportType;
         testAccPlan.selectReportType='NEXT_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        system.debug('****2****'+testAccPlan.accountOppListForNew);
        
    }
    Static testmethod void customReportMethodProbbility2(){
       
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
       // acc.Industry='Automotive';
        acc.Lead_Source__c='Internet';
        acc.Industry='Aerospace';
      Id rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].Id;
        
        acc.recordtypeid = rtId ;
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Manager_s_Probability__c=50;
            opp.StageName='Under Negotiation'; 
            opp.Customer_Type__c='New';
           
            insert opp;
         ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
         String selectReportType;
         testAccPlan.selectReportType='NEXT_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        system.debug('****3****'+testAccPlan.accountOppListForNew);
        
    }
    Static testmethod void customReportMethodProbbility3(){
       
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
      //  acc.Industry='Automotive';
        acc.Lead_Source__c='Internet';
     Id rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].Id;
        
        acc.recordtypeid = rtId ;
        acc.Industry='Automotive';
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Manager_s_Probability__c=70;
           opp.StageName='Under Negotiation';
            opp.Customer_Type__c='New';
           
            insert opp;
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
        String selectReportType;
        testAccPlan.selectReportType='NEXT_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        system.debug('****4****'+testAccPlan.accountOppListForNew);
    }
    Static testmethod void customReportMethodProbbility4(){
       
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
      //  acc.Industry='Automotive';
        acc.Lead_Source__c='Internet';
      Id rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].Id;
        
        acc.recordtypeid = rtId ;
        acc.Industry='Aerospace';
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Manager_s_Probability__c=70;
           opp.StageName='Under Negotiation';
            opp.Customer_Type__c='New';
           
            insert opp;
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
        String selectReportType;
        testAccPlan.selectReportType='NEXT_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        system.debug('****5****'+testAccPlan.accountOppListForNew);
        }
        Static testmethod void customReportMethodProbbility6(){
       
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
      //  acc.Industry='Automotive';
        acc.Lead_Source__c='Internet';
        acc.Industry='Aerospace';
   Id rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].Id;
        
        acc.recordtypeid = rtId ;
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Manager_s_Probability__c=90;
           opp.StageName='Under Negotiation';
            opp.Customer_Type__c='New';
           
            insert opp;
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
        String selectReportType;
        testAccPlan.selectReportType='NEXT_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        system.debug('****5****'+testAccPlan.accountOppListForNew);
        }
        Static testmethod void customReportMethodProbbility5(){
       
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
        acc.Industry='Automotive';
        acc.Lead_Source__c='Internet';
     Id rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].Id;
        
        acc.recordtypeid = rtId ;
        //acc.Industry='Aerospace';
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Manager_s_Probability__c=90;
           opp.StageName='Under Negotiation';
            opp.Customer_Type__c='New';
           
            insert opp;
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
        String selectReportType;
        testAccPlan.selectReportType='THIS_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        system.debug('*****6***'+testAccPlan.accountOppListForNew);
        }
        Static testmethod void customReportMethodProbbility7(){
       
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
       acc.Industry='Automotive';
        acc.Lead_Source__c='Internet';
      Id rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].Id;
        
        acc.recordtypeid = rtId ;
       // acc.Industry='Aerospace';
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Manager_s_Probability__c=70;
           opp.StageName='Under Negotiation';
            opp.Customer_Type__c='Existing Customer';
           
            insert opp;
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
        String selectReportType;
        testAccPlan.selectReportType='NEXT_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        
        
        system.debug('****7****'+testAccPlan.accountOppListForNew);
        }
        Static testmethod void customReportMethodProbbility8(){
       
        Account acc=new account();
        acc.Name='Kvp';
        acc.Type='Customer';
        acc.Ownership='Public Ltd';
        acc.Strategic_Importance__c='Less';
        acc.Strategic_Account__c='YEs';
        acc.Account_Priority__c='Low';
        acc.Financial_Stability_Risk__c='Low';
        acc.Payment_Structure_Collection_Risk__c='Low';
        acc.Country_Specific_Statutory_Risk__c='Low';
        acc.Service_Availability_Risk_Other_Countrie__c='Low';
       acc.Industry='Automotive';
       Id rtId = [select id from recordtype where developername='MBA'  AND SobjectType = 'Account' LIMIT 1].Id;
        
        acc.recordtypeid = rtId ;
        acc.Lead_Source__c='Internet';
       // acc.Industry='Aerospace';
        insert acc;
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            opp.Amount=100;
            //opp.StageName='RFQ Study';
            opp.Project_Type__c='Domestic';
            opp.Name='Titan';
            opp.CloseDate=System.today();
            opp.Expected_Machine_Dispatch_Date__c=System.today();
            opp.RFQ_Reference1__c='Test Record';
            opp.Feasibility__c='yes';
            opp.RFQ_Received_Visit_Date__c=System.today();
            opp.Comment_Remarks__c='abcd';
            opp.Comment_Remarks_Ad__c='TestRecord';
            opp.New_Technology_Experience__c='Low';
            opp.Quote_Type__c='Detailed Quote';
            opp.Service_Tax_Percent_del__c=50;
            opp.Similar_Project_from_Other_Account__c='Low';
            opp.Repeat_Possibilities_Same_Account__c='Low';
            opp.Lower_Lead_Time_Risk__c='Low';
            opp.Manufacturability_Risk__c='Low';
            opp.Design_Cycle_Time_Risk__c='Low';
            opp.Process_Risk__c='Low';
            opp.Customer_Product_Risk__c='Low';
            opp.Manager_s_Probability__c=90;
            opp.StageName='Under Negotiation';
            opp.Customer_Type__c='Existing Customer';
           
            insert opp;
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ReportOnFicalYear testAccPlan = new ReportOnFicalYear(sc);
        String selectReportType;
        testAccPlan.selectReportType='NEXT_FISCAL_YEAR';
        testAccPlan.generateExcel();
        testAccPlan.generateReport();
        system.debug('****8****'+testAccPlan.accountOppListForNew);
        } 
 
}