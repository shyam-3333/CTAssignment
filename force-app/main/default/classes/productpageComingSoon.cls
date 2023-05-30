public class productpageComingSoon{
    string accId;
    public productpageComingSoon(){
       accId = ApexPages.currentPage().getParameters().get('AccontId');   
    }
    public pageReference doRedirect(){
        PageReference pr = new PageReference('/apex/ProductCategorySelectPage?AccontId='+accId);
        pr.setredirect(true);
        return pr;  
    }

}