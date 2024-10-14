@isTest
public class ContactHandlerTest {
    public static testmethod void emailDuplicacy(){
        List<contact> lst= New List<contact>();
        For(Integer i=0;i<=4;i++){
            Contact ct=new Contact(LastName='Test '+ i, Email='test'+ i +'@gmail.com');
            lst.add(ct);
        }
        insert lst;
        Contact con = New Contact(LastName='Demo',Email='test1@gmail.com');
        insert con;
        
        For(Contact ct: lst){
            ct.Email='test1@gmail.com';
            update ct;
        }
    }
}