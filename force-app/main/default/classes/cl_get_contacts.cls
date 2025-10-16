public with sharing class cl_get_contacts {

    @AuraEnabled(cacheable=true)
    public static list<Contact> newcontactlist() {

        return [SELECT ID, FirstName,LastName,Phone,Email FROM Contact Where Email !=null LIMIT 25];

    }
}