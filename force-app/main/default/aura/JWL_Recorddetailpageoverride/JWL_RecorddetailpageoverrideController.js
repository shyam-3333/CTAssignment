({
	doInit : function(component, event, helper) {
		helper.getjwlresponselist(component, event, helper);
        helper.getjwlcomponent(component, event, helper);
	},
    pdfpreview:function(component,event,helper){
        helper.pdfpreviewhelper(component,event,helper);
    }
})