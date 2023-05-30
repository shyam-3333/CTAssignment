public class VFAO7Days_06 {
  Public List<Opportunity> accounttotals5{get;set;}
    public VFAO7Days_06 (){}
    public VFAO7Days_06(VFAO7Days_07 controller) {
       accounttotals5= new List<Opportunity>();
        for(Opportunity opp:[SELECT Account.Name,Name,CreatedDate,R1_Proposal_Submission_Ad__c,Member1__r.Name,Member2__r.Name,StageName,Opportunity_Age__c 
        from opportunity where  (Account.Industry='Automotive') AND Opportunity_Age__c >= 28 AND (StageName = 'Preliminary Opportunity' OR StageName = 'RFQ Study'
        OR  StageName = 'Concept Finalization' OR  StageName = 'Costing' OR  StageName = 'Quote Preparation')
         AND Account.RecordType.Name ='MBA' Order By Member1__r.Name ASC NULLS LAST]){
             accounttotals5.add(opp);
        }
      
         
    }
    
  }