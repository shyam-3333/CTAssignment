public class RollUpNoOfFilesHelper {
    public void calculateNoOfFiles(List<ContentDocumentLink> ConList){
        system.debug('conList===>'+conList);
        Set<id> idSet = new Set<id>();
        
        for(ContentDocumentLink con : ConList){
            
            idSet.add(con.LinkedEntityId);
            
        }
        
        list<opportunity> opList = new list<opportunity>();
        map<id,integer> toFuture = new  map<id,integer>();
        if(idSet.size()>0){
            opList = [select id,Name,No_of_content_documents__c from opportunity where id in :idSet];
            system.debug('opList===>'+opList);
            for(opportunity opp : opList){
                if(opp.No_of_content_documents__c!=null){
                    opp.No_of_content_documents__c = opp.No_of_content_documents__c + 1;
                    toFuture.put(opp.Id,(integer)opp.No_of_content_documents__c);
                }
                else{
                    opp.No_of_content_documents__c = 1;
                    toFuture.put(opp.Id,(integer)opp.No_of_content_documents__c);
                }
                
            }
           futureMethod(toFuture);
        }
        
    }
    public void decrementWhileDelete(list<ContentDocument> conTlist){
        system.debug('In helper');
        Map<id,integer> oppMap = new  Map<id,integer>();
        list<id> idSet = new list<id>();
        list<id> opIds = new list<id>();
        for(ContentDocument con : conTlist){
            idSet.add(con.Id);
        }
        system.debug('contentDocument ids =====>'+idSet);
        string idOne = idSet[0];
        list<ContentDocumentLink> conL = new list<ContentDocumentLink>();
        conL = [SELECT Id, LinkedEntityId, ContentDocumentId, IsDeleted, SystemModstamp, ShareType, Visibility FROM ContentDocumentLink where contentDocumentId = :idOne];
        system.debug('ContentDocumentLink===>'+conL);
        for(ContentDocumentLink conL1 : conL){
            
            if(string.ValueOf(conL1.LinkedEntityId).startsWith('006')){
                opIds.add(conL1.LinkedEntityId); 
            }
            
        } 

        system.debug('opportunity >'+opIds);
        list<opportunity> opList = new list<opportunity>();
        opList = [select id,No_of_content_documents__c from opportunity where id in :opIds];
        for(opportunity opp : opList){
            opp.No_of_content_documents__c = opp.No_of_content_documents__c - 1;
            oppMap.put(opp.Id,(Integer)opp.No_of_content_documents__c);
        }
        system.debug('opList====>'+opList);
        futureMethod(oppMap);
    }
    public void futureMethod(Map<id,Integer> valuesList){
       List<opportunity> oppList = new list<opportunity>();
        for(id opId : valuesList.Keyset()){
            opportunity opp = new opportunity();
            opp.Id = opId;
            Opp.No_of_content_documents__c = valuesList.get(opId);
            oppList.add(opp);
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
    
}