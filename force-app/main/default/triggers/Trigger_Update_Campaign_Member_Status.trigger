trigger Trigger_Update_Campaign_Member_Status on Campaign (after insert) {

    List<CampaignMemberStatus> cms = new List<CampaignMemberStatus>();
        
    for(Campaign c : Trigger.New){
        CampaignMemberStatus cms1 = new CampaignMemberStatus();
        cms1.Label = 'Invite Sent';
        cms1.CampaignId = c.ID;
        cms1.SortOrder = 3;
        cms.add(cms1);
    }
    
    Insert cms;
   
}