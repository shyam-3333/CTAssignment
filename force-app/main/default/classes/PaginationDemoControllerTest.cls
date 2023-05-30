@isTest
public class PaginationDemoControllerTest {
    
    @isTest
    public static void testPAginationController() {
    	//String test = System.Label.CostBandFilter;
		Taneira_Cost_Band_Range__c tan = new Taneira_Cost_Band_Range__c();
        tan.Name = 'A(0-4)';
        tan.Values__c = '0-4000';
        insert tan;
        Taneira_CostPriceBand__c tcr = new Taneira_CostPriceBand__c();
        tcr.Name ='A(0-2.1)';
        tcr.CostPriceRange__c='0-2100';
        insert tcr;
        
        Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        Account acc = new Account();
        acc.Name= 'test Account';
        acc.Phone_No__c = '2648394';
        acc.RecordTypeId = recordTypeIdAcc;
        insert acc;
        List<Master__c> mast = new List<Master__c>();
        Master__c mas = new Master__c();
        mas.Name__c ='Product Category';
        mas.Name ='Saree';
        mas.Active__c=true;
        mast.add(mas);
        Master__c mas1 = new Master__c();
        mas1.Name__c ='Craft';
        mas1.Name ='Applique';
        mas1.Active__c=true;
        mast.add(mas1);
        Master__c mas2 = new Master__c();
        mas2.Name__c ='Product Category';
        mas2.Name ='Dupatta';
        mas2.Active__c=true;
        mast.add(mas2);
        Master__c mas3 = new Master__c();
        mas3.Name__c ='Origin';
        mas3.Name ='RAJASTHAN';
        mas3.Active__c=true;
        mast.add(mas3);
        Master__c mas4 = new Master__c();
        mas4.Name__c ='Proc-Type';
        mas4.Name ='Trading';
        mas4.Active__c=true;
        mast.add(mas4);
        Master__c mas5 = new Master__c();
        mas5.Name__c ='Loom';
        mas5.Name ='Handloom';
        mas5.Active__c=true;
        mast.add(mas5);
        Master__c mas6 = new Master__c();
        mas6.Name= 'Silk';
        mas6.Name__c ='Zari Type';
        mas6.Active__c = True ;
        mas6.Code__c ='ZT';
        mast.add(mas6);
        Master__c mas7 = new Master__c();
        mas7.Name= 'Wedding';
        mas7.Name__c ='Occasion';
        mas7.Active__c  = True ;
        mas7.Code__c ='W';
        mast.add(mas7);
        Master__c mas8 = new Master__c();
        mas8.Name= 'Silk';
        mas8.Name__c ='Weft';
        mas8.Active__c  = True ;
        mas8.Code__c ='SI';
        mast.add(mas8);
        
        insert mast;
        
        
        
        List<Product__c> prods = new List<Product__c>();
         Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c pro = new Product__c();      
        pro.Name = 'Brown Saree';
        pro.Account__c = acc.id;
        pro.RecordTypeId = recordTypeId;
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 123;
        pro.Colour__c = 'Red';
        pro.Workmanship__c = 'Ajrak';
        pro.Design_Story__c = 'Shikargah';
        pro.Loom__c ='Handloom';
        pro.Taneira_Material_Weft__c ='Silk';
        pro.Material_Wrap__c='Silk';
        pro.Nature__c ='Handmade product of India';
        pro.Occasion__c = 'Wedding';
        pro.Cluster__c ='Assam';
        pro.Product_Category_Taneira__c ='Saree';
        pro.Route__c ='Colourway';
        pro.Zari_Type__c = 'Silk';
        pro.Proc_Type__c = 'Trading';
        pro.Cost_Band__c = 'A(0-2)';
        pro.Warehouse_Stock__c=10;
        pro.Sold_Stock__c=2;
        pro.Store_Stock__c=8;
        //pro.Special_request__c=true;
        //pro.Comment_for_Special_Request__c = 'test';
        pro.Sync_Date__c=System.today();
        
        prods.add(pro);
        
        insert prods;
            
        //Test.setCurrentPage(Page.PaginationDemo);
        ApexPages.currentPage().getParameters().put('ProductCategory','Saree');
        ApexPages.currentPage().getParameters().put('srch','SHT');
        ApexPages.currentPage().getParameters().put('ProcType','Trading');
        ApexPages.currentPage().getParameters().put('Origin','RAJASTHAN');
        ApexPages.currentPage().getParameters().put('vendor',acc.Id);
        ApexPages.currentPage().getParameters().put('Loom','Handloom');
        ApexPages.currentPage().getParameters().put('Weft','Silk');
        ApexPages.currentPage().getParameters().put('Story1','Test Story1');
        ApexPages.currentPage().getParameters().put('Story2','Test Story2');
        ApexPages.currentPage().getParameters().put('Warp','Silk');
        ApexPages.currentPage().getParameters().put('ZariType','Pure');
        ApexPages.currentPage().getParameters().put('DetailedColor','Dummy NA');
        ApexPages.currentPage().getParameters().put('CostBandFilter',Label.CostBandFilter);
        //ApexPages.currentPage().getParameters().put('MRP',String.valueOf(2000.34));
        //ApexPages.currentPage().getParameters().put('CostPrice',String.valueOf(1000.55));
        //ApexPages.currentPage().getParameters().put('Quantity',String.valueOf(10));
        ApexPages.currentPage().getParameters().put('Occasion','Formal');
        ApexPages.currentPage().getParameters().put('Craft','Applique');
        ApexPages.currentPage().getParameters().put('BodyDesElement','Animal');
        ApexPages.currentPage().getParameters().put('BodyDesMaterial','Only Thread');
        ApexPages.currentPage().getParameters().put('BodyPattern','Ganga Jamuna');
        ApexPages.currentPage().getParameters().put('BlouseType','Stiched');
        
        
         PaginationDemoController obj = new PaginationDemoController();
         PageReference pageRef= Page.PaginationDemo;
       // Test.setCurrentPage(pageRef);
         obj.dosubmit();
              String filterOptions = '';String prodId=prods[0].Id;
                filterOptions += 'lastProdId:::'+prodId+'###';
                filterOptions += 'Vendor:::'+'{!$CurrentPage.parameters.Vendor}'+'###';
                filterOptions += 'ProductCategory:::'+'{!$CurrentPage.parameters.ProductCategory}'+'###';
                filterOptions += 'ProcType:::'+'{!$CurrentPage.parameters.ProcType}'+'###';
                filterOptions += 'Origin:::'+'{!$CurrentPage.parameters.Origin}'+'###';
                filterOptions += 'Loom:::'+'{!$CurrentPage.parameters.Loom}'+'###';
                filterOptions += 'Weft:::'+'{!$CurrentPage.parameters.Weft}'+'###';
                filterOptions += 'Warp:::'+'{!$CurrentPage.parameters.Warp}'+'###';
                filterOptions += 'ZariType:::'+'{!$CurrentPage.parameters.ZariType}'+'###';
                filterOptions += 'Craft:::'+'{!$CurrentPage.parameters.Craft}'+'###';
                filterOptions += 'BorderDesElement:::'+'{!$CurrentPage.parameters.BorderDesElement}'+'###';
                filterOptions += 'BodyDesMaterial:::'+'{!$CurrentPage.parameters.BodyDesMaterial}'+'###';
                filterOptions += 'BorderDesMaterial:::'+'{!$CurrentPage.parameters.BorderDesMaterial}'+'###';
                filterOptions += 'BorderSize:::'+'{!$CurrentPage.parameters.BorderSize}'+'###';
                filterOptions += 'PalluDesDensity:::'+'{!$CurrentPage.parameters.PalluDesDensity}'+'###';
                filterOptions += 'PalluDesMaterial:::'+'{!$CurrentPage.parameters.PalluDesMaterial}'+'###';
                filterOptions += 'PalluPattern:::'+'{!$CurrentPage.parameters.PalluPattern}'+'###';
                filterOptions += 'PalluSize:::'+'{!$CurrentPage.parameters.PalluSize}'+'###';
                //filterOptions += 'WareHouse:::'+'{!$CurrentPage.parameters.WareHouse}'+'###';
                filterOptions += 'Fabric:::'+'{!$CurrentPage.parameters.Fabric}'+'###';
                //filterOptions += 'Store:::'+'{!$CurrentPage.parameters.Store}'+'###';
                //filterOptions += 'Sold:::'+'{!$CurrentPage.parameters.Sold}'+'###';
                //filterOptions += 'CostFilter:::'+'{!$CurrentPage.parameters.CostFilter}';
                
         PaginationDemoController.getProductList(prodId,filterOptions);
      
       
        //PaginationDemoController.getProducts(null);
    }
}