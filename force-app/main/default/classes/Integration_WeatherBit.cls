public with sharing class Integration_WeatherBit {
    public static void getCurrentWeather(String lat,String lon){
                Http http=new Http();
                HttpRequest request=new HttpRequest();
                String url=System.Label.WEATHERBIT_API+'/current?lat='+lat+'&lon='+lon+'&key='+System.Label.WEATHERBIT_API_KEY;
        System.debug('Endpoint='+url);
                request.setEndpoint(url);
                request.setHeader('Content-Type','application/json');
                request.setHeader('Accept','application/json');
                request.setMethod('GET');
                try{
                    HttpResponse response=http.send(request);
                    String responseBody=response.getBody();
                    Integer statusCode=response.getStatusCode();
                    System.debug(responseBody);
                    System.debug(statusCode);
                    if(statusCode==200){
                        Integration_WeatherBitResponseWrapper wrapper=(Integration_WeatherBitResponseWrapper)JSON.deserialize(responseBody,Integration_WeatherBitResponseWrapper.class);
                        if(wrapper?.data?.size()>0){
                        Integration_WeatherBitResponseWrapper.data weather_bit_data=wrapper.data.get(0);
                        //String info=weather_bit_data?.city_name+'  '+weather_bit_data?.app_temp+'  '+weather_bit_data?.precip+'  '+weather_bit_data?.sunrise+'  '+weather_bit_data?.weather.description+'  '+weather_bit_data?.wind_spd;

                        System.debug('Weather Report fetched = > ');
                        System.debug(weather_bit_data?.city_name);
                        System.debug(weather_bit_data?.app_temp);
                        System.debug(weather_bit_data?.precip);
                        System.debug(weather_bit_data?.sunrise);    
                        System.debug(weather_bit_data?.weather.description);
                        System.debug(weather_bit_data?.wind_spd);
                    }
                }

                }catch(System.Exception e){
                    System.debug(e.getMessage());
                }

    }
}