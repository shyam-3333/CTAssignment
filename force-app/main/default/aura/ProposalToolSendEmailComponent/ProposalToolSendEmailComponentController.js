({
    
    showAttachments : function(component, event, helper) {
        
        var action = component.get('c.retrieveAttachment');
        var readyReckenorId = component.get('v.recordId');
        action.setParams({"readyReckenorId" : readyReckenorId});
        
        action.setCallback(this,function(response){
            console.log('Debug-->'+response.getReturnValue().length);
            if(response.getReturnValue().length>0){
                component.set('v.contentDocumentList',response.getReturnValue());
                
            }else{
                $A.get("e.force:closeQuickAction").fire() 
                
                var toastEvent = $A.get("e.force:showToast");
                
                toastEvent.setParams({
                    "title": "Error!",
                    "type" : 'error',
                    "mode" : 'dismissible',
                    "duration" : 5000,
                    "message": "Documents Not Found"
                });
                toastEvent.fire();
                
                //component.set('v.contentDocumentList',response.getReturnValue());
                
            }
        });
        $A.enqueueAction(action);
    },
    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    },
    selectAll: function(component, event, helper) {
        //get the header checkbox value  
        var selectedHeaderCheck = event.getSource().get("v.value");
        if(component.find("boxPack")){
            // get all checkbox on table with "boxPack" aura id (all iterate value have same Id)
            // return the List of all checkboxs element 
            var getAllId = component.find("boxPack");
            // If the local ID is unique[in single record case], find() returns the component. not array   
            if(! Array.isArray(getAllId)){
                if(selectedHeaderCheck == true){ 
                    component.find("boxPack").set("v.value", true);
                    component.set("v.selectedCount", 1);
                }else{
                    component.find("boxPack").set("v.value", false);
                    component.set("v.selectedCount", 0);
                }
            }else{
                // check if select all (header checkbox) is true then true all checkboxes on table in a for loop  
                // and set the all selected checkbox length in selectedCount attribute.
                // if value is false then make all checkboxes false in else part with play for loop 
                // and select count as 0 
                if (selectedHeaderCheck == true) {
                    for (var i = 0; i < getAllId.length; i++) {
                        component.find("boxPack")[i].set("v.value", true);
                        component.set("v.selectedCount", getAllId.length);
                    }
                } else {
                    for (var i = 0; i < getAllId.length; i++) {
                        component.find("boxPack")[i].set("v.value", false);
                        component.set("v.selectedCount", 0);
                    }
                } 
            }  
        }
    },
    // For count the selected checkboxes. 
    checkboxSelect: function(component, event, helper) {
        // get the selected checkbox value  
        var selectedRec = event.getSource().get("v.value");
        // get the selectedCount attrbute value(default is 0) for add/less numbers. 
        
        var getSelectedNumber = component.get("v.selectedCount");
        // check, if selected checkbox value is true then increment getSelectedNumber with 1 
        // else Decrement the getSelectedNumber with 1     
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
        }
        // set the actual value on selectedCount attribute to show on header part. 
        component.set("v.selectedCount", getSelectedNumber);
    },
    // For count the selected checkboxes for the attachments. 
    checkboxSelect1: function(component, event, helper) {
        
        helper.checkbox1(component,event);
    },
    back : function(component,event,helper)
    {
        component.set("v.truthy", true);
        component.set("v.truthy1",false);   
    },
    doInit: function(component, event, helper) {
        helper.getContactList(component);
    },
    searchKeyChange: function(component, event) {
        let searchKey = component.find("searchKey").get("v.value");
        console.log('searchKey:::::'+searchKey);
        let contactList = component.get("v.contacts1");
        let listOfContact = [];
        
        for(let i = 0; i<contactList.length; i++)
        {
            if(contactList[i].Name.toLowerCase().includes(searchKey.toLowerCase()))
            {
                listOfContact.push(contactList[i]);
            }
        }
        contactList = listOfContact;
        console.log('contactList11' , listOfContact);
        console.log('contactList22' , contactList);
        var action = component.get("c.searchContacts");
        action.setParams({
            "searchKey": listOfContact
        });
        action.setCallback(this, function(a) {
            component.set("v.contacts", a.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    selectAll1: function(component, event, helper) {
        //get the header checkbox value  
        
        
        var selectedHeaderCheck = event.getSource().get("v.value");
        
        // get all checkbox on table with "boxPack1" aura id (all iterate value have same Id)
        // return the List of all checkboxs element 
        var getAllId = component.find("boxPack1");
        
        // If the local ID is unique[in single record case], find() returns the component. not array   
        if(! Array.isArray(getAllId)){
            if(selectedHeaderCheck == true){ 
                component.find("boxPack1").set("v.value", true);
                component.set("v.selectedCount1", 1);
            }else{
                component.find("boxPack1").set("v.value", false);
                component.set("v.selectedCount1", 0);
            }
        }else{
            // check if select all (header checkbox) is true then true all checkboxes on table in a for loop  
            // and set the all selected checkbox length in selectedCount attribute.
            // if value is false then make all checkboxes false in else part with play for loop 
            // and select count as 0 
            if (selectedHeaderCheck == true) {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack1")[i].set("v.value", true);
                    component.set("v.selectedCount1", getAllId.length);
                }
            } else {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack1")[i].set("v.value", false);
                    component.set("v.selectedCount1", 0);
                }
            } 
        }  
        
    },
    // For count the selected checkboxes. 
    checkboxSelect: function(component, event, helper) {
        // get the selected checkbox value  
        var selectedRec = event.getSource().get("v.value");
        // get the selectedCount attrbute value(default is 0) for add/less numbers. 
        var getSelectedNumber = component.get("v.selectedCount");
        // check, if selected checkbox value is true then increment getSelectedNumber with 1 
        // else Decrement the getSelectedNumber with 1     
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            
            getSelectedNumber--;
        }
        // set the actual value on selectedCount attribute to show on header part. 
        component.set("v.selectedCount", getSelectedNumber);
    },
    //For Contact selected records 
    selectedAttachment: function(component, event, helper) {
        
        // create var for store record id's for selected checkboxes  
        var conId = [];
        // get all checkboxes 
        var getAllId = component.find("boxPack1");
        console.log(getAllId);
        // If the local ID is unique[in single record case], find() returns the component. not array
        if(! Array.isArray(getAllId)){
            if (getAllId.get("v.value") == true) {
                conId.push(getAllId.get("v.text"));
            }
        }else{
            // play a for loop and check every checkbox values 
            // if value is checked(true) then add those Id (store in Text attribute on checkbox) in conId var.
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                    conId.push(getAllId[i].get("v.text"));
                }
            }
        } 
        console.log('conId  --> ',conId);
        component.set('v.contentDocumentList1',conId);   
        if(conId.length >0 ){
            component.set("v.truthy1", true);
            component.set("v.truthy",false);
            
        }else{
            var toastEvent = $A.get("e.force:showToast"); 
            
            toastEvent.setParams({
                "title": "Error!",
                "type" : 'error',
                "mode" : 'dismissible',
                "duration" : 5000,
                "message": "Please Select At Least One File"
            });
            toastEvent.fire();   
        }
    },
    //For Contact selected records 
    contactSelected: function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast"); 
        var isValidEmail = false; 
        var isnotEmpty = true;
        var emailField = component.find("email");
        var contactsSelected = component.get("v.selectedLookUpRecords");
        var subject = component.get("v.subjectOfEmail");
        var messageBody = component.get("v.messageBody");
        var multilpleEmails = [];
                var multilpleEmailsToSend = [];

        
        
        if(component.find("email")){
            var emailFieldValue = component.find("email").get("v.value");
            console.log(emailFieldValue);
            
            var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;  
            if(!$A.util.isEmpty(emailFieldValue)){ 
                if(emailFieldValue.includes(',')){
                    multilpleEmails = emailFieldValue.split(',');
                    for(var key in multilpleEmails){
                        if(multilpleEmails[key].match(regExpEmailformat)){
                            console.log(multilpleEmails[key]);
                            multilpleEmailsToSend.push(multilpleEmails[key]);
                            isValidEmail = true;
                        }else{
                            isValidEmail = false;
                            multilpleEmailsToSend = [];
                            console.log('isValidEmail -->'+ isValidEmail);
                            toastEvent.setParams({
                                "title": "Error!",
                                "type" : 'error',
                                "mode" : 'dismissible',
                                "duration" : 5000,
                                "message": "Enter valid Email."
                            });
                            toastEvent.fire();   
                            break;
                        }
                    }
                }else{
                    if(emailFieldValue.match(regExpEmailformat)){
                        multilpleEmailsToSend.push(emailFieldValue);
                        isValidEmail = true;
                    }else{
                        console.log('Error');
                        multilpleEmailsToSend = [];
                        isValidEmail = false;
                        console.log('isValidEmail -->'+ isValidEmail);
                        toastEvent.setParams({
                            "title": "Error!",
                            "type" : 'error',
                            "mode" : 'dismissible',
                            "duration" : 5000,
                            "message": "Enter valid Email."
                        });
                        toastEvent.fire();   
                    }
                    
                }
                
                
            }
        }else
        {
            isnotEmpty= false;
        }
        // if Email Address is valid then execute code     
        if(isValidEmail || contactsSelected.length > 0){
            
            if((subject == undefined || subject =='') || (messageBody == undefined || messageBody =='')){
                toastEvent.setParams({
                    "title": "Error!",
                    "type" : 'error',
                    "mode" : 'dismissible',
                    "duration" : 5000,
                    "message": "Plese fill subject and message of Email"
                });
                toastEvent.fire();   
            }else{
                var conId = [];
                var conEmail;
                // get all checkboxes 
                var getAllId = component.find("boxPack");
                console.log("---> ",getAllId);
                if(getAllId){
                    // If the local ID is unique[in single record case], find() returns the component. not array
                    if(component.find("boxPack")){
                        if(! Array.isArray(getAllId)){
                            if (getAllId.get("v.value") == true) {
                                conId.push(getAllId.get("v.text"));
                            }
                        }else{
                            // play a for loop and check every checkbox values 
                            // if value is checked(true) then add those Id (store in Text attribute on checkbox) in conId var.
                            for (var i = 0; i < getAllId.length; i++) {
                                if (getAllId[i].get("v.value") == true) {
                                    conId.push(getAllId[i].get("v.text"));
                                }
                            }
                        } 
                    }
                }
                var isEmail = false;
                if(component.find("email") && component.find("email").get("v.value") != ''){
                    conEmail = (component.find("email").get("v.value"))
                    
                    isEmail = true;
                }
                
                component.set('v.emailList',conId);
                console.log(component.get('v.emailList'));   
                
                var selectedContacts = contactsSelected;
                
                console.log("In send mail action");
                let contacctIds = [];
                let tempArray = [];
                if(selectedContacts.length > 0){
                    for(var i = 0; i < selectedContacts.length; i++){
                        contacctIds.push(selectedContacts[i].Id);
                    }
                    isEmail = true;
                    console.log('t.push(cU[i])  ', contacctIds);
                }
                
                var fileIds = component.get("v.contentDocumentList1");
                
                var file = [];
                console.log('fileIds', fileIds);
                for(var i = 0; i < fileIds.length; i++){
                    file.push(fileIds[i]);
                }
                
                
                var action = component.get("c.sendEmailApex");
                
                action.setParams({
                    "readyReckenorId" : component.get('v.recordId'),
                    "toAddress" : contacctIds,
                    "ccAddress" : tempArray,
                    "subject" : subject,
                    "body" : messageBody,
                    "Email" : multilpleEmailsToSend,
                    "files" : file
                });
                console.log('after set param for email');
                action.setCallback(this, function(response){
                    console.log("In call back of notify component on send email button");
                    var state = response.getState();
                    console.log("state --> ",state);
                    if(state === "SUCCESS"){
                        console.log("In success");
                        var toastEvent1 = $A.get("e.force:showToast");
                        toastEvent1.setParams({
                            title : 'Success',
                            message: 'Email Sent Successfully',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'success',
                            mode: 'pester'
                        });
                        $A.get("e.force:closeQuickAction").fire() 
                        toastEvent1.fire();
                    }else if(state === "ERROR"){
                        //console.log(response.getError()[0]);
                        var toastEvent1 = $A.get("e.force:showToast");
                        toastEvent1.setParams({
                            title : 'Error',
                            message:'Error sending the Email',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'error',
                            mode: 'pester'
                        });
                        toastEvent1.fire();
                        
                    }
                });
                $A.enqueueAction(action);
            }
            
        }else{
            /*toastEvent.setParams({
                "title": "Error!",
                "type" : 'error',
                "mode" : 'dismissible',
                "duration" : 5000,
                "message": "Please Select At Least One Email"
            });
            toastEvent.fire(); */
        }     
    },
    
})