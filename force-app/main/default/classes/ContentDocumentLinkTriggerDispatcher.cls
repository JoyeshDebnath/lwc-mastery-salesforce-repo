public  class ContentDocumentLinkTriggerDispatcher {
  public static void dispatch(System.TriggerOperation opsType) {
      System.debug(opsType);
    switch on opsType{
        when AFTER_INSERT{
            ContentDocumentLinkTriggerHandler.copyFileToAccount(Trigger.New);
        } 
    }
  }
}