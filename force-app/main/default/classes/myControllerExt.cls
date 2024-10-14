public class myControllerExt {
    private final Account acct;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public myControllerExt(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
        System.debug('AccRecord---'+this.acct);
    }

    public String getGreeting() {
        return 'Hello ' + acct.name + ' (' + acct.id + ')';
    }

}