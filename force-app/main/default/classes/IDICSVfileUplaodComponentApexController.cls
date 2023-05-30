/*
 * Company : Kvp Business Solution
 * Date    : 11/4/2019
 * Author  : Sameer Ranjan
 * Description : Controller Class of IDICSVfileUplaodComponent.cmp  Aura Component
 * History     : N/L
 */
public with sharing class IDICSVfileUplaodComponentApexController {

	private static Boolean isPlatingMaterialComp = false;
	public class CustomException extends Exception {
	}
	public IDICSVfileUplaodComponentApexController() {
		System.debug('Empty Constructor');
	}
	// Fatch the CSV String
	@AuraEnabled
	public static String fatchRecords(String requestedParameters) {
		List<Object> jsonObject = (List<Object>) JSON.deserializeUntyped(requestedParameters);
		Map<String, Object> mapJson = (Map<String, Object>) jsonObject [0];
		Map<String, Object> mapRequestValue = (Map<String, Object>) jsonObject [1];
		List<SObject> records = Database.query((String) mapJson.get('query'));
		String returnCSVString = '';
		returnCSVString += '' + getLabelValue((String) mapRequestValue.get('requestedFields')) + '\n';
		for(SObject each :records) {
			returnCSVString += '' + getRowString(each, (String) mapRequestValue.get('requestedFields')) + '\n';
		}
		returnCSVString += 'EOF';
		return returnCSVString;
	}

	private static String getLabelValue(String apiString) {
		String type = 'QC_MTL_Component__c';
		Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(type).getDescribe().fields.getMap();
		String returnString = '';
		for(String eachString :apiString.split(',')) {
			returnString += fieldMap.get(eachString.trim()).getDescribe().getLabel() + ',';
		}
		return returnString;
	}
	private static String getRowString(SObject instence, String fieldAPIName) {
		//System.debug('fieldAPIName' + fieldAPIName);
		Integer eachFieldCount = 1;
		String returnString = '';
		List<String> listString = fieldAPIName.split(',');
		for(String each :listString) {
			if(eachFieldCount != listString.size()) {
				returnString += instence.get(each.trim()) + ',';
			} else {
				returnString += instence.get(each.trim());
			}
			eachFieldCount++;
		}
		return returnString.remove('null');
	}
	// upload Raw material
	private static void uploadRawMaterial(Object fileData) {
		Map<String, Object> mapFileObject = (Map<String, Object>) JSON.deserializeUntyped(String.valueOf(fileData));
		String csvString = EncodingUtil.base64Decode(mapFileObject.get('baseDate').toString()).toString();
		List<String> rows = csvString.split('\n');
		//System.debug(rows.size());
		if(!rows [rows.size() -1].contains('EOF')) {
			throw new CustomException('please defined EOF in last row.');
		}
		Boolean isEOF = true;
		Integer rowNo = 1;
		List<String> rowValue;
		set<String> setQCMTLComponentName = new set<String>();
		set<String> setQcAccessMasterExternalId = new set<String>();
		set<String> setSupplierExternalId = new set<String>();
		set<String> setMasterId = new Set<String>();
		Map<Integer, List<String>> mapOfSNRow = new Map<Integer, List<String>>();
		while(isEOF) {
			rowValue = rows [rowNo].split(',');
			if(rowValue [0].contains('EOF')) {
				isEOF = false;
				continue;
			}
			if(!isBlank(rowValue [0].trim())) {
				setQCMTLComponentName.add(rowValue [0].trim());
			}
			if(!isBlank(rowValue [6].trim())) {
				setMasterId.add(rowValue [6].trim());
			}
			if(!isBlank(rowValue [7].trim())) {
				setSupplierExternalId.add(rowValue [7].trim());
			}
			if(!isBlank(rowValue [8].trim())) {
				setQcAccessMasterExternalId.add(rowValue [8].trim());
			}
			mapOfSNRow.put(rowNo, rowValue);
			rowNo++;
		}
		System.debug('setQCMTLComponentName' + setQCMTLComponentName);
		List<QC_Access_Master__c> listMasterRecords = new List<QC_Access_Master__c>();
		if(QC_Access_Master__c.sObjectType.getDescribe().isCreateable()) {
			listMasterRecords = [SELECT Id, QC_Account_Master_External_Id__c
							     FROM QC_Access_Master__c
							     WHERE QC_Account_Master_External_Id__c IN :setQcAccessMasterExternalId];
		}
		List<Supplier_Grade__c> listSupplierGrade = new List<Supplier_Grade__c>();
		if(Supplier_Grade__c.sObjectType.getDescribe().isCreateable()) {
			listSupplierGrade = [SELECT Id, Supplier_Grade_External_Id__c, TCL_Designation__c
							     FROM Supplier_Grade__c
							     WHERE Supplier_Grade_External_Id__c IN :setSupplierExternalId];
		}
		List<QC_MTL_Component__c> fatchExistingRecords = [SELECT Id, Name
													      FROM QC_MTL_Component__c
													      WHERE Name IN :setQCMTLComponentName];
		List<QC_Access_Master__c> msterRecords = [SELECT Id,Name,Specification_Revision__c FROM QC_Access_Master__c where Name in:setMasterId];

		Map<String, Id> mapMasterWithRecordid = new Map<String, Id>();
		for(QC_Access_Master__c eachRecord :listMasterRecords) {
			mapMasterWithRecordid.put(eachRecord.QC_Account_Master_External_Id__c, eachRecord.Id);
		}
		Map<String, Id> mapSupplierRecordid = new Map<String, Id>();
		Map<String, String> mapSupplierWithTCLDesi = new Map<String, String>();
		for(Supplier_Grade__c eachRecord :listSupplierGrade) {
			mapSupplierRecordid.put(eachRecord.Supplier_Grade_External_Id__c, eachRecord.Id);
			mapSupplierWithTCLDesi.put(eachRecord.Supplier_Grade_External_Id__c,eachRecord.TCL_Designation__c);
		}
		Map<String, Id> mapNameWithRecordId = new Map<String, Id>();
		for(QC_MTL_Component__c each :fatchExistingRecords) {
			mapNameWithRecordId.put(each.Name, each.Id);
		}
		Map<String,Id> mapOfMasterWithId = new Map<String,Id>();
		Map<String, String> mapOfmasterWithSpectiRevi = new Map<String, String>();
		for(QC_Access_Master__c each :msterRecords){
			mapOfMasterWithId.put(each.Name,each.Id);
			mapOfmasterWithSpectiRevi.put(each.Name, each.Specification_Revision__c);
		}
		List<QC_MTL_Component__c> upsertQCMTLRecords = new List<QC_MTL_Component__c>();
		for(Integer eachIndex :mapOfSNRow.keySet()) {
			System.debug('mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8]))' + mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8])));
			System.debug('mapOfSNRow.get(eachIndex) [15]'+mapOfSNRow.get(eachIndex) [14]);
			upsertQCMTLRecords.add(new QC_MTL_Component__c(Id = mapNameWithRecordId.get(returnNull(mapOfSNRow.get(eachIndex) [0])), 
								   Sample_Received_From__c = returnNull(mapOfSNRow.get(eachIndex) [2]), 
								   MTL_User_Email__c = returnNull(mapOfSNRow.get(eachIndex) [3]), 
								   Raw_Material_Type__c = returnNull(mapOfSNRow.get(eachIndex) [4]), 
								   Raw_Material_Name__c = returnNull(mapOfSNRow.get(eachIndex) [5]), 
								   Titan_Specification_Reference__c = mapOfMasterWithId.get(returnNull(mapOfSNRow.get(eachIndex) [6])), 
								   Supplier_Grade__c = mapSupplierRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [7])), 
								   Supplier_Name_New__c = mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8])), 
								   Specification_revision__c = mapOfmasterWithSpectiRevi.get(returnNull(mapOfSNRow.get(eachIndex) [6])), 
								   Invoice_Dc_No__c = returnNull(mapOfSNRow.get(eachIndex) [9]), 
								   RM_Size__c = returnNull(mapOfSNRow.get(eachIndex) [10]), 
								   Testing_Type__c = 'Raw Material', 
								   Heat_No_Grade__c = returnNull(mapOfSNRow.get(eachIndex) [11]), 
								   Supply_Quantity__c = returnNull(mapOfSNRow.get(eachIndex) [12]), 
								   Sample_Size_Qty__c = returnNull(mapOfSNRow.get(eachIndex) [13]) != null ? Decimal.valueOf(returnNull(mapOfSNRow.get(eachIndex) [13])) :null, 
								   TCL_Designation__c = mapSupplierWithTCLDesi.get(returnNull(mapOfSNRow.get(eachIndex) [7])), 
								   Material_Sample_Type__c = mapOfSNRow.get(eachIndex) [14].trim()));
		}
		System.debug(upsertQCMTLRecords);
		for(QC_MTL_Component__c each :upsertQCMTLRecords) {
			System.debug(each.Id);
		}
		if(!upsertQCMTLRecords.isEmpty()) {
			upsert upsertQCMTLRecords;
		}
	}
	// upload Plating Records
	private static void uploadPlatingRecords(Object fileData) {
		Map<String, Object> mapFileObject = (Map<String, Object>) JSON.deserializeUntyped(String.valueOf(fileData));
		String csvString = EncodingUtil.base64Decode(mapFileObject.get('baseDate').toString()).toString();
		List<String> rows = csvString.split('\n');
		//System.debug(rows.size());
		if(!rows [rows.size() -1].contains('EOF')) {
			throw new CustomException('please defind EOF in last row.');
		}
		Boolean isEOF = true;
		Integer rowNo = 1;
		List<String> rowValue;
		set<String> setQCMTLComponentName = new set<String>();
		set<String> setQcAccessMasterExternalId = new set<String>();
		set<String> setMasterId = new Set<String>();
		Map<Integer, List<String>> mapOfSNRow = new Map<Integer, List<String>>();
		while(isEOF) {
			rowValue = rows [rowNo].split(',');
			if(rowValue [0].contains('EOF')) {
				isEOF = false;
				continue;
			}
			if(!isBlank(rowValue [0].trim())) {
				setQCMTLComponentName.add(rowValue [0].trim());
			}
			if(!isBlank(rowValue [6].trim())) {
				setMasterId.add(rowValue [6].trim());
			}
			if(!isBlank(rowValue [7].trim())) {
				setQcAccessMasterExternalId.add(rowValue [7].trim());
			}
			if(!isBlank(rowValue [8].trim())) {
				setQcAccessMasterExternalId.add(rowValue [8].trim());
			}
			if(!isBlank(rowValue [19].trim())){
				setQcAccessMasterExternalId.add(rowValue [19].trim());
			}
			mapOfSNRow.put(rowNo, rowValue);
			rowNo++;
		}
		System.debug('setQCMTLComponentName' + setQCMTLComponentName);
		List<QC_Access_Master__c> listMasterRecords = new List<QC_Access_Master__c>();
		if(QC_Access_Master__c.sObjectType.getDescribe().isCreateable()) {
			listMasterRecords = [SELECT Id, QC_Account_Master_External_Id__c
							     FROM QC_Access_Master__c
							     WHERE QC_Account_Master_External_Id__c IN :setQcAccessMasterExternalId];
		}
		List<QC_MTL_Component__c> fatchExistingRecords = [SELECT Id, Name
													      FROM QC_MTL_Component__c
													      WHERE Name IN :setQCMTLComponentName];
		List<QC_Access_Master__c> msterRecords = [SELECT Id,Name FROM QC_Access_Master__c where Name in:setMasterId];

		Map<String, Id> mapMasterWithRecordid = new Map<String, Id>();
		for(QC_Access_Master__c eachRecord :listMasterRecords) {
			mapMasterWithRecordid.put(eachRecord.QC_Account_Master_External_Id__c, eachRecord.Id);
		}
		Map<String, Id> mapNameWithRecordId = new Map<String, Id>();
		for(QC_MTL_Component__c each :fatchExistingRecords) {
			mapNameWithRecordId.put(each.Name, each.Id);
		}
		Map<String,Id> mapOfMasterWithId = new Map<String,Id>();
		for(QC_Access_Master__c each :msterRecords){
			mapOfMasterWithId.put(each.Name,each.Id);
		}
		List<QC_MTL_Component__c> upsertQCMTLRecords = new List<QC_MTL_Component__c>();
		if(isPlatingMaterialComp) {
			for(Integer eachIndex :mapOfSNRow.keySet()) {
				System.debug('mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8]))' + mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8])));
				upsertQCMTLRecords.add(new QC_MTL_Component__c(Id = mapNameWithRecordId.get(returnNull(mapOfSNRow.get(eachIndex) [0])), 
									   Sample_Received_From__c = returnNull(mapOfSNRow.get(eachIndex) [2]), 
									   MTL_User_Email__c = returnNull(mapOfSNRow.get(eachIndex) [3]), 
									   Department_PMC__c = returnNull(mapOfSNRow.get(eachIndex) [4]), 
									   Part_Name__c = returnNull(mapOfSNRow.get(eachIndex) [5]), 
									   Titan_Specification_Reference__c = mapOfMasterWithId.get(returnNull(mapOfSNRow.get(eachIndex) [6])), 
									   Supplier_Name_New__c = mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [7])), 
									   Brand__c = mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8])), 
									   Source__c = returnNull(mapOfSNRow.get(eachIndex) [9]), 
									   Model__c = returnNull(mapOfSNRow.get(eachIndex) [10]), 
									   Docket_Number__c = returnNull(mapOfSNRow.get(eachIndex) [11]), 
									   Testing_Type__c = 'Plating and Material Composition', 
									   Batch_Quantity__c = returnNull(mapOfSNRow.get(eachIndex) [12]), 
									   Material__c = returnNull(mapOfSNRow.get(eachIndex) [13]), 
									   Plating_Type__c = returnNull(mapOfSNRow.get(eachIndex) [14]), 
									   Specification_revision__c = returnNull(mapOfSNRow.get(eachIndex) [15]), 
									   Required_test_PMC__c = returnNull(mapOfSNRow.get(eachIndex) [16]), 
									   Sample_Size_Plating__c = returnNull(mapOfSNRow.get(eachIndex) [17].trim()) != null ? Decimal.valueOf(mapOfSNRow.get(eachIndex) [17].trim()) :null, 
									   Material_Sample_Type__c = mapOfSNRow.get(eachIndex) [18].trim()));
			}
			checkValidation(upsertQCMTLRecords);
		} else {
			for(Integer eachIndex :mapOfSNRow.keySet()) {
				System.debug('mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8]))' + mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8])));
				upsertQCMTLRecords.add(new QC_MTL_Component__c(Id = mapNameWithRecordId.get(returnNull(mapOfSNRow.get(eachIndex) [0])), 
									   Sample_Received_From__c = returnNull(mapOfSNRow.get(eachIndex) [2]), 
									   MTL_User_Email__c = returnNull(mapOfSNRow.get(eachIndex) [3]), 
									   Department__c = returnNull(mapOfSNRow.get(eachIndex) [4]), 
									   Part_Name__c = returnNull(mapOfSNRow.get(eachIndex) [5]), 
									   Titan_Specification_Reference__c = mapOfMasterWithId.get(returnNull(mapOfSNRow.get(eachIndex) [6])), 
									   Supplier_Name_New__c = mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [7])), 
									   Brand__c = mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [8])), 
									   Source__c = returnNull(mapOfSNRow.get(eachIndex) [9]), 
									   Model__c = returnNull(mapOfSNRow.get(eachIndex) [10]), 
									   Docket_Number__c = returnNull(mapOfSNRow.get(eachIndex) [11]), 
									   Testing_Type__c = 'Plating', 
									   Batch_Quantity__c = returnNull(mapOfSNRow.get(eachIndex) [12]), 
									   Material__c = returnNull(mapOfSNRow.get(eachIndex) [13]), 
									   Plating_Type__c = returnNull(mapOfSNRow.get(eachIndex) [14]), 
									   Specification_revision__c = returnNull(mapOfSNRow.get(eachIndex) [15]), 
									   Required_Test__c = returnNull(mapOfSNRow.get(eachIndex) [16]), 
									   Sample_Size_Plating__c = returnNull(mapOfSNRow.get(eachIndex) [17].trim()) != null ? Decimal.valueOf(mapOfSNRow.get(eachIndex) [17].trim()) :null, 
									   Material_Sample_Type__c = mapOfSNRow.get(eachIndex) [18].trim(),
									   Plater_Name__c =  mapMasterWithRecordid.get(returnNull(mapOfSNRow.get(eachIndex) [19].trim()))));
			}
			System.debug(upsertQCMTLRecords);
			checkValidation(upsertQCMTLRecords);
		}
		if(!upsertQCMTLRecords.isEmpty()) {
			upsert upsertQCMTLRecords;
		}
	}
	private static void checkValidation(List<QC_MTL_Component__c> upsertQCMTLRecords){
		Integer i = 1;
		for(QC_MTL_Component__c each : upsertQCMTLRecords){
			if(!isPlatingMaterialComp && each.Department__c == null ){
				throw new CustomException('row no:'+(i+1)+' Department Empty!!');
			}
			if(isPlatingMaterialComp && each.Department_PMC__c == null){
				throw new CustomException('row no:'+(i+1)+' Department Empty!!');
			}
			i++;
		}
	}
	// upload PMC records
	private static void uploadPlatingmaterialRecords(Object fileData) {
		uploadPlatingRecords(fileData);
	}
	private static String returnNull(String value) {
		if(value != '' && value != null) {
			return value.trim();
		} else {
			return null;
		}
	}
	private static Boolean hasPermission(String objectName) {
		return schema.getGlobalDescribe().get(objectName).getDescribe().isUpdateable();
	}
	private static Boolean isBlank(String value) {
		return (value == '' || value == null);
	}
	@AuraEnabled
	public static String uploadCSVFile(String requestParametes) {
        
		Map<String, Object> jsonObject = (Map<String, Object>) JSON.deserializeUntyped(requestParametes);
		//System.debug(jsonObject.get('fileData'));
		System.debug(jsonObject.get('uploadingAction'));
		if(String.valueOf(jsonObject.get('uploadingAction')) == 'Raw Material') {
			uploadRawMaterial(jsonObject.get('fileData'));
		} else if(String.valueOf(jsonObject.get('uploadingAction')) == 'Plating') {
			uploadPlatingRecords(jsonObject.get('fileData'));
		} else if(String.valueOf(jsonObject.get('uploadingAction')) == 'Plating and Material Composition') {
			isPlatingMaterialComp = true;
			uploadPlatingmaterialRecords(jsonObject.get('fileData'));
		}
		return '';
	}
}