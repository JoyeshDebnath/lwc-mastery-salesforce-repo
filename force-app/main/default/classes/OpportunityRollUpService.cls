//contains all the business logics of the Opportunity roll up summeray related trigger

public  class OpportunityRollUpService {
    public static void updateAccountRevenue(Set<Id> accountIds){
        List<Account> accountsToUpdate=new List<Account>();

        List<AggregateResult> aggr=[SELECT AccountId,SUM(Amount) AnnualRevenue 
                                    FROM Opportunity
                                    WHERE AccountId IN : accountIds
                                    AND StageName='Closed Won'
                                    AND CALENDAR_YEAR(CloseDate) =:System.today().year()
                                    GROUP BY AccountId
                                    ];
        Map<Id,Decimal> revenueMap=new Map<Id,Decimal>();
        for(AggregateResult ar:aggr){
            revenueMap.put((Id)ar.get('AccountId'),(Decimal)ar.get('AnnualRevenue'));
        }
        for(Id accId:accountIds){
            Decimal revenue=revenueMap.containsKey(accId)?revenueMap.get(accId):0;
            accountsToUpdate.add(new Account(Id=accId,AnnualRevenue=revenue));
        }

        if(!accountsToUpdate.isEmpty())
            update accountsToUpdate;
    }
}