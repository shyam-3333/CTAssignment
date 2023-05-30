public class CloneQuote_Actual
{
  Id quoteid;
  String status='Approved';
  boolean val=true;
  boolean va=false;
  
  Quote q;

  
  public CloneQuote_Actual(ApexPages.StandardController controller) 
  {

  }
  
 /* public PageReference autoRun()
  {
      quoteid = ApexPages.Currentpage().getParameters().get('id');
      system.debug('quoteid===>'+quoteid);
      if(quoteid == null)
          return null;
      
      Schema.DescribeSObjectResult r = Quote.sObjectType.getDescribe();   
      Map<String,Schema.SObjectField> M = r.fields.getMap(); 
      
      String SOQL = 'Select '; 
      for(String fieldName : M.keySet()){
              SOQL += fieldName + ',';  
      } 
  
      SOQL = SOQL.substring(0,SOQL.length()-1); 
      SOQL += ' From Quote where id=:quoteid and Approval_Status_Quote__c=:status LIMIT 1' ;  

      Quote S = Database.query(SOQL); 
      
    
    
      Quote sss = (Quote)S;
  
      Quote newsss = sss.clone(false,true);
        // piyush 
      newsss.Cloned__c = true;
      newsss.Approved_Discount_corp__c=0;
      newsss.Approval_Status_Quote__c='Approval Required';
      newsss.Approved_QuoteLineItem__c=0;
      newsss.Final_Approval_Check__c=false;*/
      
      //newsss.Mechanical_Bought_out_Cost_INR__c = null;
      //newsss.Mechanical_Fabrication_Cost_INR__c = null;
      //newsss.Electrical_Bought_out_Cost_INR__c = null;
      //newsss.Electrical_Fabrication_Cost_INR__c = null;
      //newsss.Contingency_INR__c = null;
      //newsss.Overheads_INR__c = null;
      //newsss.Packing_and_Forwarding_INR__c = null;
      // newsss.Transport_Charges_INR__c = null;
      // newsss.Transit_Insurance_INR__c = null;
        
      /*
      Map<String,CheckValidation__c> myCheck=CheckValidation__c.getAll();
      
      boolean up=myCheck.get('Check').isChecked;
      
      up=false;
      
      myCheck.get('check').isChecked=up;
      
      update myCheck.get('check');*/
      
     /* CheckValidation__c val=[select isChecked__c from CheckValidation__c];
      val.isChecked__c=false;
    
      update val;
      
      
      insert newsss;
      
          CheckValidation__c eval=[select isChecked__c from CheckValidation__c];
      eval.isChecked__c=true;
    
      update eval;

      
      System.debug('------------------------------------------------------------------------->'+newsss); 
      
      
      List<QuoteLineItem> myQuote=new List<QuoteLineItem>();
      
      
      for(Quotelineitem qt:[Select id,isdeleted,linenumber,currencyisocode,createddate,createdbyid,
    lastmodifieddate,lastmodifiedbyid,systemmodstamp,quoteid,pricebookentryid,
    quantity,unitprice,discount,description,servicedate,sortorder,listprice,
    subtotal,totalprice,fa_price_piece__c,material_cost_piece__c,min_lot_size_nos__c,
    one_time_development_charges_part__c,opportunity_id__c,part_number__c,product_id__c,
    raw_material_specification__c,unit_price_for_bulk__c,value_add_piece__c,
    opportunity_status__c,boi_cost_piece__c,boi_cost_piece_pecsapdf__c,optional__c,
    spl_process_cost_piece__c,spl_process_cost_piece_pecsapdf__c,value_add_piece_pecsapdf__c,
    regret_reasons__c,unit_price_pecsapdf__c,part_number_pecsapdf__c,
    material_cost_piece_pecsapdf__c,quote_amount__c,roll_up__c,sales_price_1__c,total_price_1__c,
    subtotal_1__c,back_cover_engraving__c,dial_printing_charges__c,price_per_unit_customization__c,
    all_customization_charges__c,bce_for_std_qt_tmplt__c,custom_totalprice__c,customization_payment_criteria__c,dpc_for_std_qt_tmplt__c,
    developmental_charges__c,die_customization_charges__c,discount_for_bce__c,discount_for_other_charges__c,
    discount_c__c,discount_for_dpc__c,discount_in_rupees__c,discounted_bce__c,discounted_dpc__c,
    discounted_other_charges__c,extra_charges__c,final_price_for_std_qt_tmplt__c,free_of_cost_approved__c,
    laser_customization_charges__c,multi_location_delivery_charges__c,net_price_for_std_qt_tmplt__c,
    octroi_charges__c,other_charges__c,other_charges_for_std_qt_tmplt__c,packaging__c,
    price_per_unit_after_discount__c,product_name__c,purity__c,sales_price_ucp_for_std_qt_tmplt__c,sales_price_c__c,
    serial_number__c,total_cust_charges__c,total_price_custom__c,validity__c,weight__c,
    weight_of_the_product__c,custom_subtotal__c,weight_for_rollup__c,total_weight__c,average_eau__c,discount_in_values_for_corporate__c,
    nre_cost__c,subcontract_cost__c,fai_cost__c,product_catagory__c,product_sub_category__c From QuoteLineItem
    where QuoteId=:quoteId])
        {
          QuoteLineItem qc=qt.clone(false);
          qc.QuoteId=newsss.id;
          myQuote.add(qc);
          
        }
      
        CheckAgain__c wval=[select isChecked__c from CheckAgain__c];
      wval.isChecked__c=false;
    
      update wval;
      
      insert myQuote; 
      
        CheckAgain__c ewval=[select isChecked__c from CheckAgain__c];
      ewval.isChecked__c=true;
    
      update ewval;

      
              
      
              PageReference pageRef = new PageReference('/' + newsss.Id );
      pageRef.setRedirect(true);
      return pageRef;
      }*/
    
    
  @AuraEnabled
  public static string onLoad(id quoId){
      String status1='Approved';
    System.debug('quoteid===>'+quoId);
    //try {
      if(quoId != null){
        //quoId = ApexPages.Currentpage().getParameters().get('id');
        
        
        Schema.DescribeSObjectResult r = Quote.sObjectType.getDescribe();   
        Map<String,Schema.SObjectField> M = r.fields.getMap(); 
        
        String SOQL = 'Select '; 
        for(String fieldName : M.keySet()){
                SOQL += fieldName + ',';  
        } 
    
        SOQL = SOQL.substring(0,SOQL.length()-1); 
        SOQL += ' From Quote where id=:quoId LIMIT 1' ; 
          
        Quote S = Database.query(SOQL); 
        
      
      
        Quote sss = (Quote)S;
          if(sss.Approval_Status_Quote__c != 'Approved'){
              return 'Not approved';
          }
          system.debug('after return');
        Quote newsss = sss.clone(false,true);
          // piyush 
        newsss.Cloned__c = true;
        newsss.Approved_Discount_corp__c=0;
        newsss.Approval_Status_Quote__c='Approval Required';
        newsss.Approved_QuoteLineItem__c=0;
        newsss.Final_Approval_Check__c=false;
        insert newsss;
        List<QuoteLineItem> myQuote=new List<QuoteLineItem>();
        for(Quotelineitem qt:[Select id,isdeleted,linenumber,currencyisocode,createddate,createdbyid,
      lastmodifieddate,lastmodifiedbyid,systemmodstamp,quoteid,pricebookentryid,
      quantity,unitprice,discount,description,servicedate,sortorder,listprice,
      subtotal,totalprice,fa_price_piece__c,material_cost_piece__c,min_lot_size_nos__c,
      one_time_development_charges_part__c,opportunity_id__c,part_number__c,product_id__c,
      raw_material_specification__c,unit_price_for_bulk__c,value_add_piece__c,
      opportunity_status__c,boi_cost_piece__c,boi_cost_piece_pecsapdf__c,optional__c,
      spl_process_cost_piece__c,spl_process_cost_piece_pecsapdf__c,value_add_piece_pecsapdf__c,
      regret_reasons__c,unit_price_pecsapdf__c,part_number_pecsapdf__c,
      material_cost_piece_pecsapdf__c,quote_amount__c,roll_up__c,sales_price_1__c,total_price_1__c,
      subtotal_1__c,back_cover_engraving__c,dial_printing_charges__c,price_per_unit_customization__c,
      all_customization_charges__c,bce_for_std_qt_tmplt__c,custom_totalprice__c,customization_payment_criteria__c,dpc_for_std_qt_tmplt__c,
      developmental_charges__c,die_customization_charges__c,discount_for_bce__c,discount_for_other_charges__c,
      discount_c__c,discount_for_dpc__c,discount_in_rupees__c,discounted_bce__c,discounted_dpc__c,
      discounted_other_charges__c,extra_charges__c,final_price_for_std_qt_tmplt__c,free_of_cost_approved__c,
      laser_customization_charges__c,multi_location_delivery_charges__c,net_price_for_std_qt_tmplt__c,
      octroi_charges__c,other_charges__c,other_charges_for_std_qt_tmplt__c,packaging__c,
      price_per_unit_after_discount__c,product_name__c,purity__c,sales_price_ucp_for_std_qt_tmplt__c,sales_price_c__c,
      serial_number__c,total_cust_charges__c,total_price_custom__c,validity__c,weight__c,
      weight_of_the_product__c,custom_subtotal__c,weight_for_rollup__c,total_weight__c,average_eau__c,discount_in_values_for_corporate__c,
      nre_cost__c,subcontract_cost__c,fai_cost__c,product_catagory__c,product_sub_category__c From QuoteLineItem
      where QuoteId=:quoId])
          {
            QuoteLineItem qc=qt.clone(false);
            qc.QuoteId=newsss.id;
            myQuote.add(qc);
            
          }
        insert myQuote;
        return newsss.id;
      }
      return null;
   /* } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
      return null;
    }
      return null;*/
  }
}