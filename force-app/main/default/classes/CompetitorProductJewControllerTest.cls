@isTest
public class CompetitorProductJewControllerTest {

    static testMethod void validateHelloWorld() {
        CompetitorProductJewController.getRecordType();
        CompetitorProductJewController.getPickListValue('Competitor_Product_Jew__c','Competitor_name__c');
        Competitor_Product_Jew__c comp = new Competitor_Product_Jew__c();
        comp.Competitor_name__c = 'Alankar';
        comp.Date_of_purchase__c = system.today();
        comp.Investigated_date__c = system.today();
        comp.Approved_date__c = system.today();
        insert comp;
        Competitor_Product_Jew__c comp1 = new Competitor_Product_Jew__c();
        comp1.Competitor_name__c = 'Alankar';
        CompetitorProductJewController.saveRecord('Plain',JSON.serialize(comp1));
        CompetitorProductJewController.getRecodTypeName(comp.Id);
        CompetitorProductJewController.fetchProduct(comp.Id);
        CompetitorProductJewController.updateCompRec(JSON.serialize(comp));
        CompetitorProductJewController.getContentDocs(comp.Id);
        CompetitorProductJewController.sendEmailTo(comp.Id, 'deepak.singh@kvpcorp.com', 'Plain');
        ApexPages.currentPage().getParameters().put('id', String.valueOf(comp.Id));
        CompetitorProdJewPDFController test = new CompetitorProdJewPDFController();

    }
}