@isTest(seeAllData = true)
public class Test_TriggerUpdateAttachmentName{
    static testmethod void Test_TriggerUpdateAttachmentName(){
    
        test.starttest();
        Account acc = new Account(Name='TestAccount');
        insert acc;
        
        Opportunity opp = new Opportunity(Name = 'Test',Revision_No__c=0,StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = acc.id);
        insert opp;
        String name1 = 'Costing';
          
        Attachment att = new Attachment(ParentId=acc.Id,Name='Insurance.',Body=blob.valueOf('body'));
        insert att;
        
        Attachment attach1 =new Attachment();      
        attach1.Name='Insurance.';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.ParentId = opp.id;
        try{
        insert attach1;
        }Catch(Exception ex){
        }
        opp.Revision_No__c=20;
        update opp;
        Attachment attach2 =new Attachment();      
        attach2.Name='Insurance.';
        Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob1;
        attach2.ParentId = opp.id;
        try{
        insert attach2;
        }Catch(Exception ex){
        }
        
        test.stoptest();       
   }
      static testmethod void Test_TriggerUpdateAttachmentNameone(){
    
        test.starttest();
        Account acc = new Account(Name='TestAccount');
        insert acc;
        
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = acc.id);
        insert opp;
        String name1 = 'Costing';
          
        Attachment att = new Attachment(ParentId=acc.Id,Name='Insurance.',Body=blob.valueOf('body'));
        insert att;
        
        Attachment attach1 =new Attachment();      
        attach1.Name='Project_Approval';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.ParentId = opp.id;
        try{
        insert attach1;
        }Catch(Exception ex){
        }
        
        test.stoptest();       
   }
        static testmethod void Test_TriggerUpdateAttachmentNameone2(){
    
        test.starttest();
        Account acc = new Account(Name='TestAccount');
        insert acc;
        
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = acc.id);
        insert opp;
       
        
        test.stoptest();       
   }



}