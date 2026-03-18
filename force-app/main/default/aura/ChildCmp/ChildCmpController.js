({
	handleClick : function(component, event, helper) {
		var evt=component.getEvent('demoEvent');
        evt.setParams({
            'message':'This is Sample Response FROM Child Event '
        })
        
        evt.fire();
	}
})