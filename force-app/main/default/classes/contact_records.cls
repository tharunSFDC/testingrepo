public with sharing class contact_records {
    @AuraEnabled(cacheable=true)
    public static list<Contact> newcontactsemails()
    {
        return [select id,FirstName,LastName,Phone,Email from Contact LIMIT 25];
    }

    
}