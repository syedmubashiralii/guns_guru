# guns_guru

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


(350+150+100 =600)
(900 per week)






Ad monetization partners that support SKAdNetwork
https://iskadnetwork.com/ad-monetization/


Ad monetization partners google and others
https://developers.google.com/admob/ios/privacy/strategies

Complete guide 
https://iskadnetwork.com/google/

skan and apple search ads
https://splitmetrics.com/blog/apple-skadnetwork-guide/



# Complete Setup



To integrate SKAdNetwork in your Flutter app, you'll need to handle configuration on both the app side and within your ad network settings to ensure that conversion data flows correctly.

1. App-side Integration
For iOS SKAdNetwork attribution, you’ll configure SKAdNetwork identifiers and ensure your app is SKAdNetwork-compatible by updating specific files. Here are the main steps:

Step 1: Add SKAdNetwork Identifiers
In the Info.plist of your iOS project, include the SKAdNetwork IDs for Google, Meta, and Apple Search Ads.

Example:

xml
Copy code
<key>SKAdNetworkItems</key>
<array>
    <!-- Google Ads SKAdNetwork ID -->
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cstr6suwn9.skadnetwork</string>
    </dict>
    <!-- Meta Ad Manager SKAdNetwork ID -->
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v9wttpbfk9.skadnetwork</string>
    </dict>
    <!-- Apple Search Ads SKAdNetwork ID -->
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3rd42ekr43.skadnetwork</string>
    </dict>
</array>
Note: The SKAdNetwork identifiers above are examples and should be replaced with the latest IDs for each network. You can refer to the latest documentation from each ad provider.

Step 2: Initialize SKAdNetwork
In your app code, explicitly call SKAdNetwork.registerAppForAdNetworkAttribution() if you need to ensure registration occurs at a specific time, though this generally happens automatically.

2. Configuring Firebase Analytics
To track conversions via SKAdNetwork, configure Firebase Analytics to handle these conversions:

Step 1: Enable SKAdNetwork Measurement in Firebase
In your Firebase project settings:

Go to Events and configure relevant events (e.g., purchase, signup).
Enable SKAdNetwork Measurement in Firebase to attribute conversions with SKAdNetwork.
Step 2: Set Conversion Events for SKAdNetwork
Define the relevant conversion events you want Firebase Analytics to report for each network:

In Google Analytics > Events, mark key events like purchase, login, or signup for SKAdNetwork reporting.
Under Google Analytics > Attribution > Conversion Events, confirm these events as conversion goals to track through SKAdNetwork.
Step 3: Connect Ad Networks in Google Analytics
In Google Analytics, go to Attribution > Ad Networks and link each network to view conversion reports.
Ensure Google Ads, Meta Ads, and Apple Search Ads are connected to your Firebase project.
This setup will allow Firebase to capture SKAdNetwork conversion data and attribute it to each respective network. Once completed, the conversions should display in Google Analytics > Attribution Reports.
