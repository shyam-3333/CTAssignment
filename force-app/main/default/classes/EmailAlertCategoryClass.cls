public class EmailAlertCategoryClass {
    public list<product__c> dataList;
    public list<wrapper> wrapList{get;set;}
    
    public EmailAlertCategoryClass(){
        dataList = new list<product__c>();
        wrapList = new list<wrapper>();
    }
    public void loadDataExcel(){
         datetime startDateTime;
        datetime endDateTime;
        map<string,string> prKeyAndUser = new map<string,string>();
        for(Taneira_View__c tt :[select Product_Key_Finder1__c,Category_User__c from Taneira_View__c where Product_Key_Finder1__c != null and Category_User__c != null]){
            prKeyAndUser.put(tt.Product_Key_Finder1__c,tt.Category_User__c.substringAfter(','));
           
        }
        date statdate1 = system.today()-1;
        time startTime1 = time.newInstance(8, 00, 0, 0);
        startDateTime = datetime.now().addHours(-16);
        date enddate1 = system.today();
        system.debug('start and enddate'+statdate1+enddate1);
        time endTime1 = time.newInstance(7, 59, 59, 0);
        endDateTime = datetime.now();
        date statdate = system.today()-1;
        time startTime = time.newInstance(4, 00, 0, 0);
        startDateTime = datetime.now().addHours(-8);
        date enddate = system.today();
        system.debug('start and enddate'+statdate+enddate);
        time endTime = time.newInstance(3, 59, 59, 0);
        endDateTime = datetime.now();
         system.debug('startDateTime==>'+startDateTime+'endDateTime==>'+endDateTime);
        datalist = [select Actual_MRP__c,SKU_Code__c,Suggested_MRP__c,pricing_date__c,Product_Key_Finder__c from product__c where pricing_date__c > :startDateTime and pricing_date__c < :endDateTime];
        system.debug('datalist==>'+datalist);
        for(product__c pro :dataList){
            wrapper w1 = new wrapper();
            w1.pro = pro;
            if(prKeyAndUser.containskey(pro.Product_Key_Finder__c)){
                w1.userName = prKeyAndUser.get(pro.Product_Key_Finder__c);
            }
            
            wrapList.add(w1);
        }
    }
    public class wrapper{
        public product__c pro{get;set;}
        public string userName{get;set;}
        public wrapper(){
            pro = new product__c();
        }
    }

}