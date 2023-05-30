public class ProposalToolWatchesDeltaMorningSchedule implements Schedulable{
     public void execute(SchedulableContext SC) {
        Database.executebatch(new ProposalToolWatchesMasterDeltaBatch('-11-30/'),1000);
    }

}