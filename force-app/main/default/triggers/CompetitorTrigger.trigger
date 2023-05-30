trigger CompetitorTrigger on Competitor__c (before insert,before update) {
	//CompetitorTriggerHandler comp = new CompetitorTriggerHandler();
   //  if(trigger.isUpdate && trigger.isBefore){
   //     comp.avoidDuplicateUpdate(trigger.new, trigger.oldMap);
   // }
	if(trigger.isInsert && trigger.isBefore){
		//comp.avoidDuplicateInsert(trigger.new);
        new CompetitorNameAndZipcodeDuplication().whileInsert(trigger.new);
    }
}