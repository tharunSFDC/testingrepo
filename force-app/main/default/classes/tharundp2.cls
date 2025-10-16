public class tharundp2 {
    
    public static void unitofworktestingmethod()
    {
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new schema.sObjectType[]{
                product2.SObjectType,
                    PricebookEntry.SobjectType,
                    Opportunity.SobjectType,
                    Opportunitylineitem.sObjectType
                    });
        
        for(integer o=0; o<10; o++)
        {
            Opportunity oppo = new Opportunity();
            oppo.Name='Testing'+o;
            oppo.CloseDate=system.Today()+30;
            oppo.StageName='Closed Won';
            uow.registerNew(oppo);
            
            for(integer i=0; i<o+1; i++)
            {
                product2 pd = new product2();
                pd.Name=oppo.Name+' : Product '+''+i;
                uow.registerNew(pd);
                
                PricebookEntry bk = new PricebookEntry();
                bk.UnitPrice=100;
                bk.IsActive=true;
                bk.UseStandardPrice=true;
                
                bk.Pricebook2Id='01sGA00000Yed1kYAB';
                uow.registerNew(bk,PriceBookEntry.Product2Id,pd);
                
                OpportunityLineItem li = new OpportunityLineItem();
                li.Quantity=5;
                li.TotalPrice=100;
                uow.registerRelationship(li,OpportunityLineItem.PricebookEntryId,bk);
                uow.registerNew(li,OpportunityLineItem.OpportunityId,oppo);
               
            }
        }
        
        try{
            uow.commitWork();
            
        }catch(exception e)
        {
            system.debug(e.getmessage());
        }
    }
    
}