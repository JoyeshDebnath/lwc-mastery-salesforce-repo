({
	handleEvent : function(component, event, helper) {
		var evtResponse=event.getParams('message');
        window.console.log(JSON.stringify(evtResponse));
        component.set("v.eventValue", evtResponse.message); 
	}
})