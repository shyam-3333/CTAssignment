({
	deleteRow : function(component, event, helper){
      //Execute the DeleteRowEvent Lightning Event and pass the deleted Row Index to Event attribute
      var rowIndexVal = component.get("v.rowIndex");
      component.getEvent("MtlDelComEvnt").setParams({"indexVal" : component.get("v.rowIndex") }).fire();
  },
})