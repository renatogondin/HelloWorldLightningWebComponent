@RestResource(urlMapping='/Account/*')
global with sharing class ApexQueryAccountDetailsRestController {

    @HttpGet
    global static String doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        List<ContactFeeService.MetaContactDetailsObject> result = ContactFeeService.getContactCostsByAccount(accountId);
        return JSON.serialize(result);
    }

}