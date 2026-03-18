trigger ChangeShippingAddress on Account (before insert) {
    for(Account acc : Trigger.New){
        if(acc.BillingStreet!=null){
            acc.ShippingCity=acc.BillingCity;
        }
        if(acc.BillingCountry!=null){
            acc.ShippingCountry=acc.BillingCountry;
        }
        if(acc.BillingState!=null){
            acc.ShippingState=acc.BillingState;
        }
        if(acc.BillingPostalCode!=null){
            acc.ShippingPostalCode=acc.BillingPostalCode;
        }
    }
    
    
}