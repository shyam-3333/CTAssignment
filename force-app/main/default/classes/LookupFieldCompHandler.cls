/**
 * @description       : 
 * @author            : Mutturaj Haeroor
 * @group             : 
 * @last modified on  : 05-06-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-26-2021   Mutturaj Haeroor                     Initial Version
**/
public with sharing class LookupFieldCompHandler {
    
     public LookupFieldCompHandler() {}
    
   /* @AuraEnabled
    public static List<sObject> fetchRecord( string objName , string whereCond, String searchFieldName ,String searchStr ){
        try {
            System.debug(objName);
            if( objName != null && objName !='')
            {
                string queryStr = 'SELECT Id,'+ (searchFieldName != 'Name'  ? 'Name,'+searchFieldName : searchFieldName)  +' FROM '+ objName  + ' where '+ searchFieldName +' LIKE  '+ (searchStr == '' || searchStr == null  ? '\'%\'' : '\'' + searchStr+'%\'' )+ ' '+  (whereCond == '' || whereCond == null ? '' : ' And ' +whereCond ) ;
                List<sObject> objectList = Database.query( queryStr );
                System.debug( objectList.size());
                return objectList;
            }
            else{
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/
}