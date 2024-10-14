public class PropertyUtility {
    public static void newListedProperties(){
        List<Property__c> newPropList= New List<Property__c>();
        newPropList=[Select Name,Broker__r.Email__c,Days_On_Market__c From Property__c WHERE Date_Listed__c = LAST_N_DAYS:30 ];
        For(Property__c pt:newPropList){
            String propEmail=pt.Name+' : '+pt.Broker__r.Email__c;
            System.debug(propEmail);
        }
    }

}