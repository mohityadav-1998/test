public class ContactHandler {
    public static void emailDuplicacy(List<contact> newList, Map<Id,Contact> oldMap){
        Map<String,Contact> mapOfemailVsContact = New Map<String,Contact>();
        For(Contact con: newList){
            If(con.Email!=null && (oldMap==null || con.Email != oldMap.get(con.Id).Email)){
                If(mapOfemailVsContact.containsKey(con.Email)){
                    con.Email.addError('This Email already exist');
                }else{
                    mapOfemailVsContact.put(con.Email,con);
                }
            }
        }
        
        For(Contact ct:[Select Id,Name, Email From Contact Where Email IN:mapOfemailVsContact.keySet()]){
            If(ct.Email==mapOfemailVsContact.get(ct.Email).Email){
                Contact con= mapOfemailVsContact.get(ct.Email);
                con.Email.addError('Email Already Exist in the system');
            }
        }
    }
}