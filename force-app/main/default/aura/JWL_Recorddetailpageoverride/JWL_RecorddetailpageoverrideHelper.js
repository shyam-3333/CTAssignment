({
	getjwlresponselist : function(component, event, helper) {
        var ID= component.get('v.recordId');
		var reslist=component.get('v.responselist');
        var action=component.get("c.recorddetial");
        action.setParams({
            'jwlid' : ID
            
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var jwllist= response.getReturnValue();
                
              
                component.set('v.responselist',jwllist);
            }
	});
        $A.enqueueAction(action);
                           
      }   ,
    pdfpreviewhelper:function(component,event,helper){
        var ids = component.get('v.recordId');
        //window.open = '/apex/JWL_ViewPDF?id='+ids;	
        window.open('/apex/JWL_ViewPDF?id='+ids);
    },
    getjwlcomponent:function(component,event,helper){
        var ID= component.get('v.recordId');
		var reslist=component.get('v.jwlcomponent');
        var action=component.get("c.retriverecord");
        action.setParams({
            'recid' : ID
            
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var jwllist= response.getReturnValue();
                
              
                component.set('v.jwlcomponent',jwllist);
            }
	});
        $A.enqueueAction(action);
                           
      } 
    
})