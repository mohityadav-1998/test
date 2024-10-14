public class OpportunityHandler {
    public static void CheckClosedWonOpps(List<Opportunity> oppList, Map<Id,Opportunity> oldMap){
        Set<Id> setOfAccIds = New Set<Id>();
        Map<String,Opportunity> mapofAccidWithOpps = New Map<String,Opportunity>(); 
        For(Opportunity op:oppList){
            If(op.AccountId!=null && (oldmap==null || op.StageName != oldMap.get(op.Id).StageName)){
                   setOfAccIds.add(op.AccountId); 
                    mapofAccidWithOpps.put(op.AccountId,op);
                System.debug('1st---'+setOfAccIds);
                System.debug('2nd---'+mapofAccidWithOpps);
               }
        }
        List<Account> lstAccs= [Select Id,Name, (Select Id From Opportunities Where StageName='Closed Won')
                        From Account Where Id IN:setOfAccIds ];
        System.debug('6th---'+lstAccs);
        
        For(Account ac:lstAccs){
                            System.debug('5th---'+ac);
                            If(ac.Opportunities.size()>2){
                                System.debug('3rd---'+ac.Opportunities.size());
                              Opportunity opp =  mapofAccidWithOpps.get(ac.Id);
                                System.debug('4th---'+opp);
                                opp.stageName.addError('You can not create opprtunity if two already in closed won stage');
                            }
        }
    }
}