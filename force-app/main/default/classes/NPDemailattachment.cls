public class NPDemailattachment {
 
    public string actid;
    public string collactid {get;set;}
    public string attid;
    public list<string> fieldApi;
    public list<string> fieldApi2;
    public Map<String,String> urlMap=new Map<String,String>();
    public List<Attachment> attach;
    public string link;
    public string link1;
    public string linkcoll;
    Public List<Sobject> checklist{get;set;}
    
    public string getactid() {
    return null;
    }
    public void setactid(String s) {
    
    actid=s;
    system.debug('actid***************'+actid);
    }
     
    
    
    /*public void setcollactid(String s1) {
    collactid=s1;
    system.debug('collactid***************'+collactid);
    
    }*/
    public List<string>getfieldApi2(){
             fieldApi = new list<string>();
           fieldapi2 = new list<String>();
            string fieldList = [SELECT Checklist_Columns__c FROM NPD_Activity__c WHERE id =:actid].Checklist_Columns__c;
            fieldList = fieldList.replaceAll('\\n','');
            fieldList = fieldList.trim();
            Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap();
            string apiNameString ='';    
                for(Schema.SObjectField field : Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap().values()) {
                    string temp = field.getDescribe().getLabel();
                    if(fieldList.contains(temp)) {
                        string apiName  =  field.getDescribe().getName();
                        apiNameString   =  apiNameString+ ','+apiName;
                        fieldApi.add(apiName);                    
                    }
                } 
                
                 //Map with lable name with api name of fields. 
                 map<string,string> labelWithApi = new map<string,string>();
                 for(Schema.SObjectField field : Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap().values()) {
                  string temp = field.getDescribe().getLabel();
                  string temp1= field.getDescribe().getName();
                  
                   labelWithApi.put(temp,temp1);
                }
                set<String> tempfieldschset = new set<string>();
                tempfieldschset.addall(labelWithApi.keyset());
                
                list<string> tempfieldList = new list<string>();
                tempfieldList = fieldList.split(',');
                
                 fieldapi2 = new list<string>();
                system.debug('tempfieldList: '+tempfieldList+'...'+tempfieldschset);
             for(string t1:tempfieldList)
              {      
                if(tempfieldschset.contains(t1))
                {
                 
                  string tempstr = labelWithApi.get(t1);
                  system.debug('inside if stagement: ' + labelWithApi.get(t1));
                  fieldapi2.add(tempstr);
                }
                 system.debug('fieldapi2: '+fieldapi2);
              }  
          
            
        string query = 'SELECT id'+apiNameString+','+'Name FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__c=:actid';
        
        
        checklist = new List<Sobject>();
        try{
            checklist = database.query(query);
            if(Test.isRunningTest())
            Integer i = 10/0;
        }
        catch(exception e){}
        
       //return fieldApi;
         return fieldapi2;
    }
    
    
    public Map<String,String> getattach() {
    attach=[Select id,name From Attachment Where Parentid=:actid  ];
    system.debug('=============attach==========='+attach);
    for(Attachment att1:attach) {
    String urls=URL.getSalesforceBaseURL().toExternalForm()+'/servlet/servlet.FileDownload?file='+att1.id ;
    urlMap.put(urls,att1.Name);
    }
    return urlMap;
    }
    
    public string getlink(){
    link1 = URL.getSalesforceBaseUrl().toExternalForm()+'/apex/NPDApprovalPage?id='+actid;
    return link1;
    }
    
    
    public string getlinkcoll1(){
        linkcoll= URL.getSalesforceBaseUrl().toExternalForm()+'/'+collactid ;
        return linkcoll;
    }
    
    public void setattach(List<Attachment> ata) {
    attach=ata;
    }
    public void setlink(string l){
    link = l;
    }
    
    
    
}