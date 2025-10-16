public with sharing class new_update_oppo {

    @AuraEnabled(cacheable=true)
    public static list<Opportunity> newupdateoppo(){
        return [SELECT id,Name,StageName,CloseDate,Amount FROM Opportunity LIMIT 25];
    }

}