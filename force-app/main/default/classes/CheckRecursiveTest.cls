/*
* Company : Kvp Business Solution 
* Author  : Sameer Ranjan
* Description : test class of SkinnProcessUploadController class
*/
@isTest
public class CheckRecursiveTest {
	@isTest static void testMethodControllerClass() {
        test.startTest();
        CheckRecursive.runOnce();
        CheckRecursive.run = false;
        CheckRecursive.runOnce();
        test.stopTest();
    }
}