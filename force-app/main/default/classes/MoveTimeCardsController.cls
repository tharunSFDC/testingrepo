public class MoveTimeCardsController {
    
    
    @InvocableMethod(label='move timecards')
    public static void listoftimecs(list<list<Time_Cards__c>> updatetimecardslis)
    {
        if(!updatetimecardslis.isempty())
        {
            set<id> timecardids = new set<id>();
            list<Time_Cards__c> timecardslist = new list<Time_Cards__c>();
            
            for(list<Time_Cards__c> tm:updatetimecardslis)
            {
                timecardslist.addall(tm);
            }
            for(time_cards__c tm1:timecardslist)
            {
                timecardids.add(tm1.id);
            }
            handlerecallactions(timecardids);
            
        }
        
        
    }
    
    public static void handlerecallactions(set<id> timecardids){
        list<ProcessInstanceWorkitem> piwi =[select id,processinstanceId, processinstance.TargetObjectId 
                                             from ProcessInstanceWorkitem 
                                             where processinstance.TargetobjectId in : timecardids];
        system.debug(piwi.size());
        list<Approval.processworkitemrequest> req = new list<Approval.processworkitemrequest>();
        
        if(piwi.isempty())
        {
            return;
        }else{
            for(ProcessinstanceWorkitem wk:piwi)
            {
                Approval.processworkitemrequest recall = new Approval.processworkitemrequest();
                recall.setAction('Removed');
                recall.setWorkitemId(wk.id);
                req.add(recall);
                
            }
            
            if(!req.isempty())
            {
                Approval.process(req,false);
                system.debug(req);
                
            }
        }
    }
    
    
}