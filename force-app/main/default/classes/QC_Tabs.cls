/*
    Name         : QC_Tabs
    Created By   : Anand Durga Prasad
    Created Date :
    Modified By  :Anand Durga Prasad
    Last Modified Date:
    Description: Class to create tabs dynamically based on the component record id.
*/

public with sharing class QC_Tabs {

    public list<QC_Components__c>  childComList;
    public list<QC_Components__c>  ComList{get;set;}
    public Map<id,QC_Components__c>  masterVarChildList{get;set;}  //Used to store master variant child components
    public QC_Components__c  parentCom {get;set;}
    public list<TabWrapper> tabWrapList {get;set;}
    public string comId {get;set;}
    
    public QC_Tabs(ApexPages.StandardController controller) {
      comId   = Apexpages.currentpage().getParameters().get('id'); 
      childComList = new list<QC_Components__c>();
      //Retrieving the parent component data
      parentCom = [select id, name__c,Is_Rejected__c,Component_Status__c,master_variant__c ,master__c,document_status__c from QC_Components__c where id =:comId];
         System.debug('++++++parentCom +++++++++++'+parentCom.name__c);
      masterVarChildList = parentCom.master_variant__c != null ? new Map<id,QC_Components__c>([select id, name__c from QC_Components__c where parent__c=:parentCom.master_variant__c order by name__c]) : new Map<id,QC_Components__c>();
      //Retrieving the child components data based on parent id
      childComList = [select id, name__c from QC_Components__c where parent__c=:comId order by name__c];
      tabWrapList = new list<TabWrapper>();
      tabWrapList.add(new TabWrapper(parentCom));
      if(!childComList.isEmpty()){
          for(QC_Components__c com : childComList){
              tabWrapList.add(new TabWrapper(com));
          }
      }    
    }
      //Wrapper class to hold both parent and child component data
      public class TabWrapper{
         public id comid {get;set;}
         public string comName {get;set;}
         public TabWrapper(QC_Components__c component){
            this.comid = component.id;
            this.comName = component.name__c;
            System.debug('++++++++++this.comName++++++++++++++++'+this.comName);
         } 
      }
}