/**
 * PKCE Auth Flow helper class 
 */


public with sharing class PS_PKCEAuthHelper {
    
    public static List<String> getCodeVerifierAndCodeChallenge(){
        String code_verifier=System.UUID.randomUUID().toString();//random string genartion 
        Blob sha256=Crypto.generateDigest('SHA-256',Blob.valueOf(code_verifier));
        String code_challenge=SFDC_BASE_64_URL_ENCODE(sha256);

        System.debug('***** Code Verifier ******'+code_verifier);
        System.debug('***** Code Challenge ******'+code_challenge);
        return new List<String>{code_verifier,code_challenge};
    }

    public static String SFDC_BASE_64_URL_ENCODE(Blob input){
        if(input == null)
            return null;
        return System.EncodingUtil.base64Encode(input)
                                        .replace('/','-')
                                        .replace('+','-')
                                        .replaceAll('=+$','');
    }



}