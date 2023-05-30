public class VFNA_03{
 public decimal grandTotal2{get;set;}
 public decimal grandTotal3{get;set;}
  Public List<Opportunity> accounttotals2{get;set;}
    public VFNA_03(){}
    public VFNA_03(VFNA_07 controller) {
       grandTotal2=0;
       grandTotal3=0;
       accounttotals2= new List<Opportunity>();
        for(Opportunity opp:[Select Account.Name,Name,Basic_Price_INR_In_Lakhs__c,Turnover_INR_In_Lakhs__c,PO_Date__c,LOI_Date__c,Member1__r.Name,Member2__r.Name
        from opportunity where  Account.Industry!='Automotive' AND (Record_Type_Name__c != 'MBA Services Allocated' OR Record_Type_Name__c != 'Spares & Services Record Type'
        OR Record_Type_Name__c != 'Regret MBA Record Type' OR Record_Type_Name__c != 'PECSA' OR Record_Type_Name__c != 'MBA Spares Final' OR Record_Type_Name__c !='MBA Services Final') AND 
        (StageName = 'Order Won' OR  StageName = 'Project Under Execution'
        OR  StageName = 'Project Closed') AND Customer_Type__c != 'Internal Customer'  AND  (PO_Date__c=THIS_FISCAL_YEAR 
        OR LOI_Date__c=THIS_FISCAL_YEAR) AND (PO_Date__c=LAST_N_DAYS:30 OR LOI_Date__c=LAST_N_DAYS:30) AND Account.RecordType.Name ='MBA' Order By Member1__r.Name ASC NULLS LAST]){
             accounttotals2.add(opp);
        }
        if(accounttotals2.Size() != NULL){
        for(Opportunity opp : accounttotals2){
            grandTotal2=grandTotal2+opp.Basic_Price_INR_In_Lakhs__c;
            grandTotal3=grandTotal3+opp.Turnover_INR_In_Lakhs__c;
            
         }
        }
         
    }
    
  }