@IsTest
public class CSVReaderUtililty_Test {
    public static testMethod void utilityRowTest(){
        String s = 'Test1,Test2,Test3,Test4,1,2,Test5,"Test6"';
        List<List<String>> mainList = CSVReaderUtililty.Parse(s);
    }
}