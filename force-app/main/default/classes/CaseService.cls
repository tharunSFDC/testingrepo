public with Sharing class CaseService {
    
    public static void closeCases(set<id> caseids, string closereason)
    {
        list<Case> casttoclose=[select id,Reason,Status from Case where id in:caseids];
        
        for(Case cas:casttoclose)
        {
            cas.reason=closereason;
            cas.status='Closed';
        }
        update casttoclose;
    }

}