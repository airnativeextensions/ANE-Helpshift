

The extension SDK follows closely the Helpshift Android SDK, so most of the documentation that applies to the Android SDK will be relevant here. So you can use that as a more detailed reference. This documentation will outline the AS3 implementation. 


## Initialise Helpshift in your App


Helpshift uniquely identifies each registered App with a combination of 3 tokens:

- **API Key**: Your unique developer API key
- **Domain Name**: Your Helpshift domain name without any http: or slashes. E.g. happyapps if your account is happyapps.helpshift.com 
- **App ID**: Your App's unique ID

You can find these by navigating to Settings>SDK (for Developers) in your agent dashboard. Select your App and the correct platform from the dropdowns and copy the 3 tokens to be passed when initializing Helpshift.


Initialize Helpshift by calling the `install` method by doing the following:


```as3
var success:Boolean = 
    Helpshift.service.install(
        API_KEY,
        DOMAIN,
        APP_ID );
```


>
> You should call this early in your application after AIR is initialised and before attempting to call any other functionality of the Helpshift SDK.
>


You can pass options to the `install` function as the `config` parameter. This should be an instance of the `HelpshiftInstallConfig` class:


```as3
var config:HelpshiftInstallConfig = new HelpshiftInstallConfig()
        .setEnableLogging( true );

Helpshift.service.install(
        API_KEY,
        DOMAIN,
        APP_ID,
        config );
```


See the documentation on the `HelpshiftInstallConfig` class for details on the available configuration parameters.

