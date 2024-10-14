public class CurrencyExchangeRatesMockoutTest implements HttpCalloutMock  {
private static final String RESPONSE_BODY ='{"base":"EUR","date":"2018-08-27","rates":{"AUD":1.5886,"BGN":1.9558,"BRL":4.7606,"CAD":1.5182,"CHF":1.1428,"CNY":7.9396,"CZK":25.744,"DKK":7.4582,"GBP":0.90365,"HKD":9.1318,"HRK":7.4375,"HUF":323.87,"IDR":17016.0,"ILS":4.2281,"INR":81.623,"ISK":124.6,"JPY":129.16,"KRW":1294.4,"MXN":21.81,"MYR":4.7777,"NOK":9.6988,"NZD":1.7415,"PHP":61.997,"PLN":4.271,"RON":4.6423,"RUB":78.28,"SEK":10.61,"SGD":1.5884,"THB":37.929,"TRY":7.2082,"USD":1.1633,"ZAR":16.646}}';
public static final String RESPONSE_HEADER_PARAM_NAME = 'Content-Type';
public static final String RESPONSE_HEADER_CONTENT_TYPE = 'application/json';
public HTTPResponse respond(HttpRequest req){
HttpResponse resp=new HttpResponse();
resp.setHeader(RESPONSE_HEADER_PARAM_NAME, RESPONSE_HEADER_CONTENT_TYPE);
resp.setBody(RESPONSE_BODY);
resp.setStatusCode(200);
return resp;

}
}