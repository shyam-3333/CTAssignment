@isTest(seeAllData=true)
public class Test_TitanMBAWinlossDashboard 
{
    static testMethod void CheckOne()
    {
       
        TitanMBA_WinlossDashboard v=new TitanMBA_WinlossDashboard();
        TitanMBA_WinlossDashboard.wrapper w=new TitanMBA_WinlossDashboard.wrapper();
        v.runReportChart();
        v.changeOnIndustrySelection();
        
    }
}