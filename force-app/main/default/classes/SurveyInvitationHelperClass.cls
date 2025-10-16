public class SurveyInvitationHelperClass {
    
    public static void surveyinvitataionmethod(list<SurveyInvitation> newlist, map<id,SurveyInvitation> oldmap)
    {
        
        set<id> sviids = new set<id>();
        if(!newlist.isempty())
        {
            list<SurveySubject> subject =[select 
                                          id,
                                          SubjectId,
                                          SubjectEntityType,
                                          SurveyId,
                                          ParentId 
                                          from 
                                          SurveySubject 
                                          where ParentId =:newlist[0].id order by createddate DESC limit 1];
            system.debug(subject);
            
            for(SurveyInvitation svi:newlist)
            {
                if(svi.ResponseStatus =='Completed')
                {
                    sviids.add(svi.id);
                    
                }
            }
            
            if(!sviids.isempty())
            {
                list<SurveyResponse> responselist=[select id,InvitationId from SurveyResponse where InvitationId in :sviids];
                system.debug(responselist);
                
                if(!responselist.isempty())
                {
                    list<SurveyQuestionResponse> SurveyQuestionResponselist=[select id,
                                                                             InvitationId,
                                                                             ResponseId,
                                                                             ResponseValue
                                                                             from SurveyQuestionResponse
                                                                             where ResponseId =:responselist[0].id and InvitationId in :sviids];
                    system.debug(SurveyQuestionResponselist);
                    
                    if(!SurveyQuestionResponselist.isempty())
                    {
                        list<SurveyQuestion> quetions =[select id,QuestionName from SurveyQuestion];
                        system.debug(quetions);
                    }

                }
                
            }
            
        }
    }

}