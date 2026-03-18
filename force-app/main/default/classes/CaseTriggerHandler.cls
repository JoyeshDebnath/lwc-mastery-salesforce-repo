public with sharing class CaseTriggerHandler {
    public CaseTriggerHandler() {

    }
    private static String getPriorityAsPerZendesk(String priority){
        switch on priority{
            when 'High'{
                return 'urgent';
            }
            when 'Medium'{
                return 'normal';
            }
            when 'Low'{
                return 'low';
            }

        }
        return '';
    }
    public static void handleAfterInsert(List<Case> newCaseList){
        for(Case c:newCaseList){
            ZendeskIntegrationUtil.TicketWrapper ticket_wrapper=new ZendeskIntegrationUtil.TicketWrapper();
            ticket_wrapper.body=c?.Description;
            ticket_wrapper.subject=c?.Subject;
            ticket_wrapper.priority=getPriorityAsPerZendesk(c.Priority).toLowerCase();
            makeZendeskCallOut(JSON.serialize(ticket_wrapper));//convert the object to string 
        }
    }

    @future(callout=true)
    private static void makeZendeskCallOut(String params){
        ZendeskIntegrationUtil.TicketWrapper ticket_wrapper=(ZendeskIntegrationUtil.TicketWrapper)JSON.deserialize(params,ZendeskIntegrationUtil.TicketWrapper.class);//convert the string to object 
        ZendeskIntegrationUtil.ZendeskTicketCreationDemo(ticket_wrapper);

    }
}