/*
    Name        : QC_ReSubmission
    Created By  : Anand Durga Prasad
    Created Date:
    Modified By : Shamsher Singh
    Last Modified Date: 3/30/2015	5/7/2015
*/
public with sharing class QC_ReSubmission {
	
   public static Final string REJECT_VERDICT = 'Reject';
   /*
 	@Method       : parentComponentData
 	@Created By   : Anand
 	@Created Date : 
 	@Param        : comp (Parameter for newly created component on resubmission)
 	@Param        : parentComId (selected component record id for resubmission to query all child records.)
 	@Description  : Method to update the child record parent with newly created parent id
  */  
   public static void parentComponentData(QC_Components__C comp,id parentComId){
       list<QC_Components__c> childComList = new list<QC_Components__c>();               
       if(comp != null && comp.master__c == true){  //comp.Master_Variant__c == null
           for(QC_Components__c each : [select id from QC_Components__c where Master_Variant__c =: parentComId]){
                each.Master_Variant__c = comp.id;
                childComList.add(each);
           }
           system.debug('@@@childComList@@@@@@@@@@@@@@@@@@@@'+childComList);
           if(!childComList.isEmpty()){
	             try{
	               update childComList;
	             }catch(Exception e){
	                Apexpages.addMessages(e);
	             }
           }
       }
   }//End or Method
   
    /*
 	@Method       : copyInputTestData
 	@Created By   : Anand
 	Modified By & Date  : Shamsher Singh	5/7/2015
 	@Created Date : 
 	@Param        : comp (Parameter for newly created component on resubmission)
 	@Param        : parentComId (selected component record id for resubmission to query all child records.)
 	@Description  :(Auto Sync) Method to copy newly accepted records to child components 
  */
  
  /*
  	Created By  : Shamsher Singh
  	Method Name : copyInputTestData()
  	Condition-1 : Child variant is having a new component tab with empty data coming from master variant.
  				  In this case, child variant component will be updated when master variant component gets updated.
  	Condition-2 : Resubmitting a master variant, all the child varaints rejected components which is copied from master variant,
  				  gets synced with the newly created master variant and is_copied_data from master variant checkbox remains true.
  */
   public static void copyInputTestData(QC_Components__C comp,String comType){
      
      System.debug('---@@@---@@@---'+comp);        
      System.debug('---@@@---@@@---'+comType); 
      
      set<id> childIds 						 = new set<id>();			//hold the child variants record ids
      set<id> compChildVariantUpdate 		 = new set<id>();			//hold the ids of components of child variants to update.
      
      set<id> childVariantInputFindingParentID	 = new set<id>();		//hold the ids of the child components parent id.
      set<id> childVariantTestFindingParentID	 = new set<id>();		//hold the ids of the child components parent id.
      
      QC_Components__c queryMaster 			 = new QC_Components__c();
      
      list<QC_Components__c> updateCompVerdict = new list<QC_Components__c>();
      
      list<QC_Input_Data__c> getInputDataMasterVarComp	 = new list<QC_Input_Data__c>();	//List to hold the input parameters of the master variant component which is getting edited
      list<QC_Test_Data__c> getTestDataMasterVarComp	 = new list<QC_Test_Data__c>();		//List to hold the test parameters of the master variant component which is getting edited
      
      list<QC_Input_Data__c> getInputDataChildVarComp 	 = new list<QC_Input_Data__c>();	//List to hold the input parameters of the child variant component which is to be deleted
      list<QC_Input_Data__c> deleteInputDataChildVarComp = new list<QC_Input_Data__c>();	//List to hold the ids of input records to be deleted
      
      list<QC_Test_Data__c> getTestDataChildVarComp 	 = new list<QC_Test_Data__c>();		//List to hold the test parameters of the child variant component which is to be deleted
      list<QC_Test_Data__c> deleteTestDataChildVarComp 	 = new list<QC_Test_Data__c>();		//List to hold the ids of test records to be deleted
       
       List<QC_Input_Data__c> cloneInputParam = new List<QC_Input_Data__c>(); 
       List<QC_Test_Data__c> cloneTestParam = new List<QC_Test_Data__c>();
      try{
      	  queryMaster=[SELECT id,name,name__c,master__c FROM QC_Components__c WHERE id=:comp.Parent__c];
      	   if(queryMaster.master__c == true){ 
      	  		getInputDataMasterVarComp = [SELECT Id,Name,Comments__c,Component_No__c,Response_Id__c,Question__c,Question_Name__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c =: comp.id];
      	  		getTestDataMasterVarComp  =  [SELECT Id,Conclusion__c,Comments_and_Remarks__c,Component_Name__c,Observation__c,Condition_Ref__c FROM QC_Test_Data__c WHERE Component_Name__c =: comp.id];
      	   }
      }catch(Exception e){
      	  System.debug('Exception in master component - master variant'+e);
      } 
      System.debug('---@@@-queryMaster--@@@---'+queryMaster);    
      System.debug('---@@@-queryMaster input parameters--@@@---'+getInputDataMasterVarComp.size());   
      System.debug('---@@@-queryMaster test parameters--@@@---'+getTestDataMasterVarComp.size());   
      
      if(queryMaster.master__c == true){    
      	 //Find all the child variant component with master variant lookup
	      for(QC_Components__c sample : [SELECT id,Final_Verdict__c FROM QC_Components__c WHERE Master_Variant__c =: comp.parent__r.id ]){
	      		childIds.add(sample.id);
	      } 	     
	      //find the child variant rejected component which is having the master variant
	      for(QC_Components__c childComp : [SELECT id,name,Final_Verdict__c,name__c FROM QC_Components__c WHERE parent__c in: childIds 
	      									AND name__c =: comType AND IsCopied_From_Master__c = true] ){
	      		compChildVariantUpdate.add(childComp.id);
	      		
	      		//QC_Components__c updateVerdict = new QC_Components__c();
	      		childComp.Final_Verdict__c = comp.Final_Verdict__c;	
	      		updateCompVerdict.add(childComp);      		
	      }
	      
	      System.debug('!!!!@@@@@@@@@@'+compChildVariantUpdate);
	      try{
	      		
      			/*
      				Code block to delete the input and test parameters of the components of child variant whose verdict is rejected and Update with master variant 
      				components input and test findings. 
      			*/
      			
      			if(compChildVariantUpdate != null){
      				update updateCompVerdict;			//Update final verdict of child variant rejected component.
      				//Query the input parameters of the rejected component of the child variant
	      			if(getInputDataMasterVarComp != null){
		      			getInputDataChildVarComp = [SELECT Id,Name,Comments__c,Component_No__c,Response_Id__c,Question__c,Question_Name__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c in: compChildVariantUpdate];
		                System.debug('input data to clone'+getInputDataChildVarComp);
		                for(QC_Input_Data__c delInputData : getInputDataChildVarComp){
		                		childVariantInputFindingParentID.add(delInputData.Component_No__c);		                			
		                		deleteInputDataChildVarComp.add(delInputData);
		                }
		                System.debug('input data to delete'+deleteInputDataChildVarComp); 
		                 System.debug('input data to delete - component no'+childVariantInputFindingParentID); 
		                 for(ID eachPid : childVariantInputFindingParentID){
			                 for(QC_Input_Data__c ci : getInputDataMasterVarComp){	                 	
			                 		QC_Input_Data__c cloneInput = ci.clone(false);
			                 		cloneInput.Component_No__c = eachPid;
			                 		cloneInputParam.add(cloneInput);
			                 }
		                 }
		                 delete deleteInputDataChildVarComp;
      					 insert cloneInputParam;
	      			} 
	                ////Query the test parameters of the rejected component of the child variant            	  
	                if(getTestDataMasterVarComp != null){
		                getTestDataChildVarComp  =[SELECT Id,Conclusion__c,Comments_and_Remarks__c,Component_Name__c,Observation__c,Condition_Ref__c FROM QC_Test_Data__c WHERE Component_Name__c in: compChildVariantUpdate];     
		                System.debug('test data to clone'+getTestDataChildVarComp); 
		                for(QC_Test_Data__c delTestData : getTestDataChildVarComp){
		                		childVariantTestFindingParentID.add(delTestData.Component_Name__c);
		                		deleteTestDataChildVarComp.add(delTestData);
		                }              	    
		                System.debug('master component test findings'+getTestDataMasterVarComp);
		                System.debug('test data to delete'+deleteTestDataChildVarComp); 
		                System.debug('test data to delete - component no'+childVariantTestFindingParentID); 
		                 if(childVariantTestFindingParentID != null){
			                 for(ID eachPid : childVariantTestFindingParentID){
				                for(QC_Test_Data__c ct : getTestDataMasterVarComp){
				                 		QC_Test_Data__c cloneTest = ct.clone(false); 
				                 		cloneTest.Component_Name__c = eachPid;
				                 		cloneTestParam.add(cloneTest);
				                 }
			                 }
		                 }
		                 insert cloneTestParam;	
		                 delete deleteTestDataChildVarComp; 
	                }
	               
      			}   
      			  
          }catch(Exception e){
	      	System.debug('Exception in updating rejected component - child variant'+e);
	      }
      } 
   }
}