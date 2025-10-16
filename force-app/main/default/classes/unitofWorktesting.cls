public class unitofWorktesting {
    
    public static void untiofworktesting(list<Account> newlist)
    {
        fflib_ISObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new list<schema.sObjecttype>{
                Contact.sObjectType,
                Opportunity.sObjectType,
                lead.sObjectType
            });
        
        
        for(integer index=0;index<10;index++)
        {
            Contact con = new Contact();
            con.AccountId=newlist[0].id;
            con.LastName='testing'+index;
            con.Email='Salesforce'+index+'@gmail.com';
            con.MailingCountry='US';
            con.MobilePhone='78998739'+index;
            
            uow.registerNew(con,Contact.AccountId,newlist[0]);
        }
        
        for(integer index=0; index <10 ; index++)
        {
            Opportunity opp= new Opportunity();
            opp.AccountId=newlist[0].id;
            opp.Name='testing'+index;
            opp.CloseDate=system.today();
            opp.StageName='Closed Won';
            
            uow.registerNew(opp,Opportunity.AccountId,newlist[0]);
            
        }
        
        try{
            uow.commitWork();
            
        } catch(exception e)
        {
            system.debug(e.getmessage());
        }
        
        
    }

}