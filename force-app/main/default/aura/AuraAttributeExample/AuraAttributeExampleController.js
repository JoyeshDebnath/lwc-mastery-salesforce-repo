({
	doClick : function(component, event, helper) {
		//alert(component.isValid());
        //alert(component.getName());
        console.log(component.get('v.Whom'));
        component.set('v.Whom','SFDC Debnath');
        var ageCmp=component.find("testInput");
        alert(ageCmp.get('v.value'));
        ageCmp.set('v.value',67);
        
    }
})