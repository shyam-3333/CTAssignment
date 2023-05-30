@istest
class Npd_schedulapexForActivityMailsTest
{
public static testMethod void testschedule() {
test.starttest();
Npd_schedulapexForActivityMails   n1= new Npd_schedulapexForActivityMails ();
String sch = '0 0 23 * * ?';
system.schedule('Test activitymails', sch, n1); 
test.stoptest();

}


}