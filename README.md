# ReceptionKit
SupportKit Receptionist iPad app

## Get started

1. Clone the repository
2. `pod install`
3. Setup [SupportKit](http://app.supportkit.io) and get the App Token from Settings
3. Change `spAppToken` to the App Token and `SKTUser.currentUser().email` to the SupportKit user in `AppDelegate.swift`
4. Run

## Not implemented

- Setup page: Need push notifications and contact information permissions. Should ask for the latter when searching for someone the first time.
- Sending a message after searching contacts
- Better string localization
