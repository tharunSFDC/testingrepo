/**
 * Trigger: AccountDeletionPrevention
 * Description: Prevents deletion of Account records that have associated Contacts
 * Author: System Generated
 * Created Date: 2025-09-23
 */
trigger AccountDeletionPrevention on Account (before delete) {
    
    // Query for contacts associated with accounts being deleted
    List<Contact> relatedContacts = [
        SELECT AccountId
        FROM Contact 
        WHERE AccountId IN :Trigger.oldMap.keySet()
    ];
    
    // Create a set of account IDs that have contacts
    Set<Id> accountIdsWithContacts = new Set<Id>();
    for (Contact con : relatedContacts) {
        accountIdsWithContacts.add(con.AccountId);
    }
    
    // Prevent deletion of accounts that have contacts
    for (Account acc : Trigger.old) {
        if (accountIdsWithContacts.contains(acc.Id)) {
            acc.addError('Cannot delete Account "' + acc.Name + '" because it has associated Contacts. ' +
                        'Please delete or reassign all Contacts before deleting this Account.');
        }
    }
}
