public class VFNA7Days_02 {
 public decimal grandTotal1{get;set;}
  Public List<Opportunity> accounttotals1{get;set;}
    public VFNA7Days_02 (){}
    public VFNA7Days_02 (VFNA7Days_07 controller) {
       grandTotal1=0;
     accounttotals1= new List<Opportunity>();
        
        for(Opportunity opp:[SELECT Account.name, Name,Amount_In_Lakhs__c,StageName,First_Quote_Created_Date__c,Member1__r.Name,Member2__r.Name,(Select Name,Opportunity.Name,Opportunity.Amount_In_Lakhs__c,
        Opportunity.StageName,Opportunity.First_Quote_Created_Date__c,Opportunity.Member1__r.Name,Opportunity.Member2__r.Name,Account.Name,CreatedDate From Quotes where  (NOT Name LIKE '%R1') 
        AND CreatedDate=LAST_N_DAYS:7 )
        from opportunity where ID IN(select OpportunityId from quote where  (NOT Name LIKE '%R1') AND CreatedDate=LAST_N_DAYS:7) AND Account.Industry!='Automotive' AND 
        Account.RecordType.Name ='MBA' AND (StageName = 'Await Customer Feedback(Quote Submitted)' OR StageName = 'Revised Quote Submission'
        OR  StageName = 'Under Negotiation' OR  StageName = 'Await Feedback (Under Negotiation)' OR  StageName = 'Order Won' OR  StageName = 'Project Under Execution' 
        OR  StageName = 'Project Closed' OR  StageName = 'Opportunity On Hold' OR  StageName = 'Opportunity Lost') ORDER BY Member1__r.Name ASC NULLS LAST ]){
           accounttotals1.add(opp); 
        }
         for(Opportunity opp : accounttotals1){
            if(opp.Amount_In_Lakhs__c!=null){
            grandTotal1=grandTotal1+opp.Amount_In_Lakhs__c;
         }
        }
         
    }
    
        }