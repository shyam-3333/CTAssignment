/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/14/2019   T01    SOQL inside for loop
Saradha(Lister)  11/15/2019   T02	DML Inside for loop
*/
trigger NPDCollectionTrigger on NPD_Collections__c (before update, after update) {
    public  set<id> collectionid  = new set<id>();
    public npd_stage__c  npdStg1 = new npd_stage__c();
    public string TempBrandName =''; 
    
    public string npdCollectionids ='' ;
    
    public set<id> activityidforOwner1  =  new set<id>();
    public set<id> projectidowner1  =  new set<id>();
    public set<id> setprojectitemsowner1  =  new set<id>();
    //<T01>
    Set<id> setOfNPDIds = new Set<id>();
    //</T01>
    if(trigger.isafter && trigger.isupdate){
        //<T01>
        for(NPD_Collections__c  nc1: trigger.new){
            setOfNPDIds.add(nc1.id);
        }
        
        Map<id,NPD_Collections__c> mapOfNPD_Collections = new Map<id,NPD_Collections__c>
            ([SELECT id, Name , (select id from npd_activity__r)FROM NPD_Collections__c where id in :setOfNPDIds]);
        //</T01>
        for(NPD_Collections__c  nc1: trigger.new){
            if(nc1.SF_Project_Owner__c != trigger.oldmap.get(nc1.id).SF_Project_Owner__c){
                System.debug('activityidforOwner outside if:'+activityidforOwner1);
                
                //<T01>
                if(mapOfNPD_Collections.containskey(nc1.id) && mapOfNPD_Collections.get(nc1.id) != null && mapOfNPD_Collections.get(nc1.id).npd_activity__r != null){
                    for(npd_activity__c n1:mapOfNPD_Collections.get(nc1.id).npd_activity__r){
                        activityidforOwner1.add(n1.id);
                    }
                }
                
               
                /* for(npd_activity__c n1:[select id from npd_activity__c where NPD_Collections__c =: nc1.id])
					{
						activityidforOwner1.add(n1.id);
					}
				*/
                
                 //</T01>
                 
               /* if(activityidforOwner1.size()>0 ){
                    System.debug('activityidforOwner1'+activityidforOwner1);
                    NPD_UtilityController.ownerAssingmentforActivity(activityidforOwner1,projectidowner1,setprojectitemsowner1);
                }*/  
                
            }
            
            if(nc1.MarketingBrand__c!=trigger.oldmap.get(nc1.id).MarketingBrand__c || nc1.MarketingSub_Brand__c!=trigger.oldmap.get(nc1.id).MarketingSub_Brand__c || nc1.Source__c!=trigger.oldmap.get(nc1.id).Source__c 
               || nc1.Market__c!=trigger.oldmap.get(nc1.id).Market__c){
                   collectionid.add(nc1.id);
                   System.debug('***********collidcollid'+collectionid  );
               }
            
        }
        //<T02>
        if(activityidforOwner1.size()>0 ){
            System.debug('activityidforOwner1'+activityidforOwner1);
            NPD_UtilityController.ownerAssingmentforActivity(activityidforOwner1,projectidowner1,setprojectitemsowner1);
        }
		//</T02>        
        //calling method to update collection field in related Stages//Substages//Activity//Subactivity
        if(collectionid!=NULL){
            NPD_UtilityController.updatecollectionvalue(collectionid,trigger.new);
        }
    }
    
    
    
    
}