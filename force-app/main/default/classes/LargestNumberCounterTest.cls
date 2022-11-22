@isTest
private class LargestNumberCounterTest {
    
    @isTest
    static void testFindLargestNumberCounter() {

        List<Integer> numbers = new List<Integer>();
        numbers.add(1);
        numbers.add(2);
        numbers.add(3);
        numbers.add(4);
        numbers.add(5);

        Test.startTest();

            Integer secondLargestNumber = LargestNumberCounter.findLargestNumberCounter(numbers);

        Test.stopTest();

        System.assertEquals(4, secondLargestNumber, 'It should be 4');
    }
 }
