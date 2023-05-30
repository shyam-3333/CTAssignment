({
    doInit : function(component, event, helper) {
        if(!component.get('v.toggle')){
        //$A.get('e.force:refreshView').fire();
        component.set('v.toggle',true);
        }
    }
})