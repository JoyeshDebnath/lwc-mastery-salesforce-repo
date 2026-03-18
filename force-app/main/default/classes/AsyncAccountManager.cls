public with sharing class AsyncAccountManager implements System.Queueable{
    public void execute (System.QueueableContext qc){
        System.debug('Async Account manager ');
    }
}