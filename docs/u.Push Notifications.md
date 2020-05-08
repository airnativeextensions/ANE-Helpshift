
## Push Notifications

Helpshift allows you to send Push notifications when an agent replies to a conversation.


### Step 1: Prerequisites 

Implement FCM push in your app. To do this, implement the [PushNotifications ANE](https://airnativeextensions.com/extension/com.distriqt.PushNotifications) for FCM.





### Step 2: Configure Helpshift Agent Dashboard

To enable the Helpshift system to send push notifications to your users you will have to add your FCM Server API Key via the helpshift admin interface.

https://developers.helpshift.com/android/notifications/#configure-helpshift-push-admin



### Step 3: Configure Helpshift Android SDK



1. Send the device registration id to Helpshift via the `registerDeviceToken()` function:


```as3
Helpshift.instance.registerDeviceToken( registrationId );
```

This should be done on the `RegistrationEvent.REGISTER_SUCCESS` event handler:

```as3
PushNotifications.service.addEventListener( RegistrationEvent.REGISTER_SUCCESS, registrationEventHandler );

function registrationEventHandler( event:RegistrationEvent ):void
{
    Helpshift.instance.registerDeviceToken( event.data );
}
```



2. When you receive a message you must pass it to Helpshift using the `handlePush()` function:


```as3
Helpshift.instance.handlePush( payload );
```


This should be done when you receive the notification payload in the `PushNotificationEvent.NOTIFICATION` event handler:


```as3
PushNotifications.service.addEventListener( PushNotificationEvent.NOTIFICATION, notificationHandler );
					
function notificationHandler( event:PushNotificationEvent ):void
{
    Helpshift.instance.handlePush( event.payload );
}
```





### Customizing notification icons

By default the application icon is used as the notification icon. You can customize the notification icons using the config in the install call.


```as3
var config:HelpshiftInstallConfig = new HelpshiftInstallConfig()
        .setNotificationIcon( "ic_stat_distriqt" );

Helpshift.service.install(
        API_KEY,
        DOMAIN,
        APP_ID,
        config );
```


### Customizing notification channels

Starting from Android Oreo, Helpshift notifications will create a default channel named In-app Support. If you want to customize the name and description for the default channel, you can do so by using the following resources in your strings.xml file:

```xml
<string name="hs__default_notification_channel_name">Example Support Name</string>
<string name="hs__default_notification_channel_desc">Example Support Description</string>
```

If you want to customize the notification channels, you can create your own custom channels and provide their channel IDs using the following config APIs:

```as3
var config:HelpshiftInstallConfig = new HelpshiftInstallConfig()
        .setSupportNotificationChannelId( "support_helpshift_channel" )
        .setCampaignsNotificationChannelId( "campaigns_helpshift_channel" );

Helpshift.service.install(
        API_KEY,
        DOMAIN,
        APP_ID,
        config );
```



### Configuring in-app notifications


If you do not want the in-app notification support provided by the Helpshift SDK, you can set the flag to false. The default value of this flag is true i.e., in app notification will be enabled.


```as3
var config:HelpshiftInstallConfig = new HelpshiftInstallConfig()
        .setEnableInAppNotification( true );

Helpshift.service.install(
        API_KEY,
        DOMAIN,
        APP_ID,
        config );
```

