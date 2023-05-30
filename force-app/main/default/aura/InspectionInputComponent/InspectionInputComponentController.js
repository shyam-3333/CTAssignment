({
	doinit : function(component, event, helper) {
        
        helper.getPickList(component, event, "Test_Type__c");
        helper.getPickList(component, event, "Sample_Type__c");
        helper.getPickList(component, event, "Product_Category__c");
        //helper.getPickList(component, event, "Collection__c");
        helper.getPickList(component, event, "Karatage__c");
        helper.getPickList(component, event, "Route_of_Manufacturing__c");
        helper.getPickList(component, event, "Location__c");
        
        helper.getJwlTest(component, event, helper);
        helper.getQAEmails(component,event,helper);
        
        var JWL_Comp = component.get("v.JWL_Component");
        var datelocal = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        var timeLocal = $A.localizationService.formatDate(new Date(), "h:mm a");
        /*var d = new Date();
        d = timeLocal;
        console.log(d);*/
        
        JWL_Comp.Sample_Submission_Date__c = datelocal;
        JWL_Comp.Sample_Submission_time__c = timeLocal;
        
        component.set('v.JWL_Component',JWL_Comp);
	},
    
    // to show spinner icon at data retriving from server
    showSpinner: function(component) {
        var spinnerMain =  component.find("Spinner");
        $A.util.removeClass(spinnerMain, "slds-hide");
    },
    
    // to hide spinner icon at data retriving from server
    hideSpinner : function(component) {
        var spinnerMain =  component.find("Spinner");
        $A.util.addClass(spinnerMain, "slds-hide");
    },
    
    // to show next button at input front page
    
    showNextButtonOntestType : function(component, event, helper)
    {
        var JWLComponent = component.get("v.JWL_Component");
        var searchJwlComp = component.get("v.searchJwlComp");
        if(JWLComponent.Test_Type__c === "New"){
            JWLComponent.Sample_Type__c = "";
            JWLComponent.Product_Category__c = "";
            component.set("v.JWL_Component", JWLComponent );
            var viewNext = component.find("viewNext");
            $A.util.removeClass(viewNext,"slds-show");
            $A.util.addClass(viewNext,"slds-hide");
        }
        else if(JWLComponent.Test_Type__c === "Resubmission"){
            if(JWLComponent.Test_Type__c !== "")
            {
                searchJwlComp = "";
                component.set("v.searchJwlComp", searchJwlComp );
                var viewNext = component.find("viewNext");
                $A.util.removeClass(viewNext,"slds-hide");
                $A.util.addClass(viewNext,"slds-show");
            }
        }
        else
        {
            var viewNext = component.find("viewNext");
            $A.util.removeClass(viewNext,"slds-hide");
            $A.util.addClass(viewNext,"slds-show");
        }
    },
    
    showNextButtonSampleType : function(component, event, helper)
    {
        var JWLComponent = component.get("v.JWL_Component");
        if(JWLComponent.Test_Type__c === "New"){
            if(JWLComponent.Sample_Type__c !== ""){
                JWLComponent.Product_Category__c = "";
                component.set("v.JWL_Component", JWLComponent );
                var viewNext = component.find("viewNext");
                $A.util.removeClass(viewNext,"slds-show");
                $A.util.addClass(viewNext,"slds-hide");
            }
            else
            {
                var viewNext = component.find("viewNext");
                $A.util.removeClass(viewNext,"slds-show");
                $A.util.addClass(viewNext,"slds-hide");
            }
        }
    },
    
    showNextButtonProductCat : function(component, event, helper)
    {
        var JWLComponent = component.get("v.JWL_Component");
        if(JWLComponent.Test_Type__c === "New"){
            if(JWLComponent.Sample_Type__c !== "" && JWLComponent.Product_Category__c !== "" ){
                var viewNext = component.find("viewNext");
                $A.util.removeClass(viewNext,"slds-hide");
                $A.util.addClass(viewNext,"slds-show");
            }
            else
            {
                var viewNext = component.find("viewNext");
                $A.util.removeClass(viewNext,"slds-show");
                $A.util.addClass(viewNext,"slds-hide");
            }
        }
    },
    
    // to open next information page after clicking Next button in front iput page
    clickNextButton : function(component, event, helper) {
        
        var JWLComponent = component.get("v.JWL_Component");
        var searchJwlComp = component.get("v.searchJwlComp");
        var ResubJwlReprtRefNum = component.find("ResubJwlReprtRefNum");
        if(JWLComponent.Test_Type__c === "New"){
            if(JWLComponent.Test_Type__c !== ""  && JWLComponent.Sample_Type__c !== ""  && JWLComponent.Product_Category__c !== "" )
            {
                var typesPage = component.find("selectTypesPage");
                $A.util.removeClass(typesPage,"slds-show");
                $A.util.addClass(typesPage,"slds-hide");
                
                var informationPage = component.find("selectInformationPage");
                $A.util.removeClass(informationPage,"slds-hide");
                $A.util.addClass(informationPage,"slds-show");
                helper.getJwlResponseList(component, event, helper);
            }
        }
        else if(JWLComponent.Test_Type__c === "Resubmission"){
            if(JWLComponent.Test_Type__c !== "" && searchJwlComp !== "")
            {
                ResubJwlReprtRefNum.setCustomValidity('');
                ResubJwlReprtRefNum.showHelpMessageIfInvalid('');
                if(JWLComponent.Id !== ''){
                    var datelocal = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
                    var timeLocal = $A.localizationService.formatDate(new Date(), "h:mm a");
                    JWLComponent.Sample_Submission_Date__c = datelocal;
                    JWLComponent.Sample_Submission_time__c = timeLocal;
                    component.set("v.JWL_Component",JWLComponent);
                    var typesPage = component.find("selectTypesPage");
                    $A.util.removeClass(typesPage,"slds-show");
                    $A.util.addClass(typesPage,"slds-hide");
                    
                    var informationPage = component.find("selectInformationPage");
                    $A.util.removeClass(informationPage,"slds-hide");
                    $A.util.addClass(informationPage,"slds-show");
                    helper.getJwlResponseList(component, event, helper);
                    
                    component.set("v.searchQAEmail",JWLComponent.QA_User_Email_Id__c);
                    if(JWLComponent.Vendor__c != undefined)
                       component.set("v.searchVendor",JWLComponent.Vendor__r.Name);
                }
                else
                {
                    ResubJwlReprtRefNum.setCustomValidity('Select Report Reference Num');
                    ResubJwlReprtRefNum.showHelpMessageIfInvalid('Select Report Reference Num');
                }
                
            }
            component.set("v.openJwlResubModal","false");
        }
    },
    
    // to enable New information page to editing
    OnEdit : function(component, event, helper) {
        
        component.set("v.editFlag",false);
        var edit = component.find("Edit");
        $A.util.removeClass(edit,"slds-show");
        $A.util.addClass(edit,"slds-hide");
        
        var sc = component.find("Cancel");
        $A.util.removeClass(sc,"slds-hide");
        $A.util.addClass(sc,"slds-show");
    },
    
    // to disable New information page to editing
    OnCancel : function(component, event, helper) {
        
        component.set("v.editFlag",true);
        var sc = component.find("Cancel");
        $A.util.removeClass(sc,"slds-show");
        $A.util.addClass(sc,"slds-hide");
        
        var edit = component.find("Edit");
        $A.util.removeClass(edit,"slds-hide");
        $A.util.addClass(edit,"slds-show");
        
        component.set("v.QaEmailModel","false"); 
        component.set("v.openVendModal","false");
    },
    
    // to enable Resubmission information page to editing
    OnResubEdit : function(component, event, helper) {
        
        component.set("v.editFlag",false);
        var edit = component.find("ResubEdit");
        $A.util.removeClass(edit,"slds-show");
        $A.util.addClass(edit,"slds-hide");
        
        var sc = component.find("ResubCancel");
        $A.util.removeClass(sc,"slds-hide");
        $A.util.addClass(sc,"slds-show");
    },
    
    // to disable Resubmission information page to editing
    OnResubCancel : function(component, event, helper) {
        
        component.set("v.editFlag",true);
        var sc = component.find("ResubCancel");
        $A.util.removeClass(sc,"slds-show");
        $A.util.addClass(sc,"slds-hide");
        
        var edit = component.find("ResubEdit");
        $A.util.removeClass(edit,"slds-hide");
        $A.util.addClass(edit,"slds-show");
    },
    
    // to show vendor lookup
    openVendorModal : function(component, event , helper)
    {
       var editatble = component.get("v.editFlag");
        if(editatble === false ){
            component.set("v.openVendModal","True");
            helper.getVendors(component, event, helper);
        }
      
    },
    
    // to hide vendor lookup 
    closeVendorModal : function(component, event , helper)
    {
       component.set("v.openVendModal","false");  
        var id = event.target.id;
       var vendorLst = component.get("v.jwlVendorList");
       var jwlComponent = component.get("v.JWL_Component");
        if(id !== ""){
            component.set("v.searchVendor",vendorLst[id].Name);
        jwlComponent.Vendor__c = vendorLst[id].Id;
        }
        
        component.set("v.JWL_Component",jwlComponent);
        
    },
    
    // to select vendor from vendor lookup
    selectVendor : function(component, event , helper)
    {
       component.set("v.openVendModal","false"); 
       var id = event.target.id; 
       var vendorLst = component.get("v.jwlVendorList");
       var jwlComponent = component.get("v.JWL_Component");
        component.set("v.searchVendor",vendorLst[id].Name);
        jwlComponent.Vendor__c = vendorLst[id].Id;
        component.set("v.JWL_Component",jwlComponent);
       
    },
    
    // to show JWL component lookup at resubmission
    openResubModal : function(component, event , helper)
    {
       component.set("v.openJwlResubModal","True");
       
        var resubJwc   = {'sobjectType':'JWL_Component__c',
                          'Id':'',
                          'Test_Type__c' : 'Resubmission',
                         };
        component.set("v.JWL_Component", resubJwc);
       helper.getResubJwlcompLst(component, event, helper);
    },
    
    // to hide JWL component lookup at resubmission
    closeResubModal : function(component, event , helper)
    {
       component.set("v.openJwlResubModal","false");  
        var id = event.target.id;
       	var jwlcompResubLst = component.get("v.jwlCompResubmisionList");
       	var jwlComponent = component.get("v.JWL_Component");
       	var newTypeOfSub = jwlComponent.Test_Type__c;
        if(id !== ""){
            component.set("v.searchVendor",jwlcompResubLst[id].Name);
        	jwlComponent = jwlcompResubLst[id];
            jwlComponent.Test_Type__c = jwlcompResubLst[id].Test_Type__c;
        }
        
        component.set("v.JWL_Component",jwlComponent);
    },
    
    // to select JWL component from JWL component lookup at resubmission
    selectResubJwlComp : function(component, event , helper)
    {
       component.set("v.openJwlResubModal","false"); 
       var id = event.target.id;
        if(id != ''){
            var jwlCompResubList = component.get("v.jwlCompResubmisionList");
            var jwlComponent = component.get("v.JWL_Component");
            var newTypeOfSub = jwlComponent.Test_Type__c;
            component.set("v.searchJwlComp",jwlCompResubList[id].Report_Reference_Number__c);
            jwlComponent = jwlCompResubList[id];
            jwlComponent.Test_Type__c = newTypeOfSub;
            component.set("v.JWL_Component",jwlComponent);
        }
       
    },
    
    selectResubJwlComp1 : function(component, event , helper)
    {
       component.set("v.openJwlResubModal","false"); 
       var id = event.target.id;
        if(id != ''){
            var jwlCompResubList = component.get("v.jwlCompResubmisionList");
            var jwlComponent = component.get("v.JWL_Component");
            var newTypeOfSub = jwlComponent.Test_Type__c;
            component.set("v.searchJwlComp",jwlCompResubList[id].Report_Reference_Number__c);
            jwlComponent = jwlCompResubList[id];
            alert(component.get("v.searchJwlComp"));
            jwlComponent.Test_Type__c = newTypeOfSub;
            component.set("v.JWL_Component",jwlComponent);
        }
       
    },
    
   
    
    // to select Predefined Tests at New Input creation
    checkTest : function(component, event, helper)
    {
        var id = event.target.id;
        var jwlTest = component.get("v.jwltestList");
        var testArray = component.get("v.checkedJwltestList");
        var check = event.target.checked;
        var remainingTest=[];
        if(check){
            testArray.push(jwlTest[id]);
            component.set("v.checkedJwltestList",JSON.parse(JSON.stringify(testArray)));
            //alert(JSON.stringify(testArray));
        }	
        else{
            for( var index=0 ; index < testArray.length ; index++ )
            {
                if(jwlTest[id].Id !== testArray[index].Id  )
                {
                    remainingTest.push(testArray[index]);
                }
            }
            component.set("v.checkedJwltestList",JSON.parse(JSON.stringify(remainingTest)));
           // alert(JSON.stringify(remainingTest));
        }
    },
    
    // to select Predefined other Tests at New Input creation
    otherCheck : function(component, event, helper)
    {
        var check = event.target.checked;
        var respo = component.get("v.JWL_Response");
        var jwlTest = component.get("v.jwltestList");
        var othersTest = component.get("v.othersTests");
        var Test;
        for( var index=0 ; index < jwlTest.length ; index++ )
        {
            if(jwlTest[index].Name == "Others"  )
            {
                Test = jwlTest[index];
            }
        }
        if(check){
            var specifiction = component.find("otherSpec");
            $A.util.removeClass(specifiction,"slds-hide");
            $A.util.addClass(specifiction,"slds-show");
            respo.Jwellery_Test__c = Test.Id	;
            respo.isChecked__c = "True" ;
            
            component.set("v.JWL_Response",JSON.parse(JSON.stringify(respo)));
            
            component.set("v.othercheckflag",true);
        }else{
            var specifiction = component.find("otherSpec");
            $A.util.removeClass(specifiction,"slds-show");
            $A.util.addClass(specifiction,"slds-hide");
            respo.Jwellery_Test__c = Test.Id ;
            respo.isChecked__c = "false" ;
            respo.Test_Name__c = Test.Name;
            respo.If_Others__c='';
            component.set("v.JWL_Response",JSON.parse(JSON.stringify(respo)));
            //document.getElementById("othertest").value = "false";
            component.set("v.othercheckflag",false);
        }
    },
    
    SaveRec : function(component, event, helper)
    {
        var check = component.get("v.othercheckflag");
        var respo = component.get("v.JWL_Response");
        
        var otherTest = component.get("v.othersTests");
        var jwlTest = component.get("v.jwltestList");
        var jwl = component.get("v.JWL_Component");
        var QAemail = component.find("QAEmail");
        var additionalEmails = component.find("additionalEmail");
        var ifOthers = component.find("If-Others");
        var submtByEmail = component.find("submittedByEmail");
        var NoOfSample = component.find("NoOfSample");
        var ProductCodefield =component.find("ProductCodefield");processField
        var processField =component.find("processField");
        var sampleDate = component.find("sampleDate");
        var sampleTime = component.find("sampleTime");
        //var sampletimeval = sampleTime.get('v.value');
        
        var flag = component.get("v.flag");
        if( flag != false )
        {
            if( jwl.QA_User_Email_Id__c != '' )
            {
                if(processField.get('v.value') == '')
                {
                    processField.setCustomValidity("Please Enter Process");
                    processField.showHelpMessageIfInvalid("Please Enter Process");
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: ' Please Enter Process',
                        duration:' 2000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
                else{
                    
                    processField.setCustomValidity("");
                    processField.showHelpMessageIfInvalid("");
                    
                    if( isNaN(jwl.No_of_samples__c) || jwl.No_of_samples__c == '')
                    {
                        NoOfSample.setCustomValidity("Enter valid Number");
                        NoOfSample.showHelpMessageIfInvalid("Enter valid Number");
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message: 'Please Enter Valid Number in No Of Samples',
                            duration:' 2000',
                            key: 'info_alt',
                            type: 'Error',
                            mode: 'dismissible'
                        });
                        toastEvent.fire();
                        ProductCodefield.setCustomValidity("");
                        ProductCodefield.showHelpMessageIfInvalid("");
                    }
                    else{
                        NoOfSample.setCustomValidity("");
                        NoOfSample.showHelpMessageIfInvalid("");
                        /*
                    if(isNaN(jwl.Product_Code__c) && jwl.Product_Code__c != undefined )
                    {
                        ProductCodefield.setCustomValidity("Enter valid Number");
                        ProductCodefield.showHelpMessageIfInvalid("Enter valid Number");
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message: 'Please Enter Valid Number in Product Code',
                            duration:' 2000',
                            key: 'info_alt',
                            type: 'Error',
                            mode: 'dismissible'
                        });
                        toastEvent.fire();
                    }
                    else{*/
                        ProductCodefield.setCustomValidity("");
                        ProductCodefield.showHelpMessageIfInvalid("");
                        if( jwl.Submitted_By__c !== '' )
                        {
                            submtByEmail.setCustomValidity("");
                            submtByEmail.showHelpMessageIfInvalid("");
                            if( (additionalEmails.get("v.value")) !== '' && additionalEmails.get("v.value") !== undefined /* &&  jwl.Additional_Emails__c != undefined*/ )
                            {
                                additionalEmails.setCustomValidity("");
                                additionalEmails.showHelpMessageIfInvalid("");
                                var splitEmails=additionalEmails.get("v.value").split(',');
                                var mailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                                var flag = true;
                                for(var i=0 ; i<splitEmails.length ; i++)
                                {
                                    if(mailformat.test(splitEmails[i]) !== true)
                                    { 
                                        flag = false;
                                    }
                                }
                                if(flag === true)
                                {
                                    if(check !== false  )
                                    {
                                        var Test;
                                        for( var index=0 ; index < jwlTest.length ; index++ )
                                        {
                                            if(jwlTest[index].Name == "Others"  )
                                            {
                                                Test = jwlTest[index];
                                            }
                                        }
                                        if( respo.If_Others__c !== '' )
                                        {
                                            ifOthers.setCustomValidity("");
                                            ifOthers.showHelpMessageIfInvalid("");
                                            var othr = ifOthers.get("v.value").split(',');
                                            var jwlRespoLst=[];
                                            
                                            for(var i=0; i< othr.length ; i++)
                                            {
                                                var jwlResp = {'sobjectType':'JWL_Response__c',
                                                               'If_Others__c':'',
                                                               'isChecked__c':'false',
                                                               'Jwellery_Test__c':''} ;
                                                jwlResp.Jwellery_Test__c = Test.Id ;
                                                jwlResp.isChecked__c = "True" ;
                                                jwlResp.Test_Name__c = othr[i].trim();
                                                jwlResp.If_Others__c= othr[i].trim();
                                                jwlRespoLst.push(jwlResp);
                                            }
                                            //helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                            if(sampleTime.get('v.value') != '')
                                            {
                                                var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                                var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                                
                                                if(timeRegEx.test( sampleTime.get('v.value') ))
                                                {
                                                    sampleTime.setCustomValidity("");
                                                    sampleTime.showHelpMessageIfInvalid("");
                                                    helper.SaveNewJwlComponent(component, event, jwlRespoLst);
                                                }
                                                else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                                {
                                                    var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                                    
                                                    var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                                    (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                                    sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                                    
                                                    jwl.Sample_Submission_time__c = timeformate;
                                                    component.set('v.JWL_Component',jwl);
                                                    sampleTime.setCustomValidity("");
                                                    sampleTime.showHelpMessageIfInvalid("");
                                                    helper.SaveNewJwlComponent(component, event, jwlRespoLst);
                                                }
                                                    else
                                                    {
                                                        sampleTime.setCustomValidity("Enter valid Time");
                                                        sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                                    }
                                            }
                                        }
                                        else{
                                            ifOthers.setCustomValidity("Enter If others");
                                            ifOthers.showHelpMessageIfInvalid("Enter If others");
                                        }
                                    }
                                    else{
                                        var Test;
                                        for( var index=0 ; index < jwlTest.length ; index++ )
                                        {
                                            if(jwlTest[index].Name == "Others"  )
                                            {
                                                Test = jwlTest[index];
                                            }
                                        }
                                        
                                        var jwlRespoLst=[];
                                        var jwlResp = {'sobjectType':'JWL_Response__c',
                                                       'If_Others__c':'',
                                                       'isChecked__c':'false',
                                                       'Jwellery_Test__c':''} ;
                                        jwlResp.Jwellery_Test__c = Test.Id ;
                                        jwlResp.isChecked__c = "false" ;
                                        jwlResp.Test_Name__c = Test.Name;
                                        jwlResp.If_Others__c= '';
                                        jwlRespoLst.push(jwlResp);
                                        // helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                        if(sampleTime.get('v.value') != '')
                                        {
                                            var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                            var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                            
                                            if(timeRegEx.test( sampleTime.get('v.value') ))
                                            {
                                                sampleTime.setCustomValidity("");
                                                sampleTime.showHelpMessageIfInvalid("");
                                                helper.SaveNewJwlComponent(component, event, jwlRespoLst);
                                            }
                                            else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                            {
                                                var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                                
                                                var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                                (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                                sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                                
                                                jwl.Sample_Submission_time__c = timeformate;
                                                component.set('v.JWL_Component',jwl);
                                                sampleTime.setCustomValidity("");
                                                sampleTime.showHelpMessageIfInvalid("");
                                                helper.SaveNewJwlComponent(component, event, jwlRespoLst);
                                            }
                                                else
                                                {
                                                    sampleTime.setCustomValidity("Enter valid Time");
                                                    sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                                }
                                        }
                                    }
                                }
                                else{
                                    
                                    additionalEmails.setCustomValidity("Enter valid Email Id with comma(,) separated");
                                    additionalEmails.showHelpMessageIfInvalid("Enter valid Email Id with comma(,) separated ");
                                    var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'Error',
                                        message: 'Please Enter Valid Email Id in Additional Email Id',
                                        duration:' 2000',
                                        key: 'info_alt',
                                        type: 'Error',
                                        mode: 'dismissible'
                                    });
                                    toastEvent.fire();
                                    
                                    
                                }
                            }
                            else { 
                                /*
                                additionalEmails.setCustomValidity("Enter Additiona Email Id ");
                                additionalEmails.showHelpMessageIfInvalid("Enter Additiona Email Id ");
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error',
                                    message: 'Please Enter Additiona Email Id ',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'Error',
                                    mode: 'dismissible'
                                });
                                toastEvent.fire(); */
                                additionalEmails.setCustomValidity("");
                                additionalEmails.showHelpMessageIfInvalid("");
                                if(check !== false  )
                                {
                                    var Test;
                                    for( var index=0 ; index < jwlTest.length ; index++ )
                                    {
                                        if(jwlTest[index].Name == "Others"  )
                                        {
                                            Test = jwlTest[index];
                                        }
                                    }
                                    if( respo.If_Others__c !== '' )
                                    {
                                        ifOthers.setCustomValidity("");
                                        ifOthers.showHelpMessageIfInvalid("");
                                        var othr = ifOthers.get("v.value").split(',');
                                        var jwlRespoLst=[];
                                        
                                        for(var i=0; i< othr.length ; i++)
                                        {
                                            var jwlResp = {'sobjectType':'JWL_Response__c',
                                                           'If_Others__c':'',
                                                           'isChecked__c':'false',
                                                           'Jwellery_Test__c':''} ;
                                            jwlResp.Jwellery_Test__c = Test.Id ;
                                            jwlResp.isChecked__c = "True" ;
                                            jwlResp.Test_Name__c = othr[i].trim();
                                            jwlResp.If_Others__c= othr[i].trim();
                                            jwlRespoLst.push(jwlResp);
                                        }
                                        // helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                        if(sampleTime.get('v.value') != '')
                                        {
                                            var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                            var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                            
                                            if(timeRegEx.test( sampleTime.get('v.value') ))
                                            {
                                                sampleTime.setCustomValidity("");
                                                sampleTime.showHelpMessageIfInvalid("");
                                                helper.SaveNewJwlComponent(component, event, jwlRespoLst);
                                            }
                                            else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                            {
                                                var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                                
                                                var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                                (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                                sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                                
                                                jwl.Sample_Submission_time__c = timeformate;
                                                component.set('v.JWL_Component',jwl);
                                                sampleTime.setCustomValidity("");
                                                sampleTime.showHelpMessageIfInvalid("");
                                                helper.SaveNewJwlComponent(component, event, jwlRespoLst);
                                            }
                                                else
                                                {
                                                    sampleTime.setCustomValidity("Enter valid Time");
                                                    sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                                }
                                        }
                                    }
                                    else{
                                        ifOthers.setCustomValidity("Enter If others");
                                        ifOthers.showHelpMessageIfInvalid("Enter If others");
                                    }
                                }
                                else{
                                    var Test;
                                    for( var index=0 ; index < jwlTest.length ; index++ )
                                    {
                                        if(jwlTest[index].Name == "Others"  )
                                        {
                                            Test = jwlTest[index];
                                        }
                                    }
                                    
                                    var jwlRespoLst=[];
                                    var jwlResp = {'sobjectType':'JWL_Response__c',
                                                   'If_Others__c':'',
                                                   'isChecked__c':'false',
                                                   'Jwellery_Test__c':''} ;
                                    jwlResp.Jwellery_Test__c = Test.Id ;
                                    jwlResp.isChecked__c = "false" ;
                                    jwlResp.Test_Name__c = Test.Name;
                                    jwlResp.If_Others__c= '';
                                    jwlRespoLst.push(jwlResp);
                                    // helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                    if(sampleTime.get('v.value') != '')
                                    {
                                        var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                        var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                        
                                        if(timeRegEx.test( sampleTime.get('v.value') ))
                                        {
                                            sampleTime.setCustomValidity("");
                                            sampleTime.showHelpMessageIfInvalid("");
                                            helper.SaveNewJwlComponent(component, event, jwlRespoLst);
                                        }
                                        else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                        {
                                            var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                            
                                            var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                            (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                            sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                            
                                            jwl.Sample_Submission_time__c = timeformate;
                                            component.set('v.JWL_Component',jwl);
                                            sampleTime.setCustomValidity("");
                                            sampleTime.showHelpMessageIfInvalid("");
                                            helper.SaveNewJwlComponent(component, event, jwlRespoLst);
                                        }
                                            else
                                            {
                                                sampleTime.setCustomValidity("Enter valid Time");
                                                sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                            }
                                    }
                                }
                            }
                        }
                        else
                        {
                            submtByEmail.setCustomValidity("Enter Submitted by email Id");
                            submtByEmail.showHelpMessageIfInvalid("Enter Submitted by email Id");
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title : 'Error',
                                message: 'Please Enter Submitted By Email Id',
                                duration:' 2000',
                                key: 'info_alt',
                                type: 'Error',
                                mode: 'dismissible'
                            });
                            toastEvent.fire();
                        } 
                        
                    }
                }
            }
            else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message: 'Please Select QA Email Id',
                    duration:' 2000',
                    key: 'info_alt',
                    type: 'Error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
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
    
    //  to submit New Information 
    submitRec : function(component, event, helper)
    {
        var check = component.get("v.othercheckflag");
        var respo = component.get("v.JWL_Response");
        
        var otherTest = component.get("v.othersTests");
        var jwlTest = component.get("v.jwltestList");
        var jwl = component.get("v.JWL_Component");
        var QAemail = component.find("QAEmail");
        var additionalEmails = component.find("additionalEmail");
        var ifOthers = component.find("If-Others");
        var submtByEmail = component.find("submittedByEmail");
        var NoOfSample = component.find("NoOfSample");
        var ProductCodefield =component.find("ProductCodefield");processField
        var processField =component.find("processField");
        var sampleDate = component.find("sampleDate");
        var sampleTime = component.find("sampleTime");
        //var sampletimeval = sampleTime.get('v.value');
        
        var flag = component.get("v.flag");
        if( flag != false )
        {
            if( jwl.QA_User_Email_Id__c != '' )
            {
                if(processField.get('v.value') == '')
                {
                    processField.setCustomValidity("Please Enter Process");
                    processField.showHelpMessageIfInvalid("Please Enter Process");
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: ' Please Enter Process',
                        duration:' 2000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
                else{
                    
                    processField.setCustomValidity("");
                    processField.showHelpMessageIfInvalid("");
                    
                    if( isNaN(jwl.No_of_samples__c) || jwl.No_of_samples__c == '')
                    {
                        NoOfSample.setCustomValidity("Enter valid Number");
                        NoOfSample.showHelpMessageIfInvalid("Enter valid Number");
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message: 'Please Enter Valid Number in No Of Samples',
                            duration:' 2000',
                            key: 'info_alt',
                            type: 'Error',
                            mode: 'dismissible'
                        });
                        toastEvent.fire();
                        ProductCodefield.setCustomValidity("");
                        ProductCodefield.showHelpMessageIfInvalid("");
                    }
                    else{
                        NoOfSample.setCustomValidity("");
                        NoOfSample.showHelpMessageIfInvalid("");
                        /*
                    if(isNaN(jwl.Product_Code__c) && jwl.Product_Code__c != undefined )
                    {
                        ProductCodefield.setCustomValidity("Enter valid Number");
                        ProductCodefield.showHelpMessageIfInvalid("Enter valid Number");
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message: 'Please Enter Valid Number in Product Code',
                            duration:' 2000',
                            key: 'info_alt',
                            type: 'Error',
                            mode: 'dismissible'
                        });
                        toastEvent.fire();
                    }
                    else{*/
                        ProductCodefield.setCustomValidity("");
                        ProductCodefield.showHelpMessageIfInvalid("");
                        if( jwl.Submitted_By__c !== '' )
                        {
                            submtByEmail.setCustomValidity("");
                            submtByEmail.showHelpMessageIfInvalid("");
                            if( (additionalEmails.get("v.value")) !== '' && additionalEmails.get("v.value") !== undefined /* &&  jwl.Additional_Emails__c != undefined*/ )
                            {
                                additionalEmails.setCustomValidity("");
                                additionalEmails.showHelpMessageIfInvalid("");
                                var splitEmails=additionalEmails.get("v.value").split(',');
                                var mailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                                var flag = true;
                                for(var i=0 ; i<splitEmails.length ; i++)
                                {
                                    if(mailformat.test(splitEmails[i]) !== true)
                                    { 
                                        flag = false;
                                    }
                                }
                                if(flag === true)
                                {
                                    if(check !== false  )
                                    {
                                        var Test;
                                        for( var index=0 ; index < jwlTest.length ; index++ )
                                        {
                                            if(jwlTest[index].Name == "Others"  )
                                            {
                                                Test = jwlTest[index];
                                            }
                                        }
                                        if( respo.If_Others__c !== '' )
                                        {
                                            ifOthers.setCustomValidity("");
                                            ifOthers.showHelpMessageIfInvalid("");
                                            var othr = ifOthers.get("v.value").split(',');
                                            var jwlRespoLst=[];
                                            
                                            for(var i=0; i< othr.length ; i++)
                                            {
                                                var jwlResp = {'sobjectType':'JWL_Response__c',
                                                               'If_Others__c':'',
                                                               'isChecked__c':'false',
                                                               'Jwellery_Test__c':''} ;
                                                jwlResp.Jwellery_Test__c = Test.Id ;
                                                jwlResp.isChecked__c = "True" ;
                                                jwlResp.Test_Name__c = othr[i].trim();
                                                jwlResp.If_Others__c= othr[i].trim();
                                                jwlRespoLst.push(jwlResp);
                                            }
                                            //helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                            if(sampleTime.get('v.value') != '')
                                            {
                                                var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                                var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                                
                                                if(timeRegEx.test( sampleTime.get('v.value') ))
                                                {
                                                    sampleTime.setCustomValidity("");
                                                    sampleTime.showHelpMessageIfInvalid("");
                                                    helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                                }
                                                else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                                {
                                                    var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                                    
                                                    var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                                    (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                                    sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                                    
                                                    jwl.Sample_Submission_time__c = timeformate;
                                                    component.set('v.JWL_Component',jwl);
                                                    sampleTime.setCustomValidity("");
                                                    sampleTime.showHelpMessageIfInvalid("");
                                                    helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                                }
                                                    else
                                                    {
                                                        sampleTime.setCustomValidity("Enter valid Time");
                                                        sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                                    }
                                            }
                                        }
                                        else{
                                            ifOthers.setCustomValidity("Enter If others");
                                            ifOthers.showHelpMessageIfInvalid("Enter If others");
                                        }
                                    }
                                    else{
                                        var Test;
                                        for( var index=0 ; index < jwlTest.length ; index++ )
                                        {
                                            if(jwlTest[index].Name == "Others"  )
                                            {
                                                Test = jwlTest[index];
                                            }
                                        }
                                        
                                        var jwlRespoLst=[];
                                        var jwlResp = {'sobjectType':'JWL_Response__c',
                                                       'If_Others__c':'',
                                                       'isChecked__c':'false',
                                                       'Jwellery_Test__c':''} ;
                                        jwlResp.Jwellery_Test__c = Test.Id ;
                                        jwlResp.isChecked__c = "false" ;
                                        jwlResp.Test_Name__c = Test.Name;
                                        jwlResp.If_Others__c= '';
                                        jwlRespoLst.push(jwlResp);
                                        // helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                        if(sampleTime.get('v.value') != '')
                                        {
                                            var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                            var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                            
                                            if(timeRegEx.test( sampleTime.get('v.value') ))
                                            {
                                                sampleTime.setCustomValidity("");
                                                sampleTime.showHelpMessageIfInvalid("");
                                                helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                            }
                                            else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                            {
                                                var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                                
                                                var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                                (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                                sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                                
                                                jwl.Sample_Submission_time__c = timeformate;
                                                component.set('v.JWL_Component',jwl);
                                                sampleTime.setCustomValidity("");
                                                sampleTime.showHelpMessageIfInvalid("");
                                                helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                            }
                                                else
                                                {
                                                    sampleTime.setCustomValidity("Enter valid Time");
                                                    sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                                }
                                        }
                                    }
                                }
                                else{
                                    
                                    additionalEmails.setCustomValidity("Enter valid Email Id with comma(,) separated");
                                    additionalEmails.showHelpMessageIfInvalid("Enter valid Email Id with comma(,) separated ");
                                    var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'Error',
                                        message: 'Please Enter Valid Email Id in Additional Email Id',
                                        duration:' 2000',
                                        key: 'info_alt',
                                        type: 'Error',
                                        mode: 'dismissible'
                                    });
                                    toastEvent.fire();
                                    
                                    
                                }
                            }
                            else { 
                                /*
                                additionalEmails.setCustomValidity("Enter Additiona Email Id ");
                                additionalEmails.showHelpMessageIfInvalid("Enter Additiona Email Id ");
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error',
                                    message: 'Please Enter Additiona Email Id ',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'Error',
                                    mode: 'dismissible'
                                });
                                toastEvent.fire(); */
                                additionalEmails.setCustomValidity("");
                                additionalEmails.showHelpMessageIfInvalid("");
                                if(check !== false  )
                                {
                                    var Test;
                                    for( var index=0 ; index < jwlTest.length ; index++ )
                                    {
                                        if(jwlTest[index].Name == "Others"  )
                                        {
                                            Test = jwlTest[index];
                                        }
                                    }
                                    if( respo.If_Others__c !== '' )
                                    {
                                        ifOthers.setCustomValidity("");
                                        ifOthers.showHelpMessageIfInvalid("");
                                        var othr = ifOthers.get("v.value").split(',');
                                        var jwlRespoLst=[];
                                        
                                        for(var i=0; i< othr.length ; i++)
                                        {
                                            var jwlResp = {'sobjectType':'JWL_Response__c',
                                                           'If_Others__c':'',
                                                           'isChecked__c':'false',
                                                           'Jwellery_Test__c':''} ;
                                            jwlResp.Jwellery_Test__c = Test.Id ;
                                            jwlResp.isChecked__c = "True" ;
                                            jwlResp.Test_Name__c = othr[i].trim();
                                            jwlResp.If_Others__c= othr[i].trim();
                                            jwlRespoLst.push(jwlResp);
                                        }
                                        // helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                        if(sampleTime.get('v.value') != '')
                                        {
                                            var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                            var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                            
                                            if(timeRegEx.test( sampleTime.get('v.value') ))
                                            {
                                                sampleTime.setCustomValidity("");
                                                sampleTime.showHelpMessageIfInvalid("");
                                                helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                            }
                                            else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                            {
                                                var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                                
                                                var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                                (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                                sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                                
                                                jwl.Sample_Submission_time__c = timeformate;
                                                component.set('v.JWL_Component',jwl);
                                                sampleTime.setCustomValidity("");
                                                sampleTime.showHelpMessageIfInvalid("");
                                                helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                            }
                                                else
                                                {
                                                    sampleTime.setCustomValidity("Enter valid Time");
                                                    sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                                }
                                        }
                                    }
                                    else{
                                        ifOthers.setCustomValidity("Enter If others");
                                        ifOthers.showHelpMessageIfInvalid("Enter If others");
                                    }
                                }
                                else{
                                    var Test;
                                    for( var index=0 ; index < jwlTest.length ; index++ )
                                    {
                                        if(jwlTest[index].Name == "Others"  )
                                        {
                                            Test = jwlTest[index];
                                        }
                                    }
                                    
                                    var jwlRespoLst=[];
                                    var jwlResp = {'sobjectType':'JWL_Response__c',
                                                   'If_Others__c':'',
                                                   'isChecked__c':'false',
                                                   'Jwellery_Test__c':''} ;
                                    jwlResp.Jwellery_Test__c = Test.Id ;
                                    jwlResp.isChecked__c = "false" ;
                                    jwlResp.Test_Name__c = Test.Name;
                                    jwlResp.If_Others__c= '';
                                    jwlRespoLst.push(jwlResp);
                                    // helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                    if(sampleTime.get('v.value') != '')
                                    {
                                        var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                        var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                        
                                        if(timeRegEx.test( sampleTime.get('v.value') ))
                                        {
                                            sampleTime.setCustomValidity("");
                                            sampleTime.showHelpMessageIfInvalid("");
                                            helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                        }
                                        else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                        {
                                            var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                            
                                            var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                            (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                            sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                            
                                            jwl.Sample_Submission_time__c = timeformate;
                                            component.set('v.JWL_Component',jwl);
                                            sampleTime.setCustomValidity("");
                                            sampleTime.showHelpMessageIfInvalid("");
                                            helper.SubmitNewJwlComponent(component, event, jwlRespoLst);
                                        }
                                            else
                                            {
                                                sampleTime.setCustomValidity("Enter valid Time");
                                                sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                            }
                                    }
                                }
                            }
                        }
                        else
                        {
                            submtByEmail.setCustomValidity("Enter Submitted by email Id");
                            submtByEmail.showHelpMessageIfInvalid("Enter Submitted by email Id");
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title : 'Error',
                                message: 'Please Enter Submitted By Email Id',
                                duration:' 2000',
                                key: 'info_alt',
                                type: 'Error',
                                mode: 'dismissible'
                            });
                            toastEvent.fire();
                        } 
                        
                    }
                }
            }
            else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message: 'Please Select QA Email Id',
                    duration:' 2000',
                    key: 'info_alt',
                    type: 'Error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
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
 
    // to submit Resubmission Information 
    submitResubRec : function(component, event, helper)
    {
        var jwl = component.get("v.JWL_Component");
        var QAemail = component.find("QAEmail");
        var additionalEmails = component.find("additionalEmail");
        var ifOthers = component.find("If-Others");
        var submtByEmail = component.find("submittedByEmail");
        var NoOfSample = component.find("NoOfSample");
        var ProductCodefield =component.find("ProductCodefield");
        var processField =component.find("processField");
        var sampleDate = component.find("sampleDate");
        var sampleTime = component.find("sampleTime");
        
        var flag = component.get("v.flag");
        if( flag != false )
        {
            if(jwl.QA_User_Email_Id__c !== '')
            {
                if(processField.get('v.value') == '')
                {
                    processField.setCustomValidity("Please Enter Process");
                    processField.showHelpMessageIfInvalid("Please Enter Process");
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: ' Please Enter Process',
                        duration:' 2000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
                else{
                    processField.setCustomValidity("");
                    processField.showHelpMessageIfInvalid("");
                    
                    if( isNaN(jwl.No_of_samples__c) || jwl.No_of_samples__c == '')
                    {
                        NoOfSample.setCustomValidity("Enter valid Number");
                        NoOfSample.showHelpMessageIfInvalid("Enter valid Number");
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message: 'Please Enter Valid Number in No Of Samples',
                            duration:' 2000',
                            key: 'info_alt',
                            type: 'Error',
                            mode: 'dismissible'
                        });
                        toastEvent.fire();
                    }
                    else{
                        NoOfSample.setCustomValidity("");
                        NoOfSample.showHelpMessageIfInvalid("");
                        /*
                    if(isNaN(jwl.Product_Code__c) && jwl.Product_Code__c != undefined )
                    {
                        ProductCodefield.setCustomValidity("Enter valid Number");
                        ProductCodefield.showHelpMessageIfInvalid("Enter valid Number");
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message: 'Please Enter Valid Number in Product Code',
                            duration:' 2000',
                            key: 'info_alt',
                            type: 'Error',
                            mode: 'dismissible'
                        });
                        toastEvent.fire();
                    }
                    else{*/
                        ProductCodefield.setCustomValidity("");
                        ProductCodefield.showHelpMessageIfInvalid("");
                        
                        if( jwl.Submitted_By__c !== '' )
                        {
                            submtByEmail.setCustomValidity("");
                            submtByEmail.showHelpMessageIfInvalid("");
                            if( (additionalEmails.get("v.value")) !== '' &&  jwl.Additional_Emails__c != undefined )
                            {
                                additionalEmails.setCustomValidity("");
                                additionalEmails.showHelpMessageIfInvalid("");
                                var splitEmails=additionalEmails.get("v.value").split(',');
                                var mailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                                var flag = true;
                                for(var i=0 ; i<splitEmails.length ; i++)
                                {
                                    if(mailformat.test(splitEmails[i]) !== true)
                                    {
                                        flag = false;
                                    }
                                }
                                if(flag === true)
                                {
                                    //helper.SubmitResubJwlComponent(component, event, helper);
                                    if(sampleTime.get('v.value') != '')
                                    {
                                        var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                        var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                        
                                        if(timeRegEx.test( sampleTime.get('v.value') ))
                                        {
                                            sampleTime.setCustomValidity("");
                                            sampleTime.showHelpMessageIfInvalid("");
                                            helper.SubmitResubJwlComponent(component, event, helper);
                                        }
                                        else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                        {
                                            var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                            
                                            var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                            (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                            sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                            
                                            jwl.Sample_Submission_time__c = timeformate;
                                            component.set('v.JWL_Component',jwl);
                                            sampleTime.setCustomValidity("");
                                            sampleTime.showHelpMessageIfInvalid("");
                                            helper.SubmitResubJwlComponent(component, event, helper);
                                        }
                                            else
                                            {
                                                sampleTime.setCustomValidity("Enter valid Time");
                                                sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                            }
                                    }
                                }
                                else{
                                    additionalEmails.setCustomValidity("Enter valid Email Ids with comma(,) separated");
                                    additionalEmails.showHelpMessageIfInvalid("Enter valid Email Ids with comma(,) separated ");
                                    var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'Error',
                                        message: 'Please Enter Valid Email Id in Additional Email Id',
                                        duration:' 2000',
                                        key: 'info_alt',
                                        type: 'Error',
                                        mode: 'dismissible'
                                    });
                                    toastEvent.fire();
                                }
                            }
                            else
                            {/*
                                additionalEmails.setCustomValidity("Enter Additiona Email Id ");
                                additionalEmails.showHelpMessageIfInvalid("Enter Additiona Email Id ");
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error',
                                    message: 'Please Enter Additiona Email Id ',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'Error',
                                    mode: 'dismissible'
                                });
                                toastEvent.fire(); */
                            additionalEmails.setCustomValidity("");
                            additionalEmails.showHelpMessageIfInvalid("");
                            if(sampleTime.get('v.value') != '')
                            {
                                var timeRegEx = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]\s(AM|PM|pm|am)$/ ;
                                var timeRegEx1 = /^(0|1[0-9]|0[0-9]|[1-9]|2[0-4]):[0-5][0-9]:00.000$/ ;
                                
                                if(timeRegEx.test( sampleTime.get('v.value') ))
                                {
                                    sampleTime.setCustomValidity("");
                                    sampleTime.showHelpMessageIfInvalid("");
                                    helper.SubmitResubJwlComponent(component, event, helper);
                                }
                                else if( timeRegEx1.test(sampleTime.get('v.value')) )
                                {
                                    var sampleTimesplitarray = sampleTime.get('v.value').split(':');
                                    
                                    var timeformate = (sampleTimesplitarray[0] == 0) ? 12 +':'+sampleTimesplitarray[1]+' AM' :
                                    (sampleTimesplitarray[0] < 12 ) ? sampleTimesplitarray[0] + ':'+sampleTimesplitarray[1]+' AM' :
                                    sampleTimesplitarray[0]-12 + ':'+sampleTimesplitarray[1]+' PM';
                                    
                                    jwl.Sample_Submission_time__c = timeformate;
                                    component.set('v.JWL_Component',jwl);
                                    sampleTime.setCustomValidity("");
                                    sampleTime.showHelpMessageIfInvalid("");
                                    helper.SubmitResubJwlComponent(component, event, helper);
                                }
                                    else
                                    {
                                        sampleTime.setCustomValidity("Enter valid Time");
                                        sampleTime.showHelpMessageIfInvalid("Enter valid Time");
                                    }
                            }
                        }
                    }
                        else
                        {
                            submtByEmail.setCustomValidity("Enter Submitted by email Id");
                            submtByEmail.showHelpMessageIfInvalid("Enter Submitted by email Id");
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title : 'Error',
                                message: 'Please Enter Submitted By Email Id',
                                duration:' 2000',
                                key: 'info_alt',
                                type: 'Error',
                                mode: 'dismissible'
                            });
                            toastEvent.fire();
                        } 
                        
                    }
                }
            }
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
    
    handleUploadFinished: function (component, event, helper) {
        helper.image1upload(component,event,helper);
        
        
    },
    handleUploadFinished2: function (component, event, helper) {
        
        helper.image2upload(component,event,helper);
        
        
    },
    handleUploadFinished3: function (component, event, helper) {
        
        helper.image3upload(component,event,helper);
        
    },
    
})