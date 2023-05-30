global class NPD_Exception_Report_Scheduler implements Schedulable{
    global void execute(SchedulableContext ctx){
       list<String> addressLst = new list<String>();
       list<Email__c> lstEmail = Email__c.getall().values();
       for(Email__c em : lstEmail ){
           if(em.EmailId__c != null){
              addressLst.add(em.EmailId__c); 
           }
       }
        list<Blob> bl  = new List<Blob>();
        map<String,Blob> functionNameToBlob = new map<String,Blob>();
        list<String> emailName  = new List<String>();
        set<String> NPDfunctionName = new set<String>();
        List<NPD_Email__c> emailList = [select id,Name,
             NPD_Activity__c,
             NPD_Project_Items__r.Project_Template__r.Name,
             NPD_Project_Items__c,parentActName__c,Act_Name__c,
             Source__c, Type__c FROM NPD_Email__c where Type__c=: 'Successor' AND NPD_Project_Items__r.Project_Template__r.Name = : 'Regular'];
             
        for(NPD_Email__c email : emailList){
            emailName.add(email.Act_Name__c);
        }
        List<NPD_Activity__c> lSuccessorACtivity = [select id,User_Name__c,Brand1__c, collection_Name__c,NPD_User__r.Name,NPD_User__r.UserID__c,Planned_Lead_Time__c,Status__c,NPD_Collections__c,NPD_Collections__r.Name,Type__c,Model_Name__c,NPD_Project_Name__c,Function_Name__c,Name,Name__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where (Status__c = 'In Progress' OR Status__c = 'Not Started' Or Name__c = 'New Movement Certification') and Name__c in:emailName AND NPD_Project_Name__c != null  AND NPD_Collections__r.Name != null AND Active__c = True];
        for(NPD_Activity__c acttvity : lSuccessorACtivity){
            if(acttvity.Function_Name__c != null && acttvity.Function_Name__c != ''){
                NPDfunctionName.add(acttvity.Function_Name__c);
             // System.debug('NPD function Name'+acttvity.Function_Name__c);
            }
        }
        System.debug('set size'+NPDfunctionName.size());
        for(String s : NPDfunctionName){
            PageReference  pr = null;
            Blob b;
            if(s != null){
                pr = new pageReference('/apex/NPD_Exception_Report_Page?FunctionName='+s);
                if(Test.isRunningTest()) { 
                  b = blob.valueOf('Unit.Test');
                } else {
                    b = pr.getContent();
                }
                
                bl.add(b);
                functionNameToBlob.put(s,b);
            }   
        }
       
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        List<Messaging.EmailFileAttachment> emailAttach = new List<Messaging.EmailFileAttachment>();
        if(!functionNameToBlob.isEmpty()){
            for(String s : functionNameToBlob.keyset()){
                if(s != null && functionNameToBlob.get(s) != null){
                    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                    efa.setFileName(s+'.xls');
                    efa.setBody(functionNameToBlob.get(s));
                    emailAttach.add(efa);

                } 
            }  
        }
        email.setToAddresses(addressLst);
        email.setSubject('Exception Report');
        email.setPlainTextBody('Please find the attachment for details of exception');
         if(bl.size() > 0){
          email.setFileAttachments(emailAttach);
        }
        if(!test.isRunningTest()){
            Messaging.SendEmailResult [] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }

    }

}