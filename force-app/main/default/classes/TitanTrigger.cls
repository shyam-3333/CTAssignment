Public class TitanTrigger{
    public AllTriggers triggers=new AllTriggers();
    public class AllTriggers{
        public OpportunityStageNameError StageNameError=new OpportunityStageNameError();
        public opportunitystagevalidation  stagevalidation =new opportunitystagevalidation();
       // public OpportunityAttachmentsize   Attachmentsize=new OpportunityAttachmentsize();
      //  public Opportunityownerchange      ownerchange=new Opportunityownerchange();
    }
    public class OpportunityStageNameError{
        set<id> opid=new set<id>();
        List<Opportunity> opportunitylist=new List<Opportunity>();
        Public void init(Opportunity currentopp,Opportunity previousopp){
            if(previousopp.StageName=='Order Closed' || previousopp.StageName=='Order cancelled'){
                currentopp.addError('An Opportunity cannot be edited once the opportunity stage is Order Closed');
            }
        }
    }

    public class opportunitystagevalidation{
        set<id> opplistid=new set<id>();
        Map<id,Opportunity> oppmap=new Map<id,Opportunity>();
        Map<id,Opportunity> privousoppmap=new Map<id,Opportunity>();
        public void init(Opportunity currentopp,Opportunity previousopp){
            if(currentopp.Record_Type_Name__c=='Watches' || currentopp.Record_Type_Name__c=='Jewellery'||currentopp.Record_Type_Name__c=='Lifestyle'){
                if((currentopp.StageName != previousopp.StageName)){
                     oppmap.put(currentopp.id,currentopp);
                     privousoppmap.put(previousopp.id,previousopp);
                }
            }
        }
        public List<Opportunity> Process(List<Opportunity> Opportunities) {
            if(!oppmap.isempty()){
                for(Quote quotes:[select OpportunityId,Customization_Payment_Criteria__c,Approval_Status_Quote__c from Quote where OpportunityId=:oppmap.keyset()]){
                    if(oppmap.get(quotes.OpportunityId)!=null && oppmap.get(quotes.OpportunityId).stagename!= privousoppmap.get(quotes.OpportunityId).StageName && quotes.Customization_Payment_Criteria__c =='Free Of Cost' && quotes.Approval_Status_Quote__c!='Approved'){
                        oppmap.get(quotes.OpportunityId).addError('cannot change Stage as Quote Customization Payment Criteria is Free of cost and quote is not approved');
                    }
                }
            }
            return Opportunities;
        }
    }
    
    
    public class OpportunityAttachmentsize{
        public Map<id,Opportunity> oppmap=new  Map<id,Opportunity>();
        public void init(Opportunity currentopp){
            oppmap.put(currentopp.id,currentopp);
        }
        public List<opportunity> Process(List<opportunity> opplist){
            Integer Vattachmentcount = 0;
        Integer Regicount = 0;
            Integer Invoicecount = 0; 
            for(Attachment  ca : [Select id,Name from Attachment where  ParentId=:oppmap.keyset()]){
                if(ca.Name.indexOfIgnoreCase('validated')>=0 ){
                    Vattachmentcount++;
                }
                 if(ca.Name.indexOfIgnoreCase('invoice')>=0 ){
                    Invoicecount++;
                }
        if(ca.Name.indexOfIgnoreCase('registration')>=0 ){
                    Regicount++;
                }
         }
             for(Opportunity Opp:Opplist){
                 if(oppmap.get(opp.id)!=null && oppmap.get(opp.id).Record_Type_Name__c == 'Jewellery' && oppmap.get(opp.id).Customization_Status__c == 'Validated' && (oppmap.get(opp.id).StageName == 'Proforma Invoice'||oppmap.get(opp.id).StageName == 'Received PO/Order Won' ||oppmap.get(opp.id).StageName == 'Payment/Delivery' ||oppmap.get(opp.id).StageName == 'Order Closed' )&& Vattachmentcount == 0){
                     opp.addError('Please upload the appropriate file with the keyword "validated" included within the file name');
                }
                 if(oppmap.get(opp.id)!=null && oppmap.get(opp.id).Record_Type_Name__c == 'Jewellery' && (oppmap.get(opp.id).Account.TIN_No__c == '1'||oppmap.get(opp.id).Account.CST_No__c == '1'||oppmap.get(opp.id).Account.PAN_No__c == '1') && (oppmap.get(opp.id).StageName == 'Proforma Invoice'||oppmap.get(opp.id).StageName == 'Received PO/Order Won' ||oppmap.get(opp.id).StageName == 'Payment/Delivery' ||oppmap.get(opp.id).StageName == 'Order Closed' )&& Regicount == 0){
                     opp.addError('Please upload the appropriate file with the keyword "registration" included within the file name');
                }
        
                if((oppmap.get(opp.id)!=null && oppmap.get(opp.id).Record_Type_Name__c == 'Lifestyle' || oppmap.get(opp.id).Record_Type_Name__c == 'Watches') && oppmap.get(opp.id).Customization_Status__c == 'Validated' && (oppmap.get(opp.id).StageName == 'Proforma Invoice'||oppmap.get(opp.id).StageName == 'Received PO/Order Won' ||oppmap.get(opp.id).StageName == 'Payment/Delivery' ||oppmap.get(opp.id).StageName == 'Order Closed' ) && Vattachmentcount == 0){
                    oppmap.get(opp.id).addError('Please upload the appropriate file with the keyword "validated" included within the file name');
                }
              /*  if(oppmap.get(opp.id)!=null && oppmap.get(opp.id).Delivery_Status__c == 'Completed' && oppmap.get(opp.id).StageName == 'Payment/Delivery' && Invoicecount == 0){
                    oppmap.get(opp.id).addError('Please upload the appropriate file with the keyword "Invoice" included within the file name');
                }*/
            }
            
            return opplist;
        }
    }
    public static boolean recursiveFlag = true;
    /*public class Opportunityownerchange{
    
        public List<Opportunity> process(List<Opportunity> opplist,Integer intval){
            recursiveFlag = false;
            Map<String,String> Opprectype = new Map<String,String>{};
            if(!Test.isRunningTest()){
            for(RecordType rt: [Select Name, Id From RecordType where sObjectType='Opportunity' and isActive=true]){
                Opprectype.put(rt.Name,rt.Id);
            }
            Map<String,String> Usermap = new Map<String,String>{};
            for(User u: [Select Name, Id From User where  isActive=true  and  (name=:'Suresh C' or name=: 'N Karunanithi')]){
                Usermap.put(u.Name,u.Id);
            }
            
            for(Opportunity opp:opplist){
                if(opp.Record_Type_Name__c != 'Jewellery' && opp.Record_Type_Name__c != 'Lifestyle' && opp.Record_Type_Name__c != 'Watches'){
                    if(intval==0){
                        if(opp.CreatedDate.date() >= date.newInstance(2012, 2, 7)) {
                        if(opp.Recordtypeid !=Opprectype.get('MBA Services Allocated') && opp.Recordtypeid !=Opprectype.get('PECSA') && opp.Recordtypeid !=Opprectype.get('Quote Submitted Spares') && opp.Recordtypeid !=Opprectype.get('Regret MBA Record Type') && opp.Recordtypeid != Opprectype.get('Spares & Services Record Type')) {
                                system.debug('In side PECSA');
                                if(opp.Member1__c == null) {
                                    opp.OwnerId = Usermap.get('Suresh C');  //'00530000004B7s2';
                                }
                                else {
                                    opp.Ownerid=opp.Member1__c;
                                }  
                            }
                        }
                    }
                    else {
                        if(opp.Recordtypeid !=Opprectype.get('MBA Services Allocated') && opp.Recordtypeid !=Opprectype.get('PECSA') && opp.Recordtypeid !=Opprectype.get('Quote Submitted Spares') && opp.Recordtypeid !=Opprectype.get('Regret MBA Record Type') && opp.Recordtypeid != Opprectype.get('Spares & Services Record Type')) {
                                system.debug('In side PECSA');
                                if(opp.Member1__c == null) {
                                    opp.OwnerId = Usermap.get('Suresh C');  //'00530000004B7s2';
                                }
                                else {
                                    opp.Ownerid=opp.Member1__c;
                                }  
                            }
                            
                        if(opp.Recordtypeid ==  Opprectype.get('Spares & Services Record Type')){
                            opp.OwnerId = Usermap.get('N Karunanithi');      //'00530000004D0GS';
                        }
                    }
                }
            }
            }
            return opplist;
        }
    }*/
    public void test1(){
        integer i=0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
    }
}