public class CallPostalCodeAPI {
    @AuraEnabled
    public static string getPostalData(string pCode){
        system.debug('pCode===>'+pCode);
        string sfdcURL = 'https://api.postalpincode.in/pincode/'+pCode; 
        string response='';
        HttpRequest httpRequest = new HttpRequest(); 
        httpRequest.setMethod('GET');  
        httpRequest.setEndpoint(sfdcURL); 
        try { 
            Http http = new Http(); 
            HttpResponse httpResponse = http.send(httpRequest); 
            if (httpResponse.getStatusCode() == 200 ) { 
                response = JSON.serializePretty( JSON.deserializeUntyped(httpResponse.getBody()) );
                System.debug(' httpResponse.getBody() ' +httpResponse.getBody() ); 
                System.debug(' response ' +response );
                return response;
            } else { 
                System.debug(' httpResponse ' + httpResponse.getBody() ); 
                return httpResponse.getBody();
            }  
        } catch( System.Exception e) { 
            System.debug('ERROR: '+ e); 
            return e.getMessage();
        } 
        
    }
}