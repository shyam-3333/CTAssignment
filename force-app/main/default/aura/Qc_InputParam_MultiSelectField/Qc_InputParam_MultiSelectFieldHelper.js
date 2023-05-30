({
   /* selectOptionHelper : function(component,label,isCheck) {
        debugger;
        var selectedOption='';
        var seectedValues =[];
		var allOptions = component.get('v.options');
        var count=0;
        for(var i=0;i<allOptions.length;i++)
        {
            if(allOptions[i].label==label) 
            {
                if(isCheck=='true')
                {
                    allOptions[i].isChecked = false;
                }
                else
                {
                    allOptions[i].isChecked = true;
                }
            }
            if(allOptions[i].isChecked)
            {
                selectedOption=allOptions[i].label;
                seectedValues.push( allOptions[i].label );
                count++;
            }
        }
        if(count>1)
        {
            selectedOption = count+' items selected';
        }
        component.set("v.selectedOptions",selectedOption);
        component.set('v.options',allOptions);
        component.set('v.selectedOption', selectedOption);
        var evt = component.getEvent("MultivaluePicklistEvent");
		evt.setParams({
			"selectedValues" :  seectedValues,
            "picklistName": component.get('v.multiValpicklistName'),
            "questionIndex" : component.get( 'v.questionIndex' )
			});
		evt.fire();
    }*/
})