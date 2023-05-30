public class VF_07 {
    public decimal grandTotal2{get;set;}
    public List<AccountTotal> getaccounttotals2() {
        List<AccountTotal> accounttotals2= new List<AccountTotal>();
        for(Account a1:[select name, (select name,Amount_In_Lakhs__c, StageName, Member1__c, Member2__c from opportunities
            where CreatedDate = LAST_N_DAYS:30 AND Member1__c = null AND Member2__c = null )
            from account
            where ID IN (select accountid from opportunity where CreatedDate = LAST_N_DAYS:30 AND (Account.Industry='Automotive') AND Member1__c = null AND Member2__c = null) 
        ]) {
                accounttotals2.add(new AccountTotal(a1));
        }
        grandTotal2=0;
        List<Opportunity> oppList=new List<Opportunity>();
        for(AccountTotal act1 : accounttotals2 ){
          oppList.addAll(act1.account.opportunities);
        }
        for(Opportunity opp : oppList){
        if(opp.Amount_In_Lakhs__c!=null){
         grandTotal2=grandTotal2+opp.Amount_In_Lakhs__c;
         }
        }
        return sortaccounttotals2(accounttotals2);
    }
    public class AccountTotal {
        public Account account { get; private set; }
        public Opportunity total { get; private set; }
        public Decimal individualAmount{get;set;}
        public accountTotal(Account act2) {
            account = act2;
            individualAmount=0;
            total = new Opportunity(Total_Amount_In_Lakh__c= 0);
            for(Opportunity o:act2.opportunities) {
                if(o.Amount_In_Lakhs__c!= null)
                    individualAmount+= o.Amount_In_Lakhs__c;
            }
        }
    }
    private List<AccountTotal> sortaccounttotals2(List<AccountTotal> totals) {
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