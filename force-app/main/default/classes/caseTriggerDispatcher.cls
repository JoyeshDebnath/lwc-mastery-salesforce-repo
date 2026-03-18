public  class caseTriggerDispatcher {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            when AFTER_INSERT{
                CaseTriggerHandler.recursiveTriggerDemo(Trigger.New);
            }
            when AFTER_UPDATE{

            }
            when AFTER_DELETE{

            }
            when AFTER_UNDELETE{

            }
            when BEFORE_INSERT{

            }
            when BEFORE_UPDATE{

            }
            when BEFORE_DELETE{

            }
        }
    }
}