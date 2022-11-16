public without sharing class ContentDocumentHelper {

    public static List<Case> getAggregateDocumentsForCase(List<Id> caseRecordIds) {

        List<Case> cases = new List<Case>();
        Set<Id> caseIdsInAggregate = new Set<Id>();

        if(caseRecordIds != null && !caseRecordIds.isEmpty()) {

            AggregateResult[] aggResult = [SELECT LinkedEntityId, COUNT(Id)documents
                                           FROM ContentDocumentLink
                                           WHERE LinkedEntityId IN :caseRecordIds
                                           GROUP BY LinkedEntityId
                                           ];

            for(AggregateResult groupedResult: aggResult) {
                
                Case relatedCase = new Case();
                relatedCase.Id = (Id) groupedResult.get('LinkedEntityId');
                relatedCase.Number_Of_Attachments__c = (Integer) groupedResult.get('documents');

                caseIdsInAggregate.add(relatedCase.Id);

                cases.add(relatedCase);
            }

            // AggregateResult does not return Zero. This has to be handled separately.
            for(Id caseId: caseRecordIds) {

                if(!caseIdsInAggregate.contains(caseId)) {

                    cases.add(new Case(Id = caseId, Number_Of_Attachments__c = 0));
                }
            }
        }

        return cases;
    }

    public static Boolean isCaseRecordId(Id recordId) {
        
        if(recordId != null) {            
            if(Schema.Case.SObjectType == recordId.getSobjectType()) {

                return true;
            }
        }

        return false;
    }
}
