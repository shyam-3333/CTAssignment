public class CsvRowUtility {
 Public static list<string> parseCSVRow(string csvLine){
        String prevLine = csvLine;
        Integer startIndex;
        Integer endIndex;
        while(csvLine.indexOf('"') > -1){
            if(startIndex == null){ 
                startIndex = csvLine.indexOf('"');   
                csvLine = csvLine.substring(0, startIndex) + ':quotes:' + csvLine.substring(startIndex+1, csvLine.length());    
            }else{ 
                if(endIndex == null){   
                    endIndex = csvLine.indexOf('"');
                    csvLine = csvLine.substring(0, endIndex) + ':quotes:' + csvLine.substring(endIndex+1, csvLine.length());          
                }      
            }   
            if(startIndex != null && endIndex != null){        
                String sub = csvLine.substring(startIndex, endIndex);       
                sub = sub.replaceAll(',', ':comma:');      
                csvLine = csvLine.substring(0, startIndex) + sub + csvLine.substring(endIndex, csvLine.length());
                startIndex = null;
                endIndex = null;       
            }   
        }
        list<string> parsedData = new list<string>();
        for(String column : csvLine.split(',')){
            column = column.replaceAll(':quotes:', '').replaceAll(':comma:', ',');
            parsedData.add(column);
        }
        
        return parsedData;
    }
}