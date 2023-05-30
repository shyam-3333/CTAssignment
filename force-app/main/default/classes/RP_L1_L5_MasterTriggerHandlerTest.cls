@isTest 
public class RP_L1_L5_MasterTriggerHandlerTest {
    @testSetup
    static void setup(){
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'ProductDuplicatechecking';
        tt.Active__c = false;
        insert tt;
    }
	static testMethod void testMethod1(){
        List<L1_L5_Master__c> l1L5ListToInsert = new List<L1_L5_Master__c>();
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
		product__c pro = new product__c();
        pro.Zari_Type__c = 'Silver Faux Zari';
        pro.RecordTypeId = recordTypeId;
        pro.Loom__c = 'No Loom';
        pro.Proc_Type__c = 'Vendor Co created';
        pro.Special_Request__c = false;
        pro.Cluster__c = 'Kashmir';
        pro.Product_Category_Taneira__c = 'SAREE';
        pro.Taneira_Material_Weft__c = 'Muslin';
        pro.Material_Wrap__c = 'SATIN';
        pro.Workmanship__c ='Block Print-Kalamkari';
        pro.Quantity__c = 5;
        pro.Base_Colour__c = 'Dk Blue';
        pro.Order_Id__c = '250222S/SYNT';
        //pro.L1L5Mapped__c = false;
        pro.Product_Unique_Key__c = 'satinmuslinblockprint-kalamkarikashmirsilverfauxzari';
        pro.L1L5Mapped__c = false;
        insert pro;
        
        L1_L5_Master__c lv4 = new L1_L5_Master__c();
        lv4.Precedence__c = '5';
        lv4.Product_Category_4__c = 'fabric';
        lv4.Product_Category_1__c = 'craft';
        lv4.Product_Category_2__c = 'origin';
        lv4.Product_Category_3__c = 'zari type';
        lv4.Product_category_value_4__c = 'any';
        lv4.Product_category_value_1__c = 'any';
        lv4.Product_category_value_2__c = 'any';
        lv4.Product_category_value_3__c = 'any';
        lv4.L1__c = 'Test1';
        lv4.L2__c = 'Test2';
        lv4.L3__c = 'Test3';
        lv4.L4__c = 'Test4';
        lv4.L5__c = 'Test5';
        lv4.Active__c = true;
        l1L5ListToInsert.add(lv4);
        
        L1_L5_Master__c lv = new L1_L5_Master__c();
        lv.Precedence__c = '3';
        lv.Product_Category_1__c = 'fabric';
        lv.Product_Category_2__c = 'craft';
        lv.Product_Category_3__c = 'origin';
        lv.Product_Category_4__c = 'zari type';
        lv.Product_category_value_1__c = 'SATIN Muslin';
        lv.Product_category_value_2__c = 'Block Print-Kalamkari';
        lv.Product_category_value_3__c = 'Kashmir';
        lv.Product_category_value_4__c = 'Silver Faux Zari';
        lv.L1__c = 'Test1';
        lv.L2__c = 'Test2';
        lv.L3__c = 'Test3';
        lv.L4__c = 'Test4';
        lv.L5__c = 'Test5';
        lv.Active__c = true;
        l1L5ListToInsert.add(lv);
        
        L1_L5_Master__c lv1 = new L1_L5_Master__c();
        lv1.Precedence__c = '2';
        lv1.Product_Category_2__c = 'fabric';
        lv1.Product_Category_3__c = 'craft';
        lv1.Product_Category_4__c = 'origin';
        lv1.Product_Category_1__c = 'zari type';
        lv1.Product_category_value_2__c = 'SATIN Muslin';
        lv1.Product_category_value_3__c = 'Block Print-Kalamkari';
        lv1.Product_category_value_4__c = 'Kashmir';
        lv1.Product_category_value_1__c = 'Silver Faux Zari';
        lv1.L1__c = 'Test1';
        lv1.L2__c = 'Test2';
        lv1.L3__c = 'Test3';
        lv1.L4__c = 'Test4';
        lv1.L5__c = 'Test5';
        lv1.Active__c = true;
		l1L5ListToInsert.add(lv1);

        
        L1_L5_Master__c lv2 = new L1_L5_Master__c();
        lv2.Precedence__c = '1';
        lv2.Product_Category_3__c = 'fabric';
        lv2.Product_Category_4__c = 'craft';
        lv2.Product_Category_1__c = 'origin';
        lv2.Product_Category_2__c = 'zari type';
        lv2.Product_category_value_3__c = 'SATIN Muslin';
        lv2.Product_category_value_4__c = 'Block Print-Kalamkari';
        lv2.Product_category_value_1__c = 'Kashmir';
        lv2.Product_category_value_2__c = 'Silver Faux Zari';
        lv2.L1__c = 'Test1';
        lv2.L2__c = 'Test2';
        lv2.L3__c = 'Test3';
        lv2.L4__c = 'Test4';
        lv2.L5__c = 'Test5';
        lv2.Active__c = true;
        l1L5ListToInsert.add(lv2);
        
        L1_L5_Master__c lv3 = new L1_L5_Master__c();
        lv3.Precedence__c = '6';
        lv3.Product_Category_4__c = 'fabric';
        lv3.Product_Category_1__c = 'craft';
        lv3.Product_Category_2__c = 'origin';
        lv3.Product_Category_3__c = 'zari type';
        lv3.Product_category_value_4__c = 'SATIN Muslin';
        lv3.Product_category_value_1__c = 'Block Print-Kalamkari';
        lv3.Product_category_value_2__c = 'Kashmir';
        lv3.Product_category_value_3__c = 'Silver Faux Zari';
        lv3.L1__c = 'Test1';
        lv3.L2__c = 'Test2';
        lv3.L3__c = 'Test3';
        lv3.L4__c = 'Test4';
        lv3.L5__c = 'Test5';
        lv3.Active__c = true;
        l1L5ListToInsert.add(lv3);
  
                
        Test.startTest();
        insert l1L5ListToInsert;
        /*RP_General_L1L5Batch b = new RP_General_L1L5Batch();
        String sch = '0 0 2 * * ?'; 
		system.schedule('Test Territory Check', sch, b);
        Test.stopTest();*/
	}
    
}