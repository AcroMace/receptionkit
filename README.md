# ReceptionKit

[![Build Status](https://travis-ci.org/AcroMace/receptionkit.svg?branch=master)](https://travis-ci.org/AcroMace/receptionkit) [![DUB](https://img.shields.io/dub/l/vibe-d.svg?maxAge=2592000)](https://github.com/AcroMace/receptionkit/blob/master/LICENSE)

A simple, customizable receptionist iPad app built with [Smooch](http://smooch.io). Receive a message on Slack when someone is at the reception.

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/home.png)


## Setup

1. `git clone https://github.com/AcroMace/receptionkit.git`
2. `cd receptionkit`
3. Sign up with [Smooch](http://smooch.io) and copy the *App ID* from Settings
4. [Configure Slack with Smooch](http://docs.smooch.io/#slack)
5. **Disable Automatic Channel Archiving when configuring Smooch**. If you don't do this, your receptionist channel will be archived.
6. Open `ReceptionKit.xcworkspace` with Xcode
7. Navigate to `Config.swift`
8. Replace `Config.Smooch.AppToken` with the App Token from Smooch
9. Build and run the app (`⌘R`)


## Slack

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/slack.png)

**Replies**

You can send a message to the iPad by using `/sk [message]` inside the iPad channel (called `sk-receptionist` by default). If you want the message to be sent in real time, you need to [configure push notifications](http://docs.smooch.io/#configuring-push-notifications). Otherwise, there may be up to a 5 second delay before the message arrives.

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/reply.png)

**Name**

You can set the name of how the receptionist appears in Slack by changing `Config.Slack.Name`.

**Picture**

Smooch uses Gravatar to set the user's profile pictures. If you want to set a profile picture, you must [set a Gravatar](http://en.gravatar.com) for an email and set `Config.Slack.Email` to that email.

**Channel name**

A new channel will be created for each iPad running the app. You can rename the channel using the `/rename new-channel-name` in Slack.


## Contacts

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/contacts.png)

ReceptionKit uses the contacts on the iPad for searching contacts when a visitor presses the `i know the name of the person i am here to see` button.

You can sync the iPad with contacts from [Google](https://support.google.com/mail/answer/2753077?hl=en), [Outlook](https://support.office.com/en-au/article/Synchronize-Outlook-and-Apple-iPhone-or-iPod-touch-contacts-149cbfc5-4396-4ab3-8b65-22915e4043dc), or use any standard way of syncing contacts with iOS.


## Getting images

If you use `/sk #image` in Slack, it will post an image from the front-facing camera. You can change the command by changing `Config.Photos.ImageCaptureCommand`. You can also disable the command by setting `Config.Photos.EnableCommand` to `false`.

The app will also post a picture when someone interacts with the iPad. You can disable this behaviour by setting `SendOnInteraction` to `false`.


## Customization

![](https://github.com/AcroMace/receptionkit/raw/master/Screenshots/colours.png)

**Background colour**

The background colour and the navigation bar colour can be changed in `Config.swift` by changing `Config.Colour.Background` and `Config.Colour.NavigationBar`, respectively, to the colours' hex values.

**Image assets**

The image assets can be changed by replacing the images in `Images.xcassets`. The resolutions of the images are:

| Image type         | Resolution  |
| ------------------ | ----------- |
| Company logo       | 800 x 88    |
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

- The icons on the buttons are from [Font Awesome](http://fortawesome.github.io/Font-Awesome/). You can replace the icon in `Icons.swift` by changing the Unicode values.
- The first time you search for a contact, you will have to give the app permission to access the device's contact list.
