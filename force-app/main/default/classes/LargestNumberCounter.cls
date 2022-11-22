/**
 * Find the second largest number from the list.
 */
public class LargestNumberCounter {
    
    public static Integer findLargestNumberCounter(List<Integer> numbers) {

        numbers.sort();

        return numbers.get(numbers.size()-2);
    }
}
