/*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)  11/8/2019   T01,T02,T03		T01 - Get user role, T02 - create user with the role
*/
@isTest
private class TestAllGoogleChart
{
    static testMethod void MethodName()
    {
        User objUser = TestDataFactory.getMechanicalRoleUser();//<T01>
        User objUser1 = TestDataFactory.getElectricalRoleUser();//<T01>
        //UserRole role =[Select id from userrole where name=:'Team Lead Electrical-A'];//T01
        //Profile pf = [Select Id from Profile where Name = 'System Administrator'];
        User u = new User();
        u.FirstName = 'Test';
        u.LastName = 'User';
        u.Email = 'testuser@test123456789.com';
        u.CompanyName = 'test.com';
        u.Title = 'Test User';
        u.Username = 'testuser@test123456789.com';
        u.Alias = 'testuser';
        u.CommunityNickname = 'Test User1';
        u.TimeZoneSidKey = 'America/Mexico_City';
        u.LocaleSidKey = 'en_US';
        u.EmailEncodingKey = 'ISO-8859-1';
       // u.ProfileId = pf.Id;
        u.LanguageLocaleKey = 'en_US';
        //insert u;
        
        Profile pf2 = [Select Id from Profile where Name = 'System Administrator'];
        User u2 = new User();
        u2.FirstName = 'Test2';
        u2.LastName = 'User2';
        u2.Email = 'testuser@test1234567891.com';
        u2.CompanyName = 'test.com';
        u2.Title = 'Test User';
        u2.Username = 'testuser@test1234567891.com';
        u2.Alias = 'testuser';
        u2.CommunityNickname = 'Test User';
        u2.TimeZoneSidKey = 'America/Mexico_City';
        u2.LocaleSidKey = 'en_US';
        u2.EmailEncodingKey = 'ISO-8859-1';
        //u2.ProfileId = pf.Id;
        u2.LanguageLocaleKey = 'en_US';
        //u2.UserRoleId=role.id;//T02
        //insert u2; 
                
        /*-------------------------fatching Record type id for Account and opportunity-------------------------*/
            ID RtAccountMBA;
            ID RtIdAllocatedRecordType;
            ID RtIdAwaitFeedbackRecordType;
            ID RtIdInitialRecordtype;
            ID RtIdLayoutRecordType;
            ID RtIdMBA;
            ID RtIdMBAServicesAllocated;
            ID RtIdMBAServicesFinal;
            ID RtIdMBASparesFinal;
            ID RtIdPECSA;
            ID RtIdQuoteSubmittedRecordType;
            ID RtIdQuoteSubmittedServices;
            ID RtIdQuoteSubmittedSpares;
            ID RtIdRegretMBARecordType;
            ID RtIdSpareServicesRecordType;
        /*----------------------------------fatching account record type id------------------------------------------------*/
       List<RecordType> AccountRt = [select name,id from RecordType where Sobjecttype='Account'];
       for(RecordType ActRt: AccountRt)
       {
            if(ActRt.name=='MBA')
            {
                RtAccountMBA=ActRt.id;
                system.debug('1-------'+RtAccountMBA);
            }
           
       }
        
        /*--------------------------------------------fatching opportunity reocrdtype id------------------------------------*/
        List<RecordType> Rt = [select name,id from RecordType where Sobjecttype='Opportunity'];  
        system.debug('ganesh-------'+Rt.size());
        for(RecordType Rtype : Rt)
        {

            if(Rtype.name=='Allocated Record Type')
            {
                RtIdAllocatedRecordType = Rtype.id;
                system.debug('2-------'+RtIdAllocatedRecordType );
            }
            if(Rtype.name=='Await Feedback Record Type')
            {
                RtIdAwaitFeedbackRecordType = Rtype.id;
                system.debug('3-------'+RtIdAwaitFeedbackRecordType);
            }
            if(Rtype.name=='Initial Record type')
            {
                RtIdInitialRecordtype = Rtype.id;
                system.debug('4-------'+RtIdInitialRecordtype );
            }
            if(Rtype.name=='Layout Record Type')
            {
                RtIdLayoutRecordType = Rtype.id;
                system.debug('5-------'+RtIdLayoutRecordType );
            }
            if(Rtype.name=='MBA')
            {
                RtIdMBA = Rtype.id;
                system.debug('6-------'+RtIdMBA );
            }
            if(Rtype.name=='MBA Services Allocated')
            {
                RtIdMBAServicesAllocated = Rtype.id;
                system.debug('7-------'+RtIdMBAServicesAllocated );
            }
            if(Rtype.name=='MBA Services Final')
            {
                RtIdMBAServicesFinal = Rtype.id;
                system.debug('8-------'+RtIdMBAServicesFinal );
            }
            if(Rtype.name=='MBA Spares Final')
            {
                RtIdMBASparesFinal = Rtype.id;
                system.debug('9-------'+RtIdMBASparesFinal );
            }
            if(Rtype.name=='PECSA')
            {
                RtIdPECSA = Rtype.id;
                system.debug('10-------'+RtIdPECSA );
            }
            if(Rtype.name=='Quote Submitted Record Type')
            {
                RtIdQuoteSubmittedRecordType = Rtype.id; 
                system.debug('11-------'+RtIdQuoteSubmittedRecordType );
            }
            if(Rtype.name=='Quote Submitted Services')
            {
                RtIdQuoteSubmittedServices = Rtype.id;
                system.debug('13-------'+RtIdQuoteSubmittedServices);
            }
            if(Rtype.name=='Quote Submitted Spares')
            {
                RtIdQuoteSubmittedSpares = Rtype.id;
                system.debug('14-------'+RtIdQuoteSubmittedSpares );
            }
            if(Rtype.name=='Regret MBA Record Type')
            {
                RtIdRegretMBARecordType = Rtype.id;
                system.debug('15-------'+RtIdRegretMBARecordType );
            }
            if(Rtype.name=='Spares & Services Record Type')
            {
                RtIdSpareServicesRecordType = Rtype.id;
                system.debug('16-------'+RtIdSpareServicesRecordType);
            }                
                
                
                
        }        
                Standard_Terms_of_Titan__c s = new  Standard_Terms_of_Titan__c();
                s.Name = 'test';
                insert s;
                
                
                Account act = new Account();
                act.Name='TestAccount';
                insert act;
                
                Opportunity o = new Opportunity();
                o.Name = 'Test for Opp Test Method';
                o.Amount=333;
                o.RecordTypeId =RtIdMBA;
                o.AccountID = act.ID;
                o.Type = 'New Opportunity';
                o.StageName = 'Preliminary Opportunity';
                o.Member1__c = objUser.Id;
                o.Member2__c = objUser1.Id;
                o.CloseDate = System.Today() + 10;
                Insert o; 
                
                Quote q = new Quote();
                q.name= 'test';
                q.opportunityId = o.id;
                insert q;
                
                
               Googlechartclass GCO = new Googlechartclass();               
               googlechartForTotalProjcetVsWon gc = new googlechartForTotalProjcetVsWon();
                
                Googlechartclass.getReportLinksForGoogleChart();
                googlechartForTotalProjcetVsWon.getTotalValueWonData();
            	googlechartForTotalProjcetVsWon.getTotalProjectWonData();
                
       /*         Opportunity op = new Opportunity();
                op.Name='TestOpp';
                op.AccountId=act.Id;
                op.RecordTypeId=RtIdMBA;
                op.Amount=333333;
                insert op; */

        
            
           
            
        
     }
}