trigger Trigger_Update_Planned_Start_Date on Project_Stage_History__c (after update) {

    Set<ID> oppid = new Set<ID>();
    Set<String> stagename = new Set<String>();
    Map<String,Date> oppmap = new Map<String,Date>(); 
    List<Project_Stage_History__c> updpsh = new List<Project_Stage_History__c>();
    for(Project_Stage_History__c psh : Trigger.New){
        Project_Stage_History__c oldpsh = Trigger.oldMap.get(psh.ID);
        if(oldpsh.Planned_End_Date__c != psh.Planned_End_Date__c && psh.Planned_End_Date__c != null){
            oppid.add(psh.Opportunity__c);
            String s;
            if(psh.Stage_Name__c == 'Under Study'){
                s =  'Clarifications/Additional Inputs' + psh.Opportunity__c;
               stagename.add('Clarifications/Additional Inputs');
               // s =  'RFQ Study' + psh.Opportunity__c;
              //  stagename.add('RFQ Study');
            }else if(psh.Stage_Name__c == 'Clarifications/Additional Inputs'){
                s = 'Concept Finalization' + psh.Opportunity__c;
                stagename.add('Concept Finalization');  
            }else if(psh.Stage_Name__c == 'Concept Finalization'){        
                s = 'BOM/Costing generation/Tech specs-Mech' + psh.Opportunity__c;
                stagename.add('BOM/Costing generation/Tech specs-Mech');  
            }else if(psh.Stage_Name__c == 'BOM/Costing generation/Tech specs-Mech'){
                s = 'BOM/Costing generation/Tech specs-Elec' + psh.Opportunity__c;
                stagename.add('BOM/Costing generation/Tech specs-Elec');  
            }else if(psh.Stage_Name__c == 'BOM/Costing generation/Tech specs-Elec'){
                s = 'Quote & Submission (Release 1)' + psh.Opportunity__c;        
                stagename.add('Quote & Submission (Release 1)');  
            }
            oppmap.put(s,psh.Planned_End_Date__c);
        }   
    }
    
    for(Project_Stage_History__c psh : [select ID,Opportunity__c,Stage_Name__c,Planned_Start_Date__c,Planned_End_Date__c from Project_Stage_History__c where Opportunity__c IN: oppid AND Stage_Name__c IN: stagename]){
        Project_Stage_History__c p = new Project_Stage_History__c(ID = psh.ID);
        p.Planned_Start_Date__c = oppmap.get(psh.Stage_Name__c+psh.Opportunity__c);
        updpsh.add(p);
    }
    Update updpsh;
}