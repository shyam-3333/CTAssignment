public class JWL_ViewPDF_controller {
    public String jwlid{get;set;}
    public QA_Email_ID_With_Name__c QAuserName{get;set;}
    public List<JWL_Response__c> jlist;
    public String Dated{get;set;}
    public Date myDate{get;set;}
    public JWL_ViewPDF_controller(ApexPages.StandardController controller) {
        jwlid= Apexpages.currentPage().getParameters().get('id'); 
        jlist= new List<JWL_Response__c>();
        system.debug('jwlid'+jwlid);
        DateTime dT ;
 // myDate = date.newinstance(dT.year(), dT.month(), dT.day());
        JWL_Component__c jwl = [SELECT id,QA_User_Email_Id__c,Createddate from JWL_Component__c where Id =:jwlid LIMIT 1];
        dt=jwl.CreatedDate;
         myDate = date.newinstance(dT.year(), dT.month(), dT.day());
        QAuserName = [ SELECT Id,Name, QA_Email_Id__c FROM QA_Email_ID_With_Name__c where QA_Email_Id__c =: jwl.QA_User_Email_Id__c LIMIT 1];
    }
    
    public list<JWL_Response__c> getjwlresponsetable(){
        jlist=[select id,name,Conclusion__c,Dimension_Mannual_test__c,Jwellery_Test__c,
               JWL_Component__c,Observation__c,Specification_mannual_test__c ,Test_Name__c from JWL_Response__c  where JWL_Component__c=: jwlid and  isChecked__c=true ORDER BY Conclusion__c DESC];
        system.debug('response..............'+jlist+'--------------'+jlist.size());
        return jlist;
    }
    
    
    
}