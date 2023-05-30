({
    helperMethod: function () {

    },
    updateInputForm: function (component, event, helper, listrecord) {
        var index = component.get('v.selectedFormIndex');
        component.set('v.status', listrecord[parseInt(index)].stageStatus);
        var planStartDate = new Date(listrecord[parseInt(index)].plannedStartDate);
        component.set('v.planStartDate', parseInt(planStartDate.toDateString().split(' ')[2]).toString() + ' ' + planStartDate.toDateString().split(' ')[1] + ', ' + planStartDate.toDateString().split(' ')[3]);
        var planEndDate = new Date(listrecord[parseInt(index)].plannedEndDate);
        component.set('v.planEndDate', parseInt(planEndDate.toDateString().split(' ')[2]).toString() + ' ' + planEndDate.toDateString().split(' ')[1] + ', ' + planEndDate.toDateString().split(' ')[3]);
        
        var rollingStartDate = new Date(listrecord[parseInt(index)].rollingStartDate);
        component.set('v.rollingStartDate', parseInt(rollingStartDate.toDateString().split(' ')[2]).toString() + ' ' + rollingStartDate.toDateString().split(' ')[1] + ', ' + rollingStartDate.toDateString().split(' ')[3]);
        var rollingEndDate = new Date(listrecord[parseInt(index)].rollingEndDate);
        component.set('v.rollingEndDate', parseInt(rollingEndDate.toDateString().split(' ')[2]).toString() + ' ' + rollingEndDate.toDateString().split(' ')[1] + ', ' + rollingEndDate.toDateString().split(' ')[3]);
       
        var productLaunchDate = new Date(listrecord[parseInt(index)].productLaunchDate);
        component.set('v.productLaunchDate',parseInt(productLaunchDate.toDateString().split(' ')[2]).toString() + ' ' + productLaunchDate.toDateString().split(' ')[1] + ', ' + productLaunchDate.toDateString().split(' ')[3]);
        
        component.set('v.plannedLeadTime', listrecord[parseInt(index)].plannedLeadTime);
        helper.checkIsRecordHasPlannStartDate(component, event, helper, listrecord[parseInt(index)].plannedLeadTime, parseInt(index), listrecord);
        var planStartDate = new Date(listrecord[index].plannedStartDate);
        component.set('v.planStartDate', parseInt(planStartDate.toDateString().split(' ')[2]).toString() + ' ' + planStartDate.toDateString().split(' ')[1] + ', ' + planStartDate.toDateString().split(' ')[3]);
        var planEndDate = new Date(listrecord[index].plannedEndDate);
        component.set('v.planEndDate', parseInt(planEndDate.toDateString().split(' ')[2]).toString() + ' ' + planEndDate.toDateString().split(' ')[1] + ', ' + planEndDate.toDateString().split(' ')[3]);
        
        var Listtasktemp = [];
        var listTask = listrecord[parseInt(index)].taskList;
        if (listTask != undefined) {
            for (var x = 0; x < listTask.length; x++) {
                var userInfo = helper.userInfo(component, listTask[x].User_Info__r.Id);
                var newInst = { "Subject": listTask[x].Subject, "Status": listTask[x].Status, "Priority": listTask[x].Priority, "ActivityDate": listTask[x].ActivityDate, "Description": listTask[x].Description, "UserName": userInfo[0].label };
                Listtasktemp.push(newInst);
            }
            component.set('v.taskListValues', Listtasktemp);
        } else {
            component.set('v.taskListValues', []);
        }
        if (listrecord[parseInt(index)].actualStartDate != undefined) {
            var actualStartDate = new Date(listrecord[parseInt(index)].actualStartDate);
            component.set('v.actualStartDate', listrecord[parseInt(index)].actualStartDate);
        } else {
            var date = new Date();
            component.set('v.actualStartDate', null);
        }
        if (listrecord[parseInt(index)].actualEndDate != undefined) {
            var actualEndDate = new Date(listrecord[parseInt(index)].actualEndDate);
            component.set('v.actualEndDate', listrecord[parseInt(index)].actualEndDate);
        } else {
            var date1 = new Date();
            component.set('v.actualEndDate', null);
        }
        if (listrecord[parseInt(index)].actualLeadTime != undefined) {
            var actualLeadTime = listrecord[parseInt(index)].actualLeadTime;
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
        component.set('v.selectedCollectionTemplateId', listrecord[parseInt(index)].selectedCollectionTemplateId);
        component.set('v.IsRevisionInPro',listrecord[parseInt(index)].IsRevisionInPro);
        component.set('v.approvalCount',listrecord[parseInt(index)].approvalCount);
        component.set('v.r1Approval',listrecord[parseInt(index)].r1Approval);
        component.set('v.r2Approval',listrecord[parseInt(index)].r2Approval);
        component.set('v.r3Approval',listrecord[parseInt(index)].r3Approval);
        component.set('v.r4Approval',listrecord[parseInt(index)].r4Approval);
        component.set('v.r5Approval',listrecord[parseInt(index)].r5Approval);
        var stageOrActivityId = listrecord[parseInt(index)].stageActivityName;
        var stageActName = listrecord[parseInt(index)].stageActivityName;
        if (listrecord[parseInt(index)].parentName != undefined)
            var parentStageActivityName = listrecord[parseInt(index)].parentName;
        if (parentStageActivityName != undefined) {
            var stageActivitylevelDisplay = parentStageActivityName + '->' + stageActName;
        } else {
            stageActivitylevelDisplay = stageActName;
        }
        var levelHirec = listrecord[parseInt(index)].levelHierarchy.split('->');
        var stageActivityLevel = '';
        for (var x = levelHirec.length - 1; x > 0; x--) {
            if (levelHirec[x] != 'null')
                stageActivityLevel += levelHirec[x] + ' -> ';
        }
        stageActivityLevel += stageActName;
        component.set('v.stageActivitylevelDisplay', stageActivityLevel.split('->'));
        component.set('v.skinnStageId', listrecord[parseInt(index)].skinnStageId);
        component.set('v.AttachmentList', listrecord[parseInt(index)].attachmentList);
        component.set('v.listNotes', listrecord[parseInt(index)].listNotes);
        component.set('v.stageType', listrecord[parseInt(index)].type);
        if (component.get('v.toggleNote')) {
            component.set('v.toggleNote', false);
            component.set('v.noteTitle', "");
            component.set('v.noteBody', "");
        }
        component.set('v.commentsRemarks', listrecord[parseInt(index)].commentRemark);
        component.set('v.ownerOfRecord', listrecord[parseInt(index)].ownerName);
        component.set('v.isStageActive', listrecord[parseInt(index)].isStepActive);
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
        var ishas = component.get('v.isHasActivity');
        if (ishas && component.get('v.stageType') == 'Sub-Stage' && component.get('v.status') == 'Not Started') {
            component.set('v.actualStartDateDisable', false);
        } else if (component.get('v.stageType') == 'Sub-Stage') {
            component.set('v.actualStartDateDisable', true);
        }
        if (ishas && component.get('v.stageType') == 'Sub-Stage' && (component.get('v.status') == 'Not Started' || component.get('v.status') == 'In Progress')) {
            component.set('v.disabeActualEnd', false);
        } else if (component.get('v.stageType') == 'Sub-Stage') {
            component.set('v.disabeActualEnd', true);
        }
        component.set('v.revisionStatusValue', listrecord[parseInt(index)].revisionStatus);

        component.set('v.r1StartDate', listrecord[parseInt(index)].R1StartDate);
        component.set('v.r1EndDate', listrecord[parseInt(index)].R1EndtDate);
        component.set('v.r2StartDate', listrecord[parseInt(index)].R2StartDate);
        component.set('v.r2EndDate', listrecord[parseInt(index)].R2EndtDate);
        component.set('v.r3StartDate', listrecord[parseInt(index)].R3StartDate);
        component.set('v.r3EndDate', listrecord[parseInt(index)].R3EndtDate);
        component.set('v.r4StartDate', listrecord[parseInt(index)].R4StartDate);
        component.set('v.r4EndDate', listrecord[parseInt(index)].R4EndtDate);
        component.set('v.r5StartDate', listrecord[parseInt(index)].R5StartDate);
        component.set('v.r5EndDate', listrecord[parseInt(index)].R5EndtDate);
        component.set('v.R1Status', listrecord[parseInt(index)].R1Status);
        component.set('v.R2Status', listrecord[parseInt(index)].R2Status);
        component.set('v.R3Status', listrecord[parseInt(index)].R3Status);
        component.set('v.R4Status', listrecord[parseInt(index)].R4Status);
        component.set('v.R5Status', listrecord[parseInt(index)].R5Status);
        helper.onchangeRevisionPickList(component, event, helper);
        component.set('v.submitforApproval', listrecord[parseInt(index)].approvalRequired);
        component.set('v.isRecordLock', listrecord[parseInt(index)].isRecordLock);
        component.set('v.approvalStatus', listrecord[parseInt(index)].approStatus);
        component.set('v.approvalHistory', listrecord[parseInt(index)].processHitry);
    },
    formatDate: function (date) {
        if (date == undefined || date == '') {
            return null;
        }
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    },
    upload: function (component, file, base64Data, callback) {
        var action = component.get("c.uploadFile");
        console.log('type: ' + file.type);
        action.setParams({
            fileName: file.name,
            base64Data: base64Data,
            contentType: file.type
        });
        action.setCallback(this, function (a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                callback(a.getReturnValue());
            }else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);
    },
    showTost: function (component, event, helper, VariantName, Message) {
        if (VariantName == "warring")
            helper.warringTMsg(component, event, helper, Message);
        if (VariantName == "error")
            helper.errorTMsg(component, event, helper, Message);
        if (VariantName == "information")
            helper.informationTMsg(component, event, helper, Message);
        if (VariantName == "success")
            helper.successTMsg(component, event, helper, Message);
    },
    warringTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Warning!",
            "type": "warning",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    errorTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "type": "error",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    informationTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Information!",
            "type": "info",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    successTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "type": "success",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    saveMethod: function (component, event, helper) {
        component.set("v.Spinner", true);
        // alert('' + component.get('v.stageActName'));
        var selectedSkinnCollectionValue = component.get("v.selectedSkinnCollectionValue");
        var collectionId = selectedSkinnCollectionValue.split(',')[0];
        if (component.get('v.marketingValue') == 'MarketingStage') {
            var templateId = selectedSkinnCollectionValue.split(',')[1];
        } else {
            var templateId = selectedSkinnCollectionValue.split(',')[2];
        }
        var noteObject = {
            'noteTile': component.get('v.noteTitle'),
            'noteBody': component.get('v.noteBody')
        };
        var dataToBeSaved = {
            'sObject': 'Skinn_Collection_Template__c',
            'Id': component.get('v.skinnStageId'),
            'Skinn_Model__c': component.get('v.selectedModelId'),
            'Skinn_NPD_Template_Item__c' : component.get('v.skinnNPDTemplateItemId'),
            'Skinn_Collection__c' : collectionId,
            'Actual_start_date__c': helper.formatDate(component.get('v.actualStartDate')),
            'Actual_Lead_Time__c': component.get('v.actualLeadTime'),
            'Actual_End_date__c': helper.formatDate(component.get('v.actualEndDate')),
            'planned_Start_Date__c': helper.formatDate(component.get('v.planStartDate')),
            'planned_End_Date__c': helper.formatDate(component.get('v.planEndDate')),
            'planned_Lead_Time__c': component.get('v.plannedLeadTime'),
            'Status__c': component.get('v.status'),
            'Comments_Remarks__c': component.get('v.commentsRemarks'),
            'R1_Start_Date__c': component.get('v.r1StartDate'),
            'R1_End_Date__c': component.get('v.r1EndDate'),
            'R2_Start_Date__c': component.get('v.r2StartDate'),
            'R2_End_Date__c': component.get('v.r2EndDate'),
            'R3_Start_Date__c': component.get('v.r3StartDate'),
            'R3_End_Date__c': component.get('v.r3EndDate'),
            'R4_Start_Date__c': component.get('v.r4StartDate'),
            'R4_End_Date__c': component.get('v.r4EndDate'),
            'R5_Start_Date__c': component.get('v.r5StartDate'),
            'R5_End_Date__c': component.get('v.r5EndDate'),
            'Type__c' : component.get('v.skinnCollectionRecordType'),
            'Skinn_NPD_Template_Item__r.Parent_Id__r.Id' : component.get('v.skinnItemParentId'),
            'Rolling_Planned_Start_Date__c': helper.formatDate(component.get('v.rollingStartDate')),
            'Rolling_Planned_End_Date__c': helper.formatDate(component.get('v.rollingEndDate')),
            'Revision_status__c': component.get('v.revisionStatusValue')
        };
        let JsonStringList = [];
        JsonStringList.push(JSON.stringify(dataToBeSaved));
        JsonStringList.push(JSON.stringify(component.get('v.attachmentObject')));
        JsonStringList.push(JSON.stringify(noteObject));
        var action = component.get('c.saveStageActRecord');
        action.setParams({
            'JsonStringList': JsonStringList,
            'collectionId': collectionId,
            'templateId': templateId,
            "userId": component.get('v.selectedOwnerVal')
        });
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.Spinner", false);
                //component.set('v.stageActList', result);
                // alert('Save');
                component.set('v.attachmentObject', undefined);
                // if (result.length > 1) {
                //    helper.updateInputForm(component, event, helper, result);
                //} else {
                //component.set("v.toggleMod", false);
                var listRecord = [];
                if (result[0].valideUser == false) {
                    helper.showTost(component, event, helper, 'error', result[0].errorMessage);
                    for (var i = 1; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                } else {
                    for (var i = 0; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                }
                // helper.updateInputForm(component, event, helper, result.filter((n)=>{return n.valideUser!=ture}) );
                // }
                // component.set("v.Spinner", false);
                if (component.get('v.toggleNote')) {
                    component.set('v.toggleNote', false);
                    component.set('v.noteTitle', "");
                    component.set('v.noteBody', "");
                }
            }else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);
    },
    checkHasNote: function (toggleNote, noteTitle, noteBody) {
        if (!toggleNote) {
            return true;
        }
        if (noteTitle == undefined || noteTitle == "") {
            return false;
        }
    },
    getAllPickList: function (component, event, helper) {
        var action = component.get("c.getNameValues");
        action.setCallback(this, function (response) {
            if(response.getState()==="SUCCESS"){
                var list = response.getReturnValue();
                component.set("v.PickListValues", list.collectionNameList);
                component.set("v.TypePickListVal", list.collectionSelectTypeList);
                component.set("v.OwnerPickListVal", list.masterOwnerList);
                component.set("v.statusTaskPickList", list.statusTaskPickList);
                component.set("v.subjectTaskPickList", list.subjectTaskPickList);
                component.set("v.priorityToTaskPickList", list.priorityToTaskPickList);
                component.set("v.revisionActivation", list.revisionActivationPickListVal);
                component.set("v.listTaskUser", list.taskUserList);
            }else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }
            
        });
        $A.enqueueAction(action);
    },
    showListMethod: function (component, event, helper, templateId, collectionId, skinnModelId) {
        var action = component.get("c.fetchMSStageItems");
        action.setParams({
            "selectedCollectionId": collectionId,
            "templateId": templateId,
            "userId": component.get('v.selectedOwnerVal'),
            "modelId": component.get('v.selectedModelId')
        });
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                debugger;
                component.set("v.Spinner", false);
                // component.set("v.Spinner", false);
                //alert('-------result-----'+result);
                component.set("v.stageActList", result);

            }else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);
    },
    checkUndefiend: function (checkVar) {
        if (checkVar == undefined || checkVar == "") {
            return "";
        } else {
            return checkVar;
        }
    },
    userInfo: function (component, compValue) {
        var ownerList = component.get("v.listTaskUser");
        var userName = ownerList.filter((n) => { return n.value == compValue });
        return userName;
    },
    successorInfo: function (component, event, helper) {
        //  successorRelatedTo
        //  successorName
        //  successorEmail
        var selectedSkinnCollectionValue = component.get('v.selectedSkinnCollectionValue');
        var collectionId = selectedSkinnCollectionValue.split(',')[0];
        var action = component.get('c.successorInfoMethod');
        action.setParams({
            "currentRecordId": component.get('v.selectedCollectionTemplateId'),
            "collectionId": collectionId
        });
        action.setCallback(this, (response) => {
            if (response.getState() == "SUCCESS") {
                component.set("v.Spinner", false);
                var result = response.getReturnValue();
                component.set('v.cuurentStageINformation', result.stageInformation);
                component.set('v.successorRelatedTo', result.successorRelatedTo);
                component.set('v.successorName', result.successorName);
                component.set('v.successorEmail', result.successorEmail);
                if (result.successorName == 'NULL') {
                    component.set('v.isHasActivity', true);
                } else {
                    component.set('v.isHasActivity', false);
                }
                if (result.successorName == 'NULL' && component.get('v.stageType') == 'Sub-Stage' && component.get('v.status') == 'Not Started') {
                    component.set('v.actualStartDateDisable', false);
                } else if (component.get('v.stageType') == 'Sub-Stage') {
                    component.set('v.actualStartDateDisable', true);
                }
                if (result.successorName == 'NULL' && component.get('v.stageType') == 'Sub-Stage' && (component.get('v.status') == 'Not Started' || component.get('v.status') == 'In Progress')) {
                    component.set('v.disabeActualEnd', false);
                } else if (component.get('v.stageType') == 'Sub-Stage') {
                    component.set('v.disabeActualEnd', true);
                }

            }else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }

        });
        $A.enqueueAction(action);
    },
    saveTask: function (component, event, helper) {
        var userInfo = helper.userInfo(component, component.get('v.assignNameTask'));
        var newAddRaw = { "subjectTask": "" + helper.checkUndefiend(component.get('v.subjectTask')), "statusTask": "" + helper.checkUndefiend(component.get('v.statusTask')), "priorityToTask": "" + helper.checkUndefiend(component.get('v.priorityToTask')), "assignNameTask": "" + userInfo[0].label, "assignNameTaskUserId": userInfo[0].value, "activityDateTask": "" + helper.checkUndefiend(component.get('v.activityDateTask')), "commentTask": "" + helper.checkUndefiend(component.get('v.commentTask')) };
        //var listtask = component.get('v.listTask');
        //listtask.push(newAddRaw);
        component.set("v.Spinner", true);
        let skinnStageId = component.get('v.skinnStageId');
        let taskJSON = {
            "sObject": "Task",
            "WhatId": skinnStageId,
            "Subject": newAddRaw.subjectTask,
            "Status": newAddRaw.statusTask,
            "Priority": newAddRaw.priorityToTask,
            "User_Info__c": newAddRaw.assignNameTaskUserId,
            "ActivityDate": newAddRaw.activityDateTask,
            "Description": newAddRaw.commentTask
        };
        var action = component.get('c.addTaskMethodCall');
        action.setParams({
            "taskJSON": taskJSON
        });
        /* action.setCallback(this,(response)=>{
            if(response.getState()=="SUCCESS"){
             component.set("v.Spinner", false);
             let result=response.getReturnValue();
             alert(''+result);
             component.set('v.listTask', listtask);
             component.set('v.toggleTask', false);
             component.set('v.subjectTask', "");
             component.set('v.statusTask', "");
             component.set('v.priorityToTask', "");
             component.set('v.assignNameTask', "");
             component.set('v.activityDateTask', "");
             component.set('v.commentTask', "");
                  }
 
             });*/
        action.setCallback(this, (response) => {
            if (response.getState() == "SUCCESS") {
                component.set("v.Spinner", false);
                var result = response.getReturnValue();
                var listRecord = [];
                if (result[0].valideUser == false) {
                    helper.showTost(component, event, helper, 'error', result[0].errorMessage);
                    for (var i = 1; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                    component.set('v.subjectTask', "");
                    component.set('v.statusTask', "");
                    component.set('v.priorityToTask', "");
                    component.set('v.assignNameTask', "");
                    component.set('v.activityDateTask', "");
                    component.set('v.commentTask', "");
                } else {
                    for (var i = 0; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                }
                component.set('v.attachmentObject', undefined);
                component.set("v.Spinner", false);
            } else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }

        });
        $A.enqueueAction(action);
    },
    checkIsRecordHasPlannStartDate: function (component, event, helper, plnnedLeadTime, index, listrecord) {
        if (listrecord[index].plannedStartDate == undefined) {
            var todayDate = new Date();
            component.set('v.planStartDate', parseInt(todayDate.toDateString().split(' ')[2]).toString() + ' ' + todayDate.toDateString().split(' ')[1] + ', ' + todayDate.toDateString().split(' ')[3]);
            // var date=new Date();
            var plnlT = parseInt(plnnedLeadTime) - 1;
            var date = new Date(todayDate.getTime() + plnlT * 24 * 60 * 60 * 1000);
            component.set('v.planEndDate', parseInt(date.toDateString().split(' ')[2]).toString() + ' ' + date.toDateString().split(' ')[1] + ', ' + date.toDateString().split(' ')[3]);
        } else {
            var planStartDate = new Date(listrecord[index].plannedStartDate);
            component.set('v.planStartDate', parseInt(planStartDate.toDateString().split(' ')[2]).toString() + ' ' + planStartDate.toDateString().split(' ')[1] + ', ' + planStartDate.toDateString().split(' ')[3]);
            var planEndDate = new Date(listrecord[index].plannedEndDate);
            component.set('v.planEndDate', parseInt(planEndDate.toDateString().split(' ')[2]).toString() + ' ' + planEndDate.toDateString().split(' ')[1] + ', ' + planEndDate.toDateString().split(' ')[3]);
        }

    },
    saveNoteMethod: function (component, event, helper) {
        let skinnStageId = component.get('v.skinnStageId');
        component.set("v.Spinner", true);
        let noteSobject = {
            "sObject": "Note",
            "ParentId": skinnStageId,
            "Body": component.get('v.noteBody'),
            "Title": component.get('v.noteTitle')
        };
        var action = component.get('c.addNoteMethod');
        action.setParams({
            "noteSObject": noteSobject
        });
        action.setCallback(this, (response) => {
            if (response.getState() == "SUCCESS") {
                component.set("v.Spinner", false);
                var result = response.getReturnValue();
                var listRecord = [];
                if (result[0].valideUser == false) {
                    helper.showTost(component, event, helper, 'error', result[0].errorMessage);
                    for (var i = 1; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                } else {
                    for (var i = 0; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                }
                component.set('v.attachmentObject', undefined);
                component.set("v.Spinner", false);
            }else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);
    },
    onchangeRevisionPickList: function (component, event, helper) {
        var revisionActivationVal = component.get("v.revisionStatusValue");
        if (revisionActivationVal == undefined || revisionActivationVal == '') {
            component.set("v.activateR5", false);
            component.set("v.activateR1", false);
            component.set("v.activateR2", false);
            component.set("v.activateR3", false);
            component.set("v.activateR4", false);
        }
        if (revisionActivationVal == 'Activate R1') {
            component.set("v.activateR1", true);
            component.set("v.activateR2", false);
            component.set("v.activateR3", false);
            component.set("v.activateR4", false);
            component.set("v.activateR5", false);
        }
        if (revisionActivationVal == 'Activate R2' && component.get('v.R1Status') == 'Completed') {
            component.set("v.activateR2", true);
            component.set("v.activateR1", true);
            component.set("v.activateR3", false);
            component.set("v.activateR4", false);
            component.set("v.activateR5", false);
        } else if (revisionActivationVal == 'Activate R2') {
            helper.showTost(component, event, helper, "warring", "Complete R1 revision first!!");
            component.set('v.revisionStatusValue', "Activate R1");

        }
        if (revisionActivationVal == 'Activate R3' && component.get('v.R1Status') == 'Completed' && component.get('v.R2Status') == 'Completed') {
            component.set("v.activateR3", true);
            component.set("v.activateR1", true);
            component.set("v.activateR2", true);
            component.set("v.activateR4", false);
            component.set("v.activateR5", false);
        } else if (revisionActivationVal == 'Activate R3') {
            helper.showTost(component, event, helper, "warring", "Complete R2 revision first!!");
            component.set('v.revisionStatusValue', "Activate R2");

        }
        if (revisionActivationVal == 'Activate R4' && component.get('v.R1Status') == 'Completed' && component.get('v.R2Status') == 'Completed' && component.get('v.R3Status') == 'Completed') {
            component.set("v.activateR4", true);
            component.set("v.activateR1", true);
            component.set("v.activateR2", true);
            component.set("v.activateR3", true);
            component.set("v.activateR5", false);
        } else if (revisionActivationVal == 'Activate R4') {
            helper.showTost(component, event, helper, "warring", "Complete R3 revision first!!");
            component.set('v.revisionStatusValue', "Activate R3");

        }
        if (revisionActivationVal == 'Activate R5' && component.get('v.R1Status') == 'Completed' && component.get('v.R2Status') == 'Completed' && component.get('v.R3Status') == 'Completed' && component.get('v.R4Status') == 'Completed') {
            component.set("v.activateR5", true);
            component.set("v.activateR1", true);
            component.set("v.activateR2", true);
            component.set("v.activateR3", true);
            component.set("v.activateR4", true);
        } else if (revisionActivationVal == 'Activate R5') {
            helper.showTost(component, event, helper, "warring", "Complete R4 revision first!!");
            component.set('v.revisionStatusValue', "Activate R4");
        }


    },
    validateRevistionStartDatesHelperMethod: function (component, event, helper, value, revisionType) {
        if (value != undefined) {
            if (revisionType == "R1S") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.actualEndDate'));
                if (valiR1SValue <= valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
        if (value != undefined) {
            if (revisionType == "R2S") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r1EndDate'));
                if (valiR1SValue <= valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
        if (value != undefined) {
            if (revisionType == "R3S") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r2EndDate'));
                if (valiR1SValue <= valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
        if (value != undefined) {
            if (revisionType == "R4S") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r3EndDate'));
                if (valiR1SValue <= valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
        if (value != undefined) {
            if (revisionType == "R5S") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r4EndDate'));
                if (valiR1SValue <= valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
    },
    validateRevistionEndDatesHelperMethod: function (component, event, helper, value, revisionType) {
        if (value != undefined) {
            if (revisionType == "R1E") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r1StartDate'));
                if (valiR1SValue < valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
        if (value != undefined) {
            if (revisionType == "R2E") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r2StartDate'));
                if (valiR1SValue < valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
        if (value != undefined) {
            if (revisionType == "R3E") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r3StartDate'));
                if (valiR1SValue < valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
        if (value != undefined) {
            if (revisionType == "R4E") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r4StartDate'));
                if (valiR1SValue < valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
        if (value != undefined) {
            if (revisionType == "R5E") {
                var valiR1SValue = new Date(value.get("v.value"));
                var valiactualEndDate = new Date(component.get('v.r5StartDate'));
                if (valiR1SValue < valiactualEndDate) {
                    var valiDate = helper.formatDate(valiactualEndDate.toDateString());
                    value.set("v.value", valiDate);
                }
                var today = new Date();
                var todayform = helper.formatDate(today.toDateString());
                var valiR1SValue = new Date(value.get("v.value"));
                if (valiR1SValue >= today) {
                    value.set("v.value", todayform);
                }
            }
        }
    },
    submitForAppMethodHelperCall: function (component, event, helper) {
        var submitaction = component.get('c.submitForAppProcess');
        let recordId = component.get('v.skinnStageId');
        submitaction.setParams({ "RecId": recordId });
        submitaction.setCallback(this, (response) => {
            if (response.getState() == "SUCCESS") {
                component.set("v.Spinner", false);
                var result = response.getReturnValue();
                var listRecord = [];
                if (result[0].valideUser == false) {
                    helper.showTost(component, event, helper, 'error', result[0].errorMessage);
                    for (var i = 1; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                } else {
                    for (var i = 0; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                }
            }else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(submitaction);
    },
    saveAttachmentHelperMethod: function (component, event, helper) {
        let recordId = component.get('v.skinnStageId');
        let atchFile = JSON.stringify(component.get('v.attachmentObject'));
        let saveAttachMethod = component.get('c.saveAttcFile');
        saveAttachMethod.setParams({
            "attachFiel": atchFile,
            "recordId": recordId
        });
        saveAttachMethod.setCallback(this, (response) => {
            if (response.getState() === "SUCCESS") {
                var result = response.getReturnValue();
                var listRecord = [];
                if (result[0].valideUser == false) {
                    helper.showTost(component, event, helper, 'error', result[0].errorMessage);
                    for (var i = 1; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                } else {
                    for (var i = 0; i < result.length; i++) {
                        listRecord.push(result[i]);
                    }
                    component.set('v.stageActList', listRecord);
                    helper.updateInputForm(component, event, helper, listRecord);
                }
                component.set('v.attachmentObject', undefined);
                component.set("v.Spinner", false);
            } else {
                helper.showTost(component, event, helper, 'error', "Something went wrong please check your internet connection and try again!");
                var listRecord=component.get("v.stageActList");
                if(listRecord!=undefined)
                helper.updateInputForm(component, event, helper, listRecord);
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(saveAttachMethod);
    },
    checkIsRevision : function(component, event, helper){
        if(component.get('v.IsRevisionInPro') && component.get('v.submitforApproval') && (component.get('v.r1Approval')=="NULL" || component.get('v.r2Approval')=="NULL" || component.get('v.r3Approval')=="NULL" || component.get('v.r4Approval')=="NULL" || component.get('v.r5Approval')=="NULL" ) ){
            helper.showTost(component, event, helper, "error", "First submit record for approval!");
            return false;
         }
        if(component.get('v.IsRevisionInPro') && component.get('v.submitforApproval') && component.get('v.approvalStatus')=='Submit for approval'){
            helper.showTost(component, event, helper, "information", "Wait for approval!");
            return false;
        }
        if(component.get('v.IsRevisionInPro') && component.get('v.submitforApproval') && component.get('v.approvalStatus')=='Rejected'){
            helper.showTost(component, event, helper, "error", "Record is Rejected please re-submit!");
            return false;
        }
        if(component.get('v.IsRevisionInPro') && component.get('v.submitforApproval') && component.get('v.r1Approval')=='Approved'){
            //helper.showTost(component, event, helper, "information", "Wait for approval!");
            return true;
        }
        return true;
    }
})