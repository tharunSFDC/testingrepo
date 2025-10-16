public class ActiononAccount {
    @InvocableMethod
    public static list<string> returnaccounts(list<id> ids)
    {
        list<string> accountname = new list<string>();
        
        list<Account> acclist =[SELECT Name FROM Account where id =:ids];
        
        for(Account ac:acclist)
        {
            accountname.add(ac.Name);
            
        }
        return accountname;
    }
    

}