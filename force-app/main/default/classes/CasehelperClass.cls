public class CasehelperClass {
    
    // check for the notify field is not blank and updated the Accoun active and Related Contact to Active and primary contact as true
    public static void casemethodhelper(list<Case> newlist, map<id,Case> oldmap)
    {
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new schema.sObjectType[]{
                Account.SObjectType,
                    Contact.SObjectType
                    });
        set<id> accountid = new set<id>();
        set<id> contactid = new set<id>();
        if(!newlist.isempty())
        {
            for(Case ca:newlist)
            {
                if(ca.Notify__c !=null)
                {
                    if(ca.AccountId !=null)
                    {
                        accountid.add(ca.AccountId);
                    }
                    if(ca.ContactId !=null)
                    {
                        contactid.add(ca.ContactId);
                    }
                    
                    
                }
                case oldcase=oldmap.get(ca.id);
                if(ca.Notify__c==null && oldcase.Notify__c !=null){
                    if(ca.AccountId !=null)
                    {
                        accountid.add(ca.AccountId);
                    }
                    if(ca.ContactId !=null)
                    {
                        contactid.add(ca.ContactId);
                    }
                    
                }
            }
            
            if(!accountid.isempty() || !contactid.isempty())
            {                
                for(Account acc:[select id,Active__c from Account where id in: accountid])
                {
                    if(acc.Active__c !='Yes'){
                        acc.Active__c='Yes';
                        uow.registerDirty(acc);
                    }
                        
                    
                }
                for(contact con:[select id,Primary_Contact__c,Active__c from Contact where id in:contactid])
                {
                    if(con.Primary_Contact__c !=true)
                    {
                        con.Primary_Contact__c=true;
                        con.Active__c=true;
                        uow.registerDirty(con);
                    }
                    
                }
            }

            }
        
        try{
            uow.commitWork();
            
        }catch(exception e)
        {
            system.debug('Error:  '+ e.getmessage());
            
        }
            
        }
        
    }