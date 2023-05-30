public class ProposalToolGeneratePDFData {
    public static String dataOfProposal{get;set;}
    public static List<ProductWrapper> mainData{get;set;}
    public static void generatePDF(){
        mainData = new List<ProductWrapper>();
        String recordId = ApexPages.currentPage().getParameters().get('proposalToolId');
        ProductWrapper pr;
        List<Proposal_Products__c> dataOfProducts;
        
        dataOfProducts = [Select Images_URL__c,Is_Hide_Pride__c,Sellable_SKU__c ,Quantity__c,Product_Brand__c,List_Price__c,Offer_Price__c,Product_Full_Name__c,Custom_Images__c from Proposal_Products__c where Proposal__c =:recordId];
        for(Proposal_Products__c product : dataOfProducts){
            pr = new ProductWrapper();
            pr.quantity= Integer.valueOf(product.Quantity__c);
            pr.productBrand= product.Product_Brand__c;
            if(product.List_Price__c != null){
                pr.productListPrice= Integer.valueOf(product.List_Price__c);
            }
            if(product.Offer_Price__c != null){
                pr.productOfferPrice= Integer.valueOf(product.Offer_Price__c);
                
            }
            pr.isBlankListPrice = product.List_Price__c ==null?false:true;
            pr.isBlankOfferPrice = product.Offer_Price__c ==null?false:true;
            pr.sellebleSKU = product.Sellable_SKU__c;
            pr.productFullName=product.Product_Full_Name__c;
            pr.isHidePrice = !product.Is_Hide_Pride__c;
            if(product.Custom_Images__c != null && product.Custom_Images__c  !=''){
                String temCustom = product.Custom_Images__c;
                pr.customURL = temCustom.split(','); 
                pr.productImage = pr.customURL[0];
                pr.cutomImagesData = true;
            }else{
                pr.productImage = product.Images_URL__c;
                pr.cutomImagesData = false;
            }
            pr.lastImage = false;
            mainData.add(pr);
            
        }
    }
    
    @TestVisible
    public class ProductWrapper{
        public String productId{get;set;}
        public List<String> customURL{get;set;}
        public String productImage{get;set;}
        public String productBrand{get;set;}
        public Integer quantity{get;set;}
        public Integer price{get;set;}
        public String productFullName{get;set;}
        public Boolean cutomImagesData{get;set;}
        public Integer productListPrice{get;set;}
        public Integer productOfferPrice{get;set;}
        public String sellebleSKU {get;set;}
        public Boolean isHidePrice {get;set;}
        public Boolean isBlankListPrice {get;set;}
        public Boolean isBlankOfferPrice {get;set;}
        public Boolean lastImage {get;set;}
        
        
    }
}