({
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
    CHUNK_SIZE: 750000,      //Chunk Max size 750Kb 
    getPickList : function(component, event, fieldApiName,objectnamejwl) {
        var action = component.get("c.getPickListValue");
        action.setParams({
            "fieldname" : fieldApiName,
            "objectname":objectnamejwl
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var returnlist = response.getReturnValue();
                console.log('returnlist..'+JSON.stringify(returnlist));
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
                                        component.set("v.Locationlist",JSON.parse(returnlist[0]));
                                        else if(fieldApiName === "Final_Verdict__c")
                                            component.set("v.finalVerdict",JSON.parse(returnlist[0]));
                                            else if(fieldApiName === "Conclusion__c")
                                                component.set("v.conclusionlist",JSON.parse(returnlist[0]));
            }
        });
        $A.enqueueAction(action);
    },
    fetchAccounts : function(component, event, helper) {
        
        var action = component.get("c.fetchAccounts");
        //alert(action);
        var accName =component.get('v.nameVal');
        console.log(accName);
        action.setParams({
            'searchkeyword' : accName
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            
            if (state === "SUCCESS") {
                var accList= response.getReturnValue();
                console.log('accList-->'+accList);
                component.set('v.JWLrecordlist',accList);
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message){
                            console.log("Error message: " +
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
        
    },
    
    redirecttorecordhelper: function(component, event, helper) {
        var ids = component.get('v.recordId');
        
        
        //alert(ids);
        var typesPages = component.find("divid");
        $A.util.removeClass(typesPages,"slds-show");
        $A.util.addClass(typesPages,"slds-hide");
        var typesPage = component.find("Recorddetail");
        $A.util.removeClass(typesPage,"slds-hide");
        $A.util.addClass(typesPage,"slds-show"); 
        
        var action = component.get("c.retriverecord");
        
        var rec =component.get('v.JWLrecorddetail');
        
        action.setParams({
            'recid' : ids
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            
            if (state === "SUCCESS") {
                var jwllist= response.getReturnValue();
                console.log('jwllist-->'+jwllist);
                debugger;
                component.set('v.recdetail',jwllist);
                
            }
            
        });
        $A.enqueueAction(action);
    },
    editablefieldshelper:function(component,helper){
        //alert("test");
        component.set('v.editflag', false);
        component.set('v.isReadonly22', false);
         component.set('v.Readonly', false);
        
        var edit = component.find("Edit");
        $A.util.removeClass(edit,"slds-show");
        $A.util.addClass(edit,"slds-hide");
        
        
        var sc = component.find("Save/Cancle");
        $A.util.removeClass(sc,"slds-hide");
        $A.util.addClass(sc,"slds-show");
        var edittypes = component.find("enableonedit");
        $A.util.removeClass(edittypes,"slds-show");
        $A.util.addClass(edittypes,"slds-hide");

        
        
        
        
    },
    getJwlTest : function(component, event, helper)
    {
        
        var accList =component.get('v.JWLrecordlist');
        console.log("rec ;list.."+accList);
        /*var ids ;
        for(var i =0;i<1;i++){
            //alert(accList[i].Id);
            console.log(accList[i].Id);
            ids = accList[i].Id;
            
            debugger;
            // break;
            
        }*/
        
        
        var action = component.get("c.getjwlreponsetestcases");
        
        action.setParams({
            'jwlcompid' : component.get('v.recordId')
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                
                
                var returnTest=response.getReturnValue();
                component.set('v.jwlTestList',returnTest);
                console.log("returnlist..........."+returnTest);
            }
        });
        $A.enqueueAction(action);
    },
    generatetesthelper:function(component,event,helper){
        var check = event.target.checked;
        var jwlcomponent=component.get("v.recdetail");
        var jwlresponse=component.get("v.jwlTestList");
        /*var response = [];
        for(var x in jwlresponse){
            if(jwlresponse[x]["isChecked__c"]){
                response.push(jwlresponse[x]);
            }
        }*/
        if(check){
            var specifiction = component.find("thetable");
            $A.util.removeClass(specifiction,"slds-hide");
            $A.util.addClass(specifiction,"slds-show");
        }else{
            var specifiction = component.find("thetable");
            $A.util.removeClass(specifiction,"slds-show");
            $A.util.addClass(specifiction,"slds-hide");
        }
        var action=component.get("c.updateresponse");
        debugger;
        action.setParams({
            'componentlist' : jwlcomponent,
            'responselist' : jwlresponse
            
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
               
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Test parameters generated',
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
    responsewithactivetest:function(component,event,helper){
        
        var accList =component.get('v.JWLrecordlist');
        
        var ids ;
        for(var i =0;i<1;i++){
            //alert(accList[i].Id);
            console.log(accList[i].Id);
            ids = accList[i].Id;
            
        }
        
        var action = component.get("c.responsewithtest");
        
        action.setParams({
            'jwlid' : component.get('v.recordId')
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                //debugger;
                //alert(response.getReturnValue());
                var returnTest=response.getReturnValue();
                //console.log('shjdhjas-->'+JSON.stringify(returnTest));
                component.set('v.Activetestlist',response.getReturnValue());
                component.set('v.indexValue',returnTest.length);
                debugger;
                
                //console.log("alltestParaMeterList..........."+JSON.stringify(component.get('v.Activetestlist')));
            }
            
        }); 
        $A.enqueueAction(action);
    },
    
    saverecord:function(component,event,helper){
        var jwlcomponent=component.get("v.recdetail");
        var jwlresponse=component.get("v.Activetestlist");
        
        component.set("v.editflag",true);
        component.set("v.isReadonly22",true);
        component.set("v.Readonly",true);
        
        var sc = component.find("Save/Cancle");
        $A.util.removeClass(sc,"slds-show");
        $A.util.addClass(sc,"slds-hide");
        
        var edit = component.find("Edit");
        $A.util.removeClass(edit,"slds-hide");
        $A.util.addClass(edit,"slds-show");
        
        
        var action=component.get("c.savefinalresponse");
        
        action.setParams({
            'componentlist' : jwlcomponent,
            'responselist' : jwlresponse
            
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var edittypes = component.find("enableonedit");
                $A.util.removeClass(edittypes,"slds-hide");
                $A.util.addClass(edittypes,"slds-show");
        
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Jewellery Response is saved successfully',
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
    
    deleteTestInRow:function(component,event,deleteTestRespo){
    
        var action = component.get("c.deleteTestInRow");
        
        action.setParams({
            'deleteRespo' : deleteTestRespo
        });
        
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var returnTest=response.getReturnValue();
            }
        });
    	$A.enqueueAction(action);
    },
    
    
    insertmannaulresponse:function(component,event,helper){
        var newrow=component.get("v.addNewTestValueList");
        var jwlcomponent=component.get("v.recdetail");
        var addname = component.find("addname");
        var ids2 = component.get('v.recordId');
        
        var action=component.get("c.insertnewrow");
        action.setParams({
            'newrowlist' : newrow,
            'recid2' : ids2
            
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var newlist=response.getReturnValue();
                component.set("v.addNewTestValueList",newlist);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'manual Response is saved successfully',
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
    image1upload:function(component,event,helper){
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        //alert("Files uploaded : " + uploadedFiles.length);
        //set action to call updatePicturePath method from Server-side controller
        var action = component.get('c.updatePicturePath');
        
        //set parametrs
        action.setParams({
            recId : component.get('v.recordId')
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state === 'DRAFT') {
                
                var data = response.getReturnValue();
                var tempData = component.get('v.recdetail');
                for(var x in tempData){
                    tempData[x]['Image_1__c'] = data['Image_1__c'];
                }
                component.set('v.recdetail',tempData);
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
            recId : component.get('v.recordId')
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state === 'DRAFT') {
                
                var data = response.getReturnValue();
                var tempData = component.get('v.recdetail');
                for(var x in tempData){
                    tempData[x]['Image_2__c'] = data['Image_2__c'];
                }
                component.set('v.recdetail',tempData);
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
            recId : component.get('v.recordId')
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state === 'DRAFT') {
                
                var data = response.getReturnValue();
                var tempData = component.get('v.recdetail');
                for(var x in tempData){
                    tempData[x]['Image_3__c'] = data['Image_3__c'];
                }
                component.set('v.recdetail',tempData);
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
    pdfpreviewhelper:function(component,event,helper){
        var ids = component.get('v.recordId');
        var jwlobj =component.get('v.objInfo');
        //window.open = '/apex/JWL_ViewPDF?id='+ids;	
        window.open('/apex/JWL_ViewPDF?id='+ids);
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
                
            }
        });
        $A.enqueueAction(action);
    },
    
    calcBusinessDays :function (component,dDate1, dDate2) { 
        var iWeeks, iDateDiff, iAdjust = 0;
        if (dDate2 < dDate1) 
            return -1; 
        var iWeekday1 = dDate1.getDay(); 
        var iWeekday2 = dDate2.getDay();
        alert(iWeekday1 +',' +iWeekday2);
        iWeekday1 = (iWeekday1 == 0) ? 7 : iWeekday1; 
        iWeekday2 = (iWeekday2 == 0) ? 7 : iWeekday2;
        if ((iWeekday1 > 6) && (iWeekday2 > 6)) iAdjust = 1; 
        iWeekday1 = (iWeekday1 > 6) ? 6 : iWeekday1; 
        iWeekday2 = (iWeekday2 > 6) ? 6 : iWeekday2;
        
        
        iWeeks = Math.round((dDate2.getTime() - dDate1.getTime()) / 604800000);
        alert(iWeeks);
        if (iWeekday1 < iWeekday2) { 
            iDateDiff = (iWeeks * 6) + (iWeekday2 - iWeekday1)
        } else {
            iDateDiff = ((iWeeks ) * 6) - (iWeekday1 - iWeekday2)
        }
        
        iDateDiff -= iAdjust 
        
        return (iDateDiff + 1); 
    },
    
    
    
})