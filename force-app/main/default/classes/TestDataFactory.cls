/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/12/2019   		Created to create a new user of role Electrical which will be used in many test classes
*/
public class TestDataFactory {
    
    private static User electricalUser = null;
    private static User mechanicalUser = null;
    public static User getElectricalRoleUser(){
        // UserRole role = [select Id,Name from userrole where Name like '%Electrical%' LIMIT 1];
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId()];
        User objUser = new User();
        System.runAs ( thisUser ) {
            Profile adminProfile = [select id from profile where name='System Administrator'];
            UserRole objUserRole = new UserRole(Name = 'Electrical');
            insert objUserRole;
            //objUser = new User();
            objUser.firstname = 'TestUser';
            objUser.lastName = 'YN';
            objUser.email = 'testUser@titancorp.com';
            objUser.Username = 'testUser1@titancorp.com';
            objUser.EmailEncodingKey = 'ISO-8859-1';
            objUser.Alias = 'titan';
            objUser.TimeZoneSidKey = 'America/Los_Angeles';
            objUser.LocaleSidKey = 'en_US';
            objUser.LanguageLocaleKey = 'en_US';
            objUser.isActive = true;
            objUser.UserRoleId = objUserRole.Id;
            objUser.ProfileId = adminProfile.id;
            try{
                insert objUser; 
                electricalUser = objUser;
            }catch(Exception e){
                if(e.getMessage().indexOf('DUPLICATE_USERNAME') != 0){
                    objUser = electricalUser;
                }
            }
            
        }
        return objUser;
    }
    public static User getMechanicalRoleUser(){
        
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId()];
        User objUser = new User();
        System.runAs ( thisUser ) {
            Profile adminProfile = [select id from profile where name='System Administrator'];
            UserRole objUserRole = new UserRole(Name = 'Mechanical');
            insert objUserRole;
            //objUser = new User();
            objUser.firstname = 'TestUser';
            objUser.lastName = 'YN';
            objUser.email = 'testUser@titancorp.com';
            objUser.Username = 'testUser2@titancorp.com';
            objUser.EmailEncodingKey = 'ISO-8859-1';
            objUser.Alias = 'titan';
            objUser.TimeZoneSidKey = 'America/Los_Angeles';
            objUser.LocaleSidKey = 'en_US';
            objUser.LanguageLocaleKey = 'en_US';
            objUser.isActive = true;
            objUser.UserRoleId = objUserRole.Id;
            objUser.ProfileId = adminProfile.id;
            try{
                insert objUser; 
                mechanicalUser = objUser;
            }catch(Exception e){
                if(e.getMessage().indexOf('DUPLICATE_USERNAME') != 0){
                    objUser = mechanicalUser;
                }
            }
        }
        return objUser;
    }
    public static List<User> getUsers(){
        
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId()];
        User objUser = new User();
        List<User> userslst = new List<User>();
        System.runAs ( thisUser ) {
            
            User u = new User(
                ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Marketing User'].Id,
                FirstName = 'Fragrance',
                LastName = 'Expert',
                Email = 'sfdcadmin@kvpcorp.com',
                Username = 'FragranceExpertm@titan.com',
                CompanyName = 'TEST',
                Title = 'title',
                Alias = 'alias',
                TimeZoneSidKey = 'America/Los_Angeles',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US'
            );
            userslst.add(u);
            User u2 = new User(
                ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Fragrance Expert'].Id,
                FirstName = 'Fragrance',
                LastName = 'Expert',
                Email = 'sfdcadmifn@kvpcorp.com',
                Username = 'FragranceExpert@titan.com',
                CompanyName = 'TEST',
                Title = 'title',
                Alias = 'alias',
                TimeZoneSidKey = 'America/Los_Angeles',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US'
            );
            userslst.add(u2);
            User u3 = new User(
                ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn NPD User'].Id,
                FirstName = 'Fragrance',
                LastName = 'Expert',
                Email = 'sfdcadmins@kvpcorp.com',
                Username = 'FragranceExperst@titan.com',
                CompanyName = 'TEST',
                Title = 'title',
                Alias = 'alias',
                TimeZoneSidKey = 'America/Los_Angeles',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US'
            );
            userslst.add(u3);
            User u4 = new User(
                ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn QA User'].Id,
                FirstName = 'Fragrance',
                LastName = 'Expert',
                Email = 'sfdcadminq@kvpcorp.com',
                Username = 'FragranceExpertq@titan.com',
                CompanyName = 'TEST',
                Title = 'title',
                Alias = 'alias',
                TimeZoneSidKey = 'America/Los_Angeles',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US'
            );
            userslst.add(u4);
            User u5 = new User(
                ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Sourcing User'].Id,
                FirstName = 'Fragrance',
                LastName = 'Expert',
                Email = 'sfdcadmin@kvpcorp.com',
                Username = 'FragranceExpertslk@titan.com',
                CompanyName = 'TEST',
                Title = 'title',
                Alias = 'alias',
                TimeZoneSidKey = 'America/Los_Angeles',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US'
            );
            userslst.add(u5);
            try{
               insert userslst; 
            }catch(Exception e){
            	    
            }
            
        }
        return userslst;
    }
}