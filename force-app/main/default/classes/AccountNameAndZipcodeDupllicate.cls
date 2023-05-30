public class AccountNameAndZipcodeDupllicate { 
    
    private final static string dupePanError='Another Account with the same PAN No. is already available';
    private final static string dupeSapError='Another Account with the same SAP Code is already available';
    private final static string dupeGstError='Another Account with the same GST No. is already available';
    
    public void whileInsert(list<Account> newList){
        set<string> names = new set<string>();
        Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Account.getRecordTypeInfosById();
        
        for(Account Acc :[select Name,BillingPostalcode from Account where RecordType.Name IN ('Prospect_MBA', 'MBA','Suspect_MBA','Consultant_MBA')]){
            
            if(acc.Name.contains(' ')){
                names.add(acc.Name.substringBefore(' ')+Acc.BillingPostalCode);
                if(acc.Name.substringAfter(' ').contains(' ')){
                    names.add(acc.Name.substringAfter(' ').substringBefore(' ')+Acc.BillingPostalCode);
                    if(acc.Name.substringAfter(' ').substringAfter(' ').contains(' ')){
                        names.add(acc.Name.substringAfter(' ').substringAfter(' ').substringBefore(' ')+Acc.BillingPostalCode);
                    }
                    else{
                        names.add(acc.Name.substringAfter(' ').substringAfter(' ')+Acc.BillingPostalCode);
                    }
                }
                else {
                    names.add(acc.Name.substringAfter(' ')+Acc.BillingPostalCode);
                }
            } 
            else{
                names.add(acc.Name+Acc.BillingPostalCode);
            }
            
        } 
        system.debug('names'+names);
        for(Account acc : newList){
            integer dupCount = 0;
            string rtName = rtMap.get(Acc.RecordTypeId).getName();
            system.debug('Acc.RecordType.Name'+rtName);
            if(rtName == 'Prospect_MBA' || rtName == 'MBA' || rtName == 'Suspect_MBA' || rtName == 'Consultant_MBA'){
                system.debug('In if');
                
                if(Acc.Name.contains(' ')){
                    if(names.contains(Acc.Name.substringBefore(' ')+Acc.BillingPostalCode)){
                        dupCount++;                  
                    }
                    if(Acc.Name.substringAfter(' ').contains(' ')){
                        if(names.contains(Acc.Name.substringafter(' ').substringBefore(' ')+Acc.BillingPostalCode)){
                            dupCount++;                       
                        }
                        if(Acc.Name.substringAfter(' ').substringAfter(' ').Contains(' ')){
                            if(names.contains(Acc.Name.substringafter(' ').SubStringAfter(' ').SubstringBefore(' ')+Acc.BillingPostalCode)){
                                dupCount++;                   
                            }
                        }
                        else{
                            if(names.contains(Acc.Name.substringafter(' ').SubStringAfter(' ')+Acc.BillingPostalCode)){
                                dupCount++;                   
                            }
                        }
                    }
                    else{
                        if(names.contains(Acc.Name.substringAfter(' ')+Acc.BillingPostalCode)){
                            dupCount++;                
                        }
                    }
                }
                else{
                    if(names.contains(Acc.Name+Acc.BillingPostalCode)){
                        dupCount++;                   
                    }
                }
            }
            system.debug('dupCount==>'+dupCount);
            If(dupCount>=1 && acc.Skip_duplication_rule__c == false){
                    Acc.AddError('Duplicate Name and Postal code');
            }
        }
        
    }
        public void checkDuplicate(List<Account> newList){
        system.debug('Inside checkDuplicate method');
        Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Account.getRecordTypeInfosById();
        Set<ID> accId = new Set<ID>();
        Map<String,Account> panMap = new Map<String,Account>();
        Map<String,Account> sapMap = new Map<String,Account>();   
        Map<String,Account> gstMap = new Map<String,Account>();    
            for(Account objAcc : newList){
            string rtName = rtMap.get(objAcc.RecordTypeId).getName();
                system.debug('RecordType'+rtName);
                if(rtName == 'Corporate'){
                    if(panMap.containsKey(objAcc.Pan_No__c))
                        objAcc.adderror(dupePanError);
                    else if(sapMap.containsKey(objAcc.Account_SAP_Id__c))
                        objAcc.adderror(dupeSapError);
                    else if(gstMap.containsKey(objAcc.GSTN_Number__c))
                        objAcc.adderror(dupeGstError); 
                    else{
                        if(objAcc.ID != null)
                            accId.add(objAcc.ID);
                        if(objAcc.Pan_No__c != null)
                            panMap.put(objAcc.Pan_No__c,objAcc);
                        if(objAcc.Account_SAP_Id__c != null)
                            sapMap.put(objAcc.Account_SAP_Id__c,objAcc); 
                        if(objAcc.GSTN_Number__c != null)
                            gstMap.put(objAcc.GSTN_Number__c,objAcc);    
                    }
                }
            }
            List<Account> accList = [select ID,Pan_No__c,Account_SAP_Id__c,GSTN_Number__c,RecordTypeId from Account where ((Pan_No__c IN: panMap.keyset() or Account_SAP_Id__c IN: sapMap.keyset() or GSTN_Number__c IN: gstMap.keySet()) AND ID NOT IN: accId)];
            system.debug('accList size '+accList.size()); 
            for(Account objAcc :accList){
                string rtName = rtMap.get(objAcc.RecordTypeId).getName();
                system.debug('RecordType'+rtName);
                if(rtName == 'Corporate'){                
                    if(objAcc != null){
                        Account panAccount = panMap.get(objAcc.Pan_No__c);
                        if(panAccount != null)
                            panAccount.adderror(dupePanError);
                        Account sapAccount = sapMap.get(objAcc.Account_SAP_Id__c);
                        if(sapAccount != null)
                            sapAccount.adderror(dupeSapError);
                        Account gstAccount = gstMap.get(objAcc.GSTN_Number__c);
                        if(gstAccount != null)
                            gstAccount.adderror(dupeGstError);  
                    }
                }
            }
        }
}