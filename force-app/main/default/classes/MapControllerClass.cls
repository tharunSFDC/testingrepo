public class MapControllerClass {
     
    @AuraEnabled(cacheable=true)
    public static list<Account> getAccount()
    {
        return [select id,Name,description,billingstreet,
        billingcountry,billingcity,billingstate,billingpostalcode from Account ORDER by Name limit 10];
    }
}