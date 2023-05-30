/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Developer1(Lister)  11/8/2019   T01     Test class issue fixing
*/
@isTest

private class AttachmentTest{

    static testMethod void AttachmentTestMethod() {
 
        
         
         Map<String,Schema.RecordTypeinfo> rec = Opportunity.SobjectType.getDescribe().getRecordTypeInfosByName();
       
         Account act = new Account(Name = 'Test Account for Test');
         insert act;
         Account aa=[select id,name from Account where id=:act.id];
         
         System.assertEquals('Test Account for Test',aa.name);
         Opportunity o = new Opportunity();
         o.Name = 'Test for Opp Test Method';
         o.RecordTypeId = rec.get('PECSA').getRecordTypeId(); //<T01> Changed the recordtype to PECSA from Initial Record type
         o.AccountID = act.ID;
         o.Type = 'AMC';
         o.StageName = 'Under Study';
         o.CloseDate = System.Today() + 10;
         insert o;
        
        List<Attachment> attList = new List<Attachment>();
        Attachment a = new Attachment();
         a.ParentID = o.ID;
         a.Name = 'Layout.txt';   
         a.Body = Blob.valueof('ABC');
         attList.add(a);
         
         Attachment a1 = new Attachment();
         a1.ParentID = o.ID;
         a1.Name = 'Costing.txt';   
         a1.Body = Blob.valueof('ABC');
         attList.add(a1);
         
         Attachment a2 = new Attachment();
         a2.ParentID = o.ID;
         a2.Name = 'Clarifications.txt'; 
         a2.Body = Blob.valueof('ABC');
          attList.add(a2);
         
         Attachment a3 = new Attachment();
         a3.ParentID = o.ID;
         a3.Name = 'OA.txt'; 
         a3.Body = Blob.valueof('ABC');
          attList.add(a3);
         
         Attachment a4 = new Attachment();
         a4.ParentID = o.ID;
         a4.Name = 'Timeline.txt';  
         a4.Body = Blob.valueof('ABC');
          attList.add(a4);
        
        
        
         
        

     /* list<Product__c> testproducts=TestForAskme.productRecord(1);
        testproducts[0].RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        insert testproducts;*/
         
         Attachment a5 = new Attachment();
         a5.ParentID = o.ID;
         a5.Name = 'Regret.txt';   
         a5.Body = Blob.valueof('ABC');
          attList.add(a5);
         
         Attachment a6 = new Attachment();
         a6.ParentID = o.ID;
         a6.Name = 'Cycletime.txt';  
         a6.Body = Blob.valueof('ABC');
          attList.add(a6);
        
      

         
         Attachment a7 = new Attachment();
         a7.ParentID = o.ID;
         a7.Name = 'Quote.txt';   
         a7.Body = Blob.valueof('ABC');
          attList.add(a7);
         insert attList;
             
       delete a7;
    }
    
     static testMethod void AttachmentTestMethod1() {
 
        
         
         Map<String,Schema.RecordTypeinfo> rec = Opportunity.SobjectType.getDescribe().getRecordTypeInfosByName();
       
         Account act = new Account(Name = 'Test Account for Test');
         insert act;
         Account aa=[select id,name from Account where id=:act.id];
         
         System.assertEquals('Test Account for Test',aa.name);
         Opportunity o = new Opportunity();
         o.Name = 'Test for Opp Test Method';
         o.RecordTypeId = rec.get('PECSA').getRecordTypeId(); //<T01> Changed the recordtype to PECSA from Initial Record type
         o.AccountID = act.ID;
         o.Type = 'AMC';
         o.StageName = 'Under Study';
         o.CloseDate = System.Today() + 10;
         insert o;
        
    
         
         Attachment a5 = new Attachment();
         a5.ParentID = o.ID;
         a5.Name = 'Regret.txt';   
         a5.Body = Blob.valueof('ABC');
          insert a5;
         
         Attachment a6 = new Attachment();
         a6.ParentID = o.ID;
         a6.Name = 'Cycletime.txt';  
         a6.Body = Blob.valueof('ABC');
         insert a6;
        
           Attachment a3 = new Attachment();
         a3.ParentID = o.ID;
         a3.Name = 'OA.txt'; 
         a3.Body = Blob.valueof('ABC');
          insert a3;

         
         Attachment a7 = new Attachment();
         a7.ParentID = o.ID;
         a7.Name = 'Quote.txt';   
         a7.Body = Blob.valueof('ABC');
          insert a7;
         
             
       delete a7;
    }
}