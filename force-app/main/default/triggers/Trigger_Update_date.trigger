trigger Trigger_Update_date on Project_Stage_History_New__c (after update) {
    
    Map<ID,Date> designdate = new Map<ID,Date>();
    Map<ID,Date> commissiondate = new Map<ID,Date>();
    Map<ID,Date> warrantydate = new Map<ID,Date>();
    Map<ID,Date> mq2date = new Map<ID,Date>();
    List<ID> designopp = new List<Id>();
    List<ID> commissionopp = new List<ID>();
    List<ID> warrantyopp = new List<ID>();
    List<ID> mq2opp = new List<ID>();
    List<Opportunity> udesignopp = new List<Opportunity>();
    List<Opportunity> ucommissionopp = new List<Opportunity>();
    List<Opportunity> uwarrantyopp = new List<Opportunity>();
    List<Opportunity> umq2opp = new List<Opportunity>();
    for(Project_Stage_History_New__c proj_stage : Trigger.New){
        Project_Stage_History_New__c oldproj = Trigger.oldMap.get(proj_stage.ID);
        if(proj_stage.Stage_Name__c == 'Design' && oldproj.Actual_Start_Date_PS__c != proj_stage.Actual_Start_Date_PS__c && proj_stage.Actual_Start_Date_PS__c != null)
            designdate.put(proj_stage.Opportunity__c,proj_stage.Actual_Start_Date_PS__c);
        if(proj_stage.Stage_Name__c == 'Commissioning' && oldproj.Actual_End_Date_PS__c != proj_stage.Actual_End_Date_PS__c && proj_stage.Actual_End_Date_PS__c != null)
            commissiondate.put(proj_stage.Opportunity__c,proj_stage.Actual_End_Date_PS__c);
        if(proj_stage.Stage_Name__c == 'Warranty' && oldproj.Actual_End_Date_PS__c != proj_stage.Actual_End_Date_PS__c && proj_stage.Actual_End_Date_PS__c != null)
            warrantydate.put(proj_stage.Opportunity__c,proj_stage.Actual_End_Date_PS__c);
        if(proj_stage.Stage_Name__c == 'Testing' && oldproj.MQ2_Date__c != proj_stage.MQ2_Date__c && proj_stage.MQ2_Date__c != null)
            mq2date.put(proj_stage.Opportunity__c,proj_stage.MQ2_Date__c);
    }
    designopp.addAll(designdate.keySet());
    commissionopp.addAll(commissiondate.keySet());
    warrantyopp.addAll(warrantydate.keySet()); 
    mq2opp.addAll(mq2date.keySet());  
    for(ID oid : designopp){
        Opportunity o = new Opportunity(Id = oid);
        o.Design_Start_Date__c = designdate.get(oid);
        udesignopp.add(o);
    }
    Update udesignopp;
    
    for(ID oid : commissionopp){
        Opportunity o = new Opportunity(Id = oid);
        o.Commissioning_End_Date__c = commissiondate.get(oid);
        ucommissionopp.add(o);
    }
    Update ucommissionopp;
    
    for(ID oid : warrantyopp){
        Opportunity o = new Opportunity(Id = oid);
        o.Warranty_End_Date__c = warrantydate.get(oid);
        uwarrantyopp.add(o);
    }
    Update ucommissionopp;
    
    for(ID oid : mq2opp){
        Opportunity o = new Opportunity(Id = oid);
        o.MQ2_Date__c = mq2date.get(oid);
        umq2opp.add(o);
    }
    Update umq2opp;
}