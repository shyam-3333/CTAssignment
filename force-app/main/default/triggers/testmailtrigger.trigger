trigger testmailtrigger on Account(after insert, after update) {
    
testmail.sendmail(trigger.new);
}