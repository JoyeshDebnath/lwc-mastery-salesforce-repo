({
    saveContactRecord: function (component, event, helper) {
        // alert('btn clicked ');
        console.log(component.get('v.accountId'))
        var action = component.get('c.createContactRecord');
        if (component.get('v.createContact.LastName') == null || component.get('v.createContact.LastName') == undefined)
        { 
            alert('Lastname is Required ');
            return;
        }

        action.setParams({
            contact: component.get('v.createContact'),
            AccountId:component.get('v.accountId')
        })

        action.setCallback(this, function (response) { 
            if (response.getState() === 'SUCCESS')
            {
                alert(response.getState())
                console.log('Returned Value  :'+component.getElement()+'   '+response.getReturnValue());
            } else
            { 
               alert(response.getState())
                console.log(response.getError())
            }
        })

        $A.enqueueAction(action);
            
    }
})