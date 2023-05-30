/*************************************************************
* Created by: Vinoth Kumar A
* Created on: 06/05/2019
* Description: Email should be sent if the Final Verdict of the component is reject, in the frequency of 10 days 
* ************************************************************/
global class QC_FinalVerdictRejectEmailSchedulerClass implements Schedulable{
    global void execute(SchedulableContext sc){
        QC_FinalVerdictRejectEmailBatchClass Qc =  new QC_FinalVerdictRejectEmailBatchClass();
        database.executeBatch(Qc,1);
    }
}