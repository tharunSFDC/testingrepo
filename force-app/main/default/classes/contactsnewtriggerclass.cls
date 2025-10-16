public class contactsnewtriggerclass {
    public static date changedateofcontact;
    
    public static void ResourceChangeMethod(list<Contact> newlist, map<id,Contact> oldmap)
    {
        if(newlist !=null)
        {
            for(contact con:newlist)
            {
                Contact oldcontact=oldmap.get(con.id);
                
                if(con.AccountId !=oldcontact.AccountId || 
                   con.Email != oldcontact.Email || 
                   con.Phone != oldcontact.Phone || 
                   con.Department != oldcontact.Department)
                {
                    
                    if(con.LastModifiedDate.date() == system.Today())
                    {
                        changedateofcontact=con.LastModifiedDate.date();
                        updatecontactmethod(con,oldcontact,changedateofcontact);
                        
                    }
                    
                }
            }
        }
        
        
    }
    public static void updatecontactmethod(Contact contactid, Contact oldcontact, date changedateofcontact)
    {
        list<Resource_Change_Object__c> rcupsert= new list<Resource_Change_Object__c>();
        if(contactid !=null)
        {
            list<Resource_Change_Object__c> rclist=[select id,Contact__c,Change_Date__c,Account__c,New_Email__c,New_Phone__c,newDepartment__c,
                                                    Old_Account__c,Old_Department__c,Old_Email__c,Old_Phone__c,Name 
                                                    from Resource_Change_Object__c
                                                    where (Contact__c =:contactid.id and Change_Date__c =: changedateofcontact)];
            if(!rclist.isempty())
            {
                
                for(Resource_Change_Object__c rc:rclist)
                {
                    if(rc.Contact__c == contactid.Id && rc.Change_Date__c == changedateofcontact)
                    {
                        if(rc.Contact__c ==oldcontact.Id)
                        {
                            if(contactId.AccountId != oldcontact.AccountId)
                            {
                                rc.Account__c=contactid.AccountId;
                                rc.Old_Account__c=oldcontact.AccountId;
                                
                            }else if(contactid.Email != oldcontact.Email){
                                rc.New_Email__c=contactid.Email;
                                rc.Old_Email__c=oldcontact.Email;
                                
                            }else if(contactid.Phone != oldcontact.Phone)
                            {
                                rc.New_Phone__c=contactid.Phone;
                                rc.Old_Phone__c=oldcontact.Phone;
                                system.debug(rc.New_Phone__c);
                                system.debug(rc.Old_Phone__c);
                            }else if(contactid.Department != oldcontact.Department)
                            {
                                rc.newDepartment__c=contactid.Department;
                                rc.Old_Department__c=oldcontact.Department;
                                
                            }
                            
                        }
                        
                    }
                    rcupsert.add(rc);
                }
            }else{
                Resource_Change_Object__c rc= new Resource_Change_Object__c();
                datetime now = datetime.now();
                rc.Contact__c=contactid.id;
                rc.Account__c=contactid.AccountId;
                rc.Change_Date__c=changedateofcontact;
                rc.Name=now.format()+' ' +'Contact Resource Change';
                rc.New_Email__c=contactid.Email;
                rc.New_Phone__c=contactid.Phone;
                rc.newDepartment__c=contactid.Department;
                rc.Old_Account__c=oldcontact.AccountId;
                rc.Old_Department__c=oldcontact.Department;
                rc.Old_Email__c=oldcontact.Email;
                rc.Old_Phone__c=oldcontact.Phone;
                
                rcupsert.add(rc);
            }
            
        }
        
        if(rcupsert !=null)
        {
            Database.upsertResult[] result=Database.upsert(rcupsert,false);
        }
        
        
    }
    public static void contactmethod(List<Contact> conlist)
    {
        set<id> ids = new set<id>();
        for(Contact con:conlist)
        {
            ids.add(con.AccountId);
        }
        
        list<Account> acclist =[SELECT id,Name,Number_of_Contacts__c,
                                (SELECT id,FirstName,LastName From Contacts) 
                                from Account where id IN :ids];
        list<Account> accupdatelist = new list<Account>();
        for(Account ac:acclist)
        {
            ac.Number_of_Contacts__c=ac.contacts.size();
            accupdatelist.add(ac);
            
        }
        if(accupdatelist != null)
        {
            update accupdatelist;
        }
        
    }
    
}