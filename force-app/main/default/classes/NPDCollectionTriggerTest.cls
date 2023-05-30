@istest
private class NPDCollectionTriggerTest 
{
    @istest public static void testmethod1()
    {
    
    Npd_activity_trigger_controller__c cus1=  new Npd_activity_trigger_controller__c();
  cus1.name='stagetrigger';
  cus1.continueExecution__c = false;
  insert cus1;
    
    npd_master__c nm1 = new npd_master__c();
    nm1.name='testing owner' ;
    nm1.type__c ='owner';
    insert nm1;
    
    npd_master__c nm2 = new npd_master__c();
    nm2.name='testing owner2' ;
    nm2.type__c ='owner';
    insert nm2;
    
    NPD_Collections__c nc1 = new NPD_Collections__c();
    nc1.name='testing1223';
    nc1.Tentative_Launch_Month_Date__c = date.ValueOf('2017-09-21');
    nc1.SF_Project_Owner__c =  nm1.id;
    insert nc1;
    
    npd_activity__c Act = new npd_activity__c();
    Act.name__c = 'concet design - ids';
    Act.NPD_Collections__c = nc1.id;
    insert Act;
    
      NPD_Collections__c nc2 = new NPD_Collections__c();
      nc2.id= nc1.id;
      nc2.SF_Project_Owner__c =  nm2.id;
      
      update nc2;
      
      }
      }