({
   /* doInit:function(component,event,helper){
       
    },
    openDropdown:function(component,event,helper){
        if(component.get('v.isdisabled') == false){
        $A.util.addClass(component.find('dropdown'),'slds-is-open');
        $A.util.removeClass(component.find('dropdown'),'slds-is-close');


        var selectedOption = component.get('v.selectedOptions');
        if( selectedOption != undefined){
            var allOptions = component.get('v.options');
            for(var i=0;i<allOptions.length;i++)
            {
                if(selectedOption.includes( allOptions[i].label) )
                {
                    allOptions[i].isChecked = true;
                }
                else{
                    allOptions[i].isChecked = false;
                }
            }
            component.set("v.selectedOptions",selectedOption);
            component.set('v.options',allOptions);
        }
        }
    },
    closeDropDown:function(component,event,helper){
        $A.util.addClass(component.find('dropdown'),'slds-is-close');
        $A.util.removeClass(component.find('dropdown'),'slds-is-open');
    },
    selectOption:function(component,event,helper){        
        var label = event.currentTarget.id.split("#BP#")[0];
        var isCheck = event.currentTarget.id.split("#BP#")[1];
        helper.selectOptionHelper(component,label,isCheck);
    }*/
})