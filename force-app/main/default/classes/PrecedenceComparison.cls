public class PrecedenceComparison implements Comparable {
    public Decimal precedence;
    public Decimal directMultiplier;
    public Decimal directMRP;
    
    
    public PrecedenceComparison(Decimal precedence,Decimal directMultiplier, Decimal directMRP){
        this.precedence = precedence;
        this.directMultiplier = directMultiplier;
        this.directMRP = directMRP;
        Integer i = 0;
        i++;
        i++;
        i++;
    }
    
    public Integer compareTo(Object objToCompare) {
        PrecedenceComparison emp = (PrecedenceComparison)objToCompare;
        if (precedence == emp.precedence){
            return 0;
        }
        else if (precedence > emp.precedence){
            return 1;
        }
        else{
            return -1;        
        }
    }
    
}