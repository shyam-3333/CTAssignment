global class sendEmailsToActivityOwners implements database.Batchable<sobject>, Database.Stateful
{
       global list<npd_Activity__c > ActsTonotification = new list<npd_Activity__c >();

       global list<npd_Activity__c > ActsTonotification2 = new list<npd_Activity__c >();
       
       global  Date dte = Date.today().addDays(-2);
       
       global  Date dte2 = Date.today().addDays(2);
       
       global  String BodyText = 'hi sir , <br/><br/>';
       
      global  String BodyText2 = 'hi sir , <br/><br/>';



  global database.querylocator start(database.BatchableContext bc)
    {
      
       String Name ='Completed';
       String ActName ='Activity';
       
     
      return database.getquerylocator('select id,name__c,planned_end_date__c,Stage_name__c,NPD_Project_Name__r.name,notificationEmail__c,notificationEmail2__c,NPD_Project_Name__c from npd_activity__c where (status__c !=\''+Name+'\' and type__c=\''+ActName+'\' )' );

     
            }
    global void execute(database.BatchableContext bc, list<npd_activity__c>npdActs)
    {
    
     
     // intially disableing Activity and stage trigger . End of the method activating those triggers again. 
       Npd_activity_trigger_controller__c  cus1 = [select id,continueExecution__c  from Npd_activity_trigger_controller__c where name='stagetrigger'];
       cus1.continueExecution__c = true;
        update cus1;
     
    
    
        System.debug('------------->');
        list<npd_Activity__c > ActsToUpdate=new list<npd_Activity__c >();
        list<npd_Activity__c > ActsToUpdate2=new list<npd_Activity__c >();
         

        //  Adding activities to send email to the admin on this status. 
         for(npd_Activity__c n3:npdActs)
       {
               // if(ActsTonotification.size() < 10000)
               if(n3.planned_end_date__c == dte && n3.NPD_Project_Name__c != null)
               {      
                    // system.debug('The n3 name is : '+ n3.name__c);
                     ActsTonotification.add(n3);
                     
               }
               
               if(n3.planned_end_date__c == dte2 && n3.NPD_Project_Name__c != null )
               {      
                   
                     ActsTonotification2.add(n3);
                     
               }

        }
        
        
        
        
       
     // Making the checkbox to true to fire the workflow email alert.
       for(npd_Activity__c n1:npdActs)
       {
        if(n1.planned_end_date__c == dte && n1.NPD_Project_Name__c != null)
        {
            n1.notificationEmail__c = true;
            ActsToUpdate.add(n1);
         }
         
         if(n1.planned_end_date__c == dte2 && n1.NPD_Project_Name__c != null)
        {
            n1.notificationEmail2__c = true;
            ActsToUpdate.add(n1);
         }
         
        }
        update ActsToUpdate;
        
      // Revert backing the checkbox for reusing the same field for next time.
      
         for(npd_Activity__c n2:npdActs)
       {
        n2.notificationEmail__c = false;
        n2.notificationEmail2__c = false;
        ActsToUpdate2.add(n2);
        }
        
        update ActsToUpdate2;     
        
       
       
       Npd_activity_trigger_controller__c  cus2 = [select id,continueExecution__c  from Npd_activity_trigger_controller__c where name='stagetrigger'];
       cus2.continueExecution__c = false;
        update cus2;
       
        
    }
    global void finish(database.BatchableContext bc)
    {
        

      for(npd_activity__c npd1 : ActsTonotification)
      {
        BodyText = BodyText + npd1.name__c + ' ---  '  + npd1.Stage_name__c +'   ---   ' +  npd1.NPD_Project_Name__r.name +'<br/><br/>'; 
        
         //BodyText =BodyText +  '***********************************************'+'\n';   
         

       }
       
        for(npd_activity__c npd2 : ActsTonotification2)
      {
        BodyText2 = BodyText2 + npd2.name__c + ' ---  '  + npd2.Stage_name__c +'   ---   ' +  npd2.NPD_Project_Name__r.name +'<br/><br/>'; 
        
         //BodyText =BodyText +  '***********************************************'+'\n';   
         

       }
       
      

    Messaging.SingleEmailMessage mail1=new Messaging.SingleEmailMessage();
            String[] toadd=new String[]{'sai.prasanth@kvpcorp.com'};
           mail1.setToAddresses(toadd);
            mail1.setSubject('Activities end date before 2 days processed list');
          // mail1.setPlainTextBody(BodyText);
           // mail1.setHtmlBody('<html><body>'+BodyText+'</body></html>');
            mail1.setHtmlBody(BodyText);
         //   Messaging.sendEmail(new Messaging.singleEmailMessage[]{mail1});
            
            
            Messaging.SingleEmailMessage mail2=new Messaging.SingleEmailMessage();
            String[] toadd2=new String[]{'sai.prasanth@kvpcorp.com'};
           mail2.setToAddresses(toadd2);
            mail2.setSubject('Activities end date after 2 days processed list');
          // mail1.setPlainTextBody(BodyText);
           // mail1.setHtmlBody('<html><body>'+BodyText+'</body></html>');
            mail2.setHtmlBody(BodyText2);
            Messaging.sendEmail(new Messaging.singleEmailMessage[]{mail2,mail1});
            
    }
    
    }