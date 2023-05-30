@IsTest
public class UtilityRowIterator_Test {
    public static testMethod void utilityRowTest(){
        String rowTestFirst = 'Test string1';
        String rowTestSecond = 'Test string2';
        List<String> firstList = new List<String>();
        List<String> secondList = new List<String>();
        
        Utility_RowIterator row_Iteration = New Utility_RowIterator(rowTestFirst);
            String firstRow;
            while(row_Iteration.hasNext()){
                firstRow = row_Iteration.next();
                firstList.add(firstRow);
            }
        
        Utility_RowIterator rowIterator = New Utility_RowIterator(rowTestSecond,'\n');
            String secondRow;
            while(rowIterator.hasNext()){
                secondRow = rowIterator.next();
                secondList.add(secondRow);
            }
        System.assertEquals(rowTestFirst, firstList[0]);
        System.assertEquals(rowTestSecond, secondList[0]);
    }
}