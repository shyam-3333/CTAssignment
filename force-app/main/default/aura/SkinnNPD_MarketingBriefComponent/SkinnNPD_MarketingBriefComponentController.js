({
    doInit: function (component, event, helper) {
        component.set('v.IsSaveButtonClick', false);
        component.set("v.url", window.location.origin);
        helper.getAllPickList(component, event, helper);
    },
    displayTabs: function (component, event, helper) {
        component.set('v.IsSaveButtonClick', false);
        component.set('v.formToggle', false);
        if (component.get('v.toggleNote')) {
            component.set('v.toggleNote', false);
            component.set('v.noteTitle', "");
            component.set('v.noteBody', "");
        }
        component.set("v.Spinner", true);
        var selectedSkinnCollectionValue = component.get("v.selectedSkinnCollectionValue");
        // component.set("v.Spinner", true);
        var collectionValId = selectedSkinnCollectionValue.split(',')[0];
        //component.set("v.toggleSearch",true);
        //alert('------collectionVal------'+collectionVal);
        var action = component.get("c.fetchModelNames");
        action.setParams({
            "selectedCollectionId": collectionValId
        });
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                //alert('-------result-----'+result);
                component.set("v.modelList", result);
                component.set("v.toggleMod", true);
                component.set("v.Spinner", false);
                // component.set("v.Spinner", false);
                component.set('v.stageActList', []);
            } else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord = component.get("v.stageActList");
                if (listRecord != undefined)
                    helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);


    },
    stageActivity: function (component, event, helper) {
        //alert("-----id-------"+event.currentTarget.id);
        // component.set("v.Spinner", true);
        if (component.get('v.toggleNote')) {
            component.set('v.toggleNote', false);
            component.set('v.noteTitle', "");
            component.set('v.noteBody', "");
        }
        component.set('v.formToggle', false);
        component.set('v.IsSaveButtonClick', false);
        var selectedSkinnCollectionValue = component.get("v.selectedSkinnCollectionValue");
        var collectionId = selectedSkinnCollectionValue.split(',')[0];
        var modId = event.currentTarget.id;
        var marketingVal = document.getElementById(modId).value;
        component.set('v.marketingValue', marketingVal);
        var selectedIndex = modId.split(',');
        var listofModel = component.get('v.modelList');
        component.set("v.Spinner", true);
        component.set('v.selectedModelId', listofModel[selectedIndex[0]].Id);
        //alert('selectedmodelId--'+component.get('v.selectedModelId'));
        //alert('---marketingVal-----'+marketingVal);
        if (marketingVal == 'MarketingStage') {
            let templateId = selectedSkinnCollectionValue.split(',')[1];
            helper.showListMethod(component, event, helper, templateId, collectionId, listofModel[selectedIndex[0]].Id);
        } else {
            let templateId = selectedSkinnCollectionValue.split(',')[2];
            helper.showListMethod(component, event, helper, templateId, collectionId, listofModel[selectedIndex[0]].Id);
        }

    },
    inputForm: function (component, event, helper) {
        component.set("v.Spinner", true);
        component.set('v.formToggle', true);
        var clickId = event.currentTarget.id;
        var indexs = clickId.split(',');
        var listrecord = component.get('v.stageActList');
        component.set('v.status', listrecord[indexs[0]].stageStatus);
        component.set('v.selectedFormIndex', indexs[0]);
        component.set('v.plannedLeadTime', listrecord[indexs[0]].plannedLeadTime);
        component.set('v.skinnNPDTemplateItemId', listrecord[indexs[0]].skinnNPDTemplateItemId);
        helper.checkIsRecordHasPlannStartDate(component, event, helper, listrecord[indexs[0]].plannedLeadTime, indexs[0], listrecord);

        var rollingStartDate = new Date(listrecord[parseInt(indexs[0])].rollingStartDate);
        component.set('v.rollingStartDate', parseInt(rollingStartDate.toDateString().split(' ')[2]).toString() + ' ' + rollingStartDate.toDateString().split(' ')[1] + ', ' + rollingStartDate.toDateString().split(' ')[3]);
        var rollingEndDate = new Date(listrecord[parseInt(indexs[0])].rollingEndDate);
        component.set('v.rollingEndDate', parseInt(rollingEndDate.toDateString().split(' ')[2]).toString() + ' ' + rollingEndDate.toDateString().split(' ')[1] + ', ' + rollingEndDate.toDateString().split(' ')[3]);

        component.set('v.skinnCollectionRecordType', listrecord[parseInt(indexs[0])].skinnCollectionRecordType);

        var productLaunchDate = new Date(listrecord[parseInt(indexs[0])].productLaunchDate);
        component.set('v.productLaunchDate', parseInt(productLaunchDate.toDateString().split(' ')[2]).toString() + ' ' + productLaunchDate.toDateString().split(' ')[1] + ', ' + productLaunchDate.toDateString().split(' ')[3]);
        component.set('v.listNotes', listrecord[indexs[0]].listNotes);
        component.set('v.skinnItemParentId', listrecord[indexs[0]].skinnItemParentId);
        //,listrecord[indexs[0]].taskList);
        var Listtasktemp = [];
        var listTask = listrecord[indexs[0]].taskList;
        if (listTask != undefined) {
            for (var x = 0; x < listTask.length; x++) {
                var userInfo = helper.userInfo(component, listTask[x].User_Info__r.Id);
                var newInst = {
                    "Subject": listTask[x].Subject,
                    "Status": listTask[x].Status,
                    "Priority": listTask[x].Priority,
                    "ActivityDate": listTask[x].ActivityDate,
                    "Description": listTask[x].Description,
                    "UserName": userInfo[0].label
                };
                Listtasktemp.push(newInst);
            }
            component.set('v.taskListValues', Listtasktemp);
        } else {
            component.set('v.taskListValues', []);
        }
        if (listrecord[indexs[0]].actualStartDate != undefined) {
            var actualStartDate = new Date(listrecord[indexs[0]].actualStartDate);
            component.set('v.actualStartDate', listrecord[indexs[0]].actualStartDate);
        } else {
            var date = new Date();
            component.set('v.actualStartDate', null);
        }
        if (listrecord[indexs[0]].actualEndDate != undefined) {
            var actualEndDate = new Date(listrecord[indexs[0]].actualEndDate);
            component.set('v.actualEndDate', listrecord[indexs[0]].actualEndDate);
        } else {
            var date1 = new Date();
            component.set('v.actualEndDate', null);
        }
        if (listrecord[indexs[0]].actualLeadTime != undefined) {
            var actualLeadTime = listrecord[indexs[0]].actualLeadTime;
            component.set('v.actualLeadTime', actualLeadTime);
        } else {
            component.set('v.actualLeadTime', '');
        }
        var selectedSkinnCollectionValue = component.get('v.selectedSkinnCollectionValue');
        var collectionId = selectedSkinnCollectionValue.split(',')[0];
        var tentativeLaunchDate = selectedSkinnCollectionValue.split(',')[3];
        var collectionReference = selectedSkinnCollectionValue.split(',')[4];
        component.set('v.collectionReference', collectionReference);
        component.set('v.tentativeLaunchPlan', tentativeLaunchDate);
        component.set('v.selectedCollectionTemplateId', listrecord[indexs[0]].selectedCollectionTemplateId);
        component.set('v.approvalCount', listrecord[indexs[0]].approvalCount);
        component.set('v.IsRevisionInPro', listrecord[indexs[0]].IsRevisionInPro);
        component.set('v.r1Approval', listrecord[indexs[0]].r1Approval);
        component.set('v.r2Approval', listrecord[indexs[0]].r2Approval);
        component.set('v.r3Approval', listrecord[indexs[0]].r3Approval);
        component.set('v.r4Approval', listrecord[indexs[0]].r4Approval);
        component.set('v.r5Approval', listrecord[indexs[0]].r5Approval);
        var stageOrActivityId = listrecord[indexs[0]].stageActivityName;
        var stageActName = listrecord[indexs[0]].stageActivityName;
        if (listrecord[indexs[0]].parentName != undefined)
            var parentStageActivityName = listrecord[indexs[0]].parentName;
        if (parentStageActivityName != undefined) {
            var stageActivitylevelDisplay = parentStageActivityName + '->' + stageActName;
        } else {
            stageActivitylevelDisplay = stageActName;
        }
        var levelHirec = listrecord[indexs[0]].levelHierarchy.split('->');
        var stageActivityLevel = '';
        for (var x = levelHirec.length - 1; x > 0; x--) {
            if (levelHirec[x] != 'null')
                stageActivityLevel += levelHirec[x] + ' -> ';
        }
        stageActivityLevel += stageActName;
        component.set('v.stageActivitylevelDisplay', stageActivityLevel.split('->'));
        component.set('v.skinnStageId', listrecord[indexs[0]].skinnStageId);
        component.set('v.AttachmentList', listrecord[indexs[0]].attachmentList);
        component.set('v.stageType', listrecord[indexs[0]].type);

        if (component.get('v.toggleNote')) {
            component.set('v.toggleNote', false);
            component.set('v.noteTitle', "");
            component.set('v.noteBody', "");
        }
        component.set('v.IsSaveButtonClick', false);
        component.set('v.commentsRemarks', listrecord[indexs[0]].commentRemark);
        component.set('v.ownerOfRecord', listrecord[indexs[0]].ownerName);
        component.set('v.isStageActive', listrecord[indexs[0]].isStepActive);
        //  component.set("v.Spinner", false);
        helper.successorInfo(component, event, helper);
        if (component.get('v.stageType') == 'Stage' || component.get('v.stageType') == 'Sub-Stage' || component.get('v.status') == 'Completed' || component.get('v.status') == 'In Progress') {

            component.set('v.actualStartDateDisable', true);
        } else {
            component.set('v.actualStartDateDisable', false);
        }
        if (component.get('v.stageType') == 'Stage' || component.get('v.stageType') == 'Sub-Stage' || component.get('v.status') == 'Completed') {
            component.set('v.disabeActualEnd', true);
        } else {
            component.set('v.disabeActualEnd', false);
        }
        component.set('v.revisionStatusValue', listrecord[indexs[0]].revisionStatus);

        component.set('v.r1StartDate', listrecord[indexs[0]].R1StartDate);
        component.set('v.r1EndDate', listrecord[indexs[0]].R1EndtDate);
        component.set('v.r2StartDate', listrecord[indexs[0]].R2StartDate);
        component.set('v.r2EndDate', listrecord[indexs[0]].R2EndtDate);
        component.set('v.r3StartDate', listrecord[indexs[0]].R3StartDate);
        component.set('v.r3EndDate', listrecord[indexs[0]].R3EndtDate);
        component.set('v.r4StartDate', listrecord[indexs[0]].R4StartDate);
        component.set('v.r4EndDate', listrecord[indexs[0]].R4EndtDate);
        component.set('v.r5StartDate', listrecord[indexs[0]].R5StartDate);
        component.set('v.r5EndDate', listrecord[indexs[0]].R5EndtDate);
        component.set('v.R1Status', listrecord[indexs[0]].R1Status);
        component.set('v.R2Status', listrecord[indexs[0]].R2Status);
        component.set('v.R3Status', listrecord[indexs[0]].R3Status);
        component.set('v.R4Status', listrecord[indexs[0]].R4Status);
        component.set('v.R5Status', listrecord[indexs[0]].R5Status);
        helper.onchangeRevisionPickList(component, event, helper);
        component.set('v.submitforApproval', listrecord[indexs[0]].approvalRequired);
        component.set('v.isRecordLock', listrecord[indexs[0]].isRecordLock);
        component.set('v.approvalStatus', listrecord[indexs[0]].approStatus);
        component.set('v.approvalHistory', listrecord[indexs[0]].processHitry);
    },
    saveDataForm: function (component, event, helper) {
        var listrecord = component.get('v.stageActList');
        var stageInfo = component.get('v.cuurentStageINformation');
        if (stageInfo.Approval_Required__c && component.get('v.stageType') != 'Stage' && (stageInfo.Approval_Status__c == undefined || stageInfo.Approval_Status__c == "Rejected" || stageInfo.Approval_Status__c == "Submit for approval")) {
            if (stageInfo.Approval_Status__c == undefined && component.get('v.stageType') == 'Stage') {
                helper.showTost(component, event, helper, "information", "Please Submit Record for Approval!");
            } else if (stageInfo.Approval_Status__c == undefined && (component.get('v.stageType') == 'Sub-Stage') || component.get('v.stageType') == 'Activity') {
                helper.showTost(component, event, helper, "information", "You can't start activity! Wait for Stage Approval!");
            } else if (stageInfo.Approval_Status__c == "Submit for approval") {
                helper.showTost(component, event, helper, "information", "Wait for Stage Approval!");
            } else if (stageInfo.Approval_Status__c == "Rejected" && component.get('v.stageType') == 'Stage') {
                helper.showTost(component, event, helper, "error", "Record is Rejected Please re-submit record for approval!");
            }
        } else {
            if ((component.get('v.approvalStatus') == 'None' || component.get('v.approvalStatus') == undefined) && component.get('v.submitforApproval') && component.get('v.status') == 'In Progress') {

                helper.updateInputForm(component, event, helper, listrecord);
                helper.showTost(component, event, helper, "error", "First submit record for approval!");

            } else {
                if (component.get('v.approvalStatus') == 'Rejected') {
                    helper.updateInputForm(component, event, helper, listrecord);
                    helper.showTost(component, event, helper, "error", "Record is Rejected please re-submit!");
                } else {
                    if (!component.get('v.isRecordLock') || component.get('v.approvalStatus') == 'Approved') {
                        if (component.get('v.isStageActive')) {
                            if (helper.checkIsRevision(component, event, helper)) {
                                helper.saveMethod(component, event, helper);
                            } else {
                                helper.updateInputForm(component, event, helper, listrecord);
                            }
                        } else {
                            helper.showTost(component, event, helper, "warring", "Stage is not active!");
                        }
                    } else {
                        helper.updateInputForm(component, event, helper, listrecord);
                        helper.showTost(component, event, helper, "information", "Wait for approval!");
                    }
                }
            }
        }
    },
    editForm: function (component) {
        component.set('v.readOnly', false);
    },
    cancelForm: function (component) {
        component.set('v.readOnly', true);
    },
    onchangeActualDate: function (component, event, helper) {
        if (component.get('v.actualStartDate') != undefined && component.get('v.actualStartDate') != '') {
            var actiualStaDate = component.get('v.actualStartDate');
            var todayDate = new Date();
            var userInsertedDate = new Date(actiualStaDate);
            if (userInsertedDate > todayDate) {
                helper.showTost(component, event, helper, 'warring', 'Actual Start Date should be Today Date!!');
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                component.set('v.actualStartDate', todayform);
            }
        }
    },
    onchangeActualLeadTime: function (component, event, helper) {
        if (component.get('v.actualLeadTime') > 0) {
            if (component.get('v.actualStartDate') != undefined && component.get('v.actualStartDate') != '') {
                var actualStartDate = new Date(component.get('v.actualStartDate'));
                if (component.get('v.actualLeadTime') != undefined && component.get('v.actualLeadTime') != "") {
                    actualStartDate.setDate(actualStartDate.getDate() + parseInt(component.get('v.actualLeadTime')));
                    var actualEndDateform = parseInt(actualStartDate.toDateString().split(' ')[2]).toString() + ' ' + actualStartDate.toDateString().split(' ')[1] + ', ' + actualStartDate.toDateString().split(' ')[3];
                    component.set('v.actualEndDate', actualEndDateform);
                }
            }
        } else {
            component.set('v.actualLeadTime', 1);
        }

    },
    // this function automatic call by aura:waiting event  
    showSpinner: function (component, event, helper) {
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true);
    },

    // this function automatic call by aura:doneWaiting event 
    hideSpinner: function (component, event, helper) {
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
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
        var date = '{}';
        component.set('v.attachmentObject', undefined);
    },
    allNoteMethod: function (component, event, helper) {
        component.set('v.toggleNote', true);
    },
    cancelNote: function (component, event, helper) {
        component.set('v.toggleNote', false);
        component.set('v.noteTitle', "");
        component.set('v.noteBody', "");
    },
    saveAttachment: function (component, event, helper) {
        component.set("v.Spinner", true);
        helper.saveAttachmentHelperMethod(component, event, helper);
    },
    deactivateMathod: function (component, event, helper) {
        if (component.get('v.status') == "Not Started") {
            var selectedSkinnCollectionValue = component.get("v.selectedSkinnCollectionValue");
            var collectionId = selectedSkinnCollectionValue.split(',')[0];
            if (component.get('v.marketingValue') == 'MarketingStage') {
                var templateId = selectedSkinnCollectionValue.split(',')[1];
            } else {
                var templateId = selectedSkinnCollectionValue.split(',')[2];
            }
            var collectionTempI = component.get('v.selectedCollectionTemplateId');
            if (confirm("Are you sure?")) {
                var action = component.get('c.deactivateCollectionTemp');
                action.setParams({
                    "collTempId": collectionTempI,
                    "skinnCollTempId": collectionId,
                    "templateId": templateId,
                    "userId": component.get('v.selectedOwnerVal'),
                    "modelId": component.get('v.selectedModelId')
                });
                action.setCallback(this, function (response) {
                    if (response.getState() == "SUCCESS") {
                        var result = response.getReturnValue();
                        component.set('v.stageActList', result);
                        helper.updateInputForm(component, event, helper, result);
                    } else {
                        helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                        var listRecord = component.get("v.stageActList");
                        if (listRecord != undefined)
                            helper.updateInputForm(component, event, helper, listRecord);
                        component.set("v.Spinner", false);
                    }
                });
                $A.enqueueAction(action);
            }
        } else {
            helper.showTost(component, event, helper, 'warring', "You Can't Deactivate this Activity! If Status is In Progress or Completed");
        }

    },
    QwnerPikChange: function (component, event, helper) {},
    activateMathod: function (component, event, helper) {
        helper.showTost(component, event, helper, 'warring', 'Contact to your admin');
    },

    setRevisionValue: function (component, event, helper) {
        helper.onchangeRevisionPickList(component, event, helper);
    },
    addTaskMethod: function (component, event, helper) {
        component.set('v.toggleTask', true);
    },
    cancelTaskMethod: function (component, event, helper) {
        component.set('v.toggleTask', false);
    },
    saveTaskMethod: function (component, event, helper) {
        var contactFields = component.find("validationTask");
        var blank = 0;
        if (contactFields.length != undefined) {
            var allValid = contactFields.reduce(function (validSoFar, inputCmp) {
                inputCmp.showHelpMessageIfInvalid();
                return validSoFar && inputCmp.get('v.validity').valid;
            }, true);
            if (!allValid) {
                blank++;
            }
        } else {
            var allValid = contactFields;
            allValid.showHelpMessageIfInvalid();
            if (!allValid.get('v.validity').valid) {
                blank++;
            }
        }
        let currentstatusValue = component.get("v.status");
        if (blank == 0 && (currentstatusValue == "Completed" || currentstatusValue == "In Progress")) {
            debugger;
            component.set('v.toggleTask', false);

            helper.saveTask(component, event, helper);
        } else {
            if (currentstatusValue == "Not Started") {
                helper.showTost(component, event, helper, "warring", "Activity Status Is Not Started!!");
            }
        }
    },
    toggleTasksubjectMethod: function (component) {
        component.set("v.toggleTaskSubject", true);
    },
    cancelTaskSubjectMethod: function (component) {
        component.set("v.toggleTaskSubject", false);
    },
    selectedSubjectTaskMethod: function (component, event, helper) {
        debugger;
        var clickId = event.currentTarget.id;
        component.set("v.subjectTask", document.getElementById(clickId).value);
        component.set("v.toggleTaskSubject", false);
    },
    SuccessorInfoMethod: function (component, event, helper) {
        component.set('v.toggleTaskSuccessorInfo', true);
    },
    successorInfoCloseMethod: function (component, event, helper) {
        component.set('v.toggleTaskSuccessorInfo', false);
    },
    saveNoteMethod: function (component, event, helper) {
        let fieldValid = component.find("finalValidation");
        if (fieldValid == undefined || fieldValid.get('v.validity').valid) {
            component.set('v.toggleNote', false);
            helper.saveNoteMethod(component, event, helper);
        } else {
            fieldValid.showHelpMessageIfInvalid();
        }
    },
    actualEndDateOnchangeMethod: function (component, event, helper) {
        var valiActualDateS = new Date(component.get('v.actualStartDate'));
        var valiActualEndD = new Date(component.get('v.actualEndDate'));
        if (valiActualDateS < valiActualEndD) {
            let todayform = helper.formatDate(valiActualEndD.toDateString());
            component.set('v.actualEndDate', todayform);
        } else if (valiActualDateS > valiActualEndD) {
            let todayform = helper.formatDate(valiActualDateS.toDateString());
            component.set('v.actualEndDate', todayform);
        }
        let today = new Date();
        if (valiActualEndD > today) {
            let todayform = helper.formatDate(today.toDateString());
            component.set('v.actualEndDate', todayform);
            helper.showTost(component, event, helper, 'warring', 'Actual End Date should be Today Date!!');
        }
    },
    validateRevistionDatesStartDateOnchangeMethod: function (component, event, helper) {

        helper.validateRevistionStartDatesHelperMethod(component, event, helper, component.find("r1StartDateId"), "R1S");
        helper.validateRevistionStartDatesHelperMethod(component, event, helper, component.find("r2StartDateId"), "R2S");
        helper.validateRevistionStartDatesHelperMethod(component, event, helper, component.find("r3StartDateId"), "R3S");
        helper.validateRevistionStartDatesHelperMethod(component, event, helper, component.find("r4StartDateId"), "R4S");
        helper.validateRevistionStartDatesHelperMethod(component, event, helper, component.find("r5StartDateId"), "R5S");
    },
    validateRevistionDatesEndDateOnchangeMethod: function (component, event, helper) {
        helper.validateRevistionEndDatesHelperMethod(component, event, helper, component.find("r1EndDateId"), "R1E");
        helper.validateRevistionEndDatesHelperMethod(component, event, helper, component.find("r2EndDateId"), "R2E");
        helper.validateRevistionEndDatesHelperMethod(component, event, helper, component.find("r3EndDateId"), "R3E");
        helper.validateRevistionEndDatesHelperMethod(component, event, helper, component.find("r4EndDateId"), "R4E");
        helper.validateRevistionEndDatesHelperMethod(component, event, helper, component.find("r5EndDateId"), "R5E");
    },
    submitForAppMethod: function (component, event, helper) {
        if (component.get('v.submitforApproval'))
            component.set("v.Spinner", true);
        helper.submitForAppMethodHelperCall(component, event, helper);
    },
    RecordIsLoadMethod: function (component, event, helper) {
        helper.showTost(component, event, helper, "warring", "Record is Locked");
    },
    showApproHistMethod: function (component, event, helper) {
        component.set('v.showApprovalHistoryCmp', true);
    },
    cancelHistyryMethod: function (component, event, helper) {
        component.set('v.showApprovalHistoryCmp', false);
    },
    createRecord: function (component, event, helper) {
        var clickId = event.currentTarget.id;
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": "" + clickId,
            "slideDevName": "detail"
        });
        navEvt.fire();
    }
})