({
    doInit: function(component, event, helper) {
        helper.getPickList(component, event, "Test_Type__c","JWL_Component__c");
        helper.getPickList(component, event, "Sample_Type__c","JWL_Component__c");
        helper.getPickList(component, event, "Product_Category__c","JWL_Component__c");
        //helper.getPickList(component, event, "Collection__c","JWL_Component__c");
        helper.getPickList(component, event, "Karatage__c","JWL_Component__c");
        helper.getPickList(component, event, "Route_of_Manufacturing__c","JWL_Component__c");
        helper.getPickList(component, event, "Location__c","JWL_Component__c");
        helper.getPickList(component, event, "Final_Verdict__c","JWL_Component__c");
        helper.getPickList(component, event, "Conclusion__c","JWL_Response__c");
        helper.getQAEmails(component,event,helper);
        helper.getVendors(component, event, helper);
        
        
    },
    showSpinner: function(component) {
        var spinnerMain =  component.find("Spinner");
        $A.util.removeClass(spinnerMain, "slds-hide");
    },
    
    hideSpinner : function(component) {
        var spinnerMain =  component.find("Spinner");
        $A.util.addClass(spinnerMain, "slds-hide");
    },
    onPicklistChange: function(component, event, helper) {
        // get the value of select option
        alert(event.getSource().get("v.value"));
    },
    OnSave : function(component, event, helper) {
        
        var finalverdict = component.find("finalverd");
        var genobservation = component.find("genobserv");
        var listactive=component.get("v.Activetestlist");
        var addname2 = component.find("addname");
        var verdictId = component.find("verdictId");
        var additionalEmails = component.find("additionalEmail");
        var jwllist=component.get("v.addNewTestValueList");
        var error=false;
        var errortest=false;
        var errortestResult=false;
        var finalerror=true;
        var generalerror=false;
        var finalverdicterror=false;
        if((finalverdict.get("v.value"))==null || (finalverdict.get("v.value"))==undefined || (finalverdict.get("v.value"))=='' ){
            finalverdicterror=true;
        }
        if((genobservation.get("v.value"))==null || (genobservation.get("v.value"))==undefined || (genobservation.get("v.value"))=='' ){
            generalerror=true;
        }
        
        
        
        for(var jwl in listactive){
            if(listactive[jwl].Conclusion__c =='' || listactive[jwl].Conclusion__c==undefined){
                error=true; 
                
                
            }
        }
        if(error){
            alert('Please fill Result');
        }
        for(var jwl in jwllist){
            if(jwllist[jwl].Test_Name__c =='' || jwllist[jwl].Test_Name__c==undefined){
                errortest=true; 
                
                
            }
            
        }
        if(errortest){
            alert('Please fill Test Name');  
        }
        
        for(var jwl in jwllist){
            if(jwllist[jwl].Conclusion__c =='' || jwllist[jwl].Conclusion__c ==undefined){
                //errortest=true; 
                errortestResult = true ;
            }
        }
        
        if(errortestResult){
            alert('Please fill Test Name');  
        }
        if(finalverdicterror==false  && error==false && errortest==false && errortestResult == false ){
            finalerror=false;
            helper.saverecord(component, event, helper);
            
        }else{
            alert("Please fill mandatory feilds");
            
        }
        if(finalerror==false && jwllist.length>0   && errortest==false ){
            helper.insertmannaulresponse(component, event, helper);  
        }
        
    },
    
    openModel: function(component, event, helper) {
        // alert('Coming');
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
        
        
        helper.fetchAccounts(component, event, helper);
        component.set("v.nextbutton", false);
        
    }
    ,closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        //alert(event.target);
        component.set("v.isOpen", false);
        var x = event.target.id;
        //alert(x);
        var accList =component.get('v.JWLrecordlist');
        for(var i =0;i<accList.length;i++){
            if(accList[i].Id==x){
                component.set('v.nameVal',accList[i].Report_Reference_Number__c);
                component.set('v.recordId',accList[i].Id);
                if(accList[i].Vendor__c != undefined)
                    component.set("v.searchVendor",accList[i].Vendor__r.Name);
                //alert(x);
                break;
                
            }
        }
    },
    
    // to show vendor lookup
    openVendorModal : function(component, event , helper)
    {
        var editatble = component.get("v.editflag");
        if(editatble === false ){
            component.set("v.openVendModal","True");
            helper.getVendors(component, event, helper);
        }
        
    },
    
    
    // to select vendor from vendor lookup
    selectVendor : function(component, event , helper)
    {
        component.set("v.openVendModal","false"); 
        var id = event.target.id; 
        var vendorLst = component.get("v.jwlVendorList");
        var jwlComponentList = component.get("v.recdetail");
        var recordId = component.get("v.recordId");
        for( var i = 0; i<jwlComponentList.length ; i++)
        {
            if(jwlComponentList[i].Id == recordId)
            {
                jwlComponentList[i].Vendor__c = vendorLst[id].Id;
                component.set("v.searchVendor",vendorLst[id].Name);
            }
        }
        component.set("v.recdetail",jwlComponentList);
        component.set('v.JWLrecordlist',jwlComponentList);
        
    },
    redirecttorecord:function(component, event, helper){
        
        helper.redirecttorecordhelper(component, event, helper);
        helper.getJwlTest(component, event, helper);
        
    },
    editablefields:function(component, event, helper){
        
        
        helper.editablefieldshelper(component, event);
    },
    
    
    handleLoad: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
    },
    
    handleSubmit: function(cmp, event, helper) {
        cmp.set('v.disabled', true);
        cmp.set('v.showSpinner', true);
    },
    
    handleError: function(cmp, event, helper) {
        // errors are handled by lightning:inputField and lightning:nessages
        // so this just hides the spinnet
        cmp.set('v.showSpinner', false);
    },
    
    handleSuccess: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
        cmp.set('v.saved', true);
    },
    cancel : function(component,event, helper){
        var edittypes = component.find("divid");
        $A.util.removeClass(edittypes,"slds-hide");
        $A.util.addClass(edittypes,"slds-show"); 
        var edittypes22 = component.find("Recorddetail");
        $A.util.removeClass(edittypes22,"slds-show");
        $A.util.addClass(edittypes22,"slds-hide");
        var edittypes33 = component.find("enableonedit");
        $A.util.removeClass(edittypes33,"slds-show");
        $A.util.addClass(edittypes33,"slds-hide");
        $A.get('e.force:refreshView').fire();
    },
    checkTest : function(component, event, helper)
    {
        debugger;
        alert("coming");
        var id = event.target.id;
        var jwlTest = component.get("v.jwlTestList");
        var testArray = component.get("v.checkedJwltestList");
        var check = event.target.checked;
        var remainingTest=[];
        if(check){
            testArray.push(jwlTest[id]);
            component.set("v.checkedJwltestList",JSON.parse(JSON.stringify(testArray)));
            alert(JSON.stringify(testArray));
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
            alert(JSON.stringify(remainingTest));
            
        }
        var action = component.get("c.updatecheckbox");
        
        action.setParams({
            'responselist' : component.get('v.checkedJwltestList')
        });
    },
    generatetest:function(component,event,helper){
        
        
        var check = event.target.checked;
        if(check){
            
            var specifiction = component.find("thetable");
            $A.util.removeClass(specifiction,"slds-hide");
            $A.util.addClass(specifiction,"slds-show");
            helper.generatetesthelper(component,event,helper);
        }else{
            var specifiction = component.find("thetable");
            $A.util.removeClass(specifiction,"slds-show");
            $A.util.addClass(specifiction,"slds-hide");
        }
        
        
        helper.responsewithactivetest(component,event,helper);
        
        
    },
    otherCheck : function(component, event, helper)
    {
        
        var check = event.target.checked;
        var respo = component.get("v.JWL_Response");
        var jwlTest = component.get("v.jwlTestList");
        var Test;
        
        if(check){
            for( var index=0 ; index < jwlTest.length ; index++ )
            {
                if(jwlTest[index].Name == "Others"  )
                {
                    Test = jwlTest[index];
                }
            }
            var specifiction = component.find("otherSpec");
            $A.util.removeClass(specifiction,"slds-hide");
            $A.util.addClass(specifiction,"slds-show");
            respo.Jwellery_Test__c = Test.Id	;
            respo.isChecked__c = "True" ;
            component.set("v.JWL_Response",JSON.parse(JSON.stringify(respo)));
            document.getElementById("othertest").value = "True";
        }else{
            var specifiction = component.find("otherSpec");
            $A.util.removeClass(specifiction,"slds-show");
            $A.util.addClass(specifiction,"slds-hide");
            respo.Jwellery_Test__c = Test.Id ;
            respo.isChecked__c = "false" ;
            respo.If_Others__c='';
            component.set("v.JWL_Response",JSON.parse(JSON.stringify(respo)));
            document.getElementById("othertest").value = "false";
            
            
        }
    },
    
    deleteRow : function(component,event,helper){
        var removeRaw=component.get('v.Activetestlist');
        var lastIndex=event.currentTarget.id;
        var updatedata=[];
        
        var x = event.target.id;
        
        // var accList =component.get('v.Activetestlist');
        removeRaw[lastIndex].isChecked__c = false ; 
        var deleteTestRespo = removeRaw[lastIndex] ;
        delete removeRaw[lastIndex];
        for(var dat in removeRaw){
            if(dat!=undefined)
                updatedata.push(removeRaw[dat]);
        }
        
        component.set('v.Activetestlist',JSON.parse(JSON.stringify(updatedata)));
        component.set('v.indexValue',updatedata.length );
        
        helper.deleteTestInRow(component,event,deleteTestRespo);
        
        
    },
    addrow: function(component, event,helper) {
        //get the  List from component  
        component.set('v.read',true);
        var jwlcomponent=component.get("v.recordId"); 
        var Activetestlist = component.get("v.Activetestlist");
        var addNewRawList=component.get('v.addNewTestValueList');
        var reslist={
            'sobjectType': 'JWL_Response__c',
            'isChecked__c':true
            
        }
        debugger;
        addNewRawList.push(reslist);
        component.set("v.addNewTestValueList", addNewRawList);
        component.set('v.indexValue',addNewRawList.length);
    },
    deleteRow1 : function(component,event,helper){
        var removeRaw=component.get('v.addNewTestValueList');
        var Activetestlist = component.get("v.Activetestlist");
        var lastIndex=event.currentTarget.id;
        var updatedata=[];
        removeRaw[lastIndex].isChecked__c = false ; 
        var deleteTestRespo = removeRaw[lastIndex] ;
        
        delete removeRaw[lastIndex];
        for(var dat in removeRaw){
            if(dat!=undefined)
                updatedata.push(removeRaw[dat]);
        }
        
        component.set('v.addNewTestValueList',updatedata);
        component.set('v.indexValue',Activetestlist.length);
        
        if(deleteTestRespo.Id !== '' )
            helper.deleteTestInRow(component,event,deleteTestRespo);
    },
    
    doSave: function(component, event, helper) {
        if (component.find("fileId").get("v.files").length > 0) {
            helper.uploadHelper(component, event);
        } else {
            alert('Please Select a Valid File');
        }
    },
    
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
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
    publishjwl:function (component, event, helper) {
        
        component.set('v.editflag', true);
        var edit = component.find("Edit");
        $A.util.removeClass(edit,"slds-show");
        $A.util.addClass(edit,"slds-hide");
        var jwlcomponent=component.get("v.recdetail");
        
        var recordId = component.get("v.recordId");
        for( var i = 0; i<jwlcomponent.length ; i++)
        {
            if(jwlcomponent[i].Id == recordId)
            {
                
                jwlcomponent[i].Publish_Date__c = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
                var submissionTime = (jwlcomponent[i].Sample_Submission_time__c);
                var submissionTimeArr1 = submissionTime.split(' ');
                
                if(submissionTimeArr1[1] == 'AM' || submissionTimeArr1[1] == 'am')
                {
                    var temp = submissionTimeArr1[0].split(':');
                    submissionTime = parseInt(temp[0])*60 + parseInt(temp[1]);  // convert submissionTime in min
                }
                else if(submissionTimeArr1[1] == 'PM' || submissionTimeArr1[1] == 'pm')
                {
                    var temp = submissionTimeArr1[0].split(':');
                    submissionTime = (parseInt(temp[0])+12)*60 + parseInt(temp[1]);  // convert submissionTime in min
                }
                var currentTime = $A.localizationService.formatDate(new Date(), "HH:mm");
                var temp1 = currentTime.split(':');
                currentTime = parseInt(temp1[0])*60 + parseInt(temp1[1]);  // convert currentTime in min
                
                var dayStartTime = 510; // dayStartTime 8:30 AM in min
                var datEndTime = 1020;  // datEndTime 5:00 PM in min
                
                
                if( submissionTime > datEndTime )
                    submissionTime = datEndTime;
                else if(submissionTime < dayStartTime)
                    submissionTime = dayStartTime;
                //*************************************        
                if(currentTime > datEndTime)
                    currentTime = datEndTime;
                else if(submissionTime < dayStartTime)
                    currentTime = dayStartTime;
                
                var publishDate = new Date(jwlcomponent[i].Publish_Date__c);
                var SampleSubDate = new Date(jwlcomponent[i].Sample_Submission_Date__c);
                if( jwlcomponent[i].Publish_Date__c == jwlcomponent[i].Sample_Submission_Date__c )
                {
                    // jwlcomponent[i].Lead_Time__c = 1 ;
                    //submissionTime = submissionTime - dayStartTime ;
                    
                    var leadTime = currentTime - submissionTime ;
                    jwlcomponent[i].Lead_Time__c = parseInt(leadTime / 60)+':'+Math.round((leadTime/60 - parseInt(leadTime/60) ) *60) + ' Hrs';
                }
                else if(jwlcomponent[i].Publish_Date__c > jwlcomponent[i].Sample_Submission_Date__c)
                {
                    /*
                    jwlcomponent[i].Lead_Time__c = helper.calcBusinessDays(component,SampleSubDate ,publishDate );
                    alert(jwlcomponent[i].Lead_Time__c);  */
                    submissionTime = datEndTime - submissionTime  ;
                    var leadTime =  submissionTime ;
                    SampleSubDate.setDate(SampleSubDate.getDate() + 1);
                    for(var date1 = SampleSubDate; date1 <= publishDate ; date1.setDate(date1.getDate() + 1) )
                    {
                        if(date1.getDay() != 0 && date1 < publishDate)
                        {
                            leadTime = parseInt(leadTime) + 8.50 * 60 ;// adding one day business hours
                        }
                        else if(date1.getDay() != 0 && Date(date1) == Date(publishDate))
                        {
                            currentTime = currentTime - dayStartTime ;
                            leadTime = leadTime + currentTime;
                        }
                        
                    }
                    jwlcomponent[i].Lead_Time__c = parseInt(leadTime / 60)+':'+Math.round((leadTime/60 - parseInt(leadTime/60) ) *60) + ' Hrs' ;//parseInt(leadTime / 60)+':'+ parseInt((leadTime / 60) - parseInt(leadTime / 60)*100) + 'Hrs';
                }
            }
        }
        var action=component.get("c.publish");
        
        action.setParams({
            'componentlist' : jwlcomponent
            
            
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var data = response.getReturnValue();
                component.set('v.recdetail',data); 
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'This Product is Published',
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
    sendEmail:function(component,event,helper){
        //var action=component.get("c.updatedocumentstatus");
        
        component.set('v.editflag', true);
        var edit = component.find("Edit");
        $A.util.removeClass(edit,"slds-show");
        $A.util.addClass(edit,"slds-hide");
        var jwlcomponent2=component.get("v.recdetail");
        
        var recordId = component.get("v.recordId");
        
        var action=component.get("c.updatedocumentstatus");
        
        action.setParams({
            'componentlist' : jwlcomponent2
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var data = response.getReturnValue();
                component.set('v.recdetail',data); 
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Email sent successfully',
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
    pdfpreview:function(component,event,helper){
        helper.pdfpreviewhelper(component,event,helper);
    },
    
    keyEnterInGO : function(component,event,helper){
        if(event.getParams('keyCode') == 13){
            alert('ENTER'+ event.getParams('keyCode'));
        }
        
    },
    
    
})