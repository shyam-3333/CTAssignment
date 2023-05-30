@isTest
public class Test_PecsaAttValidation{
    static testmethod void test_pecsaattvalidation(){
        Account acc = new Account(Name='TestAccount');
        insert acc;
        
        Attachment att = new Attachment(ParentId=acc.Id,Name='LTA.',Body=blob.valueOf('ttttt'));
        insert att;
        
        Attachment att1 = new Attachment(ParentId=acc.Id,Name='MOU.',Body=blob.valueOf('ttttt'));
        insert att1;
        
        Attachment att2 = new Attachment(ParentId=acc.Id,Name='NDA.',Body=blob.valueOf('ttttt'));
        insert att2;
        
        Attachment att3 = new Attachment(ParentId=acc.Id,Name='Bank_Guarantee.',Body=blob.valueOf('ttttt'));
        insert att3;
        
        Attachment att4 = new Attachment(ParentId=acc.Id,Name='Indemnity_bond.',Body=blob.valueOf('ttttt'));
        insert att4;
        
        Attachment att5 = new Attachment(ParentId=acc.Id,Name='Insurance.',Body=blob.valueOf('ttttt'));
        insert att5;
        
        acc.LTA__c = true;
        acc.MOU__c=true;
        acc.NDA__c=true;
        acc.Bank_Guarantee__c = true;
        acc.Indemnity_bond_chkbox__c=true;
        acc.Insurance__c=true;
        update acc;
        
        
    }
}