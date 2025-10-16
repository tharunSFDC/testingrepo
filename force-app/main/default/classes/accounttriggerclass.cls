public class accounttriggerclass {
    public static void accoutsmethod(list<Account> newacc, map<id,Account> oldmap)
    {
        fflib_SobjectUnitofWork uow = new fflib_SobjectUnitofWork(
            new list<sObjectType>{
            Account.SObjecttype,
            Contact.SObjectType,
            Opportunity.SObjectType});
        
        set<id> accids = new set<id>();
        
        if(!newacc.isempty())
        {
            for(Account acc:newacc)
            {
                Account oldacc=oldmap.get(acc.id);
                
                if(acc.Rating =='Hot' & oldacc.Rating != 'Hot')
                {
                    accids.add(acc.id);
                }
            }
            
        }
        
        if(!accids.isempty())
        {
            list<Contact> conlist = [select id,FirstName,Phone,Email,Accountid from Contact where AccountId in:accids];
            list<Opportunity> opplist=[select id,Amount,Accountid from Opportunity where AccountId in:accids];
            
            string firstname;
            string accdesc;
            if(!conlist.isempty())
            {
                for(Contact con:conlist)
                {
                    firstname ='FirstName only==>'+' '+con.FirstName+' '+'\n';
                    accdesc+=firstname;
                    
                    con.Description='Sampletesting here';
                    uow.registerDirty(con);
                    
                }
                
            }
            for(id ids:accids)
            {
                Account updateacc=new Account();
                updateacc.Id=ids;
                updateacc.Description=accdesc;
                
                uow.registerDirty(updateacc);
            }
            
            if(!opplist.isempty())
            {
                for(Opportunity opp:opplist)
                {
                    uow.registerDeleted(opp);
                }
            }
            
        }
        
        uow.commitWork();
        
    }

}