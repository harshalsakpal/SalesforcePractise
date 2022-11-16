trigger ContentDocumentTrigger on ContentDocument (after delete, before delete) {

    if(Trigger.isAfter) {

        if(Trigger.isDelete) {
            
            ContentDocumentTriggerHandler.handleAfterDelete();
        }
    }

    if(Trigger.isBefore) {

        if(Trigger.isDelete) {
            
            ContentDocumentTriggerHandler.handleBeforeDelete();
        }
    }
}