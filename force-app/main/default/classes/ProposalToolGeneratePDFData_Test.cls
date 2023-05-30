@isTest
public class ProposalToolGeneratePDFData_Test {
    static testMethod void ProppdfTest(){
        Test.StartTest();
        
        Product_Master__c pm = ProposalToolTestDataFactory.createProduct('Eyewear','Sunglasses');
        
        
        
        Proposal__c prop = new Proposal__c();
        insert prop;
        
        Proposal_Products__c propProd = new Proposal_Products__c();
        propProd.Custom_Images__c = 'Test.jpg';
        propProd.Product_Full_Name__c = 'test';
        propProd.Proposal__c = prop.Id;
        propProd.Product__c= pm.Id;
        
        propProd.List_Price__c = 10;
        propProd.Offer_Price__c = 10;
        
        insert propProd;
        
        
        
        
        Test.setCurrentPageReference(new PageReference('Page.Proposal_Tool_Pdf'));
        ApexPages.currentPage().getParameters().put('proposalToolId',prop.Id);
        ProposalToolGeneratePDFData.generatePDF();
        
        
        
        Test.StopTest();
    }
}