/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Developer2(Lister)  11/13/2019   		Created this class newly for retrieving report id and create href link in VF pages using custom meta data
*/
public class ReportLinkWrapper {
    public String linkName{get;set;}
    public String reportPath{get;set;}
    public String reportName{get;set;}
    
    /*
		This  method returns report id for the report names queried from custom metadata to use in VF pages 
	*/
    public static  List<ReportLinkWrapper> getURLForReports(Map<String,String> reportNames,List<ReportLinkWrapper> reportIdsForUrlList){
        Set<Report> reportsSet = new Set<Report>([select id,DeveloperName from Report where DeveloperName in : reportNames.keyset()]);
        
        Map<String,String> reportIdsForUrlMap = new Map<String,String>();
        ReportLinkWrapper wrapper = null;
        for(Report report : reportsSet){
            if(reportNames.containskey(report.DeveloperName)){
                wrapper = new ReportLinkWrapper();
                wrapper.linkName = reportNames.get(report.DeveloperName);
                wrapper.reportPath = ('/'+String.valueOf(report.Id));
                wrapper.reportName = report.DeveloperName;
                reportIdsForUrlList.add(wrapper);
            }
        }
        return reportIdsForUrlList;
    }
}