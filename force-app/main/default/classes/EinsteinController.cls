public class EinsteinController {
    @AuraEnabled
    public static String getAccessToken() {
        ContentVersion base64Content = [SELECT Title, VersionData FROM ContentVersion where Title='einstein_platform.pem1' ORDER BY Title LIMIT 1];
        System.debug('base64Content==='+base64Content);
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
    
    public static void getImageText() {
        String access_token = getAccessToken();
        //System.debug('Access Token'+access_token);
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.einstein.ai/v2/vision/ocr');
        req.setHeader('content-type', 'multipart/form-data; charset="UTF-8"; boundary="1ff13444ed8140c7a32fc4e6451aa76d"');
        req.setHeader('Authorization', 'Bearer '+access_token); //replace token with your access token
        
        req.setHeader('Cache-Control', 'no-cache');
        string form64 = '';
        
        form64 += HttpFormBuilder.WriteBoundary();
         form64 += HttpFormBuilder.WriteBodyParameter('sampleLocation','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpUN_fTKgpSEMREz3ctB-pWaCb-SSDmbjwrA&usqp=CAU');
        //form64 += HttpFormBuilder.WriteBodyParameter('sampleLocation', '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');
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('modelId', 'OCRModel');
        form64 += HttpFormBuilder.WriteBoundary(HttpFormBuilder.EndingType.CrLf);
        
        blob formBlob = EncodingUtil.base64Decode(form64);
        string contentLength = string.valueOf(formBlob.size());
        
        req.setBodyAsBlob(formBlob);
        req.setHeader('Connection', 'keep-alive');
        req.setHeader('Content-Length', contentLength);
        req.setTimeout(60*1000);
        
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        System.debug('Status Code: '+res.getStatusCode());
        System.debug('Status Code: '+resp);
        System.debug('=='+resp );
        if(res.getStatusCode() == 200) {
            EinteinParser ocr = EinteinParser.parse(resp);  
            for( EinteinParser.Probabilities prob : ocr.probabilities) {
                system.debug('========Label==== '+prob.label);
                system.debug('========BoundingBox==== '+prob.boundingBox);
                system.debug('========probability==== '+prob.probability);
            }        
        }
        
    }
    @AuraEnabled
    public static SObject getBusinessCardText(String imageUrl) {
        String access_token = getAccessToken();
        System.debug('imageUrl'+imageUrl);
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.einstein.ai/v2/vision/ocr');
        req.setHeader('content-type', 'multipart/form-data; charset="UTF-8"; boundary="1ff13444ed8140c7a32fc4e6451aa76d"');
        req.setHeader('Authorization', 'Bearer '+access_token); //replace token with your access token
        
        req.setHeader('Cache-Control', 'no-cache');
        string form64 = '';
        
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('sampleLocation', imageUrl);
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('modelId', 'OCRModel');
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('task', 'contact');
        form64 += HttpFormBuilder.WriteBoundary(HttpFormBuilder.EndingType.CrLf);
        
        blob formBlob = EncodingUtil.base64Decode(form64);
        string contentLength = string.valueOf(formBlob.size());
        
        req.setBodyAsBlob(formBlob);
        req.setHeader('Connection', 'keep-alive');
        req.setHeader('Content-Length', contentLength);
        req.setTimeout(60*1000);
        
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        System.debug('Status Code: '+res.getStatusCode());
         System.debug('Status Code: '+resp);

        if(res.getStatusCode() == 200) {
            EinteinParser ocr = EinteinParser.parse(resp);  
            for( EinteinParser.Probabilities prob : ocr.probabilities) {
                system.debug('========Label==== '+prob.label);
                system.debug('========BoundingBox==== '+prob.boundingBox);
                system.debug('========probability==== '+prob.probability);
            }        
        }
        SObject rec=  convertOCRResponseToSObjectRecord('Lead', resp );
        return rec;
        
    }

    @AuraEnabled
    public static SObject convertOCRResponseToSObjectRecord(
    String objectApiName,String resp //Lead or Contact
    ) {
        SObject record = ((SObject)Type.forName(objectApiName).newInstance());
    String uncategorisedWords='';
    String separator = '\n';
        EinteinParser ocr = EinteinParser.parse(resp);
    for(EinteinParser.Probabilities extractedWord : ocr.probabilities) {
        System.debug(extractedWord);           
        String word = extractedWord.label.trim();
        switch on extractedWord.attributes.tag {
            when 'PERSON' {
                record.put('LastName', word);
            }
            when 'ADDRESS' {
                uncategorisedWords += 'Address: '+ word;
            }
            when 'PHONE' {
                record.put('Phone',word);
            }
            when 'MOBILE_PHONE' {
                record.put('MobilePhone',word);
            }when 'EMAIL' {
                record.put('Email',word);
            }
            when 'WEBSITE' {    
                if(objectApiName == 'Lead') record.put('Website', word);
                uncategorisedWords += 'Website: '+ word + separator;
            }
            when 'ORG' {
                if(objectApiName == 'Lead') record.put('Company', word);
                uncategorisedWords += 'Company: '+ word+ separator;
            }
            when else {
                uncategorisedWords +=  word + separator;
            }
        }
    }
    record.put('Description', uncategorisedWords);
        //Adding all the unmapped words(the ones tagged as 'OTHER') to the 'Description' field.
        System.debug('Record----'+record);
        If(record.get('LastName')==''){
            record.put('LastName','OCR123');}
        insert record;
        System.debug('Record----'+record.get('Id'));
    return record;
    }

 @AuraEnabled
    public static string getImageUrl(Id fileId){
        string before = 'Testing base 64 encode';            
         Blob beforeblob = Blob.valueOf(before);
        System.debug('fileId----   '+fileId);
        ContentVersion cv = [select id from contentversion where contentdocumentid =:fileId];
        /*ContentVersion cv  = new ContentVersion();
        cv.ContentDocumentId=fileId;
        cv.Title='File Title';
        cv.PathOnClient ='test'; 
        cv.VersionData =beforeblob;      
        insert cv;*/
        ContentDistribution cd = new ContentDistribution();
        cd.ContentVersionId=cv.Id;
        cd.Name='Distribution '+fileId;
        cd.PreferencesNotifyOnVisit=false;
        cd.PreferencesAllowViewInBrowser=true;
       // cd.PathOnClient ='test'; 
        insert cd;
        System.debug('cd----   '+cd.Id);
        String fileUrl=[Select DistributionPublicUrl From ContentDistribution Where Id=:cd.Id].DistributionPublicUrl;
        
        System.debug('fileUrl----   '+fileUrl);
       
        return fileUrl;
    }

}