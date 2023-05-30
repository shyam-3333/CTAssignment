trigger productPartupdation on Product2 (After insert, After Update) {
    If(Trigger.isafter &&(Trigger.isinsert || Trigger.isUpdate)){
        runPartProduct run = new runPartProduct();
        string croneexp='0 0 6 * * ?';
        system.schedule('jobName', croneexp, run);
    }
}