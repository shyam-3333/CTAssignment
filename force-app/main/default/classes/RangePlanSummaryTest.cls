@isTest
public class RangePlanSummaryTest {
    static testMethod void fetchRangePlanTest(){
        String textKey = '071122S/EXCL';
        List<Master__c> testmasterList = new List<Master__c>(); 
        List<RangePlan_Master__c> rangePlanList = new List<RangePlan_Master__c>(); 
        
        Vendor__c vendor = new Vendor__c();
        vendor.Name = 'test';        
        insert vendor; 
        
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        m1.Source_Type__c = '';
        m1.Product_Type__c = 'Saree';
        m1.Total_Quantity__c = 5; //actualProcured
        m1.Total_Value__c = 2000;
        m1.Active__c = True;
        testmasterList.add(m1);
        insert testmasterList;
        
        
        list<Product__c> prodList = new list<Product__c>();
        
        Product__c prd2 = new Product__c();        
        prd2.Name = 'mv128';
        prd2.Base_Colour__c = 'White';
        prd2.Product_Category_Taneira__c = 'SAREE';
        prd2.Cluster__c = 'Banaras';
        prd2.Taneira_Material_Weft__c = 'Silk';
        prd2.Material_Wrap__c = 'Silk';
        prd2.Workmanship__c = 'Ikkat';                      //XYZNULLSIIKKATDEFAULTDEFAULT
        prd2.Cost_Band__c = 'A(0-2)';
        prd2.Quantity__c = 3;
        prd2.Cost__c = 36;
        prd2.Border_Pattern__c='Contrast Border';
        prd2.Body_Pattern__c='Medium Buta';
        prd2.Loom__c = 'Handloom';
        prd2.PO_Number__c='324324';
        prd2.Proc_Type__c = 'Value Added';
        prd2.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd2.vendor_custom__c = vendor.Id;
        prd2.Pallu_Pattern__c='Contrast Pallu';
        prd2.Suggested_MRP__c=454;
        prd2.Comments__c='Testq432';
        prd2.Sync_Date__c=System.today();
        prd2.Created_From__c = 'Offline App';
        prd2.Collection_Update__c = 'test';
        prd2.Body_Pattern_Update__c = 'Solid';
        prd2.Body_Des_Element_Update__c = 'Temple';
        prd2.Body_Des_Material_Update__c = 'Only Zari';
        prd2.Body_Des_Density_Update__c = 'Dense';
        prd2.Border_Pattern_Update__c = 'Contrast Border';
        prd2.Border_Des_Material_Update__c = 'Only Zari';
        prd2.Border_Size_Update__c = 'No Border';
        prd2.Pallu_Pattern_Update__c = 'No Pallu';
        prd2.Pallu_Design_Update__c = 'Solid';
        prd2.Pallu_Des_Material_Update__c = 'Only Zari';
        prd2.Pallu_Des_Density_Update__c = 'Dense';
        prd2.Pallu_Size_Update__c = 'Small';
        prd2.Border_Des_Element_Update__c = 'Temple';
        prd2.Occasion_Update__c = 'Formal';
        prd2.Design_Story_Update__c = 'Korvai';
        prd2.Story_1_Update__c = 'Bengal';
        prd2.PO_Number__c = 'test';
        prd2.Occasion__c = 'e5rd';
        prd2.Salwar_Fabric__c='Silk';
        prd2.L1__c = 'aa';
        prd2.L2__c = 'bb';
        prd2.L3__c = 'cc';
        prd2.L4__c = 'dd';
        prd2.Buyers_Cost__c = 10000;
        prd2.Order_Id__c = '071122S/EXCL';                
        prodList.add(prd2);        
        insert prodList;
        
        if(prodList.size()>0){
            try{
                
                
                RestRequest req = new RestRequest(); 
                RestResponse res = new RestResponse();
                Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
                req.addHeader('httpMethod', 'POST');
                req.requestUri = '/services/apexrest/ProductQRCodeUpdate';       
                String postData = '[{"QR_CODE__c":"8974563210","QR_Code_Scanned_Date__c":"2011-07-31T19:43:37"}]';
                //String JsonMsg=JSON.serialize(postData);
                req.requestBody = Blob.valueof(postData);
                RestContext.request = req; 
                RestContext.response= res;
                Test.setMock(HttpCalloutMock.class, new ProductQRCodeWithSKUCallOutHelperMock() );
                Test.startTest();
                
                
                ProductTriggerHandler.beforeInsertProduct(prodList);
                
                Test.stopTest();
            }
            catch(exception e)
            {
                System.debug('error---->'+e.getMessage());
            }           
        }   
        
        RangePlan_Master__c rp2 = new RangePlan_Master__c();
        rp2.Order_ID__c = m1.Id;
        rp2.Active__c = True;
        rp2.Total_Order_Quantity__c = 10;
        rp2.Order_Value__c = 5000;
        rp2.L1__c = 'aa';
        rp2.L2__c = 'bb';
        rp2.L3__c = 'cc';
        rp2.L4__c = 'dd';
        rangePlanList.add(rp2);
        insert rangePlanList;
        
        RangePlanSummary.fetchRangePlan(textKey);
    }
        static testMethod void fetchRangePlanTest2(){
        String textKey = '071122S/EXCL';
        List<Master__c> testmasterList = new List<Master__c>(); 
        List<RangePlan_Master__c> rangePlanList = new List<RangePlan_Master__c>(); 
        
        Vendor__c vendor = new Vendor__c();
        vendor.Name = 'test';        
        insert vendor; 
        
        Master__c m1 = new Master__c();
        m1.Name = '071122S/EXCL';
        m1.Name__c = 'Order Id';
        m1.Source_Type__c = '';
        m1.Product_Type__c = 'Saree';
        m1.Total_Quantity__c = 5; //actualProcured
        m1.Total_Value__c = 2000;
        m1.Active__c = True;
        testmasterList.add(m1);
        insert testmasterList;
        
        
        list<Product__c> prodList = new list<Product__c>();
        
        Product__c prd2 = new Product__c();        
        prd2.Name = 'mv128';
        prd2.Base_Colour__c = 'White';
        prd2.Product_Category_Taneira__c = 'SAREE';
        prd2.Cluster__c = 'Banaras';
        prd2.Taneira_Material_Weft__c = 'Silk';
        prd2.Material_Wrap__c = 'Silk';
        prd2.Workmanship__c = 'Ikkat';                      //XYZNULLSIIKKATDEFAULTDEFAULT
        prd2.Cost_Band__c = 'A(0-2)';
        prd2.Quantity__c = 3;
        prd2.Cost__c = 36;
        prd2.Border_Pattern__c='Contrast Border';
        prd2.Body_Pattern__c='Medium Buta';
        prd2.Loom__c = 'Handloom';
        prd2.PO_Number__c='324324';
        prd2.Proc_Type__c = 'Value Added';
        prd2.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd2.vendor_custom__c = vendor.Id;
        prd2.Pallu_Pattern__c='Contrast Pallu';
        prd2.Suggested_MRP__c=454;
        prd2.Comments__c='Testq432';
        prd2.Sync_Date__c=System.today();
        prd2.Created_From__c = 'Offline App';
        prd2.Collection_Update__c = 'test';
        prd2.Body_Pattern_Update__c = 'Solid';
        prd2.Body_Des_Element_Update__c = 'Temple';
        prd2.Body_Des_Material_Update__c = 'Only Zari';
        prd2.Body_Des_Density_Update__c = 'Dense';
        prd2.Border_Pattern_Update__c = 'Contrast Border';
        prd2.Border_Des_Material_Update__c = 'Only Zari';
        prd2.Border_Size_Update__c = 'No Border';
        prd2.Pallu_Pattern_Update__c = 'No Pallu';
        prd2.Pallu_Design_Update__c = 'Solid';
        prd2.Pallu_Des_Material_Update__c = 'Only Zari';
        prd2.Pallu_Des_Density_Update__c = 'Dense';
        prd2.Pallu_Size_Update__c = 'Small';
        prd2.Border_Des_Element_Update__c = 'Temple';
        prd2.Occasion_Update__c = 'Formal';
        prd2.Design_Story_Update__c = 'Korvai';
        prd2.Story_1_Update__c = 'Bengal';
        prd2.PO_Number__c = 'test';
        prd2.Occasion__c = 'e5rd';
        prd2.Salwar_Fabric__c='Silk';
        prd2.L1__c = 'aab';
        prd2.L2__c = 'bb';
        prd2.L3__c = 'cc';
        prd2.L4__c = 'dd';
        prd2.Buyers_Cost__c = 10000;
        prd2.Order_Id__c = '071122S/EXCL';                
        prodList.add(prd2);        
        insert prodList;
        
        if(prodList.size()>0){
            try{
                
                
                RestRequest req = new RestRequest(); 
                RestResponse res = new RestResponse();
                Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
                req.addHeader('httpMethod', 'POST');
                req.requestUri = '/services/apexrest/ProductQRCodeUpdate';       
                String postData = '[{"QR_CODE__c":"8974563210","QR_Code_Scanned_Date__c":"2011-07-31T19:43:37"}]';
                //String JsonMsg=JSON.serialize(postData);
                req.requestBody = Blob.valueof(postData);
                RestContext.request = req; 
                RestContext.response= res;
                Test.setMock(HttpCalloutMock.class, new ProductQRCodeWithSKUCallOutHelperMock() );
                Test.startTest();
                
                
                ProductTriggerHandler.beforeInsertProduct(prodList);
                
                Test.stopTest();
            }
            catch(exception e)
            {
                System.debug('error---->'+e.getMessage());
            }           
        }   
        
        RangePlan_Master__c rp2 = new RangePlan_Master__c();
        rp2.Order_ID__c = m1.Id;
        rp2.Active__c = True;
        rp2.Total_Order_Quantity__c = 10;
        rp2.Order_Value__c = 5000;
        rp2.L1__c = 'aa';
        rp2.L2__c = 'bb';
        rp2.L3__c = 'cc';
        rp2.L4__c = 'dd';
        rangePlanList.add(rp2);
        insert rangePlanList;
        
        RangePlanSummary.fetchRangePlan(textKey);
    }

}