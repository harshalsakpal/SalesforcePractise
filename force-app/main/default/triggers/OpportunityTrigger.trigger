trigger OpportunityTrigger On Opportunity (before insert, before update) {

    if(Trigger.isBefore) {
        
        if(Trigger.isInsert) {
            
            OpportunityTriggerHandler.handleBeforeInsert();
        }

        if(Trigger.isUpdate) {

            OpportunityTriggerHandler.handleBeforeUpdate();
        }
    }
}