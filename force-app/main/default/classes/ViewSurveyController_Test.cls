@istest
private class ViewSurveyController_Test{
    //------------------------------------------------------------------------------//
    //------------------------------------------------------------------------------//
    private static Testmethod void testViewSurveyController() {
        SurveyTestingUtil tu = new SurveyTestingUtil();
        Apexpages.currentPage().getParameters().put('id',tu.surveyId);
        Apexpages.Standardcontroller stc;
        ViewSurveyController vsc = new ViewSurveyController(stc);
       viewShareSurveyComponentController v = new viewShareSurveyComponentController();
        
        ViewSurveyController vs = new ViewSurveyController(v);
        Survey__c survey =  new Survey__c();
        survey.Name ='test survey';
        insert survey;
       vsc.updateSurveyThankYouAndLink();
        vsc.refreshQuestionList();
        vsc.questionName = 'question name';
        vsc.questionRequired = true;
        vsc.resultPage();
        vsc.getResponses();
        vsc.updateSurveyName();
        vsc.init();
          vsc.qRequired = true;
        vsc.qQuestion = 'question name';
        vsc.qRequired = true;
        vsc.questionType = 'required';	
       // vsc.responses.add('test');
        vsc.surveyTakerId = 'id';
        System.assert(vsc.allQuestionsSize == 4);
        System.assert(tu.surveyId != null);
        
         Survey_Question__c sq = new Survey_Question__c();
        sq.name = 'Question Name';
        sq.Type__c = 'Single Select--Vertical';
        sq.Survey__c = survey.id;
        sq.OrderNumber__c = 1;
        sq.Required__c = true;
        sq.Question__c = 'test';
        insert sq;
         
        ViewSurveyController.checkRequired('string',sq);
      

        vsc.submitResults();
        for (SFQuestion q : vsc.allQuestions)
        {
            q.selectedOption = String.valueof(2);
            q.choices = String.valueof(2);
            q.selectedOptions = new List<String>();
            q.selectedOptions.add(String.valueof(2));
            vsc.submitResults();
        }
        System.assertEquals(false, vsc.thankYouRendered);
SurveyTaker__c st = new SurveyTaker__c();
        //test something
    }


    private static Testmethod void testUpdateSurveyName() {
        SurveyTestingUtil tu = new SurveyTestingUtil();
        Apexpages.currentPage().getParameters().put('id',tu.surveyId);
        Apexpages.Standardcontroller stc;
        ViewSurveyController vsc = new ViewSurveyController(stc);
        vsc.surveyName = 'new name';
        system.assert(vsc.updateSurveyName() == null);

    }


    private static Testmethod void testupdateSurveyThankYouAndLink() {
        SurveyTestingUtil tu = new SurveyTestingUtil();
        Apexpages.currentPage().getParameters().put('id',tu.surveyId);
        Apexpages.Standardcontroller stc;
        ViewSurveyController vsc = new ViewSurveyController(stc);
        vsc.surveyThankYouText = 'new stuff';
        vsc.surveyThankYouURL = 'more new stff';
        system.assert(vsc.updateSurveyThankYouAndLink()==null);
    }


}