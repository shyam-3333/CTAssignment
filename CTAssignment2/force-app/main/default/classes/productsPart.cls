public class productsPart Implements database.Batchable<sobject> {
    
    Public database.querylocator start(database.batchableContext info){
        string query='Select id,name,createddate,ProductCode from Product2 WHERE (CreatedDate= yesterday AND HOUR_IN_DAY(CreatedDate) > 6)OR(CreatedDate=today)';
        return database.getqueryLocator(Query);
    }
    
    Public void execute(database.batchableContext info, List<Product2>prdlist){
               
        set<ID>PrdID= new Set<ID>();
        For(Product2 prd: prdlist){
            prdID.add(prd.ID);
        }
        
        List<SQX_Part__c>lstPArt=[Select ID, Name, Part_Number__c, Product__r.name,Product__r.ProductCode From SQX_Part__c Where Product__c=null AND Product__r.ID IN :prdID];
        
        //If name and Product code are matching Update Parts Prouduct field.
        for(SQX_Part__c part: lstPArt){
            IF((part.name==part.Product__r.name) &&(part.Part_Number__c==part.Product__r.ProductCode)){
                part.Product__c=part.Product__r.ID;
            }
                   }
        
        If(!lstPArt.isempty()){
            update lstPArt;
        }
        //If name and Product code are not matching create new Prouduct Record.
        for(SQX_Part__c part2: lstPArt){
            IF((part2.name!=part2.Product__r.name) &&(part2.Part_Number__c!=part2.Product__r.ProductCode)){
                part2.Product__r.name='test';
                part2.Product__r.ProductCode='123';
                part2.Product__c=part2.Product__r.ID;
            }
                   }
        
        If(!lstPArt.isempty()){
            insert lstPArt;
        }
        
            
        }
        
    
    Public void finish(database.batchableContext info){
        //This is finish method
    }
}