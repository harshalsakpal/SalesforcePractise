public without sharing class ContentDocumentTriggerHandler {

    @TestVisible
    private static List<Id> caseIdsForDeletedDocuments = new List<Id>();

    public static void handleBeforeDelete() {

        caseIdsForDeletedDocuments = getRelatedCaseIds((List<ContentDocument>) Trigger.Old);
    }

    public static void handleAfterDelete() {

        if(!caseIdsForDeletedDocuments.isEmpty()) {

            List<Case> caseWithDocuments = ContentDocumentHelper.getAggregateDocumentsForCase(caseIdsForDeletedDocuments);

            Database.update(caseWithDocuments, true);
        }
    }

    private static List<Id> getRelatedCaseIds(List<ContentDocument> documents) {
        
        List<Id> parentCaseId = new List<Id>();
        List<Id> documentIds = new List<Id>();

        for(ContentDocument document: documents) {

            documentIds.add(document.Id);
        }

        List<ContentDocumentLink> documentLinks = [SELECT Id, LinkedEntityId 
                                                    FROM ContentDocumentLink 
                                                    WHERE ContentDocumentId IN :documentIds
                                                  ];
        for(ContentDocumentLink documentLink: documentLinks) {
            
            if(documentLink.LinkedEntityId != null && ContentDocumentHelper.isCaseRecordId(documentLink.LinkedEntityId)) {
                
                parentCaseId.add(documentLink.LinkedEntityId);
            }
        }

        return parentCaseId;
    }    
}
