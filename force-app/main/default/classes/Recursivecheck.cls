/************

Developed By    : Vinoth Kumar (KVP Business Solution Pvt Ltd).
Created Date    : 19/06/2019.
Purpose         : This class is use to control the recursion.

************/

public Class Recursivecheck{
    public static boolean run = true;
    public static boolean isOpportunityToFeedbackAfterUpdateRecursive = false;
     public static boolean isOpportunityAutoUpdateOfCustomerType = false;
    
    public static boolean runOnce(){
        system.debug('truerun:'+run);
        if(run){
         run=False;
         return True;
        }else{
            system.debug('falserun:'+run);
            return run;
         }
    }
}