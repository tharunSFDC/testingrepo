public class Accounts extends fflib_SObjectDomain {
    
    public Accounts(list<Account> sObjectlist)
    {
        super(sObjectlist);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable{
        public fflib_SObjectDomain construct(list<sObject> SObjectlist)
        {
            return new Accounts(sobjectlist);
        }
    }
    
    public override void onApplyDefaults()
    {
        for(Account acc:(list<Account>) Records)
        {
            acc.Description='Domain classes rock!';
        }
    }
    public override void onBeforeUpdate(map<id,sObject> existingrecords)
    {
        for(Account account:(List<Account>)records)
        {
            account.AnnualRevenue=(account.description).getLevenshteinDistance('Domain classes rock!');
        }
    }

}