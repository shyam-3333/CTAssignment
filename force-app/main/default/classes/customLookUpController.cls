public class customLookUpController {
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName, String whereCondition) {
        system.debug('ObjectName-->' + ObjectName);
        system.debug('searchKeyWord-->' + searchKeyWord);
        String searchKey = searchKeyWord + '%';
        String sQuery; 
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5
        
        sQuery =  'SELECT Id, Name from ' +ObjectName + ' where Name LIKE: searchKey and '+whereCondition+' order by createdDate DESC limit 15';
        
        if(ObjectName.equalsIgnoreCase('QC_Access_Component__c')){
            sQuery =  'SELECT Id, Name,Report_Ref_Number__c from ' +ObjectName + ' where Name LIKE: searchKey and '+whereCondition+' order by createdDate DESC limit 15';
        }
        if(ObjectName.equalsIgnoreCase('QC_MTL_Component__c')){
            sQuery='SELECT Id,Name,Report_Reference_Number__c,Raw_Material_Type__c,Testing_Type__c,Document_Status__c,Sample_Size_Plating__c from '+ObjectName+' where Report_Reference_Number__c LIKE: searchKey and '+whereCondition+' order by createdDate DESC limit 15';
        }
        
        
        
            system.debug('-------sQuery------'+sQuery);
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        System.debug('resultxxxxxxxxxxxxxxx'+returnList);
        return returnList;
    }
    
}