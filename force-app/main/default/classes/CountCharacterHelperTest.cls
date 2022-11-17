@isTest(IsParallel = true)
private class CountCharacterHelperTest {
    
    @isTest
    static void testCharacterCount() {

        String input = 'wwwwaaabcaaaa';
        CountCharacterHelper charHelper = new CountCharacterHelper();

        Test.startTest();
            
            String output = charHelper.countCharacters(input);

        Test.stopTest();

        System.assertEquals('w4a3bca4', output, 'Output does not match expected string');
    }
}
