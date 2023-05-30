@isTest
public class TestuploadAtt{
    static testmethod void TestuploadAtt(){
    
        Account acc = new Account(Name='TestAccount');
        insert acc;
        
      
        Attachment att = new Attachment(ParentId=acc.Id,Name='Insurance.',Body=blob.valueOf('body'));
        insert att;
  
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        apexpages.currentpage().getparameters().put('id',acc.id);        
        UploadAttBANKINSU claim = new UploadAttBANKINSU(sc);
        
        claim.fileName='Insurance.';
        claim.fileBody=blob.valueOf('body');
        claim.save();
        claim.displayAtt();
        
        }
        
        
    static testmethod void TestuploadAtt1(){
        
        Account ac = new Account(Name='TestAcc');
        insert ac;
        
      
        Attachment at = new Attachment(ParentId=ac.Id,Name='NDA.',Body=blob.valueOf('text'));
        insert at;
        ApexPages.StandardController sc1 = new ApexPages.standardController(ac);
        apexpages.currentpage().getparameters().put('id',ac.id);        
        UploadAttBANKINSU claim = new UploadAttBANKINSU(sc1);
        
        claim.fileName='Insurance.';
        claim.fileBody=blob.valueOf('body');
        claim.save();
        claim.displayAtt();
        }
        
   }