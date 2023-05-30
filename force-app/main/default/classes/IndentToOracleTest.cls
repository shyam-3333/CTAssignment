@isTest

private class IndentToOracleTest{

    static testMethod void IndentToOracleTestMethod() {
         LIst<Quote> lUpdateQuote = new List<Quote>();
         List<Quote> lQuote = new List<Quote>();
         Account a = new Account(Name = 'Test for Indent Account');
         insert a;
         
         Opportunity  opp = new Opportunity(AccountID = a.ID,Name= 'Test for Indent Opportunity',StageName = 'Revised Quote',Type = 'new',Region_Picklist__c = 'North',Amount = 1000,CloseDate = System.Today());
         insert opp;
         
         Quote qt = new Quote(Name = 'test Indent Quote',OpportunityID = opp.ID,Product_for_Approval__c = 'GV/GC Valid on Gold Coin',Indent_Created__c = True,Order_Type__c='Custom'); 
         insert Qt;
         
         lQuote.add(qt);  
         
         IndentToOracle io = new IndentToOracle();
             io.fetch(); 
         IndentToOracle.DefinedTestParam  indentOracle = new IndentToOracle.DefinedTestParam();
         indentOracle.id = qt.id;
         indentOracle.Insti_ref = 'fefefefrre';
         indentOracle.Indent_Created_Date = system.today();
         indentOracle.Discount   = 32324;
         indentOracle.Cheque_No_RTGS_No  = 'fefefefrre';
         indentOracle.Cheque_Date = system.today();
         indentOracle.Bank_Name = 'fefefefrre';
         indentOracle.Customer_Id = 'fefefefrre';
         indentOracle.PO_No = 'fefefefrre';
         indentOracle.PO_Date = System.today();
         indentOracle.Region_Picklist = 'fefefefrre';
         indentOracle.Subtotal = 1232131;
         indentOracle.Product_for_Approval = 'fefefefrre';
         indentOracle.Commemt = 'fefefefrre';


             
         for(Quote qt1 : lQuote){
             qt1.Indent_Status__c  = 'Processed';
             lUpdateQuote.add(qt1);
         }
         if(!lUpdateQuote.isEmpty()){
            update lUpdateQuote;
         }
    }
}