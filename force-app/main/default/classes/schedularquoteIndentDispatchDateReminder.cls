global class schedularquoteIndentDispatchDateReminder Implements Schedulable  {
    
    /* schedularquoteIndentDispatchDateReminder s=new schedularquoteIndentDispatchDateReminder();
        String cronStr = '0 0,30 * * * *';
		System.schedule('Process Accs Job', cronStr, s);  */
    
     global void execute(SchedulableContext sc){
      
       quoteIndentDispatchDateReminder qt=new quoteIndentDispatchDateReminder();        
       database.executebatch(qt);
    }
}