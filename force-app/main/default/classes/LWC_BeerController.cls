public with sharing class LWC_BeerController {
    @AuraEnabled(cacheable=true)
    public static  List<sObject> searchParams(String searchParam){
        
        String likeParam='%'+searchParam+'%';
        String Query='';
        if(searchParam!=null && !String.isBlank(searchParam))
            Query='SELECT Id,Alcohol__c,Image__c,brewery_Name__c,brewery_id__c,Consumed_Quantity__c,Id__c,Name,Price__c,Remaining_Quantity__c,Tags__c,Total_Quantity__c FROM Beer__c WHERE Name LIKE : likeParam LIMIT 50';
        else
            Query='SELECT Id,Alcohol__c,Image__c,brewery_Name__c,brewery_id__c,Consumed_Quantity__c,Id__c,Name,Price__c,Remaining_Quantity__c,Tags__c,Total_Quantity__c FROM Beer__c LIMIT 50';
        
        List<sObject> beerList=Database.query(Query);
        return beerList;
        
    }
    
    public static String generateCartId(){
        String charList='klhfwhehelhflwehflwhhhglwhglwglhglwhglehlwehglhwglhglhlgowhlghlweghlwhlghwle';
        Integer position ;
        Integer lengthRequired = 30;
        String res='';
        for(Integer i=0;i<=lengthRequired ; i++){
            position = Integer.valueof(String.valueof(Math.roundToLong(charList.length()*Math.random())))-1;
            res+=charList.substring(position,position+1);
        }
        return res;
    }
    
    public static String getCouponInformation (String name){
        Coupon__c couponRec=[SELECT Name,Id,Price__c 
                            FROM Coupon__c 
                            WHERE Expired__c = false
                                AND Name =: name];
        
        return couponRec.Id;
    }
    
    @AuraEnabled(cacheable=false)
    public static String getCartId(){
        List<Cart__c> cartInfo = [SELECT Id,Name FROM Cart__c WHERE 
                                    User__c =: UserInfo.getUserId() 
                                    AND  
                                    Cart_Status__c='Open' 
                                    AND 
                                    Is_Active__c=true];
        System.debug('The cart Info='+cartInfo);
        if(cartInfo !=null && cartInfo.size()>0){
            return cartInfo.get(0).Id;
        }
        else{
            Cart__c defaultCart=new Cart__c();
            String couponId=getCouponInformation('Default');
            defaultCart.Cart_Id__c=generateCartId();
            defaultCart.Cart_Status__c='Open';
            defaultCart.Is_Active__c=true;
            defaultCart.Coupon__c=couponId;
            defaultCart.User__c=UserInfo.getUserId();
            
            try{
                insert defaultCart;
            }catch(Exception e){
                System.debug(e.getMessage());
            }
            System.debug('Default cart ID='+defaultCart.Id);
            return defaultCart.Id;
            
        }
        
    }
    
    @AuraEnabled
    public static String createCartItems(String cartId,String beerId,Decimal amount){
        Cart_Item__c item=new Cart_Item__c();
        item.Beer__c=beerId;
        item.Cart__c=cartId;
        item.Item_Quantity__c=1;
        item.Item_Amount__c=amount;
        
        insert item;
        return item.Id;
    }
    
}