({
    reInit : function(component, event, helper) {
        var referenceId = component.get("v.referencedReportId");
        helper.getSuggestionValue(component, event, helper);
        //var mtlDataList =component.get("v.mtlResponseList");
        var rawMType=component.get('v.typeRawMaterial');
        //alert(''+rawMType);
        component.set('v.temptypeRawMaterial',rawMType)
        if(referenceId != undefined && referenceId !=''){
            helper.fetchDataAtInit(component,event,helper);
        }
        /*if((referenceId !=undefined && referenceId !='') && (mtlDataList.length ==0 || mtlDataList ==undefined || mtlDataList ==NULL)){
            helper.fetchDataAtInit(component,event,helper);
        }*/
    },
    onkeyupmethod : function(component, event, helper){
        var data=component.get("v.testParamList");
        for(var x=0;x<data.length;x++){
            if(data[x].Testtype.includes('Hardness')){
                data[x].avgValue=parseFloat(data[x].minInput)+parseFloat(data[x].maxInput);
                data[x].avgValue=parseFloat(parseFloat(data[x].avgValue)/2).toFixed(2); 
                if(data[x].avgValue=='NaN'){
                    data[x].avgValue=0;
                }
            }
            
        }
        
        component.set("v.testParamList",data);
        //alert(':::data:::'+component.get("v.testParamList"));
    },
    saveTest : function(component,event,helper){
        
        
    },
    saveMtlInputData : function(component,event,helper){
        //alert('Coming here!!!');
        //var rawMType=component.get('v.temptypeRawMaterial');
        //alert(''+rawMType);
        helper.updateInputParam(component,event,helper);
        //helper.insrtTestParam(component,event,helper);
    },
    //var titanSpecName =component.get("v.mtlSelectedLookUpRecForTitanSpec").Name;
    changedSampleSz : function(component,event,helper){
        debugger;
        
    //    var titanSpecName =component.get("v.mtlSelectedLookUpRecForTitanSpec").Name; //new
        var sampleSizeData =component.get("v.changeSampleSizeVal");
    //  var copy=component.get('v.testParamList');
        if(sampleSizeData !='' && sampleSizeData !=undefined && sampleSizeData >0 ){
            component.set("v.mtlSampleSize", sampleSizeData);
            var copy=component.get('v.testParamList');
            if(copy.length >0){
                /*var temp=[];
                var stat=true;
                var array={};
                for(var i=0;i<copy.length;i++){
                    if(copy[i].Testtype != undefined){
                        if(!copy[i].Testtype.includes('Hardness')){
                            temp.push(copy[i]); 
                        }
                    }
                    
                    else{
                        if(stat){
                            
                            array=copy[i];
                            stat=false;
                        } 
                    }
                } */
                var temp = copy.filter( e => e.Testtype != undefined && e.Testtype.includes('Hardness'));
                var arrList = copy.filter( e => e.Testtype == undefined );
                var array = arrList.length > 0 ? arrList[0] : {} ;
                for(var i=0;i< (component.get("v.mtlSelectedLookUpRecForTitanSpec.Name") == 'T8086' ? 5 : sampleSizeData);i++){
                    
                    var obj={'Testtype' : array.Testtype,
                             'standDefVal' :array.standDefVal,
                             'userInpBool' : true,
                             'minDefBool' : true,
                             'maxDefBool' :true,
                             'verdStatus':'None',
                             'recrdId':array.recrdId,
                             'testValueRecordId':array.testValueRecordId,
                             'isMandtry': true};
                    temp.push(obj);
                }
                component.set('v.testParamList',temp);
                component.set('v.testParamListSize',temp.length);
            } 
        
            //component.set("v.mtlSampleSize", sampleSizeData);
        }
        else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message: 'Sample Size should be always greater than 0 !!',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
        }
    },
    addRow: function(component, event, helper) {
        helper.createObjectData(component, event);
    },
    removeDeletedRow: function(component, event, helper) {
        var index = event.getParam("indexVar");
        var AllRowsList = component.get("v.testParametersLst");
        var stringifiedData=JSON.stringify(AllRowsList);
        var delRowData=[];
        for(var i=0;i<AllRowsList.length;i++){
            delRowData.push(AllRowsList[i].Name);
        }
        AllRowsList.splice(index, 1);
        component.set("v.testParametersLst", AllRowsList);
        component.set("v.deleteDataList",delRowData);
    },
    removeDelRow : function(component,event,helper){
        var removeRaw=component.get('v.testParamList');
        var lastIndex=event.currentTarget.id;
        var testListParam=component.get("v.testParamList");
        var checkIsdeleted=helper.deleteMtlResp(component,event,helper,testListParam,lastIndex);
        
        /*var delData =[];
        var dataToBeDeletedList=[];
        delData.push(removeRaw[lastIndex]);
        var newSz = removeRaw.length - delData.length;
        //component.set("v.delDataList",delData);
        //alert('delDataList###::: '+JSON.stringify(delData));
        alert('delDataList asfs::: '+JSON.stringify(delData[0].recrdId));
        for(var i =0;i<delData.length; i++){
            if(delData[i].recrdId !=undefined && delData[i].recrdId !=''){
               	dataToBeDeletedList.push(delData[i]); 
            }
        }
        alert('dataToBeDeletedList ::: '+JSON.stringify(dataToBeDeletedList));
        var updatedata=[];
        delete removeRaw[lastIndex];
        for(var dat in removeRaw){
            if(dat!=undefined)
                updatedata.push(removeRaw[dat]);
        }
        component.set('v.testParamList',updatedata);
        if(newSz !=undefined && newSz !=''){
            component.set("v.testParamListSize",newSz);
        }*/
    },
    /*getDataFromAddRowComp : function(component,event,helper){
        var dataList =event.getParam("addRowDataList");
        component.set("v.addRowDataList",JSON.parse(dataList));
        alert('::::addRowtestData:::!! '+JSON.parse(dataList));
    },*/
    delBckData :function(component,event,helper){
        var removeRaw=component.get('v.testParamList');
        var lastIndex=event.currentTarget.id;
        var testListParam=component.get("v.testParamList");
        helper.deleteMtlResp(component,event,helper,testListParam[lastIndex]);
        
    },
    dispTestOnChng :function(component,event,helper){
        helper.genTestOnTitanSpecChange(component,event,helper);
        
    },
    onchangeAutoSuggestion : function(component, event, helper){
        var data=document.getElementById("AutoSuggestion").value;
        component.set('v.mtlRawMaterialName',data);
        //component.set('v.mtlSelectedLookUpRecForTitanSpec',null);
        //component.set('v.mtlSelectedLookUpRecordForSupplierGrd',null);
        var titanSpec = component.find('lookupIdTitan');
        titanSpec.clearValue();
        var supllierGrade=component.find('lookupId');
        supllierGrade.clearValue();
        
    },
    handleLookupComponentEvent : function(component,event,helper){
        var selectedRecordFromEvent = event.getParam("recordByEvent");
        var customId = event.getParam("customId");
        if(customId == 'qcMTLTitanSpecId'){
            component.set("v.selectedLookUpRecordForTitanSpec",selectedRecordFromEvent);
            helper.setSpecificationRevision(component, event, helper,selectedRecordFromEvent.Id);
        }
        if(customId == 'qcMTLSupplierGradeId'){
            component.set("v.selectedLookUpRecordForSupplierGrd",selectedRecordFromEvent);
            helper.setTCLDesignation(component, event, helper,selectedRecordFromEvent.Id);
        }
        if(customId == 'brandId'){
            component.set("v.selectedLookUpRecordForBrand",selectedRecordFromEvent);
        }
        if(customId == 'qcMTLSuplrNameId'){
            component.set("v.mtlSelectedLookupRecForSuplrName",selectedRecordFromEvent);
            //helper.setSuplrName(component,event,helper,selectedRecordFromEvent.Id);
        } 
        if(customId == 'qcMTLPltrNameId'){
            component.set("v.mtlSelectedLookupRecForPltrName",selectedRecordFromEvent);
            //helper.setSuplrName(component,event,helper,selectedRecordFromEvent.Id);
        }
    },
})