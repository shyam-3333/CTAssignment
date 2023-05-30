@isTest
private class Utilities_Test {
    @isTest
    private static void getInstance(){
        String instance = '';
        Organization o = [SELECT OrganizationType, InstanceName FROM Organization limit 1];
        String orgType = o.OrganizationType;
        String insName = o.InstanceName;
        
        //Set this header to test it
        ApexPages.currentPage().getHeaders().put('Host', insName+'.visual.force.com');
        List<String> parts = ApexPages.currentPage().getHeaders().get('Host').split('\\.');
        instance = parts[parts.size() - 4] + '.';
        if(orgType == 'Developer Edition'){
            System.assertEquals(instance, Utilities.getInstance());
        }else{
           // System.assertEquals(instance, Utilities.getInstance());
        }
        
    }
    @isTest
    private static void getSubdomainPrefix(){

        //This will always be empty unless it's sandbox
        Organization o = [SELECT OrganizationType, InstanceName FROM Organization limit 1];
        if(o.OrganizationType == 'Developer Edition'){
            System.assertEquals('', Utilities.getSubdomainPrefix());
        }else{
            //System.assertEquals('orgrefact-', Utilities.getSubdomainPrefix());
        }
        
    }
    
}