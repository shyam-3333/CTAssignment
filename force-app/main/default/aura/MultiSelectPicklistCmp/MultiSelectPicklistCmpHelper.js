({
    setOptions : function(component) {
      var options = component.get("v.options");
        if(options != undefined && options.length > 0) {
                  options.sort(function compare(a,b) {
                     if (a.value == 'All'){
                       return -1;
                     }
                     else if (a.value < b.value){
                       return -1;
                     }
                     if (a.value > b.value){
                       return 1;
                     }
                     return 0;
                   });

      //debugger;
            component.set("v.options_",options);
      console.log(options);  
      var values = this.getSelectedValues(component);
      this.setInfoText(component,values);
        }else{
          // added by rajib as we need to reset the picklist
          component.set("v.options_",options);
          this.setInfoText(component,[]);
        }
    }, 
  setInfoText: function(component, labels) {
    
    if (labels.length == 0) {
      component.set("v.infoText", "Select an option...");
    }
    if (labels.length == 1) {
      component.set("v.infoText", labels[0]);
    }
    else if (labels.length > 1) {
      component.set("v.infoText", labels.length + " options selected");
    }
  },

  getSelectedValues: function(component){
    var options = component.get("v.options_");
    var values = [];
    options.forEach(function(element) {
      if (element.selected) {
        values.push(element.value);
      }
    });
    return values;
  },
    getSelectedResponseIds: function(component){
    var options = component.get("v.options_");
    var resIds = [];
    options.forEach(function(element) {
      if (element.selected) {
        resIds.push(element.resId);
      }
    });
    return resIds;
  },

  getSelectedLabels: function(component){
    var options = component.get("v.options_");
    var labels = [];
    options.forEach(function(element) {
      if (element.selected) {
        labels.push(element.label);
      }
    });
    return labels;
  },

  despatchSelectChangeEvent: function(component,values, responseIds){
    var compEvent = component.getEvent("callselectChange");
    component.set("v.values",values);  
      compEvent.setParams({ "values": values, "picklistId" : component.get("v.picklistId"), "questionId": component.get("v.questionId"),"responseIds" : responseIds, "picklistLabel" : component.get("v.picklistLabel")  });
    compEvent.fire();
  }
})