public  class LinkedInController {
   
    @AuraEnabled(cacheable=false)
    public static Boolean isLinkedInConnected() {
        try {
            String token = Auth.AuthToken.getAccessToken(
                'LinkedIn_Credential',  // External Credential developer name
                'Open ID Connect'       // provider type string
            );
            return String.isNotBlank(token);
        } catch (Exception e) {
            return false;
        }
    }

    // ── ALTERNATIVE: lightweight ping callout ─────────────────────
    // More reliable than token check — confirms token actually works
    @AuraEnabled(cacheable=false)
    public static Boolean isLinkedInConnectedViaPing() {
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:LinkedIn_API/v2/me?projection=(id)');
            req.setMethod('GET');
            req.setHeader('LinkedIn-Version', '202401');
            req.setTimeout(5000);

            HttpResponse res = new Http().send(req);

            // 200 = connected and working
            // 401 = token missing or expired
            // 403 = connected but wrong scope
            return res.getStatusCode() == 200 || res.getStatusCode() == 403;

        } catch (System.CalloutException e) {
            // CalloutException with 'Unauthorized' message = no token stored
            return false;
        } catch (Exception e) {
            return false;
        }
    }


    @AuraEnabled(cacheable=false)
    public static Boolean isLinkedInConnectedViaObject() {
        try {
            // NOTE: ExternalIdentity — NO __c suffix — this is a standard object
            List<ExternalIdentity> ids = [
                SELECT Id
                FROM ExternalIdentity
                WHERE ExternalDataSourceId IN (
                    SELECT Id FROM ExternalDataSource
                    WHERE DeveloperName = 'LinkedIn_Credential'
                )
                AND UserId = :UserInfo.getUserId()
                LIMIT 1
            ];
            return !ids.isEmpty();
        } catch (Exception e) {
            // ExternalIdentity may not be queryable in all contexts
            return false;
        }
    }

    // ── Rest of controller unchanged ──────────────────────────────
    @AuraEnabled
    public static String getLinkedInAuthUrl() {
        PageReference ref = Auth.AuthToken.getAuthorizationUrl(
            'LinkedIn_Credential',
            null
        );
        return ref != null ? ref.getUrl() : null;
    }

    //fetches the linked in profile infor to display in UI 
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> fetchProfile(){
        try{
            LinkedInService.LinkedInProfile profile = LinkedInService.getProfile();
            String email = LinkedInService.getEmail();
            Map<String,Object> result=new Map<String,Object>{
                'firstName'=>profile.firstName,
                'lastName'=>profile.lastName,
                'headline'=>profile.headLine,
                'email'=>email,
                'profilePictureUrl'=>profile.profilePictureUrl,
                'linkedInId'=>profile.linkedInId
            };
            return result;

        }catch(LinkedInService.LinkedInAuthException e ){
                throw new AuraHandledException(e.getMessage());
        }
        catch(Exception e){
            throw new AuraHandledException('Linked In Fetch Failed : '+e.getMessage());
        }
    }

    //Enriches the Contact Record : called from UI 
    //Save to Contact 
    @AuraEnabled 
    public static Map<String,Object> enrichContact(Id contactId){
        try{
            LinkedInService.EnrichResult r= LinkedInService.enrichContact(contactId);
             return new Map<String,Object>{
                'success'   => r.isSuccess,
                'firstName' => r.profile.firstName,
                'lastName'  => r.profile.lastName,
                'headline'  => r.profile.headline
            };
        
        }catch(LinkedInService.LinkedInAuthException e ){
            throw new AuraHandledException(e.getMessage());
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}