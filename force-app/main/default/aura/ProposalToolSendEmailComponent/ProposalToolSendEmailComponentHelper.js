({      
    getContactList: function(component) {
        console.log('getContactList')
        var action = component.get('c.getContacts');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.contacts', actionResult.getReturnValue());
            component.set('v.contacts1',actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    checkbox1:function(component,event)
    { 
        var selectedRec = event.getSource().get("v.value");
        var getSelectedNumber1 = component.get("v.selectedCount1");
        if (selectedRec == true) {
            getSelectedNumber1++;
        } else {
            component.find("box3").set("v.value",false);
            console.log(component.find("box3").get("v.value"));
            getSelectedNumber1--;
        }
        component.set("v.selectedCount1", getSelectedNumber1);
    }
})