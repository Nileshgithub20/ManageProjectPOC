public class FlowController {
   
    @InvocableMethod( label='Create Account' description='Create Account using Title' category='Callout' )
    public static void getTitle( List < Account > inputs ) {
       
        system.debug( 'Inputs is ' + inputs );
        Account acc = inputs.get(0);
        RequestWrapper newReq = new RequestWrapper();
        newReq.Name = acc.name;
        newReq.Phone = acc.Phone;
        newReq.Fax = acc.Fax;
        newReq.AccountNumber = acc.AccountNumber;
        newReq.Website = acc.Website;
        newReq.Industry = acc.Industry;
        
        createAccount(JSON.serialize(newReq));
       
    }
   
    @future( callout=true )
    public static void createAccount( String strInput ) {
        System.debug('strInput '+strInput);
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setEndPoint( 'https://centelonsolutions5-dev-ed.my.salesforce-sites.com/services/apexrest/createAccountOrg1/*');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody(strInput);  
        HTTPResponse res = h.send(req); 
        System.debug('Response status is'+res.getStatusCode());
        if(res.getstatusCode() == 200 && res.getbody() != null){
            System.debug('Success');
        }else{
            System.debug(res);
        }
       
    }
    
    public class RequestWrapper{
        public String Name{get;set;}
        public String Phone{get;set;}
        public String Fax{get;set;}
        public String AccountNumber{get;set;}
        public String Website{get;set;}
        public String Industry{get;set;}
    }
   
}