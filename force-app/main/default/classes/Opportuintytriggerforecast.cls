public with sharing class Opportuintytriggerforecast {
    //When an Opportunity with amount 500000 is inserted
    // create forecase record with the opportunity expected revenue and quarter
    //Addtionally, noftiy the Account owner via chatter using queueable ensure.
     @AuraEnabled(cacheable=true)
    public static list<Opportunity> returnoppos()
    {
        return [select id,Name,AccountId,CloseDate,Amount,Stagename from Opportunity limit 100];
    }
    /*

    public static void foresCastMethod(list<Opportunity> newlist, map<id,sObject> oldmap)
    {
        set<id> oppoids = new set<id>();
        set<id> Accountids = new set<id>();
        if(newlist.isempty())
        {
            return;
        }else{
            for(opportunity oppo:newlist)
            {
                Opportunity  oldoppo =(opportunity)oldmap.get(oppo.id);
                if(oppo.Amount >=500000 && oppo.Amount !=oldoppo.Amount)
                {
                    if(oppo?.AccountId !=null)
                    {
                        oppoids.add(oppo.id);
                        Accountids.add(oppo.AccountId);
                    }
                }
            }
        }
        if(!oppoids.isempty())
        {
            list<Opportunity> oppolist=[select id,Name,AccountId,StageName,Amount,CloseDate from opportunity where id in:oppoids];
            list<ForeCast__c> foreCastList = new list<ForeCast__c>();

            if(oppolist !=null)
            {
                for(opportunity oppo:oppolist)
                {
                    ForeCast__c fc = new ForeCast__c();
                    fc.Name=oppo.Name+'ForeCast';
                    fc.Opportunity__c=oppo.id;
                    fc.ForestCast_Amount__c=oppo.Amount;
                    fc.ForeCastStage__c=oppo.StageName;
                    fc.Forecast_Quarter__c=string.valueof(math.ceil(oppo.CloseDate.month()/3.0));
                    foreCastList.add(fc);
                }
            }

            if(foreCastList !=null)
            {
                Database.SaveResult[] results = Database.insert(foreCastList,false);
                system.debug(results);
            }
            if(!Accountids.isempty())
            {
                system.enqueueJob(new NotifyAccountOwner(Accountids));
            }
        }
    } */

}