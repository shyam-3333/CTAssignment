@isTest (seeAllData=false)
public class RP_General_L1L5BatchTest {
	private class RestMock implements HttpCalloutMock{
      public HTTPResponse respond(HTTPRequest req) {
            String fullJson = 'your Json Response';   
            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'text/json');
            res.setBody(fullJson);
            res.setStatusCode(200);
            return res;
        }  
    }
    
    static testMethod void testMethod1(){
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.startTest();
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'L1_L5_MasterTrigger';
        tt.Active__c = false;
        insert tt;
        
        TriggerStatus__c tt1 = new TriggerStatus__c();
        tt1.Name = 'ProductDuplicatechecking';
        tt1.Active__c = false;
        insert tt1;
        
        
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
        pro.Buyers_Cost__c = 5000;
        pro.Order_Id__c = '250222S/SYNT';
        pro.L1L5Mapped__c = false;
        insert pro;
        
        product__c pro1 = new product__c();
        pro1.Zari_Type__c = 'Silver Faux Zari';
        pro1.RecordTypeId = recordTypeId;
        pro1.Loom__c = 'No Loom';
        pro1.Proc_Type__c = 'Vendor Co created';
        pro1.Special_Request__c = false;
        pro1.Cluster__c = 'Kashmir';
        pro1.Product_Category_Taneira__c = 'SAREE';
        pro1.Taneira_Material_Weft__c = 'Muslin';
        pro1.Material_Wrap__c = 'SATIN';
        pro1.Workmanship__c ='Block Print-Kalamkari';
        pro1.Quantity__c = 5;
        pro1.Base_Colour__c = 'Dk Blue';
        pro1.Buyers_Cost__c = 5000;
        pro1.Order_Id__c = '250222S/SYNT';
        pro1.L1L5Mapped__c = false;
        insert pro1;        
		
	L1_L5_Master__c lv = new L1_L5_Master__c();
        lv.Product_Category_1__c = 'fabric';
        lv.Product_Category_2__c = 'craft';
        lv.Product_Category_3__c = 'origin';
        lv.Product_Category_4__c = 'zari type';
        lv.Product_category_value_1__c = 'SATIN Muslin';
        lv.Product_category_value_2__c = 'Block Print-Kalamkari';
        lv.Product_category_value_3__c = 'Kashmir';
        lv.Product_category_value_4__c = 'Silver Faux Zari';
        lv.Fabric__c = 'satinmuslin';
        lv.Craft__c = 'blockprint-kalamkari';
        lv.Origin__c = 'kashmir';
        lv.Zari_Type__c = 'silverfauxzari';
        lv.Precedence__c = '5';
        lv.L1__c = 'Test1';
        lv.L2__c = 'Test2';
        lv.L3__c = 'Test3';
        lv.L4__c = 'Test4';
        lv.L5__c = 'Test5';
        lv.Active__c = true;
        lv.Unique_Key__c = 'satinmuslinblockprint-kalamkarikashmirsilverfauxzari';
        Database.insert(lv);
        
        L1_L5_Master__c lv2 = new L1_L5_Master__c();
        lv2.Product_Category_1__c = 'fabric';
        lv2.Product_Category_2__c = 'craft';
        lv2.Product_Category_3__c = 'origin';
        lv2.Product_Category_4__c = 'zari type';
        lv2.Product_category_value_1__c = 'satinmuslin';
        lv2.Product_category_value_2__c = 'blockprint-kalamkari';
        lv2.Product_category_value_3__c = 'kashmir';
        lv2.Product_category_value_4__c = 'silverfauxzari';
        lv2.Fabric__c = 'any';
        lv2.Craft__c = 'any';
        lv2.Origin__c = 'any';
        lv2.Zari_Type__c = 'any';
        lv2.Precedence__c = '1';
        lv2.L1__c = 'Test1';
        lv2.L2__c = 'Test2';
        lv2.L3__c = 'Test3';
        lv2.L4__c = 'Test4';
        lv2.L5__c = 'Test5';
        lv2.Active__c = true;
        lv2.Unique_Key__c = 'satinmuslinblockprint-kalamkarikashmirsilverfauxzari';
        Database.insert(lv2);
       
        
        RP_General_L1L5Batch b = new RP_General_L1L5Batch();
        String sch = '0 0 * * * ?'; 
		system.schedule('Test Territory Check',sch,b);
        Test.stopTest();
	}
    
}