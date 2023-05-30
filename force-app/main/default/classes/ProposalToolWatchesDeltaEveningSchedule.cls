public class ProposalToolWatchesDeltaEveningSchedule implements Schedulable{
    public void execute(SchedulableContext SC) {
        Database.executebatch(new ProposalToolWatchesMasterDeltaBatch('-17-30/'),1000);
    }
}