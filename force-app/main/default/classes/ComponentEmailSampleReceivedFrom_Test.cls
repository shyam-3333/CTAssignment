@isTest
public class ComponentEmailSampleReceivedFrom_Test {
    @isTest private static void multiEmail(){
        List<QC_Components__c> compList = new List<QC_Components__c>();
        QC_Components__c comp = new QC_Components__c();
        comp.Name__c = 'CA/0040[b]/18-1';
        comp.Sample_Received_From__c = 'vinoth@kvpcorp.com';
        comp.Email_Sample_Received_From_1__c = '';
        comp.Email_Sample_Received_From_3__c = '';
        comp.Email_Sample_Received_From_2__c = '';
        comp.Additional_email_address__c = 'vino@kvp.com';
        compList.add(comp);
        insert comp;
        
        QC_Components__c comp1 = new QC_Components__c();
        comp1.Name__c = 'CA/0040[b]/18-2';
        comp1.Sample_Received_From__c = 'vinoth1@kvpcorp.com';
        comp1.Email_Sample_Received_From_1__c = '';
        comp1.Email_Sample_Received_From_3__c = '';
        comp1.Email_Sample_Received_From_2__c = '';
        comp1.Additional_email_address__c = 'vinoth.kumar@kvpcorp.com,vinothkumar.a333@gmail.com';
        compList.add(comp1);
        insert comp1;
        
         QC_Components__c comp2 = new QC_Components__c();
        comp2.Name__c = 'CA/0040[b]/18-3';
        comp2.Sample_Received_From__c = 'vinoth2@kvpcorp.com';
        comp2.Email_Sample_Received_From_1__c = '';
        comp2.Email_Sample_Received_From_3__c = '';
        comp2.Email_Sample_Received_From_2__c = '';
        comp2.Additional_email_address__c = 'vino@kvp.com,kumar@kvp.com,kumar1@kvp.com';
        compList.add(comp2);
        insert comp2;
        
        ComponentEmailSampleReceivedFromHandler.MultipleEmailAdd(compList);
    }
}