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
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		08/01/2016
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.helpshift
{
	import com.distriqt.extension.helpshift.Helpshift;
	import com.distriqt.extension.helpshift.HelpshiftInstallConfig;
	import com.distriqt.extension.helpshift.HelpshiftUser;
	import com.distriqt.extension.helpshift.campaigns.InboxMessage;
	import com.distriqt.extension.helpshift.support.ApiConfig;
	import com.distriqt.extension.helpshift.support.FaqTagFilter;
	import com.distriqt.extension.helpshift.support.Metadata;
	import com.distriqt.extension.helpshift.support.flows.ConversationFlow;
	import com.distriqt.extension.helpshift.support.flows.FAQSectionFlow;
	import com.distriqt.extension.helpshift.support.flows.FAQsFlow;
	import com.distriqt.extension.helpshift.support.flows.SingleFAQFlow;
	
	import flash.display.Bitmap;
	import flash.events.ErrorEvent;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**	
	 */
	public class HelpshiftTests extends Sprite
	{
		public static const TAG : String = "";
		
		private var _l : ILogger;
		
		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}
		
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public function HelpshiftTests( logger:ILogger )
		{
			_l = logger;
			try
			{
				log( "Helpshift Supported: " + Helpshift.isSupported );
				if (Helpshift.isSupported)
				{
					log( "Helpshift Version:   " + Helpshift.service.version );
					
					Helpshift.service.addEventListener( ErrorEvent.ERROR, errorHandler );
				}
				
			}
			catch (e:Error)
			{
				trace( e );
			}
		}
		
		// Generic error handler
		private function errorHandler( event:ErrorEvent ):void
		{
			log( "ERROR: " + event.text );
		}
		
		
		
		////////////////////////////////////////////////////////
		//  
		//
		
		public function install():void
		{
			var config:HelpshiftInstallConfig = new HelpshiftInstallConfig()
					.setEnableLogging( true );
			
			var success:Boolean =
						Helpshift.service.install(
							Config.API_KEY,
							Config.DOMAIN,
							Config.APP_ID,
							config );
		
			log( "install(): " + success );
		
		}
		
		
		public function setTheme():void
		{
			Helpshift.service.setTheme( "Helpshift.Theme.Dark" );
		}
		
		public function login():void
		{
			log( "login()" );
			Helpshift.instance.login(
					new HelpshiftUser( "my_identifier", "distriqt@distriqt.com ")
							.setName("Michael")
			);
		}
		
		
		public function logout():void
		{
			log( "logout()" );
			Helpshift.instance.logout();
		}
		
		
		
		
		//
		//	SUPPORT
		//
		
		
		public function isConversationActive():void
		{
			log( "isConversationActive() = " + Helpshift.instance.support.isConversationActive() );
		}
		
		
		
		public function showConversations():void
		{
			log( "showConversations()" );
			
			var metadata:Metadata = new Metadata()
					.addMetadata("usertype", "paid")
					.addMetadata("score", "12345")
					.addMetadata("source", "distriqt-ane")
					.addTag("feedback")
					.addTag("paid user")
			;
			
			var config:ApiConfig = new ApiConfig()
					.setCustomMetadata( metadata )
					.setConversationPrefillText("This isn't working!");
			
			Helpshift.instance.support.showConversation( config );
		}
		
		
		
		public function showFAQs():void
		{
			log( "showFAQs()" );
			
			var config:ApiConfig = new ApiConfig()
					.setWithTagsMatching( new FaqTagFilter( [FaqTagFilter.OPERATOR_OR ], ["test"] ) );
			
			Helpshift.instance.support.showFAQs( config );
		}
		
		
		public function showFAQSection():void
		{
			log( "showFAQSection()" );
			
			Helpshift.instance.support.showFAQSection( "12" );
		}

		
		public function showSingleFAQ():void
		{
			log( "showSingleFAQ()" );
			Helpshift.instance.support.showSingleFAQ( "4" );
		}
		
		
		
		public function customContactUsFlows():void
		{
			log( "customContactUsFlows()" );
			
			var faqSectionFlow:FAQSectionFlow = new FAQSectionFlow( "FAQ Section", "12", new ApiConfig() );
			var singleFAQFlow:SingleFAQFlow = new SingleFAQFlow( "Single FAQ", "4", new ApiConfig() );
			var showConversationFlow:ConversationFlow = new ConversationFlow( "Contact Us about our app", new ApiConfig() );
			var faqsFlow:FAQsFlow = new FAQsFlow( "FAQs", new ApiConfig() );
			
			var customContactUsFlows:Array = [
					faqSectionFlow,
					singleFAQFlow,
					showConversationFlow
			];
			
			var config:ApiConfig = new ApiConfig()
					.setCustomContactUsFlows( customContactUsFlows );
			
			Helpshift.instance.support.showFAQs( config );
		}
		
		
		
		
		
		//
		//	CAMPAIGNS
		//
		
		
		public function showInbox():void
		{
			log( "showInbox()" );
			Helpshift.instance.campaigns.showInbox();
		}
		
		
		public function addProperties():void
		{
			log( "addProperties()" );
			
			Helpshift.instance.campaigns.addBooleanProperty( "is-pro", false );
			Helpshift.instance.campaigns.addStringProperty( "user-type", "paid" );
			Helpshift.instance.campaigns.addIntProperty( "user-level", 7 );
			
		}
	
		
		public function getCountOfUnreadMessages():void
		{
			log( "getCountOfUnreadMessages() = " + Helpshift.instance.campaigns.getCountOfUnreadMessages() );
		}
		
		
		public function getAllInboxMessages():void
		{
			log( "getAllInboxMessages()" );
			var messages:Array = Helpshift.instance.inbox.getAllInboxMessages();
			for each (var message:InboxMessage in messages)
			{
				log( "message: " + message.identifier + "["+message.actions.length +"]" );
			}
		}
		
		
		
	}
}
