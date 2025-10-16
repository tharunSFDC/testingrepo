@istest
public class accounttriggerclassTest {
    
    static testmethod void accounttestmethod()
    {
        Test.starttest();
        accountsnew();
        Test.stoptest();

        
    }
    public static void accountsnew()
    {
        list<Account> acclist= new list<Account>();
        
        for(integer i=0; i<10; i++)
        {
            Account ac= new Account();
            ac.Name='test'+i;
            ac.Create_a_contact__c=True;
            ac.Rating='Hot';
            ac.Industry='Banking';
            acclist.add(ac);
        }
        
        if(!acclist.isempty())
        {
            insert acclist;
        }
    }

}