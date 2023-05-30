public class Npd_schedulapexForActivityMails implements schedulable{
    
    public void execute(schedulablecontext sc)
    {
        sendEmailsToActivityOwners  m1= new sendEmailsToActivityOwners();
        database.executebatch(m1);
    }
                
}