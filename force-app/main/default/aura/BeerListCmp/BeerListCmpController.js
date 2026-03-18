({
    showInfo : function(component, event, helper) {
        var recordId = event.currentTarget.getAttribute('data-recordId');
        component.set('v.recordId',recordId);
        //    Show Modal
    
    }
})