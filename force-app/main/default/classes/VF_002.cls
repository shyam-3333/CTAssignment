public class VF_002 {
    public decimal grandTotal{get;set;}
    public List<AccountTotal> getaccounttotals() {
        List<AccountTotal> accounttotals= new List<AccountTotal>();
        for(Account a:[SELECT name,(Select Name,Amount_In_Lakhs__c,StageName,Member1__r.FirstName,Member2__r.FirstName
        from opportunities where Opportunity_Age__c >= 28 AND (StageName = 'Preliminary Opportunity' OR StageName = 'RFQ Study'
        OR  StageName = 'Concept Finalization' OR  StageName = 'Costing' OR  StageName = 'Quote Preparation'))
        from account WHERE  ID IN(select accountid from opportunity where (Account.Industry='Automotive' )  AND Opportunity_Age__c >= 28 AND (StageName = 'Preliminary Opportunity' OR StageName = 'RFQ Study'
        OR  StageName = 'Concept Finalization' OR  StageName = 'Costing' OR  StageName = 'Quote Preparation') )]) {
            accounttotals.add(new AccountTotal(a));
        }
        grandTotal=0;
        List<Opportunity> oppList=new List<Opportunity>();
        for(AccountTotal act : accounttotals ){
          oppList.addAll(act.account.opportunities);
        }
        for(Opportunity opp : oppList){
         grandTotal=grandTotal+opp.Amount_In_Lakhs__c;
        }
        return sortAccountTotals(accounttotals);
    }
    public class AccountTotal {
        public Account account { get; private set; }
        public Opportunity total { get; private set; }
        public Decimal individualAmount{get;set;}
        public accountTotal(Account a) {
            account = a;
            individualAmount=0;
            total = new Opportunity(Total_Amount_In_Lakh__c= 0);
            for(Opportunity o:a.opportunities) {
                if(o.Amount_In_Lakhs__c!= null)
                    individualAmount+= o.Amount_In_Lakhs__c;
            }
        }
    }
    private List<AccountTotal> sortAccountTotals(List<AccountTotal> totals) {
        List<AccountTotal> returnList = new List<AccountTotal>();
        Map<Decimal, List<AccountTotal>> totalMap = new Map<Decimal, List<AccountTotal>>();
        for(AccountTotal t:totals) {
            if(totalMap.get(t.total.Amount_In_Lakhs__c) == null) {
                totalMap.put(t.total.Amount_In_Lakhs__c, new List<AccountTotal>());
            }
        totalMap.get(t.total.Amount_In_Lakhs__c).add(t);
        }
        List<Decimal> keys = new List<Decimal>(totalMap.keySet());
        keys.sort();
        for(Integer i = (keys.size()-1);i >= 0; i--) {
            returnList.addAll(totalMap.get(keys.get(i)));
        }
        return returnList;
    }
}