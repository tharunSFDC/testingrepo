public class NotifyAccountOwner implements queueable {
    private set<id> accountids;

    public NotifyAccountOwner(set<id> accountids){
        this.accountids=accountids;
    }

    public void execute(QueueableContext qc)
    {
        if(!accountids.isempty()){

            list<Account> acclist=[select id,ownerId from Account where id in : accountids];
            list<feedItem> posts = new list<feedItem>();

            for(Account acc: acclist)
            {
                FeedItem fd = new FeedItem();
                fd.ParentId=acc.id;
                fd.body='A high-value Opportunity forecast has been created n/'+
                'This is a huge win for the team—let’s collaborate to close this deal!';
                fd.Type='TextPost';
                posts.add(fd);
            }

            if(!posts.isempty())
            {
                Database.SaveResult[] results = Database.insert(posts,false);
                system.debug(results);
            }

        }

    }
}