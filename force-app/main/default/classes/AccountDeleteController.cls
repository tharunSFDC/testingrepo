public class  AccountDeleteController{
    @AuraEnabled(cacheable=true)
    public static List<Account> displayAccounts(){
        return [select Id,Name,Rating,Phone,Fax from Account];
    }
    @AuraEnabled
    public static List<Account> delAccRecords(List<String> selecRecords){
        List<Account> returnlist=new List<Account>();
        for(Account acc:[select Id,Name from Account where Id in:selecRecords]){
            returnlist.add(acc);

        }
        if(returnlist.size()>0){
            try{
                delete returnlist;
            }
            catch(Exception  e){
           throw new AuraHandledException(e.getMessage());
            }
        }
        return displayAccounts();
        
    }
    
}