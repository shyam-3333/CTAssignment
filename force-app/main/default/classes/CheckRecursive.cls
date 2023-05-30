public with sharing class CheckRecursive {
    @testvisible
    private static boolean run = true;
    public static boolean skinnCollectionTriggerFlag = true;
    public static boolean skinnCollectionTemplateTriggerFlag = true;
    public static boolean skinnModelTriggerFlag = true;
    // Custom Setting
    public static Skinn_Triggers_Activation__c isTriggerActive = Skinn_Triggers_Activation__c.getOrgDefaults();
    public static boolean runOnce(){
        if(run){
            run=false;
            return true;
        }else{
            return run;
        }
    }
}