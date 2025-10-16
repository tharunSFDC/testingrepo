public class AccountAction {
    @InvocableMethod
    public static list<Decimal> updateamount(list<id> ids)
    {
        //ferchinf opportunity information
        list<Opportunity> newopp =[SELECT AccountId, Amount FROM Opportunity where id =: ids[0]];
        system.debug(newopp);
        
        // fecting account information realted oppo
        list<Account> acc = [SELECT AnnualRevenue FROM Account where id=: newopp[0].accountId];
        
        List<Decimal> annual = new list<Decimal> ();
        
        acc[0].AnnualRevenue=acc[0].AnnualRevenue+newopp[0].Amount;
        
        update acc;
        
        annual.add(acc[0].AnnualRevenue);
        return annual;
        
        
    }

}