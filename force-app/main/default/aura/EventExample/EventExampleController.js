({
	doChange : function(component, event, helper) {
		alert('Value is Changed');
	},
    changeValue : function(component,event,helper){
        component.set('v.test','TEST');
    }
})