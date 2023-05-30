/*********************************************************************
   Name         : Titan
   Description  : This class is used for the capturing the record of Time Plan in two table with dynamic query and wrapper class.
                  
   Created By   : Ashutosh@KVP
   Created Date : 10/09/2014
   
   REVISION HISTORY
   ================
   
   Date          By                  Description
   ---------------------------------------------------------------
    31-Dec-2014  Hardev Parmar    By passed validation rule while saving record from inline vf page            
   
   
***************************************************************************************************************************/

 global without sharing class OppTimePlan{
    public List<WrapperRecPlan> lstWrapperRecPlan {get;set;}
    public List<WrapperRecPlan> lstWrapperRecPlanCopy{get;set;}
    public List<Opportunity> listOppProposed {get;set;}
    public boolean isEdit {get;set;}
    public boolean isShow {get;set;}
    public boolean isFlag {get;set;}
    public Id currentId {get;set;}
    public Id profileId {get;set;}
    public boolean disableedit{get;set;}
    public Boolean restrictRow{get;set;}
    public Boolean displayRowTechLead{get;set;}
    public OppTimePlan(ApexPages.StandardController stdController) {
        isEdit = false;
        isFlag =false;
        currentId = stdController.getId();// currentId capture current Id of Opportunity record.
        listOppProposed = [Select Id,Ignore_Validation_Rule__c, Activities_Planned_Ad__c, Activities_Planned__c,Comment_Remarks_Ad__c,Comment_Remarks__c,
                          Concept_Validation_Ad__c,Concept_Validation__c,Customer_Committed_Date_Ad__c,Customer_Committed_Date__c,
                          Elec_Proposal_Submission_Ad__c,Elec_Proposal_Submission__c,Mech_Proposal_Submission_Ad__c,Mech_Proposal_Submission__c,
                          Parameter__c,R1_Proposal_Submission_Ad__c,R1_Proposal_Submission__c,Remarks_for_Delay_Ad__c,Remarks_for_Delay__c,
                          RFQ_Qualified_Ad__c,RFQ_Qualified__c,Strategy_Meeting_Ad__c,Strategy_Meeting__c,Visit_Ad__c,Visit__c,
                          (SELECT Activities_Planned__c,Comment_Remarks__c,Concept_Validation__c,Customer_Commited_Date__c,Elec_Proposal_Submission__c,
                          Id,Mech_Propsal_Submission__c,Opportunity__c,Parameter__c,R1_Proposal_Submission__c,Remarks_for_Delay__c,RFQ_Qualified__c,
                          Strategy_Meeting__c,Visit__c FROM Time_Plans__r order by CreatedDate ASC) from Opportunity where Id = :currentId];

        lstWrapperRecPlan = new List<WrapperRecPlan>();
        lstWrapperRecPlanCopy = new List<WrapperRecPlan>();
        integer i = 0;
        disableedit=false;
        restrictRow=false;
        displayRowTechLead=false;
       if(listOppProposed.size() > 0) {// Time_Plans__r is related object of Opportunity
           for(Time_Plan__c tp : listOppProposed[0].Time_Plans__r) {
                WrapperRecPlan wrp = new WrapperRecPlan(tp,++i);
                lstWrapperRecPlan.add(wrp);  
            }
        }
        restrictUser();
    }
     
     
     
    public void restrictUser() {
        Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        system.debug('ProfileName'+profileName);
        if(profileName=='Team member'||profileName=='Manager' || profileName=='Team Leader') {
            if(lstWrapperRecPlan.size()>=1) {
                disableedit=true;
            }else {
                disableedit=false;
            }
       }else {
                disableedit=false;
       }
       if(profileName=='Team member'){
           restrictRow=true;
       }
        if(profileName=='Manager' || profileName=='HOD' || profileName=='Team Leader'){
           displayRowTechLead=true;
       }
   }
   
          
    public void editRecord(){
        if(lstWrapperRecPlan.size()==0){
            lstWrapperRecPlan.add(new WrapperRecPlan(new Time_Plan__c(), lstWrapperRecPlan.size()+1));
        }
        disableedit=false;
        isEdit = true;
        restrictUser();
   }
    
    public void save() {
     
      try{
            
            listOppProposed[0].Ignore_Validation_Rule__c = true;
            update listOppProposed;
            
            List<Time_Plan__c> lstTP1 = new List<Time_Plan__c>();
           
        for(WrapperRecPlan wrp : lstWrapperRecPlan) {
            wrp.timePlan.Opportunity__c = currentId;
            lstTP1.add(wrp.timePlan); 
        }
        lstTP1.sort();
        upsert lstTP1;
        isEdit = false;
        isFlag=false;
       
        if(lstWrapperRecPlanCopy.size()>0){
            lstWrapperRecPlan.addAll(lstWrapperRecPlanCopy);
        }
        lstWrapperRecPlan.sort();
        }
        catch(Exception ex){  
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage()));
             return;
       }
       restrictUser();
     }

    public void cancel(){
        Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        if(lstWrapperRecPlan.size()>=1 && profileName!='HOD'){
            lstWrapperRecPlan.clear();
        }
        isEdit = false;
        isFlag=false;
    }
    public void cancelFirstPage(){
       lstWrapperRecPlan.clear();
       lstWrapperRecPlan.addAll(lstWrapperRecPlanCopy);
       isEdit = false;
       isFlag=false;
    }
    public void addRow(){
        lstWrapperRecPlanCopy = new List<WrapperRecPlan>();
        for(WrapperRecPlan wp:lstWrapperRecPlan){
            lstWrapperRecPlanCopy.add(wp);
        }
        lstWrapperRecPlan.clear();
        lstWrapperRecPlan.add(new WrapperRecPlan(new Time_Plan__c(), lstWrapperRecPlanCopy.size()+1));
         isEdit = true;
         isShow = true;
         isFlag = true;
    } 
    public void deleteRow(){
        String index = Apexpages.currentpage().getParameters().get('index');
        list<WrapperRecPlan> tempWrap =  new list<WrapperRecPlan>();
        tempWrap.addAll(lstWrapperRecPlan);
        if(index != null) {
            Integer i = Integer.valueOf(index); 
            for(WrapperRecPlan wrp : tempWrap) {
                if(wrp.index == i) {
                    if(wrp.timePlan.id != null ){
                       try{
                         delete wrp.timePlan;
                         lstWrapperRecPlan.remove(i-1);
                       }
                       catch(Exception e){
                       }
                    }
                }
             try{
             }catch(Exception e){}
                 
             }
        }
        isEdit = false;
        isFlag=false;
        Integer sizeofWrapper=1;
        Set<Time_Plan__c> lstTP1 = new Set<Time_Plan__c>();
        for(WrapperRecPlan wrp : lstWrapperRecPlan) {
            wrp.timePlan.Opportunity__c = currentId;
            lstTP1.add(wrp.timePlan); 
        }
        lstWrapperRecPlan.clear();
        for(Time_Plan__c tp:lstTP1){
            WrapperRecPlan wrp = new WrapperRecPlan(tp,sizeofWrapper);
            lstWrapperRecPlan.add(wrp);
            lstWrapperRecPlan.sort();
            sizeofWrapper++;
        }
        lstWrapperRecPlan.sort();
    }
    // create wrapper class for Revised Plan Date.
    global class WrapperRecPlan implements Comparable{
        public Time_Plan__c timePlan {get;set;}
        public Integer index {get;set;}    
        public WrapperRecPlan(Time_Plan__c tp, Integer i) {
            timePlan = tp;
            index = i;
        }
       global Integer compareTo(Object ObjToCompare) {//Sort the Wrapper class by taking order number
          WrapperRecPlan testWrap=(WrapperRecPlan)ObjToCompare;
          if(index == testWrap.index){
            return 0;
          }
          if(index > testWrap.index){
            return 1;
          }
            return -1;
      } 
    }
}