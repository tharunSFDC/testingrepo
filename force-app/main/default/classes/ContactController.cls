public with sharing class ContactController {


    @AuraEnabled(cacheable=true)
    public static list<Contact> getContactList()
    {
        return [select Name,Email,Title from Contact limit 20];

    }

}