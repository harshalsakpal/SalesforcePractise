public without sharing class ContentDocumentLinkTriggerHandler {

    public static void handleAfterInsert() {
        
        List<Id> parentCaseId = getRelatedCaseIds((List<ContentDocumentLink>) Trigger.New);
        
        List<Case> caseWithDocuments = ContentDocumentHelper.getAggregateDocumentsForCase(parentCaseId);

        Database.update(caseWithDocuments, true);
    }

    private static List<Id> getRelatedCaseIds(List<ContentDocumentLink> documents) {

        List<Id> parentCaseId = new List<Id>();

        for(ContentDocumentLink document: documents) {
            
            if(document.LinkedEntityId != null && ContentDocumentHelper.isCaseRecordId(document.LinkedEntityId)) {
                
                parentCaseId.add(document.LinkedEntityId);
            }
        }

        return parentCaseId;
    }    
}
