@isTest
public class CalloutClassTest {

@isTest
public static void testCallout(){
      Test.setMock(HttpCalloutMock.class, new CurrencyExchangeRatesMockoutTest());
       Test.startTest();
             HttpResponse res = CalloutClass.getInfoFromExternalService();
        Test.stopTest();

}
}