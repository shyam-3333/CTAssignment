({
	doinit : function(component, event, helper) {
        debugger;
        var isNew = component.get("v.isNew");
        helper.getCompNamePickList(component, event, helper,'Color_of_the_metal_Physical_analysis__c');
       // helper.getCompNamePickList(component, event, helper,'Competitor_name__c');
        //helper.getCompNamePickList(component, event, helper,'City__c');
        helper.getCompNamePickList(component, event, helper,'Product_Category__c');
        helper.getCompNamePickList(component, event, helper,'Product_Group__c');
        helper.getCompNamePickList(component, event, helper,'Metal__c');
        helper.getCompNamePickList(component, event, helper,'Manufacturing_route__c');
        helper.getCompNamePickList(component, event, helper,'Purchased_Department__c');
        helper.getCompNamePickList(component, event, helper,'Color_of_the_metal__c');
        helper.getCompNamePickList(component, event, helper,'Purity_Competitor_Billing__c');
        helper.getCompNamePickList(component, event, helper,'Stone_Detail_Competitor_Billing__c');
       // helper.getCompNamePickList(component, event, helper,'Stone_Quality_Competitor_Billing__c');
        helper.getCompNamePickList(component, event, helper,'Colour__c');
       // helper.getCompNamePickList(component, event, helper,'Setting_Type_Competitor_Billling__c');
        helper.getCompNamePickList(component, event, helper,'Setting_Type__c');
        helper.getCompNamePickList(component, event, helper,'Attachment__c');
        helper.getCompNamePickList(component, event, helper,'Finish_Competitor_Billing__c');
        helper.getCompNamePickList(component, event, helper,'Stone_Detail__c');
        helper.getCompNamePickList(component, event, helper,'Finish_Physical_analysis1__c');
        
        if(isNew == false){
            helper.fetchRecordDetails(component, event, helper);
        }

	},
    handlechange : function(component, event, helper){
        var netweight= component.get("v.CompetitorProduct");
        //alert("input is "+netweight.Net_Weight_Competito_Billing__c);
        netweight.Gold_price_Competitor__c = netweight.Net_Weight_Competito_Billing__c * netweight.Gold_Rate_Gram_Competitor_Billing__c;
        component.set("v.CompetitorProduct",netweight);
        
    },
    
    clickSave : function(component, event, helper){
        component.set("v.showDetail",true);
        component.set("v.isNew",false);
        helper.saveRecordHelper(component, event, helper);
    },
    cancel : function(component, event, helper){
        var eUrl= $A.get("e.force:navigateToURL"); eUrl.setParams({ "url": 'https://titanlightningapps.lightning.force.com/lightning/o/Competitor_Product_Jew__c/list?filterName=Recent' }); eUrl.fire();
    },
    handleUploadFinished: function (component, event, helper) {
        helper.fetchAttachments(component,event,helper);
    },
    editMode : function(component, event, helper){
        component.set("v.showDetail",false);
        component.set("v.isNew",false);
    },
    updateRec : function(component, event, helper){

        component.set("v.showDetail",true);
        component.set("v.isNew",false);
        helper.updateRecord(component, event, helper);
        
        
    },
    closeModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
      component.set("v.isOpen", false);
   },
 
   likenClose: function(component, event, helper) {
      // Display alert message on the click on the "Like and Close" button from Model Footer 
      // and set set the "isOpen" attribute to "False for close the model Box.
      alert('thanks for like Us :)');
      component.set("v.isOpen", false);
   },
    openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.isOpen", true);
        helper.fetchAttachments(component, event, helper);
   },
    handleClose : function(component, event, helper){
        component.set("v.sendPDF",false);
    },
    openPDF : function(component, event, helper){
        component.set("v.sendPDF",true);
    },
    SendPdfCon : function(component, event, helper){
        helper.sendEmail(component, event, helper);
    },
    
    newUpload : function( component, event, helper){
        component.set("v.newAttach",true);
    },
    
   
// this methods is used to collect multivalue picklist From MultivaluePicklistEvent
    onChangePickVal : function (component, event, helper) 
    {
        var multivaluePicklistValue = event.getParam('selectedValues');
        var multivaluePicklistName = event.getParam('picklistName');

        var compProduct = component.get("v.CompetitorProduct");
        var a =[];
        var b ;
        for(var i=0 ; i< multivaluePicklistValue.length ;i++)
        {
            a.push( {'label': multivaluePicklistValue[i] ,'value': multivaluePicklistValue[i]});
            if(b == null || b == undefined )
                b = multivaluePicklistValue[i];
            else
                b = b + ';'+multivaluePicklistValue[i];
        }
        
        compProduct[multivaluePicklistName] = b ;
        component.set("v.CompetitorProduct",JSON.parse(JSON.stringify(compProduct)));
    },
})