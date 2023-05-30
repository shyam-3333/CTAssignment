public class VFAO_04{
 public decimal grandTotal4{get;set;}
  Public List<Opportunity> accounttotals3{get;set;}
    public VFAO_04(){}
    public VFAO_04(VFAO_07 controller) {
       grandTotal4=0;
       accounttotals3= new List<Opportunity>();
        for(Opportunity opp:[Select Account.Name,Name,Reason__c,Amount_In_Lakhs__c,Opportunity_Lost_Date__c,Member1__r.Name,Member2__r.Name
        from opportunity where Account.Industry='Automotive' AND Opportunity_Lost_Date__c= LAST_N_DAYS:30  AND (Reason__c='Regret' OR Reason__c='Lost on cost'
        OR Reason__c='Lost on lead time' OR Reason__c='Lost on strategic reason' OR Reason__c='Project Shelved') AND Account.RecordType.Name ='MBA' 
        Order By Member1__r.Name ASC NULLS LAST]){
             accounttotals3.add(opp);
        }
       for(Opportunity opp : accounttotals3){
            if(opp.Amount_In_Lakhs__c!=null){
            grandTotal4=grandTotal4+opp.Amount_In_Lakhs__c;
            
         }
        }
         
    }
    
  }