/**
* @File Name : AnimalsCalloutsTest.cls
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
@isTest
public class AnimalsCalloutsTest {
	@isTest static void testGetCallout(){
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		mock.setStaticResource('GetAnimalResource');
		mock.setStatusCode(200);
		mock.setHeader('Content-Type','application/json;charset=UTF-8');
		Test.setMock(HttpCalloutMock.class,mock);
		HttpResponse result=AnimalsCallouts.makeGetCallout();
		Assert.areNotEqual(null,result,'The callout returned a nulll response ...');
		Assert.areEqual('application/json;charset=UTF-8',result.getHeader('Content-Type'),'The content type value is not expected ');
		Map<String,Object> results=(Map<String,Object>)JSON.deserializeUntyped(result.getBody());
		List<Object> animals=(List<Object>)results.get('animals');
		Assert.areEqual(3,animals.size(),'The array should only contain 3 items ');

	}
}