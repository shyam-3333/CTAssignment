public class CustomLookUpControllerAcc {
    
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName, String whereCondition) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        String sQuery; 
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5
        //if(ObjectName.equalsIgnoreCase('QC_Access_Master__c')){
        		sQuery =  'SELECT Id, Name from ' +ObjectName + ' where Name LIKE: searchKey and '+whereCondition+' order by createdDate DESC limit 15';
        //}
        //else if(ObjectName.equalsIgnoreCase('QC_Access_Component__c')){
            //sQuery='SELECT Id,Name,Report_Ref_Number__c FROM '+ObjectName+ ' WHERE  Name LIKE:'+searchKey+'%'+ ' AND Document_Status__c='+'/Published/'+
                	 //'AND Record_Status__c='+'/Active/' + ' AND Sample_Category__c=:'+whereCondition +'ORDER BY CreatedDate DESC LIMIT 5 ' ;
        //}
        if(ObjectName.equalsIgnoreCase('QC_Access_Component__c')){
            sQuery =  'SELECT Id, Name,Report_Ref_Number__c from ' +ObjectName + ' where Report_Ref_Number__c LIKE: searchKey and '+whereCondition+' order by createdDate DESC limit 15';
        }
        
        
            system.debug('-------sQuery------'+sQuery);
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
    
    /*@AuraEnabled
    /public static List<QC_Access_Questions__c> fetchQuestions(){
      /  return null;
    //}*/
}