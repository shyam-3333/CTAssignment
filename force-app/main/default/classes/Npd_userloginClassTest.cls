@istest
public class Npd_userloginClassTest
{
 @isTest public static void testmethod1()
  { 
    Npd_userloginClass n1 = new Npd_userloginClass();
    n1.userid = 'keepsafe';
    n1.password = 'keepsafe';
    n1.projectid ='hello'; 
    
    npd_master__c nm1 = new npd_master__c();
    nm1.name='keepsafe'; 
    nm1.userid__c = 'keepsafe'; 
    nm1.user_password__c ='keepsafe'; 
    insert nm1;
    
    n1.loginChecking();
   }
  }