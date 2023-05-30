public class VF_001 {
    public decimal grandTotal{get;set;}
    public decimal totalTurnover{get;set;}
    public List<AccountTotal> getaccounttotals() {
        List<AccountTotal> accounttotals= new List<AccountTotal>();
        for(Account a:[select name, (Select Name,Basic_Price__c,Turnover1__c,PO_Date__c,LOI_Date__c,Member1__r.FirstName,Member2__r.FirstName
        from opportunities)
             from account where Id IN (select accountid from opportunity)]) {
            accounttotals.add(new AccountTotal(a));
            system.debug('%%%%%%'+accounttotals);
        }
        grandTotal=0;
        totalTurnover=0;
        List<Opportunity> oppList=new List<Opportunity>();
        for(AccountTotal act : accounttotals ){
          oppList.addAll(act.account.opportunities);
          system.debug('$$$$$$'+oppList);
        }
        for(Opportunity opp : oppList){
         //grandTotal=grandTotal+opp.Basic_Price__c;
         grandTotal=opp.Basic_Price__c;
        }
        for(Opportunity opp : oppList){
         //grandTotal=grandTotal+opp.Basic_Price__c;
         totalTurnover=opp.Turnover1__c;
        }
        return sortAccountTotals(accounttotals);
    }
    public class AccountTotal {
        public Account account { get; private set; }
        public Opportunity total { get; private set; }
        public accountTotal(Account a) {
            account = a;
            total = new Opportunity(Basic_Price__c= 0);
            for(Opportunity o:a.opportunities) {
                if(o.Basic_Price__c!= null)
                    total.Basic_Price__c+= o.Basic_Price__c;
            }
        }
    }
    private List<AccountTotal> sortAccountTotals(List<AccountTotal> totals) {
        List<AccountTotal> returnList = new List<AccountTotal>();
        Map<Decimal, List<AccountTotal>> totalMap = new Map<Decimal, List<AccountTotal>>();
        for(AccountTotal t:totals) {
            if(totalMap.get(t.total.Basic_Price__c) == null) {
                totalMap.put(t.total.Basic_Price__c, new List<AccountTotal>());
            }
        totalMap.get(t.total.Basic_Price__c).add(t);
        }
        List<Decimal> keys = new List<Decimal>(totalMap.keySet());
        keys.sort();
        for(Integer i = (keys.size()-1);i >= 0; i--) {
            returnList.addAll(totalMap.get(keys.get(i)));
        }
        return returnList;
    }
}