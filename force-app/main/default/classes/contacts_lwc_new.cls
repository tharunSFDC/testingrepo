public with sharing class contacts_lwc_new {
    @AuraEnabled(cacheable=true)
    public static list<Contact> newcontacts(string searchtext){

        string newstring= '%'+searchtext+'%';

        return [SELECT id, FirstName,LastName,Phone,Email FROM Contact where FirstName like:newstring];

    }

}