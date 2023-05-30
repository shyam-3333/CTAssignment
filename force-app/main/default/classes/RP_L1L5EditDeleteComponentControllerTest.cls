@isTest
public class RP_L1L5EditDeleteComponentControllerTest {
    static testMethod void method1() {
        list<L1_L5_Master__c> l1l5Data = new list<L1_L5_Master__c>();
        L1_L5_Master__c l1 = new L1_L5_Master__c(); 
        l1.Product_Category_1__c = 'Fabric';
        l1.Product_category_value_1__c = 'Synthetic';
        l1.Product_Category_2__c ='Craft' ;
        l1.Product_category_value_2__c ='banars' ;
        l1.Product_Category_3__c = 'Origin';
        l1.Product_category_value_3__c ='crepe' ;
        l1.Product_Category_4__c = 'Zari type';
        l1.Product_category_value_4__c ='no Zari' ;
        l1.L1__c ='Syn' ;
        l1.L2__c ='cre' ;
        l1.L3__c ='tst' ;
        l1.L4__c ='typ' ;
        l1.L5__c ='ztone' ;
        l1.Active__c = true;
        l1.CreatedDate = system.today();
        l1l5Data.add(l1);
        insert l1l5Data;
        RP_L1L5EditDeleteComponentController.getL1L5Master();
        list<RP_L1L5EditDeleteComponentController.DataTableWrapper> toClass = new list<RP_L1L5EditDeleteComponentController.DataTableWrapper>();
        for(L1_L5_Master__c l1l5 :l1l5Data){
            RP_L1L5EditDeleteComponentController.DataTableWrapper obj = new RP_L1L5EditDeleteComponentController.DataTableWrapper();
            //obj.name = 'L-22886';
            obj.isDelete = true;
            obj.nameUrl = l1.id;
            obj.l1obj = l1l5;
            obj.recordId = l1.id;
            obj.ProductCategory1 = 'Fabric';
            obj.ProductCategory2 = 'Craft';
            obj.ProductCategory3 = 'Origin';
            obj.ProductCategory4 = 'Zari type';
            obj.ProductCategoryValue1 = 'Synthetic';
            obj.ProductCategoryValue2 = 'banars';
            obj.ProductCategoryValue3 = 'crepe';
            obj.ProductCategoryValue4 = 'no Zari';
            obj.L1 = 'Syn';
            obj.L2 = 'cre';
            obj.L3 = 'tst';
            obj.L4 = 'typ';
            obj.L5 = 'ztone';
            obj.active = true;
            toClass.add(obj);
        }
        RP_L1L5EditDeleteComponentController.deleteL1L5Master(JSON.serialize(toClass));
    }
}