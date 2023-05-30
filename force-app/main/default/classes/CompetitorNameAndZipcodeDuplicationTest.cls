@isTest
public class CompetitorNameAndZipcodeDuplicationTest {

    public static testMethod void method1(){
        Competitor__c c1 = new Competitor__c();
        c1.name = 'Test for deployment';
        c1.Company_Presence__c = 'Domestic';
        c1.Ownership__c = 'Public';
        c1.Annual_Revenue__c = 21212;
        c1.PostalCode__c = '454545';
         insert c1;   
          Competitor__c c2 = new Competitor__c();
        c2.name = 'Tests fors deployments';
        c2.Company_Presence__c = 'Domestic';
        c2.Ownership__c = 'Public';
        c2.Annual_Revenue__c = 21212;
        c2.PostalCode__c = '454545';
         insert c2; 
        Competitor__c c3 = new Competitor__c();
        c3.name = 'Testz';
        c3.Company_Presence__c = 'Domestic';
        c3.Ownership__c = 'Public';
        c3.Annual_Revenue__c = 21212;
        c3.PostalCode__c = '454545';
         insert c3;
        Competitor__c c4 = new Competitor__c();
        c4.name = 'Testy fory';
        c4.Company_Presence__c = 'Domestic';
        c4.Ownership__c = 'Public';
        c4.Annual_Revenue__c = 21212;
        c4.PostalCode__c = '454545';
         insert c4;
        Competitor__c c5 = new Competitor__c();
        c5.name = 'Test for deployment';
        c5.Company_Presence__c = 'Domestic';
        c5.Ownership__c = 'Public';
        c5.Annual_Revenue__c = 21212;
        c5.PostalCode__c = '454545';
         database.insert(c5,false);
            
    }
}