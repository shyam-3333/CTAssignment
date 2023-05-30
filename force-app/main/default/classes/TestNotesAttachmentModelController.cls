@isTest 
private class TestNotesAttachmentModelController {
    static testMethod void myUnitTest() {
          Account ac= new Account();
               ac.Name='Test';
               insert ac;
         Contact conNew = new Contact();
            conNew.Firstname = 'PeeWee';
            conNew.LastName = 'Herman';
            conNew.AccountId = ac.Id;
            conNew.Email='sachin.deshmukh@kvpcorp.com';
            insert conNew;
       Opportunity opp = new Opportunity();
            opp.Name = 'Test';
            opp.StageName ='Proforma Invoice';
            opp.CloseDate = System.today();
            opp.AccountId = ac.id;
            insert opp;
       
       Quote q = new Quote();
           q.OpportunityId = opp.Id;
           q.Name = 'Field';
           q.Email='test@gmail.com';
           q.ContactId = conNew.id;
           insert q;
        Attachment attach1 =new Attachment();      
            attach1.Name='Unit Test Attachment.pdf';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            attach1.body=bodyBlob;
            attach1.ParentId = q.id;
            insert attach1;
       Test.startTest();
       Attach a = new Attach();
           Attach.attachWordpdf(q.Id, 'indentGV');
           Attach.attachWordpdf(q.Id, 'indent');
           Attach.attachWordpdf(q.Id, 'ProformaInvoice');
           Attach.attachWordpdf(q.Id, 'PerformaGV');
           Attach.attachWordpdf(q.Id, 'Proformawatches');
           Attach.attachWordpdf(q.Id, 'Indentwatches');
           Attach.attachWordpdf(q.Id, 'IndentGC');
       
       
             PageReference pref = Page.NoteAttachment;
                pref.getParameters().put('id',q.id);
                pref.getParameters().put('Attch',attach1.id);
                Test.setCurrentPage(pref);
            ApexPages.StandardController sc = new ApexPages.StandardController(q);
            NotesAttachmentModelController con = new NotesAttachmentModelController(sc);
            con.sendEmail();
            pref = con.attachfile();
            pref = con.createNote();
            pref = con.viewAll();
            pref = con.showpage();
       Test.stopTest();   
                   
     }
}