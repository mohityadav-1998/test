public Class CalloutClass {

public static HttpResponse getInfoFromExternalService(){

HttpRequest req = new HttpRequest();
req.setEndpoint('https://api.exchangeratesapi.io/latest&#8217');
req.setMethod('GET');
Http h = new Http();
HttpResponse res = h.send(req);
return res;

}
}