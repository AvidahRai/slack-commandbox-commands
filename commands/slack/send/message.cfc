/**
 * Sends a message to a slack webhook
 *
 **/
component {

	property name="SlackCommandUtils" inject="SlackCommandUtils@slack-commandbox-commands";

	/**
	 * @message.hint          The message you wish to send. Check the Slack docs for formatting tips.
	 * @channel.hint          Optional channel to send the message to (if different from configured channel of webhook)
	 * @username.hint         Optional username to send the message with (if different from configured username of webhook)
	 * @title.hint            Optional title of the slack message
	 * @titleLink.hint        Optional link for the slack message title
	 * @color.hint            Highlight color for the message. Can be a hex value, or one of 'good', 'warning' or 'danger'
	 * @pretext.hint          Pretext that will appear before the message attachment
	 * @thumbnail.hint        Thumbnail (URL) that will appear to the right of the slack message.
	 * @author.hint           Author name to use with the message
	 * @authorLink.hint       Hyperlink for the author
	 * @authorIcon.hint       Icon (URL) for the author
	 * @footer.hint           Footer text to appear at the bottom of the slack message
	 * @footerIcon.hint       Icon to accompany the message footer
	 * @includeTimestamp.hint Whether or not to include a timestamp
	 * @timestamp.hint        Timestamp (epoch time) of the message. Only used when includeTimestamp is true + defaults to the current time.
	 * @webhook.hint          Webhook to send message too. If not supplied, the global default webhook registered with 'slack set webhook' will be used.
	 **/
	function run(
		  required string  message
		,          string  color            = slackCommandUtils.getDefaultSetting( "color"      )
		,          string  channel          = slackCommandUtils.getDefaultSetting( "channel"    )
		,          string  username         = slackCommandUtils.getDefaultSetting( "username"   )
		,          string  emoji            = slackCommandUtils.getDefaultSetting( "emoji"      )
		,          string  title            = slackCommandUtils.getDefaultSetting( "title"      )
		,          string  titleLink        = slackCommandUtils.getDefaultSetting( "titleLink"  )
		,          string  pretext          = slackCommandUtils.getDefaultSetting( "pretext"    )
		,          string  thumbnail        = slackCommandUtils.getDefaultSetting( "thumbnail"  )
		,          string  author           = slackCommandUtils.getDefaultSetting( "author"     )
		,          string  authorLink       = slackCommandUtils.getDefaultSetting( "authorLink" )
		,          string  authorIcon       = slackCommandUtils.getDefaultSetting( "authorIcon" )
		,          string  footer           = slackCommandUtils.getDefaultSetting( "footer"     )
		,          string  footerIcon       = slackCommandUtils.getDefaultSetting( "footerIcon" )
		,          boolean includeTimestamp = slackCommandUtils.getDefaultSetting( "includeTimestamp", false )
		,          numeric timestamp        = slackCommandUtils.getEpoch()
		,          string  webhook          = slackCommandUtils.getDefaultSetting( "webhook" )
	) {
		while( !arguments.message.len() ) {
			arguments.message = shell.ask( "Enter the message you wish to send" );
		}

		while( !arguments.webhook.len() ) {
			arguments.webhook = shell.ask( "Enter your slack Webhook URL: " );
		}

		var error = SlackCommandUtils.sendMessage( argumentCollection=arguments );

		if ( error.len() ) {
			print.redLine( "Error sending slack message: [#error#]" );
		} else {
			print.greenLine( "Message sent." );
		}

		return;
	}

}
