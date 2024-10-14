public class SalesforceSentiment {
@AuraEnabled
   
    public static String getAccessToken() {
        ContentVersion base64Content = [SELECT Title, VersionData FROM ContentVersion where Title='einstein_platform.pem1' OR  Title='predictive_services' ORDER BY Title LIMIT 1];
        String keyContents = base64Content.VersionData.tostring();
         keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
         keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
         keyContents = keyContents.replace('\n', '');
        JWT jwt = new JWT('RS256');
        jwt.pkcs8 = keyContents; 
        jwt.iss = 'developer.force.com';
        jwt.sub = 'mohityadav161098@gmail.com'; // Change this with your email which is used for einstein api setup
        jwt.aud = 'https://api.einstein.ai/v2/oauth2/token';
        jwt.exp = '3600';
        String access_token = JWTBearerFlow.getAccessToken('https://api.einstein.ai/v2/oauth2/token', jwt);
          System.debug('Access Token'+access_token);        
        return access_token;    
    }
    
    @future(Callout=true)
    public static void getSentiment(Set<Id> Ids) {
        System.debug('Case List  '+Ids);
        For(Case cs:[Select Id,Description From Case Where Id IN: Ids ]){
            
        System.debug('Description '+cs.Description);
        string sentimentModelId= 'CommunitySentiment';
        string text='The presentation was great and I learned a lot';
        String access_token = getAccessToken();
        //System.debug('Access Token'+access_token);
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.einstein.ai/v2/language/sentiment');
        req.setHeader('content-type', 'application/json');
        req.setHeader('Authorization', 'Bearer '+access_token); //replace token with your access token
        req.setHeader('Cache-Control', 'no-cache');
        String body = '{\"modelId\":\"'+ sentimentModelId + '\",\"document\":\"' + cs.Description + '\"}';
        req.setBody( body );
        req.setTimeout(60*1000);
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
       SentimentAnalysisResponse wrapresp = ( SentimentAnalysisResponse ) JSON.deserialize( res.getBody(), SentimentAnalysisResponse.class );
        System.debug('SentimentAnalysisResponse: '+wrapresp.probabilities[0].label);
            
        AssignmentRule AR = new AssignmentRule(); 
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
         Database.DMLOptions dmlOpts = new Database.DMLOptions();
         dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
         case updateCase = new case(); 
            updateCase.Id = cs.Id; 
            updateCase.Sentiment__c=wrapresp.probabilities[0].label;
           updateCase.setOptions(dmlOpts);
            update updateCase;
            System.debug('cs  '+updateCase);
        
    }
    }

}