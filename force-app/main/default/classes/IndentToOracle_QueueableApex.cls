/***********************************************************
Created by: Vinoth Kumar
Created on: 24/07/2019
Description: To avoid 'Apex CPU time limit exceeded' in indentToOracle class, we have queued the dml action
************************************************************/

public class IndentToOracle_QueueableApex implements queueable {
    List<Quote> QuoteList =  new List<Quote>();
    public IndentToOracle_QueueableApex(List<Quote> QuoteListParam){
       QuoteList = QuoteListParam;
    }
    public void execute(QueueableContext context){
       List<Quote> lUpdateQuote = new List<Quote>();
          for(Quote qt : QuoteList){
             qt.Indent_Status__c  = 'Processed';
             lUpdateQuote.add(qt);
         }
          if(!lUpdateQuote.isEmpty()){
            update lUpdateQuote;
         }
    }

}