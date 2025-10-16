public with sharing class opportunitycontroller {

   public static List<Opportunity> opplist = new List<Opportunity>();

    @AuraEnabled(cacheable=true)
    public static List<opportunity> getOpportunitys1()
    {
        return [select StageName from opportunity ];
    }

    @AuraEnabled(cacheable=true)
    public static list<Opportunity> relatedOpportunitystoAccount(string stagename)
    {

        if(stagename !=null)
        {   opplist =[select id,StageName,Name,Amount,ExpectedRevenue,type 
                from 
                Opportunity 
                where 
                StageName=:stagename];



        }

        return opplist;
    }

}