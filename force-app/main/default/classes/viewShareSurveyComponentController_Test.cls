@isTest
private with sharing class viewShareSurveyComponentController_Test {
    private static testmethod void testShareSurvey()
    {
        Survey__c mySurvey = new Survey__c();
        mySurvey.Submit_Response__c = 'empty';
        mySurvey.EmailBody__c = 'test';
        insert mySurvey;
        
        Account acc = new Account();
        acc.Name = 'accountName';
        acc.Delivery_Type__c = 'Domestic Supply';
        acc.Industry = 'Services';
        acc.BillingPostalCode = '560102';
        acc.Type = 'Prospect';
        insert acc;
        
        contact Contact = new contact();
        contact.FirstName = 'vinoth';
        Contact.LastName = 'kumar';
        Contact.AccountId = acc.id;
        Contact.MobilePhone = '9784563210';
        Contact.Email = 'vinoth.kumar@kvpcorp.com';
        //insert Contact;
        contact Contact1 = new contact();
        contact1.FirstName = 'vinoth';
        Contact1.LastName = 'kumar';
        Contact1.AccountId = acc.id;
        Contact1.MobilePhone = '9784563210';
        Contact1.Email = 'vinoth1.kumar@kvpcorp.com';
        //insert Contact1;
        
        List<contact> contList =  new List<contact>();
        contList.add(contact);
        //contList.add(contact1);
        //site site = new site();
        insert contList;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName ='Proforma Invoice';
        opp.CloseDate = System.today();
        opp.AccountId = acc.id;
        insert opp;
        
        PageReference pageRef = Page.SurveyManagerPage; 
  		pageRef.getParameters().put('OppId', String.valueOf(Opp.Id));
  		Test.setCurrentPage(pageRef);
        
        
        viewShareSurveyComponentController vss = new viewShareSurveyComponentController();
        vss.surId = mySurvey.Id;
        vss.surveyId = mySurvey.Id;
        vss.surveyURL = vss.getVFUrl();
        vss.VisitAccName = '';
        vss.VisitAccString = '';
        
        
        /*
		// vss.selectedURLType = 'Chatter';
		// System.assertEquals(vss.getVFUrl(), vss.surveyURLBase);
		// System.assertEquals('id=' + mySurvey.Id /*+ '&cId={!Contact.Id}&caId=none', vss.surveyURL);*/
        
        vss.selectedURLType = 'Email Link w/ Contact Merge';
        System.assertEquals('id=' + mySurvey.Id/* + '&cId={!Contact.Id}&caId=none'*/, vss.surveyURL);
        
        vss.selectedURLType = 'Email Link w/ Contact & Case Merge';
        System.assertEquals('id=' + mySurvey.Id /*+  '&cId={!Contact.Id}&caId=none'*/, vss.surveyURL);
        vss.surveySite = null;
        vss.OppId=opp.id;
        vss.VisitName='';
        vss.VisitString='abc';
        vss.emailBody = 'testing email body';
        vss.AnonymousEmailValue = '';
        for(contact con:contList){
            // vss.selectedValues1.add(con.email); 
            vss.AnonymousEmailValue = con.email;
        }
        vss.sendAnonymousEmail();
        // vss.allContactEmail = '';
        vss.getSelectedValues();
        
        vss.sendEmail();
        vss.selectedValues1.add(Contact.Email);
        vss.NameString();
        vss.getSelectedValues();
        vss.sendEmail();
        
    }
}