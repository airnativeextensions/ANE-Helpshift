/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * @brief  		
 * @author 		marchbold
 * @created		8/5/20
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.helpshift
{
	import com.distriqt.extension.helpshift.Helpshift;
	import com.distriqt.extension.pushnotifications.AuthorisationStatus;
	import com.distriqt.extension.pushnotifications.PushNotifications;
	import com.distriqt.extension.pushnotifications.PushNotifications;
	import com.distriqt.extension.pushnotifications.Service;
	import com.distriqt.extension.pushnotifications.builders.ChannelBuilder;
	import com.distriqt.extension.pushnotifications.events.AuthorisationEvent;
	import com.distriqt.extension.pushnotifications.events.PushNotificationEvent;
	import com.distriqt.extension.pushnotifications.events.RegistrationEvent;
	
	
	public class PushNotificationsTests
	{
		////////////////////////////////////////////////////////
		//  CONSTANTS
		//
		
		private static const TAG:String = "PushNotificationsTests";
		
		
		////////////////////////////////////////////////////////
		//  VARIABLES
		//
		
		private var _l:ILogger;
		
		
		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}
		
		
		////////////////////////////////////////////////////////
		//  FUNCTIONALITY
		//
		
		public function PushNotificationsTests( logger:ILogger )
		{
			_l = logger;
			
		}
		
		
		public function setup():void
		{
			log( "setup()" );
			try
			{
				log( "PushNotifications Supported: " + PushNotifications.isSupported );
				if (PushNotifications.isSupported)
				{
					log( "PushNotifications Version:   " + PushNotifications.service.version );
					
					
					PushNotifications.service.addEventListener( AuthorisationEvent.CHANGED, pn_authorisationChangedHandler );
					
					PushNotifications.service.addEventListener( RegistrationEvent.REGISTER_SUCCESS, pn_registrationEventHandler );
					PushNotifications.service.addEventListener( RegistrationEvent.CHANGED, pn_registrationEventHandler );
					
					PushNotifications.service.addEventListener( PushNotificationEvent.NOTIFICATION, pn_notificationHandler );
					
					var service:Service = new Service( Service.FCM )
							.setNotificationsWhenActive( true );
					
					service.channels.push(
							new ChannelBuilder()
									.setId( "helpshift_channel" )
									.setName( "Helpshift Channel" )
									.build()
					);
					
					
					PushNotifications.service.setup( service );
					
					checkAuthAndRegister();
				}
			}
			catch (e:Error)
			{
				trace( e );
			}
		}
		
		
		private function checkAuthAndRegister():void
		{
			switch (PushNotifications.service.authorisationStatus())
			{
				case AuthorisationStatus.AUTHORISED:
				{
					PushNotifications.service.register();
					break;
				}
				
				case AuthorisationStatus.NOT_DETERMINED:
				{
					PushNotifications.service.requestAuthorisation();
					break;
				}
				
				case AuthorisationStatus.DENIED:
				case AuthorisationStatus.UNKNOWN:
				{
					//
					log( "AUTHORISATION DENIED" );
				}
			}
		}
		
		
		private function pn_authorisationChangedHandler( event:AuthorisationEvent ):void
		{
			log( event.type + "::" + event.status );
			checkAuthAndRegister();
		}
		
		
		private function pn_registrationEventHandler( event:RegistrationEvent ):void
		{
			log( event.type + " :: " + event.data );
			
			Helpshift.instance.registerDeviceToken( event.data );
		}
		
		
		private function pn_notificationHandler( event:PushNotificationEvent ):void
		{
			log( event.type + " :: " + event.payload );
			
			Helpshift.instance.handlePush( event.payload );
		}
		
	}
	
}
