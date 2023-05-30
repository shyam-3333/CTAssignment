({
    doInit : function(component, event, helper) {
        helper.onLoadMethod(component, event, helper);
    },
    downloadCsv : function(component, event, helper){
        // get the Records [contact] list from 'ListOfContact' attribute 
        var stockData = component.get("v.skinnModelItemList");
        
        // call the helper function which "return" the CSV data as a String   
        var csv = helper.convertArrayOfObjectsToCSV(component,stockData);   
         if (csv == null){return;} 
        
        // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
	     var hiddenElement = document.createElement('a');
          hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
          hiddenElement.target = '_self'; // 
          hiddenElement.download = 'SkinnProcessFile.csv';  // CSV file Name* you can change it.[only name not .csv] 
          document.body.appendChild(hiddenElement); // Required for FireFox browser
    	  hiddenElement.click(); // using click() js function to download csv file
    },
    handleFilesChange: function (component, event, helper) {
        var files = component.get("v.attachment");
        if (files && files.length > 0) {
            var file = files[0][0];
            var reader = new FileReader();
            reader.onloadend = function () {
                var dataURL = reader.result;
                var content = dataURL.match(/,(.*)$/)[1];
                var jsonObject = {
                    'filename': file.name,
                    'baseDate': content,
                    'contentType': file.type
                };
                component.set('v.attachmentObject', jsonObject);
            }
            reader.readAsDataURL(file);
        }
    },
    clearAttachmentMethod: function (component, event, helper) {
        component.set('v.attachmentObject', undefined);
    },
    uploadMethod : function(component, event, helper){
        var action = component.get('c.readCSVFileMethod');
        var  data = JSON.stringify(component.get('v.attachmentObject'));
        component.set("v.Spinner", true);
        action.setParams({
            "fileData" : data
        });
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.Spinner", false);
                component.set('v.skinnModelItemList',response.getReturnValue().systemData);
                if(response.getReturnValue().status == 'Success'){
                    helper.showTost(component, event, helper, 'success', "File Uploading successfully");
                    component.set('v.attachmentObject', undefined);
                } else {
                    component.set('v.attachmentObject', undefined);
                    helper.showTost(component, event, helper, 'error', ""+response.getReturnValue().status);
                }
            } else {
                alert('please check the Object permission');
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);
    }
})