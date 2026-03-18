({
    handleSearch : function(component, event, helper) {
        var searchtext = component.find('beersearch').get('v.value');
        console.log('Search text',searchtext)
        
        if (searchtext !== undefined)
        {
            var beerEvent = component.getEvent('beerEvent');
            beerEvent.setParams({
                searchtext: searchtext
            })
            beerEvent.fire();
        }
        else
        { 
            console.log('Seqarch text is undefined .....')
        }
    }
})