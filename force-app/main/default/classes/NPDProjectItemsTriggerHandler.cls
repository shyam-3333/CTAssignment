public class NPDProjectItemsTriggerHandler {
    
    
    List<NPD_Project_Items__c> pitemDeleteList = new List<NPD_Project_Items__c>();
    List<NPD_Project_Items__c> pitemActiveUpdateList = new List<NPD_Project_Items__c>();
    List<NPD_Project_Items__c> pitemInActiveUpdateList = new List<NPD_Project_Items__c>();
    public void childDelete(Map<Id,NPD_Project_Items__c> pitemMap ){
        set<Id> pitemId = new set<id>();
        for(NPD_Project_Items__c pitemRec :pitemMap.values() ){
            pitemId.add(pitemRec.Id);
        }
        for(NPD_Project_Items__c pi : [select id from NPD_Project_Items__c  where Parent_Id__c in : pitemId]){
            pitemDeleteList.add(pi);   
        }
        if(!pitemDeleteList.isEmpty()){    
            delete pitemDeleteList;
        }          
    }
    public void childActiveOrInactive(Map<Id,NPD_Project_Items__c> pitemMap ){
        set<Id> pitemId = new set<Id>();
        for(NPD_Project_Items__c pitemRec :pitemMap.values() ){
            pitemId.add(pitemRec.Id);
        }
        system.debug('P ITEM ID'+pitemId);
       for(NPD_Project_Items__c pi : [select id,Parent_Id__c from NPD_Project_Items__c  where Parent_Id__c in : pitemId]){
           system.debug('#1'+pitemMap.containskey(pi.Parent_Id__c ));
           system.debug('#2'+pitemMap.get(pi.Parent_Id__c).active__c);
           if(pitemMap.containskey(pi.Parent_Id__c ) && pitemMap.get(pi.Parent_Id__c).active__c == true){
               
                   pi.Active__c = pitemMap.get(pi.Parent_Id__c).active__c;
                   pitemActiveUpdateList.add(pi);   
             }
             if(pitemMap.containskey(pi.Parent_Id__c ) && pitemMap.get(pi.Parent_Id__c).active__c == false){
                   pi.Active__c = pitemMap.get(pi.Parent_Id__c).active__c;
                   pitemInActiveUpdateList.add(pi);   
             }
        }
        if(!pitemActiveUpdateList.isEmpty() || !pitemInActiveUpdateList.isEmpty()){
            update pitemActiveUpdateList;
            update pitemInActiveUpdateList;
        }
    }
    //Copy_CheckList_Items__c
    
    public void copyChecklistItemsOnSubActInsert(list<NPD_Project_Items__c>lstNpdProject){
    
        set<ID>setId = new set<Id>();
        
        map<string,string>mapCopyId_copyChecklist = new map<string,string>();
        map<string,string>mapCopyId_copyColumns = new map<string,string>(); 
        
        for(NPD_Project_Items__c npi:lstNpdProject){
            if(npi.Copy_CheckList_Items__c !=null &&( npi.Item_Type__c=='Sub-Activity' ||npi.Item_Type__c=='Activity' )){
                setId.add(npi.Copy_CheckList_Items__c);
            }
        }
        for(NPD_Project_Items__c n :[select id,Checklist_Columns__c,Columns_to_Copy__c from NPD_Project_Items__c where id In : setId]){
            mapCopyId_copyChecklist.put(n.id,n.Checklist_Columns__c);
            mapCopyId_copyColumns.put(n.id,n.Columns_to_Copy__c);
        }
        for(NPD_Project_Items__c npi:lstNpdProject){
            if(mapCopyId_copyChecklist.containskey(npi.Copy_CheckList_Items__c)){
                npi.Checklist_Columns__c=mapCopyId_copyChecklist.get(npi.Copy_CheckList_Items__c);
            
            }
            
         if(mapCopyId_copyColumns.containskey(npi.Copy_CheckList_Items__c) && mapCopyId_copyColumns.get(npi.Copy_CheckList_Items__c) != NULL ){
                npi.Columns_to_Copy__c=mapCopyId_copyChecklist.get(npi.Copy_CheckList_Items__c);
            
            }
        
        }
    }
    
    /*public void copyChecklistItemsOnActInsert(map<id,NPD_Project_Items__c>mapNew,map<id,NPD_Project_Items__c>mapOldValue){
        
        map<id,string>mapCopyId_copyChecklist=new map<id,string>();
        for( NPD_Project_Items__c n:mapNew.values()){
            if(mapOldValue.get(n.id).Checklist_Columns__c != mapNew.get(n.id).Checklist_Columns__c && (mapNew.get(n.id).Item_Type__c=='Sub-Activity'||mapNew.get(n.id).Item_Type__c=='Activity') ){
                    mapCopyId_copyChecklist.put(n.id,n.Checklist_Columns__c);
            
            }
        
        }
        for(NPD_Project_Items__c n:[select id,Checklist_Columns__c from NPD_Project_Items__c where id In : mapCopyId_copyChecklist.keyset()]){
        
        
        }
    
    }*/
    

}