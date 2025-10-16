public class AccountsSelector extends fflib_SObjectSelector {
    
    public list<Schema.SObjectField> getSObjectFieldList()
    {
        return new list<Schema.SObjectField>{
            Account.Name,
            Account.Description,
            Account.AnnualRevenue
        };
         
    }
    public schema.SObjectType getSObjectType()
    {
        return Account.sObjectType;
    }
    public list<Account> selectById(set<id> idset)
    {
        return (list<Account>) selectSObjectsById(idset);
    }

}