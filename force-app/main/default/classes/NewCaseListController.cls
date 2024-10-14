public class NewCaseListController {
    
    public List<case> getNewCases(){
        List<Case> results =[Select ID,CaseNumber From Case Where Status=:'New'];
        return results;
    }

}