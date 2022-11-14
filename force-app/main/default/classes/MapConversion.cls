/*
    Map<Id, Id> mapOfOpportunityIdToAccountId is input map which contains
    Id of an Opportunity as the key and Id of the Account as a value.
    In the method below we want to flip the keys to values such as Id of
    Account becomes the key and Opportunity becomes the value. 
    
    You may use additional collections and/or data structures as you see fit

    Hint: Account and Opportunity has a Master-Detail relationship.
*/
public class MapConversion {

    @TestVisible
    public static Map<Id, List<Id>> convertSet(Map<Id, Id> opportunityIdToAccountId) {
        
        Map<Id, List<Id>> accountIdToOpportunityIdList = null;

        if(opportunityIdToAccountId != null && opportunityIdToAccountId.isEmpty() == false) {

            accountIdToOpportunityIdList = new Map<Id, List<Id>>();
            
            for(Id oppId: opportunityIdToAccountId.keySet()) {

                Id accId = opportunityIdToAccountId.get(oppId);

                if(accountIdToOpportunityIdList.containsKey(accId) == false) {

                    accountIdToOpportunityIdList.put(accId, new List<Id>());
                }
                accountIdToOpportunityIdList.get(accId).add(oppId);
            }
        }

        return accountIdToOpportunityIdList;
    }
}
