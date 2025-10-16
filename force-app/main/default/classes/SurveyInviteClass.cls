public class SurveyInviteClass {
    
    public static list<SurveyInvitation> updatesurveysinvite = new list<SurveyInvitation>();
    public static id onboardingprojectid;
    public static id surveyivitationid;
    
    @InvocableMethod(label='Pass the survey id to update lastest survey invation records')
    public static void updateSurveyInvitation(list<projectwrapper> projectwrapperlist)
    {
        onboardingprojectid =projectwrapperlist.get(0).projectid;
        surveyivitationid=projectwrapperlist.get(0).surveyid;
        system.debug('project id'+' '+ onboardingprojectid);
        system.debug('Survey id'+'  '+surveyivitationid);

        UpdateSurveyinviationsrecords(surveyivitationid,onboardingprojectid);
        
    }
    @future(callout=false)
    public static void UpdateSurveyinviationsrecords(id surveuinviteids,id onboardingprojectid)
    {
        
        list<SurveyInvitation> SurveyInvitationlist=[select 
                                                     id,
                                                     Name,
                                                     Account__c,
                                                     Opportunity__c,
                                                     Onboarding_Project__c 
                                                     from 
                                                     SurveyInvitation 
                                                     where 
                                                     SurveyId =: surveuinviteids 
                                                     ORDER BY CreatedDate DESC LIMIT 1];
        if(!SurveyInvitationlist.isempty())
        {
            
            list<Onboarding_Project__c> onboardingporjects=[select 
                                                            id,
                                                            Account__c,
                                                            Source_Opportunity__c
                                                            from 
                                                            Onboarding_Project__c
                                                            where id =:onboardingprojectid];
            
            for(SurveyInvitation sv:SurveyInvitationlist)
            {
                sv.Account__c=onboardingporjects[0].Account__c;
                sv.Onboarding_Project__c=onboardingporjects[0].id;
                sv.Opportunity__c=onboardingporjects[0].Source_Opportunity__c;
                updatesurveysinvite.add(sv);
                
            }
            
            
        }
        
        
        if(!updatesurveysinvite.isempty())
        {
            Database.SaveResult[] results=Database.update(updatesurveysinvite,false);
            system.debug(results);
        }
        
    }
    
    public class projectwrapper{
        @InvocableVariable(required=true)
        public id projectid;
        @InvocableVariable(required=true)
        public id surveyid;
    }
    
}