/*************************************************************
**Created By  : Vijayavardan Reddy.
**Modified By : Vijayavardan Reddy.
**Created Date: 16-June-2014.
**Description : Unti testing for Login page.
****************************************************************/ 

@isTest(SeeAllData=true)
private class NewLoginCheckTest{

   public Static  TestMethod void testNewLogin(){
         user productuser    = new user();
           test.startTest();
           
           productuser   =      TestForAskme.toCreateUser('Process-Product profile','productusertest@testing.com');
               productuser.UserPermissionsSFContentUser=false;
           
           insert productuser;
       
       
        System.runAs(productuser){
           List<product__c>  productList          =    TestForAskme.productRecord(5);
                   insert productList;
                       
           List<variant__c> vrnList                =   TestForAskme.variantRecord(productList,3);
                   insert vrnList;
                   test.stopTest();             
                   
                   NewLoginCheck  nlgn               =  new NewLoginCheck();
                             nlgn.userName      =  productuser.UserName; 
                             nlgn.pwd           =  'xxxxxxxx';
                             nlgn.Authenticating(); 
                             
                 NewLoginCheck  nlgn1                 =  new NewLoginCheck();
                             nlgn1.userName      =  productuser.UserName; 
                             nlgn1.pwd           =  'xxxxxxxx';
                             nlgn1.Authenticating();                
                            
       }
       
   }

}