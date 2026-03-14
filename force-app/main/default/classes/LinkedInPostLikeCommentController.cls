public with sharing class LinkedInPostLikeCommentController {
    
    //get Profile info 
    public static String getProfile(){
        System.debug('Get Profile Service ...\n');
        System.debug(LinkedInApiService.get('/userinfo').getBody());
    }
}