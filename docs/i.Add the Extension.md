
## Add the Extension

First step is always to add the extension to your development environment. 
To do this use the tutorial located [here](https://airnativeextensions.github.io/tutorials/getting-started).


### AIR SDK


This ANE currently requires at least AIR 33+. This is required in order to support versions of Android > 9.0 (API 28). We always recommend using the most recent build with AIR especially for mobile development where the OS changes rapidly.



## Dependencies

Many of our extensions use some common libraries, for example, the Android Support libraries.

We have to separate these libraries into separate extensions in order to avoid multiple versions of the libraries being included in your application and causing packaging conflicts. This means that you need to include some additional extensions in your application along with the main extension file.

You will add these extensions as you do with any other extension, and you need to ensure it is packaged with your application.


### Core 

The Core extension is required by this extension. You must include this extension in your application.

The Core extension doesn't provide any functionality in itself but provides support libraries and frameworks used by our extensions.
It also includes some centralised code for some common actions that can cause issues if they are implemented in each individual extension.

You can access this extension here: [https://github.com/distriqt/ANE-Core](https://github.com/distriqt/ANE-Core).


### Android Support

The Android Support libraries encompass the Android Support, Android X and common Google libraries. 

These libraries are specific to Android. There are no issues including these on all platforms, they are just **required** for Android.

This extension requires the following extensions:

- [androidx.appcompat](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/androidx.appcompat.ane)
- [androidx.cardview](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/androidx.cardview.ane)
- [androidx.core](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/androidx.core.ane)
- [androidx.vectordrawable](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/androidx.vectordrawable.ane)
- [androidx.recyclerview](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/androidx.recyclerview.ane)
- [com.google.android.material](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/com.google.android.material.ane)

You can access these extensions here: [https://github.com/distriqt/ANE-AndroidSupport](https://github.com/distriqt/ANE-AndroidSupport).


>
> **Note**: if you have been using the older `com.distriqt.androidsupport.*` (Android Support) extensions you should remove these extensions and replace it with the `androidx` extensions listed above. This is the new version of the android support libraries and moving forward all our extensions will require AndroidX.
>




## Extension IDs

The following should be added to your `extensions` node in your application descriptor to identify all the required ANEs in your application:

```xml
<extensions>
	<extensionID>com.distriqt.Helpshift</extensionID>

	<extensionID>com.distriqt.Core</extensionID>

	<extensionID>androidx.appcompat</extensionID>
	<extensionID>androidx.cardview</extensionID>
	<extensionID>androidx.core</extensionID>
	<extensionID>androidx.vectordrawable</extensionID>
	<extensionID>androidx.recyclerview</extensionID>
	<extensionID>com.google.android.material</extensionID>
</extensions>
```




## Android 

### Manifest Additions

You should add the following manifest additions. Read the individual sections for details on which parts are needed for the functionality you require or you can just add them all.

**Make sure you only have one `<application>` node in your manifest additions combining them if you have multiple.**

The following shows the complete manifest additions node. You must replace `APPLICATION_PACKAGE` with your 
AIR application's Java package name, something like `air.com.distriqt.test`.
Generally this is your AIR application id prefixed by `air.` unless you have specified no air flair in your build options.



```xml
<manifest android:installLocation="auto">
	<uses-sdk android:minSdkVersion="14" android:targetSdkVersion="28" />

	<uses-permission android:name="android.permission.INTERNET"/>
	<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
	<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

	<application
		android:appComponentFactory="androidx.core.app.CoreComponentFactory"
		android:hardwareAccelerated="true"
		>

		<provider
			android:name="com.helpshift.support.providers.HelpshiftFileProvider"
			android:authorities="APPLICATION_PACKAGE.helpshift.fileprovider"
			android:exported="false"
			android:grantUriPermissions="true" >
			<meta-data
				android:name="android.support.FILE_PROVIDER_PATHS"
				android:resource="@xml/hs__provider_paths" />
		</provider>

		<activity
			android:name="com.helpshift.support.activities.ParentActivity"
			android:hardwareAccelerated="true"
			android:launchMode="singleTop"
			android:theme="@style/Helpshift.Theme.Activity" />
		<activity
			android:name="com.helpshift.support.HSReview"
			android:configChanges="orientation|screenSize"
			android:theme="@style/Helpshift.Theme.Dialog" />
		<activity
			android:name="com.helpshift.campaigns.activities.ParentActivity"
			android:theme="@style/Helpshift.Theme.Activity" >
		</activity>
		<activity
			android:name="com.helpshift.campaigns.activities.NotificationActivity"
			android:configChanges="orientation|screenSize|locale|layoutDirection"
			android:excludeFromRecents="true"
			android:launchMode="singleTask"
			android:noHistory="true"
			android:taskAffinity=""
			android:theme="@android:style/Theme.Translucent.NoTitleBar" />

		<service
			android:name="com.helpshift.campaigns.services.NotificationService"
			android:exported="false" />

	</application>

</manifest>
```


### MultiDex Applications 

If you have a large application and are supporting Android 4.x then you will need to ensure you enable your application to correctly support MultiDex to allow the application to be broken up into smaller dex packages.

This is enabled by default with releases of AIR v25+, except in the Android 4.x case where you need to change the manifest additions for the application tag to match the following and use the `MultiDexApplication`.


#### Using AndroidX

This will require the addition of the `androidx.multidex` extension which contains the `androidx.multidex.MultiDexApplication` implementation.

```xml
<manifest android:installLocation="auto">
	<!-- PERMISSIONS -->

	<application android:name="androidx.multidex.MultiDexApplication">

		<!-- ACTIVITIES / RECEIVERS / SERVICES -->

	</application>
</manifest>
```






## Checking for Support

You can use the `isSupported` flag to determine if this extension is supported on the current platform and device.

This allows you to react to whether the functionality is available on the device and provide an alternative solution if not.


```as3
if (Helpshift.isSupported)
{
	// Functionality here
}
```

