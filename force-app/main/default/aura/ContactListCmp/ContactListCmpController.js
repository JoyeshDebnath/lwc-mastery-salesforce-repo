({
    doInit : function(component, event, helper) {
        var action = component.get("c.getTenContacts");
        action.setParams({
            accId:component.get('v.recordId')
        })
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === 'SUCCESS')
            {
                console.log('return Value ',response.getReturnValue())
                component.set('v.contactList', response.getReturnValue());
            } else
            {
                alert('Something Went Wrong !');
            }
        });
        $A.enqueueAction(action);
    },
    doRedirect: function (component, event, helper) { 
        var eventSource = event.getSource();
        var contactRecordID = eventSource.get('v.name');
        alert(contactRecordID)
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": contactRecordID,
            "slideDevName": "detail" // Options: "detail" or "chatter"
        });
        navEvt.fire();
    }
})