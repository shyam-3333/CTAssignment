@isTest
private class BitSetTest{	
    @isTest
    static void BitSet_Test(){    
      List < Integer > nList = new List < Integer >();
        nList.add(1);
       
        Test.startTest();
         BitSet bs = new BitSet();
         bs.testBits('pValidFor', nList);
 
        PicklistEntryWrapper bsp = new PicklistEntryWrapper();
         bsp.active = 'abc';
         bsp.defaultValue = 'abc';
         bsp.label = 'abc';
         bsp.value = 'abc';
         bsp.validFor = 'xyz';
         Test.stopTest();
    }  
    
    
     @isTest
    static void BitSet_Test2(){
        List < Integer > nList2 = new List < Integer >();  
         nList2.add(0);
         BitSet bs = new BitSet();
        bs.testBits('pValidFor', nList2);
    }
}