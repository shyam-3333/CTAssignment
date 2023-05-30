/*
 * Company : Kvp Business Solution
 * Date    : 27-12-2018
 * Author  : Sameer Ranjan
 * Description : Handler class of QCMTLComponentTrigger and its use for auto generate Report Reference Number.
 * History     : N/L
 */
public with sharing class QCMTLComponentTriggerHandler {
	//Wrapper class which is help in create map "mapofmtlComponent".
	public static Boolean isTriggerEnable = true;
	class wrapperClass {
		public QC_MTL_Component__c tempValue;
		public Integer value;
	}
	//This Method Call when Before insert.
	public static void beforeInsertMethod(List<QC_MTL_Component__c> qcMtlComponentRecordList) {
		//QCMTLComponentTrigger__c Custom Setting Value use for Trigger Activation and Deactivation.
		if(QCMTLComponentTrigger__c.getOrgDefaults().TriggerActivate_Deactivate__c && isTriggerEnable) {
			//Preparing Map For Re-submission Record
			String todayYear = '';
			Integer nextYear = 0;
			Map<String, String> alphabet = new map<String, String>();
			alphabet.put('(a)', '(b)');
			alphabet.put('(b)', '(c)');
			alphabet.put('(c)', '(d)');
			alphabet.put('(d)', '(e)');
			alphabet.put('(e)', '(f)');
			alphabet.put('(f)', '(g)');
			alphabet.put('(g)', '(h)');
			alphabet.put('(h)', '(i)');
			alphabet.put('(i)', '(j)');
			alphabet.put('(j)', '(k)');
			alphabet.put('(k)', '(l)');
			alphabet.put('(l)', '(m)');
			alphabet.put('(m)', '(n)');
			alphabet.put('(n)', '(o)');
			alphabet.put('(o)', '(p)');
			alphabet.put('(p)', '(q)');
			alphabet.put('(q)', '(r)');
			alphabet.put('(r)', '(s)');
			alphabet.put('(s)', '(t)');
			alphabet.put('(t)', '(u)');
			alphabet.put('(u)', '(v)');
			alphabet.put('(v)', '(w)');
			alphabet.put('(w)', '(x)');
			alphabet.put('(x)', '(y)');
			alphabet.put('(y)', '(z)');
			alphabet.put('(z)', '(a)');
			//Report_Reference_Number__c Custom Setting
			string temp = 'qwertyuiopasdfghjklxcvbnm';
			Report_Reference_Number__c secondPart = Report_Reference_Number__c.getOrgDefaults();
			Integer rawMaterialvalue = (Integer) secondPart.MTL_Reference_Number__c;
			Integer financialYearStart = System.today().year();
            integer month = System.today().month();
            if(month == 1 || month == 2 || month == 3){
                financialYearStart = financialYearStart - 1;
            }
                
			Integer financialMonthStart = 4;
			Integer financialDayStart = 1;
			String financialYearStartDateString = '' + financialYearStart + '-0' + financialMonthStart + '-0' + financialDayStart;
			Date financialYearStartDateFormat = Date.valueOf(financialYearStartDateString);
			Integer financialYearEnd = financialYearStart + 1;
			Integer financialMonthEnd = 3;
			Integer financialDayEnd = 31;
			String financialDayEndDateString = '' + financialYearEnd + '-0' + financialMonthEnd + '-' + financialDayEnd;
			Date financialDayEndDateStringFormat = Date.valueOf(financialDayEndDateString);

			Set<String> platingDepartmentNameSet = new Set<String>();
			Set<String> platingMCDepartmentNameSet = new Set<String>();
			Map<String, Integer> platingWithCountRecords = new Map<String, Integer>();
			for(QC_MTL_Component__c var :qcMtlComponentRecordList) {
				if(var.Testing_Type__c == 'Plating')
					platingDepartmentNameSet.add(var.Department__c);
				if(var.Testing_Type__c == 'Plating and Material Composition') {
					platingMCDepartmentNameSet.add(var.Department_PMC__c);
				}
			}
			System.debug('financialYearStartDateFormatfinancialYearStartDateFormat============' + financialYearStartDateFormat);
			System.debug('financialDayEndDateStringFormatfinancialDayEndDateStringFormat========' + financialDayEndDateStringFormat);
			System.debug('platingDepartmentNameSetplatingDepartmentNameSet====' + platingDepartmentNameSet);
            List<AggregateResult> platingRecords = [SELECT Count(Id) recordCount, Department__c FROM QC_MTL_Component__c where Department__c in :platingDepartmentNameSet and Testing_Type__c = 'Plating'and createddate >=: financialYearStartDateFormat group by Department__c order by Department__c];  //createddate criteria must be changed every FY
			System.debug('platingRecords'+platingRecords);
            Integer tempDepatCt;
			String testingType = 'Plating';
			for(AggregateResult dept :platingRecords) {
				platingWithCountRecords.put((String)dept.get('Department__c') + testingType, (Integer)dept.get('recordCount'));
			}
			List<AggregateResult> platingMCRecords = [SELECT Count(Id) recordCount, Department_PMC__c FROM QC_MTL_Component__c where Department_PMC__c in :platingMCDepartmentNameSet and Testing_Type__c = 'Plating and Material Composition'and createddate >=: financialYearStartDateFormat group by Department_PMC__c order by Department_PMC__c];  //createddate criteria must be changed every FY
			System.debug('platingMCRecords'+platingMCRecords);
            testingType = 'Plating and Material Composition';
			for(AggregateResult dept :platingMCRecords) {
				platingWithCountRecords.put((String)dept.get('Department_PMC__c') + testingType, (Integer)dept.get('recordCount'));
			}
			System.debug('platingWithCountRecordsplatingWithCountRecords=====' + platingWithCountRecords);
			Integer platingvalue = (Integer) secondPart.Plating_Report_Reference_Number__c;
			Integer platingComposvalue = (Integer) secondPart.Plating_Material_Composition_RRFNumber__c;
			Map<wrapperClass, String> mapofmtlComponent = new Map<wrapperClass, String>();
			String reportReferenceNumber = '';
			Integer size = 0;
			if(Date.today().month() > 3) {
				system.debug('Date.today()' + Date.today());
				todayYear = String.valueof(date.today().year()).right(2);
				nextYear = Integer.valueof(string.valueof(date.today().year()).right(2)) +1;
			} else {
				todayYear = String.valueOf(Integer.valueOf(String.valueof(date.today().year()).right(2)) -1);
				nextYear = Integer.valueof(string.valueof(date.today().year()).right(2));
			}

			wrapperClass objectWrapper;
			Integer key = 0;
			for(QC_MTL_Component__c var :qcMtlComponentRecordList) {
				key++;
				objectWrapper= new wrapperClass();
				objectWrapper.tempValue = var;
				objectWrapper.value = key;
				if(var.Testing_Type__c == 'Raw Material' && var.Material_Sample_Type__c != 'Re-Submission') {
					size= String.valueOf(rawMaterialvalue).length();
					reportReferenceNumber= size == 1 ?('RM/000' + rawMaterialvalue + '/' + todayYear + '-' + nextYear) :size == 2 ?('RM/00' + rawMaterialvalue + '/' + todayYear + '-' + nextYear) :size == 3 ?('RM/0' + rawMaterialvalue + '/' + todayYear + '-' + nextYear) :('RM/' + rawMaterialvalue + '/' + todayYear + '-' + nextYear);
					mapofmtlComponent.put(objectWrapper, reportReferenceNumber);
					rawMaterialvalue++;
				}
				if(var.Testing_Type__c == 'Plating' && var.Material_Sample_Type__c != 'Re-Submission') {
					if(platingWithCountRecords.get(var.Department__c + var.Testing_Type__c) != null) {
						platingvalue= platingWithCountRecords.get(var.Department__c + var.Testing_Type__c);
						platingvalue++;
					} else {
						platingvalue= 1;
					}
					size= String.valueOf(platingvalue).length();
					System.debug('sizesizesize======' + size);
					reportReferenceNumber= size == 1 ?('PL/' + var.Department__c + '/000' + platingvalue + '/' + todayYear + '-' + nextYear) :size == 2 ?('PL/' + var.Department__c + '/00' + platingvalue + '/' + todayYear + '-' + nextYear) :size == 3 ?('PL/' + var.Department__c + '/0' + platingvalue + '/' + todayYear + '-' + nextYear) :('PL/' + var.Department__c + '/' + platingvalue + '/' + todayYear + '-' + nextYear);
					mapofmtlComponent.put(objectWrapper, reportReferenceNumber);
					platingWithCountRecords.put(var.Department__c + var.Testing_Type__c, platingvalue);
				}
				if(var.Testing_Type__c == 'Plating and Material Composition' && var.Material_Sample_Type__c != 'Re-Submission') {
					if(platingWithCountRecords.get(var.Department_PMC__c + var.Testing_Type__c) != null) {
						platingComposvalue= platingWithCountRecords.get(var.Department_PMC__c + var.Testing_Type__c);
						platingComposvalue++;
					} else {
						platingComposvalue= 1;
					}
					size= String.valueOf(platingComposvalue).length();
					reportReferenceNumber= size == 1 ?('PMC/' + var.Department_PMC__c + '/000' + platingComposvalue + '/' + todayYear + '-' + nextYear) :size == 2 ?('PMC/' + var.Department_PMC__c + '/00' + platingComposvalue + '/' + todayYear + '-' + nextYear) :size == 3 ?('PMC/' + var.Department_PMC__c + '/0' + platingComposvalue + '/' + todayYear + '-' + nextYear) :('PMC/' + var.Department_PMC__c + '/' + platingComposvalue + '/' + todayYear + '-' + nextYear);
					mapofmtlComponent.put(objectWrapper, reportReferenceNumber);
					platingWithCountRecords.put(var.Department_PMC__c + var.Testing_Type__c, platingComposvalue);
				}
				//Re-Submission Logic
				if(var.Material_Sample_Type__c == 'Re-Submission' && (var.Report_Reference_Number__c != NuLL || var.Report_Reference_Number__c != '')) {
					List<String> tempRepartReference = var.Report_Reference_Number__c.split('/');
					if(tempRepartReference.size() == 3) {
						System.debug(tempRepartReference [1].trim().right(3));
						if(!temp.contains(tempRepartReference [1].trim().right(3).remove('(').remove(')'))) {
							reportReferenceNumber= tempRepartReference [0].trim() + '/' + tempRepartReference [1].trim() + '(a)/' + todayYear + '-' + nextYear;
						} else {
							String alp = alphabet.get(tempRepartReference [1].trim().right(3));
							Integer rigIndex = tempRepartReference [1].length();
							rigIndex-= 3;
							reportReferenceNumber= tempRepartReference [0].trim() + '/' + tempRepartReference [1].trim().left(rigIndex) + '' + alp + '/' + todayYear + '-' + nextYear;
							// if(tempRepartReference[1].trim().right(3)=='(z)'){
							//     reportReferenceNumber=tempRepartReference[0].trim()+'/'+tempRepartReference[1].trim()+''+alp+'/'+todayYear+'-'+nextYear;
							// }
						}
						mapofmtlComponent.put(objectWrapper, reportReferenceNumber)
							;
					} 
					else if(tempRepartReference.size() == 4) {
						if(!temp.contains(tempRepartReference [2].trim().right(3).remove('(').remove(')'))) {
							reportReferenceNumber= tempRepartReference [0].trim() + '/' + tempRepartReference [1].trim() + '/' + tempRepartReference [2].trim() + '(a)/' + todayYear + '-' + nextYear;
						} else {
							String alp = alphabet.get(tempRepartReference [2].trim().right(3));
							Integer rigIndex = tempRepartReference [2].length();
							rigIndex-= 3;
							reportReferenceNumber= tempRepartReference [0].trim() + '/' + tempRepartReference [1].trim() + '/' + tempRepartReference [2].trim().left(rigIndex) + '' + alp + '/' + todayYear + '-' + nextYear;
							// if(tempRepartReference[2].trim().right(3)=='(z)'){
							//     reportReferenceNumber=tempRepartReference[0].trim()+'/'+tempRepartReference[1].trim()+'/'+tempRepartReference[2].trim()+''+alp+'/'+todayYear+'-'+nextYear;
							// }
						}
						mapofmtlComponent.put(objectWrapper, reportReferenceNumber)
							;
					}
				}
			}
			for(wrapperClass var :mapofmtlComponent.keyset()) {
				var.tempValue.Report_Reference_Number__c = mapofmtlComponent.get(var);
				System.debug(mapofmtlComponent.get(var));
			}
			secondPart.MTL_Reference_Number__c = rawMaterialvalue;
			secondPart.Plating_Report_Reference_Number__c = platingvalue;
			secondPart.Plating_Material_Composition_RRFNumber__c = platingComposvalue;
			Database.update(secondPart);
		}
	}
}