@isTest(isParallel=true)
private class ContentDocumentTriggerTest {

    @isTest
    static void testAfterInsert() {

        Test.startTest();

            createAttachments(1);

        Test.stopTest();

        Case myCase = [SELECT Id, Number_Of_Attachments__c FROM Case];

        System.assertEquals(1, myCase.Number_Of_Attachments__c, 'Counter should be at One.');
    }

    @isTest
    static void testAfterDeleteOneFile() {

        createAttachments(1);

        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];

        Test.startTest();

            delete documents;

        Test.stopTest();

        Case myCase = [SELECT Id, Number_Of_Attachments__c FROM Case];

        System.assertEquals(0, myCase.Number_Of_Attachments__c, 'Counter should set to zero.');        
    }

    @isTest
    static void testAfterDeleteMultipleFiles() {

        createAttachments(5);

        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument LIMIT 3];

        Test.startTest();

            delete documents;

        Test.stopTest();

        Case myCase = [SELECT Id, Number_Of_Attachments__c FROM Case];

        System.assertEquals(2, myCase.Number_Of_Attachments__c, 'Counter should set to two.');    
    }

    private static void createAttachments(Integer numberOfAttachments) {

        Case newCase = new Case();
        newCase.Subject = 'Test Case';
        
        insert newCase;

        List<ContentVersion> contentVersions = new List<ContentVersion>();
        for(Integer iCount=0; iCount<numberOfAttachments; iCount++) {

            ContentVersion oneVersion = new ContentVersion();
            oneVersion.Title = 'Photo Number ' + iCount;
            oneVersion.PathOnClient = 'Pic' + iCount + '.jpg';
            oneVersion.VersionData = Blob.valueOf('Test Content');
            oneVersion.IsMajorVersion = true;

            contentVersions.add(oneVersion);
        }
        
        insert contentVersions;

        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();

        for(ContentDocument document: documents) {

            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.LinkedEntityId = newCase.Id;
            cdl.ContentDocumentId = document.Id;
            cdl.ShareType = 'V';
            cdl.Visibility = 'AllUsers';

            cdls.add(cdl);
        }

        insert cdls;
    }
}
