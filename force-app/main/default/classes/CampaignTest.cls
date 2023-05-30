@isTest

private class CampaignTest{

    static testMethod void CampaignTestMethod() {
         
         Campaign c = new Campaign();
         c.Name = 'Test Campaign';
         insert c;
    }
}