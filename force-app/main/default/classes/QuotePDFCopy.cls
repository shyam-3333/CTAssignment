public with sharing class QuotePDFCopy {
	
	String quoteid='';
	public QuotePDFCopy() {
		quoteid = ApexPages.Currentpage().getParameters().get('id');
	}
	public PageReference copy() {
		 
		 List<QuoteDocument> quoteDocList = [Select q.QuoteId, q.Name, q.Id, q.Document From QuoteDocument q where q.QuoteId =: quoteid ];
		 Quote q = [Select q.OpportunityId, q.Id From Quote q where q.Id =: quoteid ];
		 
		 List<Attachment> toBeInsert = new List<Attachment>();
		 for(QuoteDocument qd: quoteDocList ) {
		 	Attachment a = new Attachment();
		 	a.ParentId = q.OpportunityId;
		 	a.Body = qd.Document;
		 	a.Name = qd.Name;
		 	toBeInsert.add(a);
		 }
		 if(toBeInsert.size() > 0) {
		 	insert toBeInsert;
		 }
		PageReference pageRef = new PageReference('/' +q.OpportunityId );
        pageRef.setRedirect(true);
        return pageRef;
	}

}