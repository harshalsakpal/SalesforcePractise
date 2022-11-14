@isTest(isParallel=true)
private class MapConversionTest {
    @isTest
    static void testConvertSet(){

        setupData();
        Map<Id, Id> mapOfOpportunityIdToAccountId = new Map<Id, Id>();
        
        List<Opportunity> lstOpportunity = [SELECT Id, AccountId FROM Opportunity];
        for(Opportunity anOpportunity: lstOpportunity){
            mapOfOpportunityIdToAccountId.put(anOpportunity.Id, anOpportunity.AccountId);
        }
        
        Set<Id> accountIds = MapConversion.convertSet(mapOfOpportunityIdToAccountId).keySet();                
        System.assertEquals(3, accountIds.size());
    }
    
    @isTest
    static void testNullInput(){

        Map<Id, List<Id>> mapAccountIdListOpportunityId = MapConversion.convertSet(null);
        System.assertEquals(null, mapAccountIdListOpportunityId);
    }
    
    @isTest
    static void testEmptyCollectionInput(){

        Map<Id, Id> mapOfOpportunityIdToAccountId = new Map<Id, Id>();
        Map<Id, List<Id>> mapAccountIdListOpportunityId = MapConversion.convertSet(mapOfOpportunityIdToAccountId);
        System.assertEquals(null, mapAccountIdListOpportunityId);
    }    
    
    private static void setupData(){
        
        Account anAccount1 = new Account(Name = 'Acc1');
        Account anAccount2 = new Account(Name = 'Acc2');
        Account anAccount3 = new Account(Name = 'Acc3');
        List<Account> lstAccount = new List<Account>{anAccount1, anAccount2, anAccount3};
            insert lstAccount;
        
        List<Opportunity> lstOpportunity = new List<Opportunity>();        
        lstOpportunity.add(new Opportunity(Name = 'Acc1-Opp1', AccountId = anAccount1.Id, StageName = 'Prospecting', CloseDate=Date.today().addDays(60)));
        lstOpportunity.add(new Opportunity(Name = 'Acc1-Opp2', AccountId = anAccount1.Id, StageName = 'Prospecting', CloseDate=Date.today().addDays(60)));
        lstOpportunity.add(new Opportunity(Name = 'Acc1-Opp3', AccountId = anAccount1.Id, StageName = 'Prospecting', CloseDate=Date.today().addDays(60)));
        
        lstOpportunity.add(new Opportunity(Name = 'Acc2-Opp1', AccountId = anAccount2.Id, StageName = 'Prospecting', CloseDate=Date.today().addDays(60)));
        lstOpportunity.add(new Opportunity(Name = 'Acc2-Opp2', AccountId = anAccount2.Id, StageName = 'Prospecting', CloseDate=Date.today().addDays(60)));
        
        lstOpportunity.add(new Opportunity(Name = 'Acc3-Opp1', AccountId = anAccount3.Id, StageName = 'Prospecting', CloseDate=Date.today().addDays(60)));
        
        insert lstOpportunity;        
    }
}
