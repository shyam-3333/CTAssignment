public class VFNA7Days_01{
 public decimal grandTotal{get;set;}
  Public List<Opportunity> accounttotals{get;set;}
    public VFNA7Days_01(){}
    public VFNA7Days_01(VFNA7Days_07 controller) {
       grandTotal=0;
     accounttotals= new List<Opportunity>();
        
        for(Opportunity opp:[SELECT Account.name, Name,Amount_In_Lakhs__c,StageName,First_Quote_Created_Date__c,Member1__r.Name,Member2__r.Name,(Select Name,Opportunity.Name,Opportunity.Amount_In_Lakhs__c,
        Opportunity.StageName,Opportunity.First_Quote_Created_Date__c,Opportunity.Member1__r.Name,Opportunity.Member2__r.Name,Account.Name,CreatedDate From Quotes where
         Name LIKE '%R1' )
        from opportunity where ID IN(select OpportunityId from quote where  Name LIKE '%R1') AND Account.Industry!='Automotive' AND 
        Account.RecordType.Name ='MBA' AND First_Quote_Created_Date__c =LAST_N_DAYS:7 AND (StageName = 'Await Customer Feedback(Quote Submitted)' OR StageName = 'Revised Quote Submission'
        OR  StageName = 'Under Negotiation' OR  StageName = 'Await Feedback (Under Negotiation)' OR  StageName = 'Order Won' OR  StageName = 'Project Under Execution' 
        OR  StageName = 'Project Closed' OR  StageName = 'Opportunity On Hold' OR  StageName = 'Opportunity Lost') ORDER BY Member1__r.Name ASC NULLS LAST ]){
            accounttotals.add(opp);
            
        }
        
          for(Opportunity opp : accounttotals){
            if(opp.Amount_In_Lakhs__c!=null){
            grandTotal=grandTotal+opp.Amount_In_Lakhs__c;
         }
        }
    }
    
        }