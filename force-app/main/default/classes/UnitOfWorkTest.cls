@istest
public class UnitOfWorkTest {
    
    @istest
    public static void challengeComplete()
    {
        fflib_SObjectUnitOfWork wow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[]{
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
            }
        );
        
        for(integer i=0; i<100; i++)
        {
            Account acc=new Account(name='test'+i);
            wow.registerNew(acc);
            
            for(integer j=0; j<5; j++)
            {
                Contact con= new Contact(lastName='lastname'+i+'-'+j);
                wow.registerNew(con, contact.AccountId, acc);
                
                Note n=new note(Title='testnote' + i +'-'+j,Body='test note body');
                wow.registerNew(n,note.parentId,acc);
            }
        }
        
        wow.commitWork();
        
        system.assertEquals(100,[select id from Account].size());
         system.assertEquals(500,[select id from Contact].size());
         system.assertEquals(500,[select id from Note].size());
        
    }

}