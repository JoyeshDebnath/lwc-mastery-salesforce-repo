public class GoogleCalenderService {
    private static final String CALENDER_BASE_URL='https://www.googleapis.com/calendar/v3/calendars/primary/events';
    
    private static String formatDateTime(DateTime dt) {
        return dt.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
    }
    private static String buildEventPayload(Event sfEvent){
        Map<String,Object> payload=new Map<String,Object>{
            'summary' => sfEvent.Subject,
            'description' => sfEvent.Description !=null? sfEvent.Description :'',
            'location' => sfEvent.Location!=null ? sfEvent.Location :'',
            'start'=> new Map<String,Object>{
                'dateTime'=>formatDateTime(sfEvent.StartDateTime),
                'timeZone'=>'Asia/Kolkata'
            },
            'end'=>new Map<String,Object>{
                'dateTime'=>formatDateTime(sfEvent.EndDateTime),
                'timezone'=>'Asia/Kolkata'
            }
        };

        return JSON.serialize(payload);

    }
    //1 : Fetch Upcoming Events from Google Calender 
    public static List<Map<String,Object>> getUpcomingEvents(Integer maxResults){
        String accessToken=GoogleOAuthHandler.getValidAccessToken();
         String timeMin = DateTime.now().formatGmt('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
        System.debug(timeMin);
        HttpRequest req=new HttpRequest();
        req.setEndpoint(CALENDER_BASE_URL+
            +'?maxResults='+maxResults
            +'&orderBy=startTime'
            +'&singleEvents=true'
            +'&timeMin='+EncodingUtil.urlEncode(timeMin,'UTF-8')
        );
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer'+accessToken);
        req.setHeader('Content-Type','application/json');
        HttpResponse res=new Http().send(req);
        if(res.getStatusCode()==200){
            Map<String,Object> results=(Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            List<Object> items = (List<Object>)results.get('items');
            List<Map<String,Object>> events = new List<Map<String,Object>>();
            for(Object item : items ){
                events.add((Map<String,Object>)item);
            }
            return events ;
        }
        else{
             throw new AuraHandledException('List events Failed To fetched '+res.getBody());
        }
    }

    //update an exisiting google calender event 
    public static void updateEvent(Event sfEvent,String googleEventId){
        String accessToken = GoogleOAuthHandler.getValidAccessToken();
        HttpRequest req=new HttpRequest();
        req.setEndpoint(CALENDER_BASE_URL
            +EncodingUtil.urlEncode(googleEventId,'UTF-8')
        );
        req.setHeader('Authorization','Bearer'+accessToken);
        req.setHeader('Content-Type','application/json');
        req.setMethod('PATCH');
        req.setBody(buildEventPayload(sfEvent));
        req.setTimeout(20000);
        HttpResponse res=new Http().send(req);
        if(res.getStatusCode()==200){
            System.debug('Updated SuccessFully !');
        }else{
            throw new AuraHandledException('Update Failed ==>'+res.getBody());
        }
    }

    //create an Event 
    public static void createEvent(Event sfEvent){
        String accessToken=GoogleOAuthHandler.getValidAccessToken();
        HttpRequest req=new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(CALENDER_BASE_URL);
        req.setBody(buildEventPayload(sfEvent));
        req.setHeader('Authorization','Bearer'+accessToken);
        req.setHeader('Content-Type','application/json');
        req.setTimeout(20000);
        HttpResponse res=new Http().send(req);
        if(res.getStatusCode()==200){
            System.debug('Created Event Successfully !!');
        }
        else{
            throw new AuraHandledException('Could not create Event ....'+res.getBody());
        }

    }

    //Delete event 
    public static void deleteEvent(String googleEventId){
        String accessToken=GoogleOAuthHandler.getValidAccessToken();
        HttpRequest req=new HttpRequest();
        req.setMethod('DELETE');
        req.setEndpoint(CALENDER_BASE_URL
        +EncodingUtil.urlEncode(googleEventId,'UTF-8'));
        req.setHeader('Authorization','Bearer'+accessToken);
        req.setTimeout(20000);
        HttpResponse res=new Http().send(req);
        if(res.getStatusCode()!=204 || res.getStatusCode()!=410){
            throw new AuraHandledException('Error while Deleteing ['+ res.getStatusCode()+']: '+res.getBody());
        }
    }

}