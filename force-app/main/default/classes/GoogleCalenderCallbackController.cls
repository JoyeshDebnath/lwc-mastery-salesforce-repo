public with sharing class GoogleCalenderCallbackController {
     public String message { get; set; }
    
    public GoogleCalenderCallbackController() {
        String code  = ApexPages.currentPage().getParameters().get('code');
        String error = ApexPages.currentPage().getParameters().get('error');
        
        if (error != null) {
            message = 'Authorization denied: ' + error;
            return;
        }
        
        if (code != null) {
            try {
                GoogleOAuthHandler.exchangeCodeForTokens(code);
                message = 'Connected to Google Calendar successfully!';
            } catch (Exception e) {
                message = 'Error: ' + e.getMessage();
            }
        }
    }
}