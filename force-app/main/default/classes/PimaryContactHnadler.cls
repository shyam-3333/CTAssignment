public class PimaryContactHnadler {

    
@AuraEnabled
public static List<Contact> getPrimaryContact(Id accountId) {
    List<Contact> contactlist = [SELECT Id, AccountId, FirstName,LastName,Name,Primary_Contact__c FROM Contact WHERE AccountId=: accountId WITH SECURITY_ENFORCED];
    return contactlist;
}
@AuraEnabled
public static string contactsprimarycheckbox(Id contactId,List<contact> contactlist){
    List<contact> contactstoupdate = new List<Contact>();
    Id accId;
    try{
        Contact con = [SELECT Id,FirstName,LastName,Name, Primary_Contact__c,AccountId FROM Contact WHERE Id =: contactId WITH SECURITY_ENFORCED];
        for(Contact c:contactlist){
            if(c.Id == contactId){
                if(!Schema.sObjectType.Contact.fields.Primary_Contact__c.isUpdateable())
                {
                c.Primary_Contact__c=true;
                accId=c.AccountId;
                }
            }else{
                c.Primary_Contact__c=false;
            }
        }
      
        Account acc = [SELECT Id FROM Account WHERE Id =:accId WITH SECURITY_ENFORCED];
        acc.Customer_Primary_Contact__c = con.Name;
        if (!Schema.sObjectType.Account.fields.Customer_Primary_Contact__c.isUpdateable()) {
            
            return 'Failure';
        }
        update contactlist;
        update acc;
        return 'success';
    }
    catch(exception e){
        return 'Failure';
    }
}
}