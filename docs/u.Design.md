

## Theming and Skinning

Helpshift Android SDK comes with following themes -

- `Helpshift.Theme.Light.DarkActionBar` (default)
- `Helpshift.Theme.Light`
- `Helpshift.Theme.Dark`
- `Helpshift.Theme.HighContrast`
- `Helpshift.Theme.DayNight.DarkActionBar`
- `Helpshift.Theme.DayNight.Light`
- `Helpshift.Theme.DayNight.HighContrast`



To use one of these themes call the `setTheme` function passing the android resource name:

```as3
Helpshift.service.setTheme( "Helpshift.Theme.Dark" );
```


This will work with custom themes that you may choose to create. 

>
> *Creating and packaging custom themes are outside the scope of this documentation.*
>
> See the Helpshift documentation on skinning: https://developers.helpshift.com/android/design/#skinning
>
> You will need to create these resources and then package in a custom resources extension and pass the resource id to the `setTheme()` function.
>



