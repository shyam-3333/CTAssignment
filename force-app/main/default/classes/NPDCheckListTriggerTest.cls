@isTest 
public class NPDCheckListTriggerTest
{
  @isTest private static void NPDCheckListTriggerTestMethod1()
  {
   NPD_Checklist__c nc1 = new NPD_Checklist__c();
   nc1.name='hello123';
   nc1.Active__c = true;
   insert nc1;
   
    NPD_Checklist__c nc2 = new NPD_Checklist__c();
    nc2.id=nc1.id;
    nc2.name='hello1234';
    update nc2;
    
    delete nc2;
  
  }
  }