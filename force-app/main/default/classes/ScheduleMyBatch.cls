Global class ScheduleMyBatch implements Schedulable{
    global void execute(SchedulableContext sc){
        BatchProcessAcc b = new BatchProcessAcc();
        database.executeBatch(b);
    }
}