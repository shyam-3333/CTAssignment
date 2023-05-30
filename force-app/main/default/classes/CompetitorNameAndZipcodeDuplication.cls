public class CompetitorNameAndZipcodeDuplication {
    public void whileInsert(list<Competitor__c> newList){
        set<string> names = new set<string>();
        
        for(Competitor__c Acc :[select Name,PostalCode__c from Competitor__c]){
            
            if(acc.Name.contains(' ')){
                names.add(acc.Name.substringBefore(' ')+Acc.PostalCode__c);
                if(acc.Name.substringAfter(' ').contains(' ')){
                    names.add(acc.Name.substringAfter(' ').substringBefore(' ')+Acc.PostalCode__c);
                    if(acc.Name.substringAfter(' ').substringAfter(' ').contains(' ')){
                        names.add(acc.Name.substringAfter(' ').substringAfter(' ').substringBefore(' ')+Acc.PostalCode__c);
                    }
                    else{
                        names.add(acc.Name.substringAfter(' ').substringAfter(' ')+Acc.PostalCode__c);
                    }
                }
                else {
                    names.add(acc.Name.substringAfter(' ')+Acc.PostalCode__c);
                }
            } 
            else{
                names.add(acc.Name+Acc.PostalCode__c);
            }
            
        } 
        system.debug('names'+names);
        for(Competitor__c acc : newList){
            integer dupCount = 0;
                if(Acc.Name.contains(' ')){
                    if(names.contains(Acc.Name.substringBefore(' ')+Acc.PostalCode__c)){
                        dupCount++;                  
                    }
                    if(Acc.Name.substringAfter(' ').contains(' ')){
                        if(names.contains(Acc.Name.substringafter(' ').substringBefore(' ')+Acc.PostalCode__c)){
                            dupCount++;                       
                        }
                        if(Acc.Name.substringAfter(' ').substringAfter(' ').Contains(' ')){
                            if(names.contains(Acc.Name.substringafter(' ').SubStringAfter(' ').SubstringBefore(' ')+Acc.PostalCode__c)){
                                dupCount++;                   
                            }
                        }
                        else{
                            if(names.contains(Acc.Name.substringafter(' ').SubStringAfter(' ')+Acc.PostalCode__c)){
                                dupCount++;                   
                            }
                        }
                    }
                    else{
                        if(names.contains(Acc.Name.substringAfter(' ')+Acc.PostalCode__c)){
                            dupCount++;                
                        }
                    }
                }
                else{
                    if(names.contains(Acc.Name+Acc.PostalCode__c)){
                        dupCount++;                   
                    }
                }
            
            system.debug('dupCount==>'+dupCount);
            If(dupCount>=1 && acc.Skip_duplication_rule__c == false){
                    Acc.AddError('Duplicate Name and Postal code');
            }
        }
        
    }
    
   
}