public class OpenWeatherService {
    //get weather info using namd credential demo : custom authenitcation (using apikey )
    public class WeatherWrapper{
        public String temperature;
        public String maxTemp;
        public String minTemp;
        public String humidity;
        public String pressure;
    }

    public static WeatherWrapper getWeatherInCity(String city){
       // String apikey=NamedCredential.getOrgCredential('OpenWeather_API').getAuthParameter('apikey');
        HttpRequest request=new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(
        'callout:OpenWeather_API/data/2.5/weather?q='
        +EncodingUtil.urlEncode(city,'UTF-8')
        +'&appid={!$Credential.OpenWeather_Cred.apikey}'
        +'&units=metric');
        request.setTimeout(20000);

        HttpResponse res=new Http().send(request);
        if(res.getStatusCode()==200){
            return formWeatherWrapper(res.getBody());
        }else{
            throw new AuraHandledException('Something Went Wrong!!');
        }
    }

    public static WeatherWrapper formWeatherWrapper(String responseBody){
        Map<String,Object> results=(Map<String,Object>)JSON.deserializeUntyped(responseBody);
        Map<String,Object> main=(Map<String,Object>)results.get('main');
        WeatherWrapper wrapper=new WeatherWrapper();
        wrapper.temperature=String.valueof(main.get('temp'))+' degree celcious';
        wrapper.maxTemp=String.valueof(main.get('temp_max')) +' degree celcious';
        wrapper.pressure=String.valueof(main.get('pressure'))+' hPa';
        wrapper.minTemp=String.valueof(main.get('temp_min'))+' degree celcious';
        wrapper.humidity=String.valueof(main.get('humidity'))+'%';
        return wrapper;
    }
}

