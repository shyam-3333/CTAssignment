({
    doInit: function (component, event, helper) {
        if (component.get('v.parentTestingType') == 'Raw Material') {
            helper.fatchRawMaterial(component, event, helper);
        } else if (component.get('v.parentTestingType') == 'Plating') {
            helper.fatchPlating(component, event, helper);
        } else if (component.get('v.parentTestingType') == 'Plating and Material Composition') {
            helper.fatchPlatingMC(component, event, helper);
        }
    },
    dwonLoadCSVFile: function (component, event, helper) {
        var csvString = component.get('v.csvFile');
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvString);
        hiddenElement.target = '_self'; //
        if (component.get('v.parentTestingType') == 'Raw Material') {
            hiddenElement.download = 'RawMaterialRecords.csv'; // CSV file Name* you can change it.[only name not .csv] 
        } else if (component.get('v.parentTestingType') == 'Plating') {
            hiddenElement.download = 'PlatingRecords.csv'; // CSV file Name* you can change it.[only name not .csv] 
        } else if (component.get('v.parentTestingType') == 'Plating and Material Composition') {
            hiddenElement.download = 'PlatingMaterialCompositionRecords.csv'; // CSV file Name* you can change it.[only name not .csv] 
        }
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
    uploadMethod: function (component, event, helper) {
        var action = component.get('c.uploadCSVFile');
        let data = JSON.stringify(component.get('v.attachmentObject'));
        let uploadingAction = component.get('v.parentTestingType');

        let jsonObject = {
            "fileData": data,
            "uploadingAction": uploadingAction
        };
        component.set("v.Spinner", true);
        action.setParams({
            requestParametes: JSON.stringify(jsonObject)
        });
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                component.set("v.Spinner", false);
                helper.showTost(component, event, helper, 'success', "File Uploading successfully");
                if (component.get('v.parentTestingType') == 'Raw Material') {
                    helper.fatchRawMaterial(component, event, helper);
                } else if (component.get('v.parentTestingType') == 'Plating') {
                    helper.fatchPlating(component, event, helper);
                } else if (component.get('v.parentTestingType') == 'Plating and Material Composition') {
                    helper.fatchPlatingMC(component, event, helper);
                }
                component.set('v.attachmentObject', undefined);
            } else {
                if (response.getError()[0].message != undefined) {
                    helper.showTost(component, event, helper, 'error', "" + response.getError()[0].message);
                    component.set("v.Spinner", false);
                } else if(response.getError()[0].fieldErrors.Department__c[0].message != undefined) {
                    helper.showTost(component, event, helper, 'error', "" + response.getError()[0].fieldErrors.Department__c[0].message);
                }else if(response.getError()[0].pageErrors[0].message != undefined){
                    helper.showTost(component, event, helper, 'error', "" + response.getError()[0].pageErrors[0].message);
                } else {
                    helper.showTost(component, event, helper, 'error', "please contact to admin");
                }
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);
    },
})