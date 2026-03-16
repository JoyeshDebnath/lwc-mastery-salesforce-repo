public class AnimeExplorerController {
    private static final String BASE_URI='https://api.jikan.moe/v4';
    
    public class AnimeWrapper{
        @AuraEnabled public Integer malId;
        @AuraEnabled public String title;
        @AuraEnabled public String titleEnglish;
        @AuraEnabled public String imageUrl;
        @AuraEnabled public String synopsis;
        @AuraEnabled public String animeType;// TV , Movies / OVA /ONA etc 
        @AuraEnabled public Double score;
        @AuraEnabled public Integer episodes;
        @AuraEnabled public String status;
        @AuraEnabled public Integer year;
        @AuraEnabled public String rating;//PG / R etc 
        @AuraEnabled public String url;
        @AuraEnabled public List<String> genres;
    }

    public class AnimeResponse {
        @AuraEnabled public List<AnimeWrapper> data;
        @AuraEnabled public Integer totalCount;
        @AuraEnabled public Integer currentPage;
        @AuraEnabled public Integer lastPage;
        @AuraEnabled public Boolean hasNextPage;
    }

    @AuraEnabled (cacheable=true)
    public static AnimeResponse searchAnime(String searchQuery,String animeType,String status,String rating,Integer page){
        String endpoint=BASE_URI+'/anime?limit=20';

        if(String.isNotBlank(searchQuery)){
            endpoint+='&q='+EncodingUtil.urlEncode(searchQuery,'UTF-8');
        }
        if(String.isNotBlank(animeType) && animeType!='all'){
            endpoint+='&type='+animeType;
        }
        if(String.isNotBlank(status) && status!='all'){
            endpoint+='&status='+status;
        }
        if(String.isNotBlank(rating) && rating!='all'){
            endpoint+='&rating='+rating;
        }
        if(page!=null && page>1){
            endpoint+='&page='+page;
        }

        HttpRequest req=new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(20000);

        Http http=new Http();
        HttpResponse res=http.send(req);
        if(res.getStatusCode()!=200){
            throw new AuraHandledException('API Error : '+res.getStatusCode() +' - '+res.getStatus());
        }
        return parseResponse(res.getBody());

    }

    public static AnimeResponse parseResponse(String jsonBody){
        Map<String,Object> body=(Map<String,Object>)JSON.deserializeUntyped(jsonBody);
        Map<String,Object> pagination=(Map<String,Object>)body.get('pagination');
        List<Object> rawList=(List<Object>)body.get('data');
        AnimeResponse result=new AnimeResponse();
        result.data=new List<AnimeWrapper>();
        result.currentPage=(Integer)pagination.get('current_page');
        result.lastPage=(Integer)pagination.get('last_visible_page');
        result.hasNextPage=(Boolean)pagination.get('has_next_page');

        Map<String,Object> items=(Map<String,Object>)pagination.get('items');
        result.totalCount=items!=null?(Integer)items.get('total') : 0;

        for(Object item : rawList){
            result.data.add(buildWrapper((Map<String,Object>)item));
        }
        return result;

    }

    public static AnimeWrapper buildWrapper(Map<String,Object> item){
        AnimeWrapper w=new AnimeWrapper();
        w.malId=(Integer)item.get('mal_id');
        w.title=(String)item.get('title');
        w.titleEnglish=(String)item.get('title_english');
        w.synopsis=(String)item.get('synopsis');
        w.animeType=(String)item.get('type');
        w.score=(Double)item.get('score');
        w.episodes=(Integer)item.get('episodes');
        w.status=(String)item.get('status');
        w.year=(Integer)item.get('year');
        w.rating=(String)item.get('rating');
        w.url=(String)item.get('url');
        //Extract Image 
        // "images": {
        //         "jpg": {
        //             "image_url": "https://myanimelist.net/images/anime/4/19644.jpg",
        //             "small_image_url": "https://myanimelist.net/images/anime/4/19644t.jpg",
        //             "large_image_url": "https://myanimelist.net/images/anime/4/19644l.jpg"
        //         },
        //         "webp": {
        //             "image_url": "https://myanimelist.net/images/anime/4/19644.webp",
        //             "small_image_url": "https://myanimelist.net/images/anime/4/19644t.webp",
        //             "large_image_url": "https://myanimelist.net/images/anime/4/19644l.webp"
        //         }
        //     },
        Map<String,Object> images=(Map<String,Object>)item.get('images');
        if(images!=null){
            Map<String,Object> jpg=(Map<String,Object>)images.get('jpg');
            if(jpg!=null){
                w.imageUrl=(String)jpg.get('large_image_url');
            }
        }
        w.genres = new List<String>();
        List<Object> genreList = (List<Object>) item.get('genres');
        if (genreList != null) {
            for (Object g : genreList) {
                Map<String, Object> genre = (Map<String, Object>) g;
                w.genres.add((String) genre.get('name'));
            }
        }

        return w;
    }

    @AuraEnabled(cacheable=true)
    public static AnimeWrapper getAnimeById(Integer malId){
        String endpoint=BASE_URI+'/anime/'+malId;
        HttpRequest req=new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(20000);

        HttpResponse res=new Http().send(req);
        if(res.getStatusCode()!=200){
            throw new AuraHandledException('Could Not Fetch Anime Details !!');
        }
        Map<String,Object> body=(Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        Map<String,Object> animeData=(Map<String,Object>)body.get('data');
        return buildWrapper(animeData);

    }
}