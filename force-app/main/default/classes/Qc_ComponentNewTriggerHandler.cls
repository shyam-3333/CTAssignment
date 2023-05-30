public with sharing class Qc_ComponentNewTriggerHandler {
   public Qc_ComponentNewTriggerHandler() {} 
    /*static Map<string,QC_components__c> skuMap = new Map<string,QC_components__c>();
    static Map<string,QC_components__c> watchVariantMap = new Map<string,QC_components__c>();
    //Initializing the maps 
    public static void initialize(){
        Boolean l3;
        Boolean l4;
        Boolean l5;
        Boolean l6;
        if(test.isRunningTest()){
            list<QC_components__c> qcLst1 = [select id, name__c,SKU_Reference__c, PSY_Reference__c, Watch_Variant__c,Sample_Category__c from QC_Components__c where Sample_Category__c != 'Re-submission' LIMIT 4000]; 
            for(QC_components__c comp : qcLst1 ){
                skuMap.put(string.valueOf(comp.SKU_Reference__c),comp);
                if(comp.name__c == 'Full-Watch' || comp.name__c == 'Watch-Head'){
                    watchVariantMap.put(comp.Watch_Variant__c,comp);
                } 
            }
        }else{
            list<QC_components__c> qcLst = [select id, name__c,SKU_Reference__c, PSY_Reference__c, Watch_Variant__c,Sample_Category__c from QC_Components__c where Sample_Category__c != 'Re-submission' LIMIT 49000];
            
            for(QC_components__c comp : qcLst ){
                skuMap.put(string.valueOf(comp.SKU_Reference__c),comp);
                if(comp.name__c == 'Full-Watch' || comp.name__c == 'Watch-Head'){
                       if(Recursivecheck.runOnce())
            {
                    watchVariantMap.put(comp.Watch_Variant__c,comp);
            }
                } 
            }
        }
    }

    //Code to identify the duplicate SKU reference and Watch Variant on insertion of the component record   
    public static void uniqueCheckOnInsert(list<QC_Components__c> newList){
         if(Recursivecheck.runOnce())
            {
        initialize();
            }
        for(QC_components__c comp : newList){
            if(!skuMap.isEmpty() && comp.SKU_Reference__c != null && skuMap.containsKey(string.valueOf(comp.SKU_Reference__c)) && comp.Sample_Category__c != 'Re-submission'){ 
                comp.addError('This SKU Reference already exists');
            }
            if(!watchVariantMap.isEmpty() && comp.Watch_Variant__c != null && watchVariantMap.containsKey(comp.Watch_Variant__c) && comp.Sample_Category__c != 'Re-submission' && (comp.name__c == 'Full-Watch' || comp.name__c == 'Watch-Head')){
                comp.addError('This Watch Variant already exists');
            }
        } 
    } 

    //Code to identify the duplicate SKU reference and Watch Variant on update of the component record   
    public static void uniqueCheckOnUpdate( Map<id,QC_Components__c> newMap, Map<id,QC_Components__c> oldMap){
        boolean B1 = true;
        for(QC_components__c comp1 : newMap.values()){
            If((comp1.SKU_Reference__c != oldMap.get(comp1.Id).SKU_Reference__c || comp1.Watch_variant__c != oldMap.get(comp1.Id).Watch_variant__c) && B1 == true){
                 initialize();
                B1 = false;
            }
        }

        for(QC_components__c comp : newMap.values()){
            if(!skuMap.isEmpty() && comp.SKU_Reference__c != null && skuMap.containsKey(string.valueOf(comp.SKU_Reference__c)) && comp.Sample_Category__c != 'Re-submission' && string.valueOf(comp.SKU_Reference__c) != string.valueOf(oldMap.get(comp.id).SKU_Reference__c)){ 
                comp.addError('This SKU Reference already exists');
            }
            if(!watchVariantMap.isEmpty() && comp.Watch_Variant__c != null && watchVariantMap.containsKey(comp.Watch_Variant__c) && comp.Sample_Category__c != 'Re-submission' && (comp.name__c == 'Full-Watch' || comp.name__c == 'Watch-Head') && comp.Watch_Variant__c != oldMap.get(comp.id).Watch_Variant__c){
                comp.addError('This Watch Variant already exists');
            }
        } 
    }
    static boolean approvalStatusRecursionFlag= false;
    public static void updateComponentApprovalStatus(Map<Id,QC_Components__c> qcCompNewMap ,Map<Id,QC_Components__c> qcCompOldMap){
        if(!qcCompNewMap.isEmpty() )
        {
            
            set<Id> setOfParentRecId = new set<Id>();
            for(QC_components__c qcPComp : qcCompNewMap.values() ){
                if(qcPComp.Parent__c == null)
                {
                    setOfParentRecId.add( qcPComp.Id);
                }
                
            }
            List<QC_Components__c> childQcCompList = new List<QC_Components__c>();
            for( QC_Components__c  qcComp : [ SELECT Id,Name,name__c,Document_Status__c,Parent__c FROM QC_Components__c where Parent__c =: setOfParentRecId ])
            {
                System.debug('child : ' + qcComp.Name);
                qcComp.Document_Status__c = qcCompNewMap.get(qcComp.Parent__c)?.Document_Status__c;
                childQcCompList.add( qcComp );
            }
            System.debug('approvalStatusRecursionFlag :' + approvalStatusRecursionFlag);
            if( childQcCompList.size() > 0 && !approvalStatusRecursionFlag)
            {
                approvalStatusRecursionFlag = true;
                update childQcCompList;
                System.debug('approvalStatusRecursionFlag :' + approvalStatusRecursionFlag);
            }
            
        }
    }

    public static void updateComponentReportRefNumber( List<QC_Components__c> qcCompNewList , Map<Id,QC_Components__c> qcCompoldMap)
    {
        if( qcCompNewList.size() > 0 )
        {
            Map< string, QC_Component_Prefix__c> cusSettingsMap = new Map< string, QC_Component_Prefix__c> ();
            for( QC_Component_Prefix__c qcCpmpPrefix : [SELECT Id,Name,Sequence_Number__c FROM QC_Component_Prefix__c])
            {
                cusSettingsMap.put( qcCpmpPrefix.Name , qcCpmpPrefix);
            }
            for( QC_Components__c qcComp : qcCompNewList)
            {
                System.debug('Parent - > ' + qcComp.Parent__c + 'Doc Status -> '  + qcComp.Document_Status__c);
                if( qcComp.Parent__c == null  && qcComp.Document_Status__c == 'Approved' && qcComp.Document_Status__c != qcCompoldMap.get(qcComp.Id).Document_Status__c)
                {
                    if( qcComp.Sample_Category__c != 'Re-submission' )
                    {
                        if( qcCompoldMap.get(qcComp.Id).Document_Status__c != 'Submit for Publish'){
                            String cusSettings = appendZeros(String.valueOf(Integer.valueOf( cusSettingsMap.get(componentPrefix(qcComp.Name__c , qcComp.Sample_Category__c ))?.Sequence_Number__c)+1));
                            qcComp.Report_Ref_Number__c = reportRefNumber(cusSettings,qcComp);
                            System.System.debug( 'Report Ref Num --> ' + reportRefNumber(cusSettings,qcComp));
                            cusSettingsMap.get(componentPrefix(qcComp.Name__c , qcComp.Sample_Category__c )).Sequence_Number__c  = appendZeros(String.valueOf( Integer.valueOf( cusSettings ) )) ;
                        }
                    }else if( qcCompoldMap.get(qcComp.Id).Document_Status__c != 'Submit for Publish'){
                        qcComp.Report_Ref_Number__c = resubmissionReportRefNumber(qcComp.Parent_Report_Reference_Number__c);
                    }
                }
            }

            if( !cusSettingsMap.isEmpty())
            {
                update cusSettingsMap.values();
            }
        }
    }

    public static string appendZeros(String seqNo){
        
        return (seqNo != null) 
            ?((seqNo.length() == 1) ? '000'+seqNo
              :(seqNo.length() == 2) ? '00'+seqNo
              :(seqNo.length() == 3) ? '0'+seqNo : seqNo) : seqNo;       
    } 

    //reportRefNumber method is used for constructing Report Ref Number for new components
    public static string reportRefNumber(string uniqueNo, QC_Components__c qcComp){
        // ****************** Change Request 4 added by Anand-4/21/2015****************************** 
         //Identifying the current Fiscal Year 
         //Integer orgFiscalMonth = [SELECT FiscalYearStartMonth FROM Organization].FiscalYearStartMonth; 
         String comtype = qcComp.Name__c ;
         String firstSelection = qcComp.Sample_Category__c ;
         Date d = System.today();
         system.debug('***********d*************'+d);
         integer currentYear = d.year() - ((d.month() == 1 ||  d.month() == 2 || d.month() == 3) ? 1 : 0);
         string fYearPeriod ='/'+ string.valueOf(currentYear).subString(2,4) + '-' + string.valueOf(currentYear+1).subString(2,4);
         string refNo = uniqueNo + fYearPeriod;
         if(firstSelection != 'Competitor Products'){
         refNo = (comtype == 'Full-Watch') ? ('FW/' + refno) 
                :(comtype == 'Watch-Head') ? ('WH/' + refno)
                :(comtype == 'Case') ? ('CA/' + refno)
                :(comtype == 'Dial') ? ('DL/' + refno)
                :(comtype == 'Metal-Strap') ? ('MS/' + refno)
                :(comtype == 'Leather-Strap' || comtype == 'Special-Strap') ? ('LS/' + refno)
                :(comtype == 'Module') ? ('FMA/' + refno)
                :(comtype == 'Battery') ? ('BT/' + refno)
                :(comtype == 'Packaging')  ? ('PA/' + refno) : fYearPeriod;
        //*******************************************************************************************
          System.debug('Report number for parent='+refNo);
          }
          else{
           refNo = (comtype == 'Full-Watch') ? ('CFW/' + refno) 
                :(comtype == 'Watch-Head') ? ('CWH/' + refno)
                :(comtype == 'Case') ? ('CCA/' + refno)
                :(comtype == 'Dial') ? ('CDL/' + refno)
                :(comtype == 'Metal-Strap') ? ('CMS/' + refno)
                :(comtype == 'Leather-Strap' || comtype == 'Special-Strap') ? ('CLS/' + refno)
                :(comtype == 'Module') ? ('CFMA/' + refno)
                :(comtype == 'Battery') ? ('CBT/' + refno)
                :(comtype == 'Packaging')  ? ('CPA/' + refno) : fYearPeriod;
          }
          return refNo;
           
      }

      // componentPrefix method is used for getting the prefix for each component to construct report ref number
      public static String componentPrefix(string compName, String firstSelection){
        if(firstSelection != 'Competitor Products'){
          return (compName != null && compName != '')   
                          ?((compName == 'Full-Watch') ? 'FW' 
                          :(compName == 'Watch-Head') ? 'WH'
                          :(compName == 'Case') ? 'CA' 
                          :(compName == 'Dial') ? 'DL'
                          :(compName == 'Metal-Strap') ? 'MS'
                          :(compName == 'Leather-Strap' || compName == 'Special-Strap') ? 'LS'
                          :(compName == 'Module') ? 'FMA' 
                          :(compName == 'Battery') ? 'BT' 
                          :(compName == 'Packaging')  ? 'PA' : null)
                          : null;
        }
        else{
         return (compName != null && compName != '')   
                          ?((compName == 'Full-Watch') ? 'CFW' 
                          :(compName == 'Watch-Head') ? 'CWH'
                          :(compName == 'Case') ? 'CCA' 
                          :(compName == 'Dial') ? 'CDL'
                          :(compName == 'Metal-Strap') ? 'CMS'
                          :(compName == 'Leather-Strap' || compName == 'Special-Strap') ? 'CLS'
                          :(compName == 'Module') ? 'CFMA' 
                          :(compName == 'Battery') ? 'CBT' 
                          :(compName == 'Packaging')  ? 'CPA' : null)
                          : null;
        }   
             
    }

    public static String resubmissionReportRefNumber(String parentReportRefNo ){
        try {
            System.debug('parentReportRefNo -> '+ parentReportRefNo);
            string newRefNumber='';
            Date d = System.today();
            system.debug('***********d*************'+d);
            integer currentYear = d.year() - ((d.month() == 1 ||  d.month() == 2 || d.month() == 3) ? 1 : 0);
            system.debug('***********currentYear*************'+currentYear);
            string fYearPeriod ='/'+ string.valueOf(currentYear).subString(2,4) + '-' + string.valueOf(currentYear+1).subString(2,4);
            system.debug('***********fYearPeriod *************'+fYearPeriod );
            if(parentReportRefNo !='' && !parentReportRefNo.contains('[')){ 
                system.debug('***********parentReportRefNo111111*************'+parentReportRefNo);
               for(string str : parentReportRefNo.split(fYearPeriod)){
                  newRefNumber = str; 
               }
                 newRefNumber += '[a]'+fYearPeriod; 
            }
            else{   
                    //Getting next alphabate based on current alphabate using Maps(alphabateMap,reverseMap)
                    system.debug('***********parentReportRefNo222222*************'+parentReportRefNo);
                        String nextAlphabate= incrementStr(parentReportRefNo.subString(parentReportRefNo.indexOf('[')+1,parentReportRefNo.indexOf(']')));
                    system.debug('***********nextAlphabate*************'+nextAlphabate);
                    for(string str : parentReportRefNo.split(fYearPeriod)){
                            newRefNumber = str.substring(0,str.length()-3); 
                    }
                            newRefNumber += '[' + nextAlphabate + ']'+fYearPeriod; 
                            System.debug('new Resubmission='+newRefNumber); 
            }   
            return newRefNumber;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static String incrementStr(string str) {
        String sRight =  str.right(1); 
            if( sRight == 'z')
            {
                return sRight = 'a'+ str;
            }  
            else
            {
                integer i=sRight.charAt(0);
                i++;
                list<Integer> arrlst= new Integer[]{i};
                str = str.removeEnd(sRight);
                sRight = String.fromCharArray(arrlst);
                if( sRight == 'z'){
                    sRight = 'a'+str;
                }
                return str+sRight;
            }
    }

    static boolean finalVerdictRecursionFlag= false;
    public static void syncComponentData(List<QC_Components__c > pNew, Map<Id, QC_Components__c > pOldMap)
    {
        Set<Id> compIdsSet = new Set<Id>();
        List<QC_Components__c> pComponentDataNew = new List<QC_Components__c>();
        for(QC_Components__c theComponentData : pNew){
            if(theComponentData.Final_Verdict__c != pOldMap.get(theComponentData.Id).Final_Verdict__c){
                compIdsSet.add(theComponentData.Id);
                pComponentDataNew.add(theComponentData);
            }
        }
        
        if(!compIdsSet.isEmpty()){
            Map<Id, QC_Components__c> compMap = new Map<Id, QC_Components__c>([SELECT Id, Name__c, Parent__c FROM QC_Components__c WHERE Id IN : compIdsSet AND Parent__r.Master__c =: TRUE]);
            Set<Id> masterCompIdsSet = new Set<Id>();
            Set<String> compNamesSet = new Set<String>();
            for(QC_Components__c theComp : compMap.values()){
                masterCompIdsSet.add(theComp.Parent__c);
                compNamesSet.add(theComp.Name__c);
            }
            
            Map<String, list<QC_Components__c>> componentDataMap = new Map<String, list<QC_Components__c>>();
            for(QC_Components__c theCompData : [SELECT Id, Name__c, Final_Verdict__c,Parent__r.Master_Variant__c FROM QC_Components__c 
                                                WHERE Parent__r.Master_Variant__c IN : masterCompIdsSet 
                                                AND Name__c IN : compNamesSet AND Master__c = FALSE])
            {
                if(componentDataMap.containsKey(theCompData.Name__c+theCompData.Parent__r.Master_Variant__c)){
                    componentDataMap.get(theCompData.Name__c+theCompData.Parent__r.Master_Variant__c).add(theCompData);
                }else{
                    list<QC_Components__c> qcCompList = new list<QC_Components__c>();
                    qcCompList.add(theCompData);
                    componentDataMap.put(theCompData.Name__c+theCompData.Parent__r.Master_Variant__c, qcCompList);
                }
            }
            system.debug('------------componentDataMap-----------'+componentDataMap.keySet());
            system.debug('------------componentDataMap-----------'+componentDataMap.values());
            
            if(!componentDataMap.isEmpty() && !compMap.isEmpty()){
                List<QC_Components__c> childCompData = new List<QC_Components__c>();
                for(QC_Components__c theComponentData : pComponentDataNew){
                    if(componentDataMap.containsKey(compMap.get(theComponentData.Id).Name__c+compMap.get(theComponentData.Id).Parent__c)){
                        for(QC_Components__c qcComp : componentDataMap.get(compMap.get(theComponentData.Id).Name__c+compMap.get(theComponentData.Id).Parent__c)){
                            QC_Components__c compData = new QC_Components__c();
                            compData.Id        = qcComp.Id;
                            compData.Final_Verdict__c = theComponentData.Final_Verdict__c;
                            childCompData.add(compData);
                        }
                    }
                }
                
                if(!childCompData.isEmpty() && !finalVerdictRecursionFlag){
                    finalVerdictRecursionFlag = true;
                    update childCompData;
                }
            }
        }
        
    }*/
}