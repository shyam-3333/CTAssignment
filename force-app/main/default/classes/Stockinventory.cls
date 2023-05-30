public with sharing class Stockinventory{
     
     public Quote stockRequest{get;set;}
     public list<Quote_Items__c> SRLI{get;set;}
     public product2 pro{get;set;}
     public list<Asset>  Ass{get;set;}
     public boolean flag{get;set;}
     public boolean Norecored{get;set;}
     public boolean Norecored1{get;set;}
     public boolean c{get; set;}
     public Integer call{get;set;}
     public String currentDCid{get;set;}
     public string sr{get; set;}
     public String QuoteId{get; set;}
     public String qiid{get; set;}
     public string strValue{get; set;} 
     public integer strrmv{get; set;}
     public integer rewnumber{get; set;}
     public String selectedId {get; set;}
     public List<String> statenames {get; set;}
     public String citynames {get; set;}
     public String expencedelete {get; set;}
     public Quote_Items__c qi {get; set;}
     Public Boolean SelectBox{get;set;}
     public Id qliid;
     
     public Stockinventory(ApexPages.StandardController controller) {
       
         flag=true;
         Norecored=true;
         Norecored1=true;
         qi=new Quote_Items__c();
         rewnumber=0;
        
       
         QuoteId = apexpages.currentpage().getparameters().get('id');
  
        
             try{
             stockRequest=[select id,name from Quote where id=:QuoteId];
             SRLI=[select id,Raw_Material_Grade__c,Delete__c,quote__c,Others1__c, Others2__c, Others_lost__c, Part_No__c,Part_Description__c,Part_Status__c,Processing_Cost_pc__c,Sub_Reasone_for_Regret_2__c ,Reasone_for_Regret_2__c ,Sub_Reasone_for_Regret__c,Reasone_for_Regret__c,Reasone_for_Lost__c,Spl_Process_Cost_pc__c,Optional__c,Raw_Material_Specification__c,One_Time_Dev_Cost_NRE__c,Material_Cost_pc__c,
             FAI_Cost_pc__c,PO_Value__c,PO_Quantity__c,PO_number__c,PO_Date__c,NRE_PO_Value__c,NRE_PO_Number__c,NRE_PO_Date__c,FA_Quantity__c,FA_Value__c,BOI_Cost_pc__c,EAU_in_no_s__c,Drawing_Revision__c,Part_Revision__c,Batch_Quantity__c,CurrencyIsoCode,Currency_custom__c, Parity_Value__c, Remarks__c from Quote_Items__c where Quote__c=:QuoteId];
         if(!SRLI.isEmpty()){
                 qi=SRLI[0];
                 System.debug('@@@@@@'+qi);
            }
          }catch(QueryException ex){}
         
     }
     
     public void dummycall(){
         Id qiid = apexpages.currentpage().getparameters().get('recId') != '' ? apexpages.currentpage().getparameters().get('recId') : null;
                 String recStatus = apexpages.currentpage().getparameters().get('recstatus');
      System.debug('-------befroe if------>'+recStatus);
       System.debug('-------qiidqiid------>'+qiid);
             if([select id from Quote_Items__c where id=:qiid and Quote__c=:QuoteId].size()>0){
          
            qi=new Quote_Items__c();
                 
                 System.debug('-------recStatus------>'+recStatus);
             qi=[select id,Raw_Material_Grade__c, Others1__c,Delete__c,quote__c, Others2__c, Others_lost__c, Part_No__c,Part_Description__c,Part_Status__c,Processing_Cost_pc__c,Sub_Reasone_for_Regret_2__c ,Reasone_for_Regret_2__c ,Sub_Reasone_for_Regret__c,Reasone_for_Regret__c,Reasone_for_Lost__c,Spl_Process_Cost_pc__c,Optional__c,Raw_Material_Specification__c,One_Time_Dev_Cost_NRE__c,Material_Cost_pc__c,
             FAI_Cost_pc__c,PO_Value__c,PO_Quantity__c,PO_number__c,PO_Date__c,NRE_PO_Value__c,NRE_PO_Number__c,NRE_PO_Date__c,FA_Quantity__c,FA_Value__c,BOI_Cost_pc__c,EAU_in_no_s__c,Drawing_Revision__c,Part_Revision__c,Batch_Quantity__c,CurrencyIsoCode,Currency_custom__c, Parity_Value__c, Remarks__c from Quote_Items__c where id=:qiid and Quote__c=:QuoteId];
         System.debug('------------->'+qi.quote__c);
           System.debug('------------->'+QuoteId);
          
         qi.Part_Status__c = recStatus;
         
          
         }
         else {
         System.debug('-------in else------>'+recStatus);
                     qi=new Quote_Items__c();
                     
                     qi.Part_Status__c = recStatus;
         
           //SRLI.add(qi);
            
         
         
         
         }
     }
     
//AutoSave method added by Pawani, for auto save functionality
    public void  autoSave(){
  
            upsert SRLI;
           
    }
 
    public void myactionfun(){
        system.debug('strValuestrValuestrValue'+strValue);
    }
    public PageReference changeCityList(){
            return null; 
        }
//******************************************For Add more line item button code*************************************
public void AddItemDetails(){
     Quote_Items__c srl = new Quote_Items__c ();
     
     srl.Quote__c=QuoteId;
     SRLI.add(srl);
   }
   
    public void RemoveItem(){
     Quote_Items__c srl = new Quote_Items__c ();
     integer i=strrmv;
     srl.Quote__c=QuoteId;
     SRLI.remove(i+2);
   }  

 
//**********************************Code for Remove lineitem******************************* 
public void removeItemDetails()
  {
      
      integer i=strrmv;
      SRLI.remove(i+2);
    
      
  } 
  
   Public PageReference DeleteSelectedRecs(){
     
      List<Quote_Items__c> DeleteList = New List<Quote_Items__c>();
      List<Integer> Index = new List<Integer>();
      
      integer i = 0;
    for(Quote_Items__c wc:SRLI){
                    System.debug('@@@@@bhanu'+i+Wc.Delete__c);
              if(wc.id !=null){
                      if(wc.Delete__c  == true){
                             DeleteList.add(wc);
                             Index.add(i); 
                         }
                                            
                     }
                      else if(wc.Delete__c){
                       Index.add(i);
                       System.debug('@@@@@inside'+i);
                       }
                       i++;
                   //delcheck = true; 
             }
             /*if(delcheck)
                  SRLI.remove(SRLI.size()-1);*/
              System.debug('Index--->'+Index);
              if(Index.size()>0){
              integer x = 0;
           for(Integer a : Index){
           System.debug('inisde remvoe @@@@@'+a);
            SRLI.remove(a-x);   
            x++;
            }
       }      
     if(DeleteList.size()>0){
              delete DeleteList;
          }
       
      //SRLI = DummyList;
      /* PageReference pr = new PageReference ('/apex/AddLineItemPecsa?id='+QuoteId);
            pr.setRedirect(true);
            return pr;   */
            return null;
          
    }
    
//***********************************************************Save code it will update both inventorys ******************************
public pageReference  Save1(){
boolean error =false;
 
 if ( qi.Part_Status__c == 'Lost' && qi.Reasone_for_Lost__c==null)  
 {
     error=true;
     qi.Part_Status__c.addError('Please select lost reason');
 }
 
 if ( qi.Part_Status__c == 'Regret' && qi.Reasone_for_Regret__c==null && qi.Reasone_for_Regret_2__c==null)  
 {
      error=true;
      qi.Part_Status__c.addError('Please select any one of the regret reason');
 }
 
 if ( qi.Part_Status__c == 'Regret' && (qi.Reasone_for_Regret__c=='Surface Treatment' || qi.Reasone_for_Regret__c=='Special Process' || qi.Reasone_for_Regret__c=='Raw Material' || qi.Reasone_for_Regret__c=='Capability'|| qi.Reasone_for_Regret__c=='Commercial Viability' || qi.Reasone_for_Regret__c=='Inspection' || qi.Reasone_for_Regret__c=='Finishing Process' || qi.Reasone_for_Regret__c=='Heat Treatment Type') && qi.Sub_Reasone_for_Regret__c==null)  
 {
      error=true;
      qi.Part_Status__c.addError('Please select sub regret reason 1');
 }
 
  if ( qi.Part_Status__c == 'Regret' && (qi.Reasone_for_Regret_2__c=='Surface Treatment' || qi.Reasone_for_Regret_2__c=='Special Process' || qi.Reasone_for_Regret_2__c=='Raw Material' || qi.Reasone_for_Regret_2__c=='Capability'|| qi.Reasone_for_Regret_2__c=='Commercial Viability' || qi.Reasone_for_Regret_2__c=='Inspection' || qi.Reasone_for_Regret_2__c=='Finishing Process' || qi.Reasone_for_Regret_2__c=='Heat Treatment Type') && qi.Sub_Reasone_for_Regret_2__c==null)  
 {
      error=true;
      qi.Part_Status__c.addError('Please select sub regret reason 2');
 }

 

 if(!error){
     System.debug('------------>'+qi.quote__c);
     if(qi.quote__c == null){
       qi.quote__c = apexpages.currentpage().getparameters().get('Id');
     
     } 
    
       
        //upsert qi;
        upsert SRLI;
     
     PageReference pr = new PageReference ('/'+QuoteId);
            pr.setRedirect(true);
            return pr;
         }
         return null;
    }


public pageReference  Save2(){
boolean error =false;
 
 if ( qi.Part_Status__c == 'Lost' && qi.Reasone_for_Lost__c==null)  
 {
     error=true;
     qi.Part_Status__c.addError('Please select lost reason');
 }
 
 if ( qi.Part_Status__c == 'Regret' && qi.Reasone_for_Regret__c==null && qi.Reasone_for_Regret_2__c==null)  
 {
      error=true;
      qi.Part_Status__c.addError('Please select any one of the regret reason');
 }
 
 if ( qi.Part_Status__c == 'Regret' && (qi.Reasone_for_Regret__c=='Surface Treatment' || qi.Reasone_for_Regret__c=='Special Process' || qi.Reasone_for_Regret__c=='Raw Material' || qi.Reasone_for_Regret__c=='Capability'|| qi.Reasone_for_Regret__c=='Commercial Viability' || qi.Reasone_for_Regret__c=='Inspection' || qi.Reasone_for_Regret__c=='Finishing Process' || qi.Reasone_for_Regret__c=='Heat Treatment Type') && qi.Sub_Reasone_for_Regret__c==null)  
 {
      error=true;
      qi.Part_Status__c.addError('Please select sub regret reason 1');
 }
 
  if ( qi.Part_Status__c == 'Regret' && (qi.Reasone_for_Regret_2__c=='Surface Treatment' || qi.Reasone_for_Regret_2__c=='Special Process' || qi.Reasone_for_Regret_2__c=='Raw Material' || qi.Reasone_for_Regret_2__c=='Capability'|| qi.Reasone_for_Regret_2__c=='Commercial Viability' || qi.Reasone_for_Regret_2__c=='Inspection' || qi.Reasone_for_Regret_2__c=='Finishing Process' || qi.Reasone_for_Regret_2__c=='Heat Treatment Type') && qi.Sub_Reasone_for_Regret_2__c==null)  
 {
      error=true;
      qi.Part_Status__c.addError('Please select sub regret reason 2');
 }

 

 if(!error){
 //qliid = apexpages.currentpage().getparameters().get('recId');
 System.debug('------------>'+qi.quote__c);
 System.debug('------rewnumberrewnumber------>'+rewnumber);
 //System.debug('------qiidqiid------>'+qliid);
   
   if(qi.quote__c == null){
       qi.quote__c = apexpages.currentpage().getparameters().get('Id');
     
     } 
    if(qi.id == null){
        qi.Part_No__c=SRLI[SRLI.size()-1].Part_No__c;
        qi.Raw_Material_Grade__c=SRLI[SRLI.size()-1].Raw_Material_Grade__c;
        qi.Part_Description__c=SRLI[SRLI.size()-1].Part_Description__c;
        qi.Processing_Cost_pc__c=SRLI[SRLI.size()-1].Processing_Cost_pc__c;
        qi.Spl_Process_Cost_pc__c=SRLI[SRLI.size()-1].Spl_Process_Cost_pc__c;
        qi.Optional__c=SRLI[SRLI.size()-1].Optional__c;
        qi.Raw_Material_Specification__c=SRLI[SRLI.size()-1].Raw_Material_Specification__c;
        qi.One_Time_Dev_Cost_NRE__c=SRLI[SRLI.size()-1].One_Time_Dev_Cost_NRE__c;
        qi.Material_Cost_pc__c=SRLI[SRLI.size()-1].Material_Cost_pc__c;
        qi.FAI_Cost_pc__c=SRLI[SRLI.size()-1].FAI_Cost_pc__c;
        qi.BOI_Cost_pc__c=SRLI[SRLI.size()-1].BOI_Cost_pc__c;
        qi.EAU_in_no_s__c=SRLI[SRLI.size()-1].EAU_in_no_s__c;
        qi.Drawing_Revision__c=SRLI[SRLI.size()-1].Drawing_Revision__c;
        qi.Batch_Quantity__c=SRLI[SRLI.size()-1].Batch_Quantity__c;
        qi.Remarks__c=SRLI[SRLI.size()-1].Remarks__c;
        SRLI[SRLI.size()-1].Part_Revision__c=qi.Part_Revision__c;
        SRLI[SRLI.size()-1].Others1__c=qi.Others1__c;
        SRLI[SRLI.size()-1].Others2__c=qi.Others2__c;
        SRLI[SRLI.size()-1].Others_lost__c=qi.Others_lost__c;
        SRLI[SRLI.size()-1].Sub_Reasone_for_Regret_2__c=qi.Sub_Reasone_for_Regret_2__c;
        SRLI[SRLI.size()-1].Reasone_for_Regret_2__c=qi.Reasone_for_Regret_2__c;
        SRLI[SRLI.size()-1].Sub_Reasone_for_Regret__c=qi.Sub_Reasone_for_Regret__c;
        SRLI[SRLI.size()-1].Reasone_for_Regret__c=qi.Reasone_for_Regret__c;
        SRLI[SRLI.size()-1].Reasone_for_Lost__c=qi.Reasone_for_Lost__c;
        SRLI[SRLI.size()-1].PO_Value__c=qi.PO_Value__c;
        SRLI[SRLI.size()-1].PO_Quantity__c=qi.PO_Quantity__c;
        SRLI[SRLI.size()-1].PO_number__c=qi.PO_number__c;
        SRLI[SRLI.size()-1].PO_Date__c=qi.PO_Date__c;
        SRLI[SRLI.size()-1].NRE_PO_Value__c=qi.NRE_PO_Value__c;
        SRLI[SRLI.size()-1].NRE_PO_Number__c=qi.NRE_PO_Number__c;
        SRLI[SRLI.size()-1].NRE_PO_Date__c=qi.NRE_PO_Date__c;
        SRLI[SRLI.size()-1].FA_Quantity__c=qi.FA_Quantity__c;
        SRLI[SRLI.size()-1].FA_Value__c=qi.FA_Value__c;
      
    }
    else{
        for(Quote_Items__c qq : SRLI)
            if(qq.id == qi.id)
            {
                system.debug('-------bhanu --'+qq.id);            
                qi.Part_No__c=qq.Part_No__c;
                qi.Raw_Material_Grade__c=qq.Raw_Material_Grade__c;
                qi.Part_Description__c=qq.Part_Description__c;
                qi.Processing_Cost_pc__c=qq.Processing_Cost_pc__c;
                qi.Spl_Process_Cost_pc__c=qq.Spl_Process_Cost_pc__c;
                qi.Optional__c=qq.Optional__c;
                qi.Raw_Material_Specification__c=qq.Raw_Material_Specification__c;
                qi.One_Time_Dev_Cost_NRE__c=qq.One_Time_Dev_Cost_NRE__c;
                qi.Material_Cost_pc__c=qq.Material_Cost_pc__c;
                qi.FAI_Cost_pc__c=qq.FAI_Cost_pc__c;
                qi.BOI_Cost_pc__c=qq.BOI_Cost_pc__c;
                qi.EAU_in_no_s__c=qq.EAU_in_no_s__c;
                qi.Drawing_Revision__c=qq.Drawing_Revision__c;
                qi.Part_Revision__c=qq.Part_Revision__c;
                qi.Batch_Quantity__c=qq.Batch_Quantity__c;
                qi.Remarks__c=qq.Remarks__c;
                qq.Others1__c=qi.Others1__c;
                qq.Others2__c=qi.Others2__c;
                qq.Sub_Reasone_for_Regret_2__c=qi.Sub_Reasone_for_Regret_2__c;
                qq.Reasone_for_Regret_2__c=qi.Reasone_for_Regret_2__c;
                qq.Sub_Reasone_for_Regret__c=qi.Sub_Reasone_for_Regret__c;
                qq.Reasone_for_Regret__c=qi.Reasone_for_Regret__c;
                qq.Others_lost__c=qi.Others_lost__c;
                qq.Reasone_for_Lost__c=qi.Reasone_for_Lost__c;
                qq.PO_Value__c=qi.PO_Value__c;
                qq.PO_Quantity__c=qi.PO_Quantity__c;
                qq.PO_number__c=qi.PO_number__c;
                qq.PO_Date__c=qi.PO_Date__c;
                qq.NRE_PO_Value__c=qi.NRE_PO_Value__c;
                qq.NRE_PO_Number__c=qi.NRE_PO_Number__c;
                qq.NRE_PO_Date__c=qi.NRE_PO_Date__c;
                qq.FA_Quantity__c=qi.FA_Quantity__c;
                qq.FA_Value__c=qi.FA_Value__c;
               
                 
                
             }    
           
    }
      
   //upsert qi;
   
   
   //SRLI.add(qi);
   upsert SRLI;
 
   PageReference pr = new PageReference ('/apex/AddLineItemPecsa?id='+QuoteId);
           pr.setRedirect(true);
           return pr;
                 
         }
         return null;
    
    }
        
//**********************************Code for Cancel button*******************************    
    public PageReference Cancel(){
            PageReference pr = new PageReference ('/'+QuoteId);
            pr.setRedirect(true);
            return pr;
       }
 }