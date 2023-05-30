@isTest

private class ProjectStageHistory{

    static testMethod void ProjectStageHistoryTestMethod() {
         RecordType rt = [select id,Name from RecordType where SobjectType='Opportunity' Limit 1];
          List<Opportunity> opp = new List<Opportunity>();

         Opportunity o = new Opportunity();
         o.Name = 'Test Opp for PSH';
         o.StageName = 'Under Study';
         o.CloseDate = System.Today() + 10;
         o.Archive_Documents__c = 'No';
         o.Document_Archival_Completed__c = 'Yes';
         insert o;
         o.CloseDate = System.Today() + 12;
         o.Sub_Activities__c = 'Explanation to Electrical Team' ;
         o.Document_Archival_Completed__c = 'No';
         o.Archive_Documents__c = 'Yes';
         
         o.StageName = 'Reciept of PO/Submission of OA-ClosedWon';
         update o;
         
         
        // Attachment   att = [select ID,Name,ParentID from Attachment where ParentID =:o.id];
         
         Opportunity o2 = new Opportunity(recordTypeId=rt.id);
         o2.Name = 'Test Opp for PH';
         o2.StageName = 'Under Study';
         o2.CloseDate = System.Today() + 10;
         o2.Sub_Activities__c = 'Explanation to Electrical Team' ;
         o2.Archive_Documents__c = 'Yes';
         o2.Document_Archival_Completed__c = 'No';

         insert o2;
         
         o2.CloseDate = System.Today() + 12;
         o2.StageName = 'Request for Amendment';
         update o2;
         
         Opportunity o3 = new Opportunity(recordTypeId=rt.id);
         o3.Name = 'Test Opp for PH';
         o3.StageName = 'Order Won';
         o3.CloseDate = System.Today() + 1;
        // o3.Sub_Activities__c = 'Explanation to Electrical Team' ;
         //o3.Archive_Documents__c = 'Yes';
         //o3.Document_Archival_Completed__c = 'No';

        // insert o3;
         
         o3.CloseDate = System.Today() + 12;
        // update o3;
         
         
         List<Project_Stage_History__c> pshlist = new List<Project_Stage_History__c>();
     
         Project_Stage_History__c psh = new Project_Stage_History__c();
         psh.Opportunity__c = o2.ID;
         psh.Stage_Name__c = 'Under Study';
         psh.Planned_End_Date__c = System.Today() + 10;
         pshlist.add(psh);
         
         Project_Stage_History__c psh1 = new Project_Stage_History__c();
         psh1.Opportunity__c = o.ID;
         psh1.Stage_Name__c = 'Clarifications/Additional Inputs';
         psh1.Planned_End_Date__c = System.Today() + 10;
         pshlist.add(psh1);
         
         Project_Stage_History__c psh2 = new Project_Stage_History__c();
         psh2.Opportunity__c = o.ID;
         psh2.Stage_Name__c = 'Concept Finalization';
         psh2.Planned_End_Date__c = System.Today() + 10;
         pshlist.add(psh2);
         
         Project_Stage_History__c psh3 = new Project_Stage_History__c();
         psh3.Opportunity__c = o.ID;
         psh3.Stage_Name__c = 'BOM/Costing generation/Tech specs-Mech';
         psh3.Planned_End_Date__c = System.Today() + 10;
         pshlist.add(psh3);
         
         Project_Stage_History__c psh4 = new Project_Stage_History__c();
         psh4.Opportunity__c = o.ID;
         psh4.Stage_Name__c = 'BOM/Costing generation/Tech specs-Elec';
         psh4.Planned_End_Date__c = System.Today() + 10;
         pshlist.add(psh4);
         
         insert pshlist;
         
         pshlist.clear();
         
         Project_Stage_History__c psh5 = new Project_Stage_History__c(ID = psh.Id);
         psh5.Planned_End_Date__c = System.Today() + 12;
         pshlist.add(psh5);
         
         Project_Stage_History__c psh6 = new Project_Stage_History__c(ID = psh1.Id);
         psh6.Planned_End_Date__c = System.Today() + 12;
         pshlist.add(psh6);
         
         Project_Stage_History__c psh7 = new Project_Stage_History__c(ID = psh2.Id);
         psh7.Planned_End_Date__c = System.Today() + 12;
         pshlist.add(psh7);
         
         Project_Stage_History__c psh8 = new Project_Stage_History__c(ID = psh3.Id);
         psh8.Planned_End_Date__c = System.Today() + 12;
         pshlist.add(psh8);
         
         Project_Stage_History__c psh9 = new Project_Stage_History__c(ID = psh4.Id);
         psh9.Planned_End_Date__c = System.Today() + 12;
         pshlist.add(psh9);
         
         Update pshlist;
         
          Task T = new Task();
          T.Type = 'Email';
          t.subject = 'Email';
          T.Description = 'Test'; //string
          //T.OwnerId = ''; //user id
          T.WhatId = o.id; //record id
          insert T;
          
          T.Description = 'Testing';
          update T;
    }
}