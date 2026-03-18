/**
* @File Name : AnimalsCallouts.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : September 3, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | September 3, 2025 |   | Initial Version
**/

public class AnimalsCallouts {
	
	public static HttpResponse makeGetCallout(){
			Http http=new Http();
			HttpRequest request = new HttpRequest();
			request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
			request.setMethod('GET');
			HttpResponse response = http.send(request);
			if(response.getStatusCode()==200){
					Map<String,Object> results=(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
					List<Object> animals=(List<Object>) results.get('animals');
					for(Object animal : animals ){
						System.debug(animal+'\n');
					}
			}
			return response;

	}

	public static HttpResponse makePostCallout(){
			Http http=new Http();
			HttpRequest request=new HttpRequest();
			request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
			request.setMethod('POST');
			request.setHeader('Content-Type','application/json;charset=UTF-8');
			request.setBody('{"name":"mighty moose"}');
			HttpResponse response=http.send(request);
			if(response.getStatusCode()!=201){
				System.debug('The sttus code was not expected : '+response.getStatusCode()+  '   '+response.getStatus());
			}else{
				System.debug(response.getBody());
			}

			return response;
	}
}