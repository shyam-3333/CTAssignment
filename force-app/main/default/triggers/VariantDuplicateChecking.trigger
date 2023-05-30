/**********************************************************************************************
**Creadeted By : Vijayavardan Reddy.
**Modified By  : Vijayavardan reddy.
**Created Date : 29-Jun-2014.
**Description  : Checking the model number with the existence values while inserting or updating.
*************************************************************************************************/   

trigger VariantDuplicateChecking on Variant__c (before insert,before update) {
  //Variable Declaration
 list<Variant__c> allvariants=new list<Variant__c>();
  //Retrieving all the Variants records
    try{
     allvariants=[select id,Name from Variant__c limit 50000];
     }catch(Exception Exep){
     System.debug('*******Exception****'+Exep);
     }
   //Iterating The list of all Variants and Identifying the Duplicates.If the Duplicates are existed Display the error message.  
     for(Variant__c vrnt:allvariants)  {
         for(Variant__c newvrnt:trigger.new){
           if(newvrnt.Name==vrnt.Name && (trigger.isinsert ||(trigger.isupdate && newvrnt.id != vrnt.id))){
              newvrnt.Name.adderror('The variant Already Exist');
          }
         } //End of for
     }// End of for     

}//End of Trigger