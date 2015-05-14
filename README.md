# ReceptionKit

A simple, customizable receptionist iPad app built with [SupportKit](http://supportkit.io). Receive a message on Slack when someone is at the reception.

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/home.png)


## Setup

1. `git clone https://github.com/AcroMace/receptionkit.git`
2. `cd receptionkit`
3. `pod install`
4. Sign up with [SupportKit](http://supportkit.io) and copy the App Token from Settings
5. [Configure Slack with SupportKit](http://docs.supportkit.io/#slack)
6. **Disable Auto Archiving**
5. Open `ReceptionKit.xcworkspace`
6. Navigate to `Config.swift`
7. Replace `Config.SupportKit.AppToken` with the App Token from SupportKit
6. Build and run the app


## Slack

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/slack.png)

**Replies**

You can send a message to the iPad by using `/sk [message]` inside the iPad channel (called `sk-receptionist` by default). If you want the message to be sent in real time, you need to [configure push notifications](http://docs.supportkit.io/#configuring-push-notifications). Otherwise, there may be up to a 5 second delay before the message arrives.

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/reply.png)

**Name**

You can set the name of how the receptionist appears in Slack by changing `Config.Slack.Name`.

**Picture**

SupportKit uses Gravatar to set the user's profile pictures. If you want to set a profile picture, you must [set a Gravatar](http://en.gravatar.com) for an email and set `Config.Slack.Email` to that email.

**Channel name**

A new channel will be created for each iPad running the app. You can rename the channel using the `/rename new-channel-name` in Slack.


## Contacts

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/search.png)

ReceptionKit uses the contacts on the iPad for searching contacts when a visitor presses the `i know the name of the person i am here to see` button.

You can sync the iPad with contacts from [Google](https://support.google.com/mail/answer/2753077?hl=en), [Outlook](https://support.office.com/en-au/article/Synchronize-Outlook-and-Apple-iPhone-or-iPod-touch-contacts-149cbfc5-4396-4ab3-8b65-22915e4043dc), or use any standard way of syncing contacts with iOS.


## Customization

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/colours.png)

**Background colour**

The background colour and the navigation bar colour can be changed in `Config.swift` by changing `Config.Colour.Background` and `Config.Colour.NavigationBar`, respectively, to the colours' hex values.

**Image assets**

The image assets can be changed by replacing the images in `Images.xcassets`. The resolutions of the images are:

| Image type         | Resolution  |
| ------------------ | ----------- |
| Company logo       | 800 x 88    |
| Horizontal buttons | 2048 x 704  |
| Vertical buttons   | 1024 x 1408 |
| Delivery logos     | 800 x 800   |

**Navigation bar**

*Logo*

The logo is displayed only in the first view and can be disabled by setting `Config.General.ShowLogo` to `false`. Otherwise, you can replace the placeholder logo with your own image (see Image Assets)

*Language toggle*

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/french.png)

The English/French language toggle is enabled by default. You can turn it off by setting `Config.General.ShowLanguageToggle` to `false`.

**Launch screen**

If you wish to customize the launch screen, you must change the `LaunchScreen.xib` file.


## Note

- The default button images are from [Font Awesome](http://fortawesome.github.io/Font-Awesome/)
- The first time you search for a contact, you will have to give the app permission to access the device's contact list
- You should really, really [configure push notifications](http://docs.supportkit.io/#configuring-push-notifications) if you want to send messages to the iPad
