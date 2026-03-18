public class LeadTriggerDispatcher {
    public static void dispatch(System.TriggerOperation operationTypes ){
        
        switch on operationTypes{
            when AFTER_INSERT{
                LeadTriggerHelper.sendEmails((Map<Id,Lead>)Trigger.newMap);
                
            }
            when AFTER_UPDATE{
               
            }
            when AFTER_DELETE{
                
            }
            when AFTER_UNDELETE{
                
            }
            when BEFORE_INSERT{
                LeadTriggerHelper.sendEmailIfPhoneOrEmailBlank(Trigger.new);
            }
            when BEFORE_UPDATE{
                 LeadTriggerHelper.sendEmailIfPhoneOrEmailBlank(Trigger.new);
            }
            when BEFORE_DELETE{

            }
        }
    }
}