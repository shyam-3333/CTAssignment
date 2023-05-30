/*
* Company : Kvp Business Solution 
* Author  : Sameer Ranjan
* Description : test class of SkinnProcessUploadController class
*/
@isTest
public class SkinnProcessUploadControllerTest {
	@isTest static void testMethodControllerClass() {
        test.startTest();
        StaticResource static_resource = [SELECT Id, SystemModStamp,Body
                                          FROM StaticResource 
                                          WHERE Name = 'SkinnProcessCSVFile'
                                          LIMIT 1];
        SkinnProcessUploadController.UploadDataFromCsv(static_resource.Body.tostring());
        SkinnProcessUploadController.onLoadMethod();
        //Test.loadData(CSVFile, static_resource);
        test.stopTest();
    }
}