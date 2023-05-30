public class VFAO7Days_05 {
  Public List<Opportunity> accounttotals4{get;set;}
    public VFAO7Days_05 (){}
    public VFAO7Days_05(VFAO7Days_07 controller) {
       accounttotals4= new List<Opportunity>();
        for(Opportunity opp:[Select Account.Name,Name,CreatedDate,R1_Proposal_Submission_Ad__c,Member1__r.Name,Member2__r.Name,StageName
        from opportunity where  Account.Industry='Automotive' AND (StageName = 'Preliminary Opportunity' OR StageName = 'RFQ Study' OR
        StageName = 'Concept Finalization' OR StageName = 'Costing' OR StageName = 'Quote Preparation') AND Account.RecordType.Name ='MBA' Order By Member1__r.Name ASC NULLS LAST]){
             accounttotals4.add(opp);
        }
      
         
    }
    
  }