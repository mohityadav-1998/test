/**
 * An apex page controller that takes the user to the right start page based on credentials or lack thereof
 */
public with sharing class CommunitiesLandingController {
    
    // Code we will invoke on page load.
    public PageReference forwardToStartPage() {
        System.debug('UserInfo.getUserType()'+UserInfo.getUserType());
            PageReference loginPage = new PageReference(Site.getBaseSecureUrl() + '/SiteLogin' );
            loginPage.setRedirect(true);
            return loginPage;
    }
    
    public CommunitiesLandingController() {}
}