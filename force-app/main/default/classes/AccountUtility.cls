public class AccountUtility {
    public static void viewAnnualRevenue(){
        List<Account> accountsList = New List<Account>();
        accountsList=[Select Name,AnnualRevenue From Account];
        For(Account act:accountsList){
            String acctRev =act.Name+':'+act.AnnualRevenue;
            System.Debug(acctRev);
                }
    }
}