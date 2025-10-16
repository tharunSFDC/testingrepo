@RestResource(urlMapping='/case/*/close')
global class CaseCloseResource {
    
    @httppost
    global static void closecase(string closecase)
    {
        CaseService.closeCases(new set<id> { RestContext.request.requestURI.split('/')[2] }, closecase);
    }

}