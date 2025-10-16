public with sharing class DataTableUsingFieldSets {

    // Method to create a data table useing fields in field sets
    @AuraEnabled(cacheable=true)
    public static string getFieldLabelandFieldAPi()
    {
        list<map<string,string>> fieldslableandapinames = new list<map<string,string>>();
        

        for(Schema.FieldSetMember fieldset: SObjectType.contact.fieldsets.contact_details.getfields())
        {
            map<string,string> labelApiName = new map<string,string>();
            labelApiName.put(fieldset.getLabel(), fieldset.getFieldPath());
            fieldslableandapinames.add(labelApiName);
            

        }

        return JSON.serialize(fieldslableandapinames);
    }

    // Method to collect Contact Records using field sets
    @AuraEnabled(cacheable=true)
    public static list<Contact> contactMethod()
    {
        try {
            string querystring='Select id';
            for(Schema.FieldSetMember fieldset:SObjectType.Contact.fieldsets.contact_details.getfields())
            {
                querystring += ',' + fieldset.getFieldPath();
            }
            querystring +=' from Contact order by createddate ASC limit 6';

            return Database.Query(querystring);
        } catch (Exception e) {
            throw new AuraHandledException('These is error'+e.getmessage());
            
        }
    }
}