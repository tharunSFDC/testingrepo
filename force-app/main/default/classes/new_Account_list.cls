public with sharing class new_Account_list {

    @AuraEnabled(cacheable=true)
    public static list<Account> Accountrecords() {

        return [SELECT id, Name,Rating,Fax,Phone FROM Account LIMIT 25 ];

    }
    @AuraEnabled
    public static list<Account> delmulaccount(list<Account> acclist){

        list<Account> delaccount=new list<Account>();

        for(Account acc:[SELECT ID FROM Account where Id in:acclist])
        {
            delaccount.add(acc);

        }
        if(delaccount!=null)
        {
                delete delaccount;
            
        }

        return Accountrecords();

    }
}