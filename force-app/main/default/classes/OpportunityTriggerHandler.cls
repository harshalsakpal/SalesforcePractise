public without sharing class OpportunityTriggerHandler {

    public static void handleBeforeInsert() {

        List<Opportunity> opportunitiesForOwnerValidation = new List<Opportunity>();
        Set<Id> accountIds = new Set<Id>();

        for(Opportunity newOpportunity: (List<Opportunity>) Trigger.New) {

            opportunitiesForOwnerValidation.add(newOpportunity);
            accountIds.add(newOpportunity.AccountId);
        }

        validateOpportunityOwner(opportunitiesForOwnerValidation, accountIds);
    }

    public static void handleBeforeUpdate() {

        List<Opportunity> opportunitiesForOwnerValidation = new List<Opportunity>();
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Opportunity> oldMapOpps = (Map<Id, Opportunity>) Trigger.oldMap;

        for(Opportunity newOpportunity: (List<Opportunity>) Trigger.New) { 

            if(newOpportunity.OwnerId != oldMapOpps.get(newOpportunity.Id).OwnerId
                || newOpportunity.AccountId != oldMapOpps.get(newOpportunity.Id).AccountId
            ) {
                                
                opportunitiesForOwnerValidation.add(newOpportunity);
                accountIds.add(newOpportunity.AccountId);
            }
        }

        validateOpportunityOwner(opportunitiesForOwnerValidation, accountIds);
    }

    private static void validateOpportunityOwner(List<Opportunity> opportunities, Set<Id> accountIds) {

        Map<Id, Set<Id>> accountIdToAccountTeamMemberId = new Map<Id, Set<Id>>();
        
        for(AccountTeamMember teamMember : [SELECT Id, UserId, AccountId FROM AccountTeamMember WHERE AccountId IN :accountIds]) {

            if(accountIdToAccountTeamMemberId.containsKey(teamMember.AccountId) == false) {

                accountIdToAccountTeamMemberId.put(teamMember.AccountId, new Set<Id>());
            }

            accountIdToAccountTeamMemberId.get(teamMember.AccountId).add(teamMember.UserId);
        }
        
        for(Opportunity changedOpp: opportunities) {

            Set<Id> accoutTeamMemberId = accountIdToAccountTeamMemberId?.get(changedOpp.AccountId);
            
            if(accoutTeamMemberId.contains(chagedOpp) == false) {

                // handle error either gracefully or use .addError() or throw an exception with a helpful error message.
                changedOpp.addError('Owner of this Opportunity is not present in the associated Account team');                
            }
        }
    }
}
