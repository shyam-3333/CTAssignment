public class Npd_userloginClass
{
  public string userid{set;get;}
  public string password{set;get;}
  public string projectid{set;get;}
  public npd_master__c nm1;
  public Npd_userloginClass()
  {
    projectId = ApexPages.currentPage().getparameters().get('proID');
    nm1 = new npd_master__c();
    projectid='';
  }
  
  public pagereference loginChecking()
  {    
  //redirectToMainPage('hello','projectId');
      if(projectid==Null || projectid=='')
      {
       projectid='noprojecctid';
      }
      if(userid!= null && password!=null)
      {
       try{
       nm1 = [select id,name,userid__c,user_password__c from npd_master__c where userid__c=:userid AND user_password__c =:password limit 1];
       } catch(exception ert1)
           {
           system.debug('ert1 exception is :' +ert1);
            }
        if(nm1.name!=null)
        {
          
         system.debug('*********');
        }     
        else
        {
  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Worng Email or Password.'));

        }
      }
       if(nm1.name!=null)
        {
            String url  =  ('/apex/NPD_DetailView_Page_Ownerbased?core.apexpages.request.devconsole=1&email='+userid+'&ProjID='+projectId);
            PageReference p1= new PageReference(url);
            p1.setRedirect(true);
            return p1;    
      
        }
       return null;   
      
  }
  
}