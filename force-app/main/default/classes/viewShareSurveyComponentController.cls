public without sharing class viewShareSurveyComponentController {
    static integer i=0;
    public Id surveyId { get; set; }
    public List < SelectOption > urlType {get;set;}
    public List < String > selectedValues1 {get;set;}
    public String selectedURLType {get;set;}
    public string AnonymousEmailValue {get;set;}
    public string emailBody {get;set;}
    public string surveyName {get;set;}
    public string conName{get;set;}
    public string OppName{get;set;}
    public string OppId{get;set;}
    public string OppString{get;set;}
    public string visitId{get;set;}
    public string surId{get;set;}
    public string AccString{get;set;}
    public string AccName{get;set;}
    public string VisitAccString{get;set;}
    public string VisitAccName{get;set;}
    public string VisitName{get;set;}
    public string VisitString{get;set;}
    public Opportunity OppObj{get;set;}
    public Visit__c visitObj{get;set;}
    public Map<string,string> SurveySentOppEmail {get;set;}
    public Map<string,string> SurveySentVisitEmail {get;set;}
    public set<string> emailList = new set<string>();
     public map<string,id> contactId ;
    public Id OppAccId;
    public Id VisitAccId;
   public map<string,string> contactName ;
    public PageReference returnPage;
    
    
    public String surveyURL {
        get {
            /*if (selectedURLType == 'Email Link, Anonymous' || selectedURLType == 'Chatter') {
return 'id=' + surveyId /*+ '&cId=none&caId=none';
} else*/ 	if (selectedURLType == 'Email Link w/ Contact Merge') {
    			return 'id=' + surveyId /*+ '&cId={!Contact.Id}&caId=none'*/;
			} else {
    			return 'id=' + surveyId /*+ '&cId={!Contact.Id}&caId={!Case.id}'*/;
			}
        }
        
        set;
    }
    
    
    
    public String surveySite {
        get{
            if(surveySite == null){
                surveySite = getVFUrl();
            }
            return surveySite;
        }
        set;
    }
    /*  public String surveyURLBase {
get {
if (selectedURLType != 'Chatter') {
/*surveyURLBase = getVFUrl();
}else{
surveyURLBase = surveySite;//Updated when select list is changed
}
return surveyURLBase;
}
set;
}*/
    //public Map<string, string> contMap {get; set;}
    // Public List<string> selectedcontacts{get;set;}
    
    public viewShareSurveyComponentController() {
        contactId = new map<string,id>();
        contactName = new map<string, string>();
        //survey = (Survey__c)ApexPages.StandardController.getRecord();
        selectedValues1 = new list<String>();
        urlType = new List < SelectOption > ();
        urlType.add(new SelectOption('Email Link w/ Contact Merge', System.Label.LABS_SF_Email_Link_w_Contact_Merge));
        //urlType.add(new SelectOption('Email Link w/ Contact & Case Merge', System.Label.LABS_SF_Email_Link_w_Contact_Case_Merge));
        urlType.add(new SelectOption('Email Link, Anonymous', System.Label.LABS_SF_Email_Link_Anonymous));
        // urlType.add(new SelectOption('Chatter', System.Label.LABS_SF_Chatter));
        //selectedURLType = 'Chatter';
        /* Modified by: vinoth kumar */
        OppId = Apexpages.currentPage().getParameters().get('OppId');
        OppString = '';
        AccString = '';
         if(OppId == null){
            OppName = '';
             AccName = '';
        } else {
            OppString = 'Opportunity Name: ';
            AccString = 'Account Name: ';
            OppObj = [SELECT Id, name,Account.Name,Owner.Email, Owner.Name  FROM Opportunity WHERE id =:OppId limit 1];
            OppName = OppObj.Name; 
            AccName = OppObj.Account.Name;
            if([SELECT Id, Contact.Name FROM Quote WHERE OpportunityId =: OppId ORDER BY CreatedDate DESC LIMIT 1].size() > 0){
            Quote qt = [SELECT Id, Contact.Name, Contact.Email FROM Quote WHERE OpportunityId =: OppId ORDER BY CreatedDate DESC LIMIT 1];
            
            	conName = qt.Contact.Name; 
                AnonymousEmailValue = qt.Contact.Email;
            }
            
        }
        VisitId = Apexpages.currentPage().getParameters().get('VisitId');
        if(VisitId != null){
            VisitAccString = 'Account Name: ';
            VisitString = 'Visit Name: ';
            visitObj = [SELECT Id, Account__r.Name,Name,Owner.Email, Owner.Name FROM Visit__c WHERE Id=:VisitId limit 1];
            VisitAccName = visitObj.Account__r.Name;
            VisitName = visitObj.Name;
        }

        surId = Apexpages.currentPage().getParameters().get('id');
       // string ebody = NULL;
        if(surId!=null){
            if([SELECT Id, emailBody__c FROM Survey__c WHERE id=:surId limit 1].emailBody__c != null){
            emailBody = [SELECT Id, emailBody__c FROM Survey__c WHERE id=:surId limit 1].emailBody__c;
        }
        }
        //To avoid sending multiple email to the same opportunities customers
        SurveySentOppEmail = new Map<string,string> ();
        SurveySentVisitEmail = new Map<string,string>();
        system.debug('query data:'+[SELECT Id,Email__c,Opportunity__c FROM Survey_Sent__c WHERE Email__c != null AND Opportunity__c != null]);
        if(OppId != null){
            for(Survey_Sent__c sst : [SELECT Id,Email__c,Opportunity__c FROM Survey_Sent__c WHERE Email__c != null AND Opportunity__c != null]){
                SurveySentOppEmail.put(String.valueOf(sst.Opportunity__c),sst.Email__c);
            }
        }
        if(VisitId != null){
            for(Survey_Sent__c sst : [SELECT Id,Email__c,Visit__c FROM Survey_Sent__c WHERE Email__c != null AND Visit__c != null]){
                SurveySentVisitEmail.put(String.valueOf(sst.Visit__c),sst.Email__c);
            }
        }
     system.debug('SurveySentOppEmail:'+SurveySentOppEmail);
     system.debug('SurveySentVisitEmail:'+SurveySentVisitEmail);
  
    }
   
  
    
    public string allContactEmail = '';
    public string strQuerry = '';
       public void NameString(){
           system.debug('NameStringOut1'+strQuerry);
           
                strQuerry = conName + '%';
           
           system.debug('NameStringOut2'+strQuerry);
    }
    
    public List<SelectOption> getSelectedValues(){
        //selectedValues1 = new List<string>();
        system.debug('I value is  : '+i);
        
        List<SelectOption> options = new List<SelectOption>();
       /* for(contact con:[SELECT id,email from contact where Name LIKE :strQuerry AND email != null limit 998]){
            system.debug('con++++++++++++++++++++'+con);
            if(allContactEmail != ''){
                allContactEmail = allContactEmail+','+con.Email; 
            } else {
                allContactEmail = con.Email;
            }
        }*/
       // system.debug('email addresses:'+allContactEmail);
        options.add(new SelectOption('All','All'));
        system.debug('NameStringIN'+strQuerry);
        system.debug('VisitId:==='+VisitId+'----OppId:====:'+OppId);
        List<contact> conList = new List<contact>();
        if(VisitId != null){
            VisitAccId = [SELECT Id, Account__c FROM Visit__c WHERE Id=:VisitId limit 1].Account__c;
            conList = [SELECT id, name,FirstName, email FROM contact WHERE AccountId=:VisitAccId AND email != null And Inactive__c = false limit 998];
        } else if(OppId != null){
            OppAccId = [SELECT Id, AccountId FROM Opportunity WHERE Id=:OppId limit 1].AccountId;
            conList = [SELECT id, name,FirstName, email FROM contact WHERE AccountId=:OppAccId AND email != null And Inactive__c = false limit 998];
        } else {
           conList = [SELECT id, name,FirstName, email from contact where Name LIKE :strQuerry AND email != null And Inactive__c = false limit 998]; 
        }
        system.debug('conList""""":'+conList);
        for(contact con:conList){
            system.debug('con================='+con);
            options.add(new SelectOption(con.Email,con.name));
            contactId.put(con.Email,con.id);
            contactName.put(con.Email, con.Name);
            system.debug('Contact MapcontactName'+contactName);
        }
       /* if(VisitId != null){
            Id VisitAccId = [SELECT Id, Account__c FROM Visit__c WHERE Id=:VisitId limit 1].Account__c;
            for(contact con:[SELECT id, name,FirstName, email FROM contact WHERE AccountId=:VisitAccId limit 998]){
              options.add(new SelectOption(con.Email,con.name));  
            }
        }*/
        system.debug('options: are (contactName)'+contactName.size()+'  ************  '+contactName.values());
        system.debug('options: are (selectedValues1)'+selectedValues1.size()+'  ************  '+selectedValues1);
        
        if(selectedValues1.contains('All') ){
            //for(string str1:allContactEmail.split(',')){
                emailList.addAll(ContactName.keySet()); 
                system.debug('emailListallcontact email'+emailList);
            //}
           // allContactEmail='';
        } else{
            for(String s:selectedValues1){
                emailList.add(s);
                system.debug('emailList.add(s);123456789:'+s);
                system.debug('email#################: \n'+s);
                
            } 
            system.debug('emailList----==---:'+emailList);
            
        }
        system.debug('options----==---:'+options);
        return options;
        
    }
    
    /* ************ */
    
    public String getVFUrl(){
        return 'https://' + ApexPages.currentPage().getHeaders().get('Host') + Page.TakeSurvey.getUrl() + '?';
    }
    
    
    public List < Selectoption > sitesPicklist {
        get{
            sitesPicklist = new List < Selectoption > ();
            try{
                //sitesPicklist.add(new Selectoption(getVFUrl(), 'Internal'));
                
                List<Site> siteList = [Select Name, Status,  Subdomain, UrlPathPrefix, SiteType, OptionsRequireHttps from Site where Subdomain != '' AND Name=:Label.SurveyForceSiteName];
                for(Site s: siteList){
                    String url = (s.OptionsRequireHttps == true)?'https://':'http://';
                    url += Utilities.getSubdomainPrefix() + s.Subdomain + '.';
                    url += Utilities.getInstance();
                    url += (s.OptionsRequireHttps == true && s.SiteType == 'Visualforce')?'secure.force.com/':'force.com/';
                    url += (String.isEmpty(s.UrlPathPrefix))?'':s.UrlPathPrefix + '/';
                    url += 'TakeSurvey?';
                    sitesPicklist.add(new Selectoption(url, s.Name));
                }
            }catch(Exception e){
                System.debug('Exception:' + e.getMessage());
            }
            return sitesPicklist;
        }
        set;
    }
    /* Modified by: vinoth kumar */
    string TealLogo =  '<html><body><img src="https://newdev-ped.cs91.force.com/servlet/servlet.ImageServer?id=0152F0000000xHw&oid=00D2F0000000UZi&lastMod=1555913835000" /><br/></body></html>';
    string imageLink ='';
    
    public PageReference sendEmail(){
        PageReference returnPage = new PageReference('https://titanlightningapps.my.salesforce.com');
        system.debug('entering sendemail');
        if(OppId == null){
            OppName = 'none';
        }
        //emailList.add('vinoth.kumar@kvpcorp.com');
        surveyName = [ SELECT Id, name, Opportunity_name__c FROM Survey__c WHERE ID =: surveyId limit 1].name;
        SYSTEM.DEBUG('SURVEYnAME::::::::::::'+surveyName);
        system.debug('emails are : *'+emailList);
        if(emailList.size() == 0){
            system.debug('Inside the condition:emails are : *'+emailList);
            getSelectedValues();
        }
        List<string> emailIterationList = new List<string>();
        
        //system.debug('SurveySentOppEmail:'+SurveySentOppEmail);
        //system.debug('emailList:'+emailList);
        
        for(string str:emailList){
            emailBody = emailBody.replace('\n','<br/>');
            emailIterationList.add(str);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(emailIterationList);
            imageLink = '<html><body><a href="'+surveySite + surveyURL+'&Email='+emailIterationList[0]+'&cId='+contactId.get(str)+'&OppName='+OppName+'&VisitId='+VisitId+'&OppId='+OppId+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F0000000xIu&oid=00D2F0000000UZi&lastMod=1558947293000" height="90" width="120"/></a></body></html>';
            system.debug('to address:' +selectedValues1);
            mail.setSubject(surveyName);
            mail.setHtmlBody('Hi '+ contactName.get(str)+',<br/>'+emailBody+'<br/><br/>Please click on the below image to take the survey<br/>'+imageLink+'<br/><br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');
            
            system.debug('url:'+'Hi '+ contactName.get(str)+',<br/>'+'Please click on the below link to take the survey<br/>'+surveySite + surveyURL+'&Email='+emailIterationList[0]+'&cId='+contactId.get(str));
            mail.setUseSignature(false);
            
            //To avoid sending multiple email to the same opportunities customers
            emailBody = emailBody.replace('<br/>','\n');
            system.debug('SurveySentOppEmail:-=-=-=-='+SurveySentOppEmail);
            system.debug('OppId:===:::'+OppId);
            if((OppId == null && VisitId == null) || (SurveySentOppEmail.get(OppId) != str) && (SurveySentVisitEmail.get(VisitId) != str)){
                system.debug('map email: '+SurveySentOppEmail.get(OppId)+'----str:'+str);
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail}); 
                //Capturing the values for an object Survey sent to track the sent surveys. 
                Survey_Sent__c Ss = new Survey_Sent__c();
                Ss.Email__c = str;
                Ss.Surveys__c = surveyId;
                Ss.Email_Body__c = String.valueOf(mail.HtmlBody) ;
                Ss.Opportunity__c = OppId;
                Ss.Customer_name__c = contactName.get(str);
                //Ss.Account__c = OppAccId;
                if(VisitAccId != null){
                    Ss.Account__c = VisitAccId;
                } else if(OppAccId != null){
                    Ss.Account__c = OppAccId;
                } else if(contactId.get(str) != null){
                    Ss.Account__c = [SELECT Id, AccountId FROM Contact WHERE Id =: contactId.get(str)].AccountId;
                }
                Ss.SurveyLinkImage__c = imageLink;
                if(VisitId != null){
                    Ss.Visit__c = VisitId;
                }
                insert Ss;
                
                // Email to notify the user about survey sent to the opportunity/visit customer
                List<string> OwnerEmailList = new List<string>();
                //OwnerEmailList.add('vinoth.kumar@kvpcorp.com');
                if(OppObj != null){
                    OwnerEmailList.add(OppObj.Owner.Email);
                    system.debug('OwnerEmailList:==='+OwnerEmailList);
                }
                if(visitObj != null){
                    OwnerEmailList.add(visitObj.Owner.Email); 
                }  
                Messaging.SingleEmailMessage mails = new Messaging.SingleEmailMessage();
                mails.setToAddresses(OwnerEmailList);
                mails.setSubject(surveyName);
                mails.setUseSignature(false);
                if(OppId != null){   
                    mails.setHtmlBody('Hi '+OppObj.Owner.Name+',<br/> Thank you for submitting the '+surveyName+' to '+contactName.get(str)+' for an opportunity '+OppObj.Name+' in '+AccName+'<br/><br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mails}); 
                    system.debug('mails:--------'+mails);
                }
                if(VisitId != null){   
                    mails.setHtmlBody('Hi '+visitObj.Owner.Name+',<br/> Thank you for submitting the '+surveyName+' to '+contactName.get(str)+' for '+VisitName+' in '+VisitAccName+'<br/><br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mails}); 
                }
                
            } else {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Survey is already sent for this Customer'));
            }
            OppName = '';
            Id ownerId = [SELECT Id,CreatedById FROM Survey__c WHERE id=:surveyId limit 1].CreatedById;
            system.debug('ownerId:'+ownerId+'UserInfo.getUserId()'+UserInfo.getUserId());
            if(UserInfo.getUserId() == ownerId){
                Survey__c survey = new Survey__c(id=surveyId);
                survey.EmailBody__c = emailBody;
                update survey;
            }
        }
        return returnPage;
    }
   // Method to send email to the anonymous users. 
    public PageReference sendAnonymousEmail(){
        if(OppId == null){
            OppName = 'none';
        } 
        
        surveyName = [ SELECT Id, name,Opportunity_name__c FROM Survey__c WHERE ID =: surveyId limit 1].name;
        SYSTEM.DEBUG('SURVEYnAME=========='+surveyName);
        string AnonymousEmailLink = '';
        List<string> AnonymousEmailList = new List<string>();
        AnonymousEmailList = AnonymousEmailValue.split(',');
        system.debug('emails are : *'+AnonymousEmailList);
        List<string> emailIterationList = new List<string>();
        for(string str:AnonymousEmailList){
            emailBody = emailBody.replace('\n','<br/>');
            emailIterationList.add(str);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(emailIterationList);
            imageLink = '<html><body><a href="'+surveySite + surveyURL+'&Email='+emailIterationList[0]+'&cId='+contactId.get(str)+'&OppName='+OppName+'&VisitId='+VisitId+'&OppId='+OppId+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F0000000xIu&oid=00D2F0000000UZi&lastMod=1558947293000" height="90" width="120"/></a></body></html>';
            AnonymousEmailLink = '<html><body><a href="'+surveySite + surveyURL+'&Email='+emailIterationList[0]+'&cId=none'+'&OppName='+OppName+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F0000000xIu&oid=00D2F0000000UZi&lastMod=1558947293000" height="90" width="120"/></a></body></html>';
            system.debug('to address:' +AnonymousEmailList);
            mail.setSubject(surveyName);
            mail.setUseSignature(false);
            
            if(contactId.containsKey(str)){
                mail.setHtmlBody('Hi '+ contactName.get(str)+',<br/>'+emailBody+'<br/><br/>Please click on the below image to take the survey<br/>'+imageLink+'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');                
            } else {
                mail.setHtmlBody('Hi '+',<br/>'+emailBody+'<br/><br/>Please click on the below image to take the survey<br/>'+AnonymousEmailLink+'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');
            }
            emailBody = emailBody.replace('<br/>','\n');
            system.debug('OppId:'+OppId+'=='+null+' and '+SurveySentOppEmail.get(OppId)+'==' +str);
            if((OppId == null && VisitId == null) || (SurveySentOppEmail.get(OppId) != str) && (SurveySentVisitEmail.get(VisitId) != str)){
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                
                //Capturing the values for an object Survey sent to track the sent surveys. 
                Survey_Sent__c Ss = new Survey_Sent__c();
                Ss.Email__c = str;
                Ss.Surveys__c = surveyId;
                Ss.Email_Body__c = String.valueOf(mail.HtmlBody) ;
                Ss.Opportunity__c = OppId;
                Ss.SurveyLinkImage__c = imageLink;
                Ss.Customer_name__c = contactName.get(str);
                if(VisitId != null){
                    Ss.Visit__c = VisitId;
                }
                insert Ss;
            } else {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Survey is already sent for this Customer'));
                
            }
            
            OppName = '';
            emailIterationList.clear();
            
            Id ownerId = [SELECT Id,CreatedById FROM Survey__c WHERE id=:surveyId limit 1].CreatedById;
            system.debug('ownerId:'+ownerId+'UserInfo.getUserId()'+UserInfo.getUserId());
            if(UserInfo.getUserId() == ownerId){
                Survey__c survey = new Survey__c(id=surveyId);
                survey.EmailBody__c = emailBody;
                update survey;
            }
        }
        PageReference returnPage = new PageReference('https://titanlightningapps.my.salesforce.com');
      return returnPage;  
    }
    /* ************ */
    
}