public class AssignStdPKtoQuote {
    public void assignPB(list<quote> newList) {
        id stdPBId = ([SELECT Id,name FROM Pricebook2 where name = 'Standard Price Book' limit 1]).id;
        for(quote q1 :newList){
            q1.priceBook2Id = stdPBId;
        }
    }

}