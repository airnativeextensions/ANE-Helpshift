

## Logging in users

A logged-in user is someone who can contact your support team only after providing a username and password. If you have logged-in users, we highly recommend passing the user's identifiers (user ID and/or email) using the login API so that your Agents can provide a personalized support experience to your users, no matter which device your end user is using. Using the Login API also ensures that a user's conversations are available to them only when they log in.

### What to provide as identifiers

You can provide either `userID` and/or `userEmail` to identify your users. We highly recommend using a user ID to identify your users. However, if you use emails to identify your users, then you should pass them in the `userEmail` field. The following logic applies when you use both userID as well as userEmail:

- When looking up users, the priority of userId is higher than that of userEmail
- When the user ID matches an exisiting user, that user's email will be updated (if the email is provided)
- When the email matches an existing user, the following logic applies:
    - If the user ID does not exist for a user matched by email, then the user ID will be added for that user (if a user ID is provided)
    - If the user ID already exists on the user matched by email, then a new user will be created (if a different user ID is provided)


### How to use

You should call Helpshift SDK's Login API whenever the user successfully logs into your app. 


```as3
var user:HelpshitUser = new HelpshiftUser( "my_identifier", "distriqt@distriqt.com ")
							.setName("Michael");

Helpshift.instance.login( user );				
```




## Logging out users


Once a user logs out from your app, you should call the Helpshift SDK logout API to ensure no one else can view this user's conversations. Note: The logout API is expected to be used in conjunction with the login API.

### How to use


```as3
Helpshift.instance.logout();
```



## Anonymous users

An anonymous user is someone who can access the app without a username and password. If a user identifier (user ID and/or email) is not passed via the login API, then Helpshift assumes that the user is an anonymous user and is not currently logged in.

If your use case involves multiple logged-in/anonymous users using the same device and discussing info during support conversations (which you ideally wouldn't want to be shared across logins), you should use the clearAnonymousUser functionality. When this API is used, anonymous users are cleared whenever any user logs in. Once cleared, such users (and their conversations) cannot be fetched again for the end users.


```as3
Helpshift.instance.clearAnonymousUser();
```










