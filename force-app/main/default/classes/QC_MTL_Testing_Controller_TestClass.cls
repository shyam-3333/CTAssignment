@isTest
public class QC_MTL_Testing_Controller_TestClass {
    public static testMethod void MethodGetSchemaVal(){
        test.startTest();
         QC_Access_Master__c eachMas = new QC_Access_Master__c (Name='T7817',Raw_Material_Name__c='RM1',Testing_Type__c='Raw Material',Titan_Spec_Status__c='Active',Raw_Material_Type__c='Module Raw Material',Specification_Revision__c='T81');
        insert eachMas;
        Supplier_Grade__c eachSuplr = new Supplier_Grade__c(Name='Spr1',QC_Access_Master__c=eachMas.Id,TCL_Designation__c='TRS2');
        insert eachSuplr;
        QC_MTL_Component__c eachObj = new QC_MTL_Component__c(Material__c='Brass',Document_Status__c='Draft',Final_Verdict__c='Accept',Testing_Type__c='Raw Material',Material_Sample_Type__c='New',Raw_Material_Type__c= 'Module Raw Material',Sample_Size_Qty__c=3,Titan_Specification_Reference__c= eachMas.Id,Supplier_Grade__c= eachSuplr.Id);
        insert eachObj;
        QC_MTL_Testing_Controller.getSchemaValue();
        test.stopTest();
    }
}