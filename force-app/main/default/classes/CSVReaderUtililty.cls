/*Created By : KVP- Chakresh Verma
*Name : CSVReaderUtililty
*Created on : 19 Aug 2021
*Description : This Class is Used to Read the CSV
*/
public class CSVReaderUtililty {
    public static Transient List<List<String>> linesValues = new List<List<String>>();
    private Transient String csvString;
    private Integer csvStringLength;
    private Integer position = 0;
    private static String COMMA = ',';
    private static String NL = '\n';
    private static String QUOTE = '"';
    private static String DOUBLE_QUOTE = '""';
    
    public boolean EOF {
        get
        {
            if( this.position < this.csvStringLength )
                return false;
            else
                return true;
        }
    }
    
    public CSVReaderUtililty(String csvString)
    {
        this.csvString = csvString;
        this.csvStringLength = csvString.length();
    }
    
    private integer ReadToLine(Integer position, List<String> values)
    {
        Integer startPos = position;
        
        String currentValue;
        Integer cAt, nlAt, foundAt;
        
        List<String> tmpValues = new List<String>();
        while (position < csvStringLength)
        {
            cAt = this.csvString.indexOf( COMMA, position );
            nlAt = this.csvString.indexOf( NL, position );
            foundAt = Math.min( cAt, nlAt );
            if( foundAt == -1 )
                foundAt = Math.max( cAt, nlAt );
            
            
            if (foundAt == -1)
            {
                currentValue = this.csvString.substring(startPos);
                position = this.csvStringLength;
            }
            else
            {
                currentValue = this.csvString.substring(startPos, foundAt );
                position = foundAt + 1;
            }
            
            
            if( !currentValue.startsWith( QUOTE ) )
            {
                tmpValues.add( currentValue );
                
                if( foundAt == nlAt )
                    break;
                
                startPos = position;
            }
            else if( currentValue.endsWith( QUOTE ) && !currentValue.endsWith( DOUBLE_QUOTE ) )
            {
                if( currentValue.indexOf( DOUBLE_QUOTE ) == -1 )
                    tmpValues.add( currentValue.substring( 1, currentValue.length() - 1 ) );
                else
                    tmpValues.add( currentValue.substring( 1, currentValue.length() - 1 ).replace( DOUBLE_QUOTE, QUOTE ) );
                
                if( foundAt == nlAt )
                    break;
                
                startPos = position;
            }
        }
        
        values.addAll( tmpValues );
        return position;
    }
    
    public List<string> ReadLine()
    {
        List<string> values = new List<string>();
        this.position = this.ReadToLine( this.position, values );
        return values;
    }
    
    public static List<List<String>> Parse(String csvString)
    {
        List<List<String>> linesValues = new List<List<String>>();
        
        CSVReaderUtililty reader = new CSVReaderUtililty(csvString);
        while (!reader.EOF)
        {
            linesValues.add(new List<String>(reader.ReadLine()));
            
            
        }
        
        return linesValues;
    }
    
    
    
    
}