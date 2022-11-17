/**
 * Given a string “wwwwaaabcaaaa” provide output as “w4a3bca4”
 */
public without sharing class CountCharacterHelper {

    public String countCharacters(String input) {

        String output = '';

        for(Integer iCount=0; iCount<input.length(); iCount++) {

            Integer charCount = 1;
            String firstChar = input.substring(iCount, iCount+1);

            while(iCount+1 < input.length() && firstChar == input.substring(iCount + 1, iCount + 2)) {

                iCount++;
                charCount++;
            }

            output += firstChar;

            if(charCount > 1) {
                output += String.valueOf(charCount);
            }
        }

        return output;
    }
}
