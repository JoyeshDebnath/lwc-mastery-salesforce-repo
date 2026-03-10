public  class BeerController {
    public BeerController() {

    }

    public static String generateCartId(){
        String charList='fkbwkefbkwebfkbfebwkbfwkqef,akabkwbqkfbekbkebkwebobob4e24ob2o4o2b4o2o';
        Integer position;
        Integer lengthRequired=30;
        String res='';
        for(Integer i=0;i<=lengthRequired;i++){
            position=Integer.valueOf(String.valueof(Math.roundToLong(charList.length()*Math.random())))-1;
            res+=charList.substring(position,position+1);
        }
        return res;
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> searchBeers(String searchParam){
        List<SObject> beersList=new List<SObject>();
        String likeParam='%'+searchParam+'%';
        String queryStr='';
        if(searchParam!=null){
                queryStr= 'SELECT Id, Name, Alcohol__c, Id__c, Image__c, Price__c, Tags__c, Total_Quantity__c, brewery_Name__c, brewery_id__c, Consumed_Quantity__c, Remaining_Quantity__c FROM Beer__c WHERE Name LIKE:likeParam LIMIT 30';
        }else{
                queryStr='SELECT Id, Name, Alcohol__c, Id__c, Image__c, Price__c, Tags__c, Total_Quantity__c, brewery_Name__c, brewery_id__c, Consumed_Quantity__c, Remaining_Quantity__c FROM Beer__c  LIMIT 30';
        }

        beersList=Database.query(queryStr);
        return beersList;
    }


    public static String getCouponInformation(String name){
        Coupon__c couponRecord=[SELECT Id,Name,Price__c FROM Coupon__c WHERE Expired__c=false AND Name=:name];
        return couponRecord.Id;
    }

    @AuraEnabled(cacheable=false)
    public static String getCartId(){
        List<Cart__c> cartInfo=[SELECT Id,Name FROM Cart__c WHERE User__c=:UserInfo.getUserId() AND Cart_Status__c='Open' AND Is_Active__c=true];
        if(cartInfo != null && cartInfo.size()>0){
            return cartInfo.get(0).Id;
        }else{
            //create a default cart 
            Cart__c defaultCart = new Cart__c();
            String couponId=getCouponInformation('Default');
            defaultCart.Cart_Id__c=generateCartId();
            defaultCart.Cart_Status__c='Open';
            defaultCart.Is_Active__c=true;
            defaultCart.Coupon__c=couponId;
            defaultCart.User__c=UserInfo.getUserId();
            insert defaultCart;

            return defaultCart.Id;
        }
    }
}