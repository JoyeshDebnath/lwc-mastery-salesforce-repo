({

    doInit: function (component, event, helper) { 
            var action = component.get("c.getBeerByName");
            
            action.setCallback(this, function (response) { 
                if (response.getState() === 'SUCCESS')
                {
                    console.log(response.getReturnValue());
                    component.set('v.beerRecords',response.getReturnValue());
                } else
                { 
                    console.error(response.getError());
                }
            })

            $A.enqueueAction(action);
    },
    handleBeerSearchEvent: function (component, event, helper) {
        console.log(event);
        var searchParam = event.getParam('searchtext');
        if (searchParam !== undefined)
        {
            var action = component.get("c.getBeerByName");
            action.setParams({
                searchParam:searchParam
            })
            action.setCallback(this, function (response) { 
                if (response.getState() === 'SUCCESS')
                {
                    console.log(response.getReturnValue());
                    component.set('v.beerRecords',response.getReturnValue());
                } else
                { 
                    console.error(response.getError());
                }
            })

            $A.enqueueAction(action);
        }
        else
        { 
            console.error('Search param from event is undefind ')
        }
        
    }
})