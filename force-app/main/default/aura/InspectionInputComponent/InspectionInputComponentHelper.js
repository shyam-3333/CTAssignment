({
	getPickList : function(component, event, fieldApiName) {
		var action = component.get("c.getPickListValue");
        action.setParams({
            "fieldname" : fieldApiName
        });
        action.setCallback(this,function(response){
           var state=response.getState();
            if(state === "SUCCESS")
            {
                var returnlist = response.getReturnValue();
                var item=JSON.parse(returnlist[0]);
                if(fieldApiName === "Test_Type__c")
               		component.set("v.TestTypeList",JSON.parse(returnlist[0]));
                else if(fieldApiName === "Sample_Type__c")
                    component.set("v.SampleTypeList",JSON.parse(returnlist[0]));
                else if(fieldApiName === "Product_Category__c")
                    component.set("v.ProductTypeList",JSON.parse(returnlist[0]));
                else if(fieldApiName === "Karatage__c")
                    component.set("v.karatageList",JSON.parse(returnlist[0]));
                else if(fieldApiName === "Route_of_Manufacturing__c")
                    component.set("v.routeOfManufactureList",JSON.parse(returnlist[0]));
                else if(fieldApiName === "Location__c")
                    component.set("v.locationList",JSON.parse(returnlist[0]));
                /*
                else if(fieldApiName === "Collection__c")
                    component.set("v.collectionList",JSON.parse(returnlist[0])); */
            }
        });
        $A.enqueueAction(action);
	},
    
    
    getVendors : function( component, event , helper)
    {
        var searchVed = component.get("v.searchVendor");
        var action = component.get("c.getRelatedVendor");
        action.setParams({
            "vendorName" :  searchVed
        });
        
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                component.set("v.jwlVendorList" , JSON.parse(JSON.stringify(response.getReturnValue())));
                component.set("v.jwlVendorListSize" , JSON.parse(JSON.stringify(response.getReturnValue().length)));
            }
        });
        $A.enqueueAction(action);
    },
    
    getResubJwlcompLst : function( component, event , helper)
    {
        var searchJwlComp = component.get("v.searchJwlComp");
        var action = component.get("c.getResubJwlcompLst");
        action.setParams({
            "resubJwlCompRefNum" :  searchJwlComp
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                component.set("v.jwlCompResubmisionList" , JSON.parse(JSON.stringify(response.getReturnValue())));
                //component.set("v.jwlCompResubmisionList" , JSON.parse(JSON.stringify(response.getReturnValue().length)));
            }
        });
        $A.enqueueAction(action);
    },
    
    SaveNewJwlComponent : function(component, event, jwlRespoLst)
    {
        var afterSubmitflag = component.get("v.afterSubmitflag");
        if(afterSubmitflag == false)
        {
            var jwlComp = JSON.parse(JSON.stringify(component.get("v.JWL_Component")));
            var checkedTest = JSON.parse(JSON.stringify(component.get("v.checkedJwltestList")));
            var jwlResp = component.get("v.JWL_Response");
            var ohtersCheck = jwlResp.isChecked__c;
            var action = component.get("c.insertJwlComponent");
            action.setParams({
                "jwl" : jwlComp,
                "testList" : checkedTest,
                "JwlRespLst" : jwlRespoLst,
                "saveflag" : false
            });
            
            action.setCallback(this,function(response){
                var state=response.getState();
                if(state === "SUCCESS")
                {
                    component.set("v.JWL_Component",JSON.parse(JSON.stringify(response.getReturnValue())));
                    component.set("v.JWL_Response",JSON.parse(JSON.stringify(jwlResp)));
                    if(ohtersCheck === 'True')
                        component.set("v.othercheckflag",true);//document.getElementById("othertest").value = "True";
                    else
                        component.set("v.othercheckflag",false);//document.getElementById("othertest").value = "false";
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Jewellery Information is Saved successfully',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                    
                    component.set("v.editFlag",true);
                    
                    // ifOtherscomponent.set("v.editFlag",true);
                    var sc = component.find("Cancel");
                    $A.util.removeClass(sc,"slds-show");
                    $A.util.addClass(sc,"slds-hide");
                    
                    var edit = component.find("Edit");
                    $A.util.removeClass(edit,"slds-hide");
                    $A.util.addClass(edit,"slds-show");
                    
                    var edit = component.find("imhUploadInNew");
                    $A.util.removeClass(edit,"slds-hide");
                    $A.util.addClass(edit,"slds-show");
                }
                else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Jewellery Information is failed to save',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
        }
        else{
            var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Jewellery Information Submitted Already!!!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
        }
        
    },
    
    SubmitNewJwlComponent : function(component, event, jwlRespoLst)
    {
        var flag = component.get("v.flag");
        if( flag != false )
        {
            var jwlComp = JSON.parse(JSON.stringify(component.get("v.JWL_Component")));
            var checkedTest = JSON.parse(JSON.stringify(component.get("v.checkedJwltestList")));
            var jwlResp = component.get("v.JWL_Response");
            var ohtersCheck = jwlResp.isChecked__c;
            var action = component.get("c.insertJwlComponent");
            action.setParams({
                /*"reqString" :JSON.stringify(jsonObject)*/
                "jwl" : jwlComp,
                "testList" : checkedTest,
                "JwlRespLst" : jwlRespoLst,
                "saveflag" : true
            });
            
            action.setCallback(this,function(response){
                var state=response.getState();
                if(state === "SUCCESS")
                {
                    component.set("v.JWL_Component",JSON.parse(JSON.stringify(response.getReturnValue())));
                    component.set("v.JWL_Response",JSON.parse(JSON.stringify(jwlResp)));
                    if(ohtersCheck === 'True')
                        component.set("v.othercheckflag",true);//document.getElementById("othertest").value = "True";
                    else
                        component.set("v.othercheckflag",false);//document.getElementById("othertest").value = "false";
                    
                    var sampleTime = component.find("sampleTime");
                    sampleTime.setCustomValidity("");
                    sampleTime.showHelpMessageIfInvalid("");
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Jewellery Information is submitted Successfully',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                    
                    component.set("v.flag",false);
                    component.set("v.afterSubmitflag",true);
                    component.set("v.editFlag",true);
                    /*var sc = component.find("Cancel");
                    $A.util.removeClass(sc,"slds-show");
                    $A.util.addClass(sc,"slds-hide");
                    
                    var edit = component.find("Edit");
                    $A.util.removeClass(edit,"slds-hide");
                    $A.util.addClass(edit,"slds-show");*/
                    var edit = component.find("ShowEdit");
                    $A.util.removeClass(edit,"slds-show");
                    $A.util.addClass(edit,"slds-hide");
                    
                    
                }
                else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Jewellery Information is failed to submit',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
        }
        else{
            var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Jewellery Information Submitted Already!!!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
        }
    },
    
    getJwlTest : function(component, event, helper)
    {
        var action = component.get("c.getJwlTests");
        
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var returnTest=response.getReturnValue();
                component.set('v.jwltestList',returnTest);
            }
        });
        $A.enqueueAction(action);
    },
    
    showNextButtonAtResub : function(component, event, helper) {
        var JWLComponent = component.get("v.JWL_Component");
        var searchJwlComp = component.get("v.searchJwlComp");
        if(JWLComponent.Test_Type__c === "Resubmission"){
            if(JWLComponent.Test_Type__c !== ""   && JWLComponent.Product_Category__c !== "")
            {
                var viewNext = component.find("viewNext");
                $A.util.removeClass(viewNext,"slds-hide");
                $A.util.addClass(viewNext,"slds-show");
                
            }
            else{
                var viewNext = component.find("viewNext");
                $A.util.removeClass(viewNext,"slds-show");
                $A.util.addClass(viewNext,"slds-hide");
            }
        }
	},
    
    getJwlResponseList : function(component, event, helper)
    {
        var jwlComp = JSON.parse(JSON.stringify(component.get("v.JWL_Component")));
        var action = component.get("c.getJwlResponseList");
        action.setParams({
            "jwl" : jwlComp
        });
        
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var returnTest=response.getReturnValue();
                var checkedReturntest= [];
                for(var i=0;i<returnTest.length;i++)
                {
                   if( returnTest[i].isChecked__c === true)
                   {
                       checkedReturntest.push(returnTest[i]) ;
                   }
                }
                component.set('v.jwlResponseList',returnTest);
                component.set("v.checkedJwlResponseList",checkedReturntest);
                
            }
        });
        $A.enqueueAction(action);
    },
    
    
    SaveResubJwlComponent : function(component, event, helper)
    {
        var afterSubmitflag = component.get("v.afterSubmitflag");
        if(afterSubmitflag == false)
        {
            var jwlComp = JSON.parse(JSON.stringify(component.get("v.JWL_Component")));
            var jwlResplst = JSON.parse(JSON.stringify(component.get("v.jwlResponseList")));
            var flag = false;
            var action = component.get("c.updateResubJwlComponent");
            action.setParams({
                "jwl" : jwlComp,
                "jwlResponseList" : jwlResplst,
                "refNumIncrementflag" : flag
            });
            
            action.setCallback(this,function(response){
                var state=response.getState();
                if(state === "SUCCESS")
                {
                    component.set("v.JWL_Component",JSON.parse(JSON.stringify(response.getReturnValue())));
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Resubmission Jewellery Information Saved successfully!!!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                    /*
                    component.set("v.editFlag",true);
                    var sc = component.find("Cancel");
                    $A.util.removeClass(sc,"slds-show");
                    $A.util.addClass(sc,"slds-hide");
                    
                    var edit = component.find("Edit");
                    $A.util.removeClass(edit,"slds-hide");
                    $A.util.addClass(edit,"slds-show");
                    */
                    var edit = component.find("ShowEdit");
                    $A.util.removeClass(edit,"slds-show");
                    $A.util.addClass(edit,"slds-hide");
                }
                else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Resubmission Jewellery Information is failed to Save!!!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
        }
        else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error',
                message: 'Resubmission Jewellery Information Submitted Already!!!',
                duration:' 5000',
                key: 'info_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
        }
    },
    
    SubmitResubJwlComponent : function(component, event, helper)
    {
        var flag = component.get("v.flag");	
        if( flag != false )
        {
            var jwlComp = JSON.parse(JSON.stringify(component.get("v.JWL_Component")));
            var jwlResplst = JSON.parse(JSON.stringify(component.get("v.jwlResponseList")));
            var action = component.get("c.updateResubJwlComponent");
            action.setParams({
                "jwl" : jwlComp,
                "jwlResponseList" : jwlResplst,
                "refNumIncrementflag" : flag
            });
            
            action.setCallback(this,function(response){
                var state=response.getState();
                if(state === "SUCCESS")
                {
                    component.set("v.JWL_Component",JSON.parse(JSON.stringify(response.getReturnValue())));
                    component.set("v.flag",false);
                    
                    var sampleTime = component.find("sampleTime");
                    sampleTime.setCustomValidity("");
                    sampleTime.showHelpMessageIfInvalid("");
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Resubmission Jewellery Information Submitted successfull!!!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                    /*
                    component.set("v.flag",false);
                    component.set("v.afterSubmitflag",true);
                    component.set("v.editFlag",true);
                    var sc = component.find("Cancel");
                    $A.util.removeClass(sc,"slds-show");
                    $A.util.addClass(sc,"slds-hide");
                    
                    var edit = component.find("Edit");
                    $A.util.removeClass(edit,"slds-hide");
                    $A.util.addClass(edit,"slds-show");
                    */
                    var edit = component.find("ShowEdit");
                    $A.util.removeClass(edit,"slds-show");
                    $A.util.addClass(edit,"slds-hide");
                }
                else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Resubmission Jewellery Information is failed to Submit!!!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
        }
        else{
            var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Resubmission Jewellery Information Submitted Already!!!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
        }
    }, 
    
    getQAEmails:function(component,event,helper){
        var  useremail= component.get('v.QaEmailIdList');
        var action = component.get("c.getQAEmailIds");
     action.setCallback(this, function(response){
            var result =response.getReturnValue();
            component.set("v.QaEmailIdList",result);
    });
    $A.enqueueAction(action);
    },
    
    image1upload:function(component,event,helper){
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        //alert("Files uploaded : " + uploadedFiles.length);
        //set action to call updatePicturePath method from Server-side controller
        var action = component.get('c.updatePicturePath');
        
        //set parametrs
        action.setParams({
            recId : component.get('v.JWL_Component').Id
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state === 'DRAFT') {
                
                var data = response.getReturnValue();
                var jwlComp = component.get('v.JWL_Component');
                jwlComp['Image_1__c'] = data['Image_1__c']
                component.set('v.JWL_Component',jwlComp);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'image uploaded',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
        });
        
        $A.enqueueAction(action);
    },
    image2upload:function(component,event,helper){
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        //alert("Files uploaded : " + uploadedFiles.length);
        //set action to call updatePicturePath method from Server-side controller
        var action = component.get('c.updatePicturePath2');
        
        //set parametrs
        action.setParams({
            recId : component.get('v.JWL_Component').Id
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state === 'DRAFT') {
                
                var data = response.getReturnValue();
                var jwlComp = component.get('v.JWL_Component');
                jwlComp['Image_2__c'] = data['Image_2__c']
                component.set('v.JWL_Component',jwlComp);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'image uploaded',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
        });
        
        $A.enqueueAction(action);
    },
    image3upload:function(component,event,helper){
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        //alert("Files uploaded : " + uploadedFiles.length);
        //set action to call updatePicturePath method from Server-side controller
        var action = component.get('c.updatePicturePath3');
        
        //set parametrs
        action.setParams({
            recId : component.get('v.JWL_Component').Id
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state === 'DRAFT') {
                
                var data = response.getReturnValue();
                var jwlComp = component.get('v.JWL_Component');
                jwlComp['Image_3__c'] = data['Image_3__c']
                component.set('v.JWL_Component',jwlComp);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'image uploaded',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
        });
        
        $A.enqueueAction(action);
    },
})