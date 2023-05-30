@isTest
public class TestEnglishNumberToWords {
  @isTest public static void unitTest(){
       EnglishNumberToWords engwrd=new EnglishNumberToWords ();
       integer count=10;
       Decimal needsToPass=10.10;
       EnglishNumberToWords.convertLessThanOneThousand(count);
       EnglishNumberToWords.convert(needsToPass);
      
      EnglishNumberToWords engwrd1=new EnglishNumberToWords ();
       integer count1=0;
       Decimal needsToPass1=0;
       EnglishNumberToWords.convertLessThanOneThousand(count1);
       EnglishNumberToWords.convert(needsToPass1);
      
      EnglishNumberToWords engwrd2=new EnglishNumberToWords ();
       integer count2=909;
       Decimal needsToPass2=89765278.22;
       EnglishNumberToWords.convertLessThanOneThousand(count2);
       EnglishNumberToWords.convert(needsToPass2);
      
       EnglishNumberToWords engwrd3=new EnglishNumberToWords ();
       integer count3=989;
       Decimal needsToPass3=989765278.00;
       EnglishNumberToWords.convertLessThanOneThousand(count3);
       EnglishNumberToWords.convert(needsToPass3);
  }

}