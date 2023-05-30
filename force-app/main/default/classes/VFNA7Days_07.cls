public class VFNA7Days_07 {
    public VFNA7Days_07(){}
    public decimal grandTotal{get;set;}
    public List<AccountTotal> getaccounttotals6() {
        List<AccountTotal> accounttotals6= new List<AccountTotal>();
        for(Account a:[select name, (select name,CreatedDate,Opportunity_Age__c from opportunities
        where  Member1__c = null AND Member2__c = null AND Account.Industry!='Automotive' AND (StageName = 'Preliminary Opportunity' OR StageName = 'RFQ Study' OR
        StageName = 'Concept Finalization' OR StageName = 'Costing' OR StageName = 'Quote Preparation')) from account
        where ID IN (select accountid from opportunity where (Account.Industry!='Automotive') AND (StageName = 'Preliminary Opportunity' OR StageName = 'RFQ Study' OR
        StageName = 'Concept Finalization' OR StageName = 'Costing' OR StageName = 'Quote Preparation') AND Member1__c = null AND Member2__c = null ) AND RecordType.Name ='MBA']) {
                accounttotals6.add(new AccountTotal(a));
        }
        return sortAccountTotals(accounttotals6);
    }
        public class AccountTotal {
        public Account account { get; private set; }
        public Opportunity total { get; private set; }
        public Decimal individualAmount{get;set;}
        public accountTotal(Account a) {
            account = a;
            individualAmount=0;
        }
    }
    private List<AccountTotal> sortAccountTotals(List<AccountTotal> totals) {
        List<AccountTotal> returnList = new List<AccountTotal>();
        Map<Decimal, List<AccountTotal>> totalMap = new Map<Decimal, List<AccountTotal>>();
        for(AccountTotal t:totals) {
            if(totalMap.get(t.total.Total_Amount_In_Lakh__c) == null) {
                totalMap.put(t.total.Total_Amount_In_Lakh__c, new List<AccountTotal>());
            }
        totalMap.get(t.total.Total_Amount_In_Lakh__c).add(t);
        }
        List<Decimal> keys = new List<Decimal>(totalMap.keySet());
        keys.sort();
        for(Integer i = (keys.size()-1);i >= 0; i--) {
            returnList.addAll(totalMap.get(keys.get(i)));
        }
        return returnList;
    }
}