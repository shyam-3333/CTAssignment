@isTest
public class schedularquoteIndentDispatchDate_Test {
		
   static testMethod void testMethod1() {
       
	 Test.startTest();
 		schedularquoteIndentDispatchDateReminder s=new schedularquoteIndentDispatchDateReminder();
		String sch = '0 0 23 * * ?'; 
        system.schedule('Test Territory Check', sch, s);
       
     Test.stopTest(); 
   }
}