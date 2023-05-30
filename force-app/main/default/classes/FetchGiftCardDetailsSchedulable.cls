global class FetchGiftCardDetailsSchedulable Implements Schedulable{
    global void execute(SchedulableContext sc)
    {
        FetchGiftCardsRedemptionDetails fetchDetails = new FetchGiftCardsRedemptionDetails();
        fetchDetails.fetchFileFromS3();
    }
}