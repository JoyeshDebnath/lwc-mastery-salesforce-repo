({
	doCalc : function(component, event, helper) {
		var input1=component.get('v.valueA');
        var input2=component.get('v.valueB');
        var btnName=event.getSource().get('v.name');
        console.log('name =',btnName)
        let res;
        switch(btnName){
            case 'add':
       			 res=parseInt(input1)+parseInt(input2);
        		 break;
             case 'minus':
       			 res=parseInt(input1)-parseInt(input2);
        		 break;
             case 'product':
       			 res=parseInt(input1)*parseInt(input2);
        		 break;
             case 'divide':
       			 res=parseInt(input1)/parseInt(input2);
        		 break;
        }
        console.log('value=',res);
       component.set('v.result',res);
        
	}
})