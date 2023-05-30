@isTest
public class DisplayOrderIdTest {
    static testMethod void fetchOrderIdTest(){
        String textKey = '071122S/EXCL';
        String textKey2 = 'ABC';
        List<Master__c> testmasterList = new List<Master__c>(); 
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        m1.Source_Type__c = '';
        m1.Product_Type__c = 'Saree';
        m1.Total_Quantity__c = 5;
        m1.Total_Value__c = 2000;
        m1.Active__c = True;
        testmasterList.add(m1);
        insert testmasterList;
        DisplayOrderID.fetchOrderId(textKey);
        DisplayOrderID.fetchOrderId(textKey2);
    }
    static testMethod void updateOrderTest(){
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        m1.Active__c = True;
        insert m1;
        String orderId = m1.Id;
        String stringJSONUpdateOrder = '{"orderName":"071122S/EXCL","orderId":"'+orderId+'","orderSourceType":"123","orderProductType":"Saree","orderExpectedArrival":"2022-12-15","orderTotalQuantity":5,"orderTotalValue":2595}';        
        DisplayOrderID.updateOrder(stringJSONUpdateOrder);       
    }
    static testMethod void saveFileTest(){
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        insert m1;
        String textKey = m1.Id;
        System.debug('textKey--------------> '+textKey);
        String textKey2 = 'ABC';
        String stringJSON = JSON.serialize('l1(ofc),l2(ofc),l3(ofc),price band,l4(zari type),cost band,average cost,total order quantity,order value,remarks\ncotton,silk,synthetic,A,Khadi,B,1234,5,123,test');        
        String stringJSONExtraheader = JSON.serialize('Test,l1(ofc),l2(ofc),l3(ofc),price band,l4(zari type),cost band,average cost,total order quantity,order value,remarks\ncotton,silk,synthetic,A,Khadi,B,1234,5,123,test\n');        
        String stringJSON3MissingHeader = JSON.serialize('l2(ofc),l3(ofc),price band,l4(zari type),cost band,average cost,total order quantity,order value,remarks\ncotton,silk,synthetic,A,Khadi,B,1234,5,123,test\n');        
        String stringJSONEmptyCSV = JSON.serialize('l1(ofc),l2(ofc),l3(ofc),price band,l4(zari type),cost band,average cost,total order quantity,order value,remarks');        
        DisplayOrderID.saveFile(stringJSON,textKey,textKey2);
        DisplayOrderID.saveFile(stringJSONExtraheader,textKey,textKey2);
        DisplayOrderID.saveFile(stringJSON3MissingHeader,textKey,textKey2);
        DisplayOrderID.saveFile(stringJSONEmptyCSV,textKey,textKey2);
    }
    static testMethod void saveFileTest2(){
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        m1.Source_Type__c = '';
        m1.Product_Type__c = 'Saree';
        m1.Total_Quantity__c = 5;
        m1.Total_Value__c = 2000;
        m1.Active__c = True;
        insert m1;
        String textKey = m1.Id;
        String textKey2 = 'ABC';
        String stringJSONDuplicateRow = JSON.serialize('L1(OFC),L2(OFC),L3(OFC),Price Band,L4(Zari Type),Cost Band,Average Cost,Total Order Quantity,Order Value,Remarks\r\ntest1,test2,test3,123456,test4,12345678,1245879,443,12458,\"test,1234\"\r\ntest1,test2,test3,123456,test4,12345678,1245879,443,12458,\"test,1234\"\r\n');        
        DisplayOrderID.saveFile(stringJSONDuplicateRow,textKey,textKey2);
    }
    static testMethod void saveFileTest3(){
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        insert m1;
        String textKey = m1.Id;
        String textKey2 = 'ABC';
        String stringJSONEmptyRow = JSON.serialize('L1(OFC),L2(OFC),L3(OFC),Price Band,L4(Zari Type),Cost Band,Average Cost,Total Order Quantity,Order Value,Remarks\r\ntest1,test2,test3,123456,test4,12345678,1245879,443,12458,\"test,1234\"\r\n,,,,,,,,,\r\ntest2,test2,test3,123456,test4,12345678,1245879,443,12458,\"test,1234\"\r\n');        
        String stringJSONSpecialCharacter = JSON.serialize('L1(OFC),L2(OFC),L3(OFC),Price Band,L4(Zari Type),Cost Band,Average Cost,Total Order Quantity,Order Value,Remarks\r\n\"test1,\",test2,test3,123456,test4,12345678,1245879,443,12458,\"test,1234\"\r\n');
        DisplayOrderID.saveFile(stringJSONEmptyRow,textKey,textKey2);
        DisplayOrderID.saveFile(stringJSONSpecialCharacter,textKey,textKey2);
    }
        static testMethod void saveFileTest4(){
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        insert m1;
        String textKey = m1.Id;
        String textKey2 = 'ABC';
        String stringJSONSpecialCharacter = JSON.serialize('L1(OFC),L2(OFC),L3(OFC),Price Band,L4(Zari Type),Cost Band,Average Cost,Total Order Quantity,Order Value,Remarks\r\n\"test1,\",test2,test3,123456,test4,12345678,1245879,443,12458,\"test,1234\"\r\n');
        DisplayOrderID.saveFile(stringJSONSpecialCharacter,textKey,textKey2);
    }
        static testMethod void saveFileTest5(){
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'RollUpNoOfFiles';
        tt.Active__c = false;
        insert tt;
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        insert m1;
        String textKey = m1.Id;
        String textKey2 = 'ABC';
        String stringJSONSpecialCharacter = JSON.serialize('L1(OFC),L2(OFC),L3(OFC),Price Band,L4(Zari Type),Cost Band,Average Cost,Total Order Quantity,Order Value,Remarks\r\ntest1,test2,test3,123456,test4,12345678,1245879,443,12458,\"test,1234\"\r\n');
        DisplayOrderID.saveFile(stringJSONSpecialCharacter,textKey,textKey2);
    }
}