//STEP 1 : get Authorisation url 
public  class PS_SalesforceTokenUtils {
/**https://MyDomainName.my.salesforce.com
 * 
 * https://MyDomainName.my.salesforce.com/services/oauth2/authorize?
client_id=3MVG9IHf89I1t8hrvswazsWedXWY0i1qK20PSFaInvUgLFB6vrcb9bbWFTSIHpO8G2jxBLJA6uZGyPFC5Aejq&
redirect_uri=https://www.mycustomerorderstatus.com/oauth2/callback&
response_type=code
 *STEP 1: Prepare the Auth URL 
 { 
 */
//Redirect url for vf page ----> https://integration-org2-dev-ed--c.develop.vf.force.com/apex/PS_SalesforceTokenPage
//---------> org domain URL --> https://integration-org2-dev-ed--c.develop
    
       public static PageReference getAuthCode(){
            Salesforce_Config__mdt sfConfig=Salesforce_Config__mdt.getInstance('PS_SalesforceToken');//ID or name of the metadata 
            if(sfConfig!=null){
                        List<String> codeVerifierAndCodeChallengeDetails=PS_PKCEAuthHelper.getCodeVerifierAndCodeChallenge();//get code verifier and code challenge 
                        String code_verifier=codeVerifierAndCodeChallengeDetails.get(0);
                        String code_challenge=codeVerifierAndCodeChallengeDetails.get(1);
                        String domainURL=Url.getOrgDomainUrl().toExternalForm();
                        String redirectURL=domainURL+'/apex/'+sfConfig.Page_Name__c;
                        String orgURL=sfConfig.Environment__c=='PROD'?'https://login.salesforce.com':'https://test.salesforce.com';
                        String authURL=orgURL+sfConfig.auth_url__c+'?client_id='+sfConfig.client_id__c+'&redirect_uri='+redirectURL+'&response_type=code'+'&code_challenge='+code_challenge;
                        System.System.debug('Auth URL=>'+authURL);
                //STEP : insert code verifier and coide challnge in custom settings or custom object .... 
                PKCE_Helper__c pkce_helper=new PKCE_Helper__c();
                pkce_helper.isActive__c=true;
                pkce_helper.code_verifier__c=code_verifier;
                pkce_helper.code_challenge__c=code_challenge;
                pkce_helper.User__c=UserInfo.getUserId();//Id of the current user ...
                insert pkce_helper;
                       
                        return new PageReference(authURL);//redirecting 
            }else{
                return null;
            }
    }

        public static  void getAccessToken(){
            //code=aPrxRbsaO0DHTZ2p9UNYpX4PSbQF5CSqHa3ec48RzAAxeJKzDlMgeGGpOfllLeE_JnAEHzLZYw%3D%3D
            Salesforce_Config__mdt sfConfig=Salesforce_Config__mdt.getInstance('PS_SalesforceToken');
            if(sfConfig!=null){
                //STEP : get the code verifier and code challenge from  custom settings or custom object ......
                 PKCE_Helper__c pkce_helper=[SELECT Id,code_verifier__c FROM PKCE_Helper__c WHERE User__c=:UserInfo.getUserId()];
                
                // String code_challenge=pkce_helper.code_challenge__c;
                String code_verifier=pkce_helper.code_verifier__c;
                // pkce_helper.isActive__c=false;
                // pkce_helper.code_challenge__c=null;
                // pkce_helper.code_verifier__c=null;
                // update pkce_helper;


                String orgUrl=sfConfig.Environment__c=='PROD'?'https://login.salesforce.com':'https://test.salesforce.com';
                String tokenURL=orgURL+sfConfig.token_url__c;
                String code=ApexPages.currentPage().getParameters().get('code');//get the code from  the apex page in vf 
                System.debug('CODE=>'+code);

                String domainURL=Url.getOrgDomainUrl().toExternalForm();
                String redirectURL=domainURL+'/apex/'+sfConfig.Page_Name__c;

                String requestBody='code='+code+'&grant_type=authorization_code&client_id='+sfConfig.client_id__c+'&client_secret='+sfConfig.client_secret__c+'&redirect_uri='+redirectURL+'&code_verifier='+code_verifier;//prepare the request body
                System.System.debug('Request Body Prepared ==> '+requestBody);
                 
                HttpRequest httpReq=new HttpRequest();
                httpReq.setEndpoint(tokenURL);
                httpReq.setMethod('POST');
                httpReq.setBody(requestBody);
                httpReq.setHeader('Content-Type','application/x-www-form-urlencoded');
                httpReq.setHeader('Accept','application/json');
           
                 Http http=new Http();
                    try{
                        HttpResponse httpRes=http.send(httpReq); 
                        if(httpRes.getStatusCode()==200){
                                PS_SalesforceTokenWrapper wrapper=(PS_SalesforceTokenWrapper)System.JSON.deserialize(httpRes.getBody(),PS_SalesforceTokenWrapper.class);
                                /**
                                 * fullname -> "Salesforce_Config__mdt.PS_SalesforceToken"
                                 * Label-> "PS_SalesforceToken"
                                 * 
                                 */
                                String fullname='Salesforce_Config.PS_SalesforceToken';
                                String label='PS_SalesforceToken';
                                Map<String,Object> fieldWithValuesMap=new Map<String,Object>();
                                fieldWithValuesMap.put('access_token__c',wrapper.access_token);
                                fieldWithValuesMap.put('expires_in_time__c',System.now().addHours(2));
                                fieldWithValuesMap.put('refresh_token__c',wrapper.refresh_token);
                                fieldWithValuesMap.put('scope__c',wrapper.scope);
                                fieldWithValuesMap.put('instance_url__c',wrapper.instance_url);
                                 fieldWithValuesMap.put('client_id__c',sfConfig.client_id__c);
                                  fieldWithValuesMap.put('client_secret__c',sfConfig.client_secret__c);

                                System.debug('SUCCESS \n'+httpRes.getBody());
                                CreateUpdateMetadataUtils.updateCreateMetadata(fullname,label,fieldWithValuesMap);//create/ update the metadata 
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Success'));
                    }
                    else{
                            System.debug('ERROR \n'+httpRes.getBody());
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,httpRes.getBody()));
                        }
                    }catch(System.CalloutException ex){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
                    }catch(System.Exception ex){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
                    }
            }
            

           

        }
}