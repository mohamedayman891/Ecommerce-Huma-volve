# Product deep links

Product links use `https://<firebase-hosting-domain>/products/<product-id>`. Firebase Hosting serves the Flutter web app for product paths, and Android App Links opens the same URL in the Android app when the installed app and domain association are verified.

## Configure the Firebase Hosting domain

Replace `your-project-id.web.app` with the Firebase Hosting domain in both places:

- `android/gradle.properties` as `firebaseHostingDomain=your-project-id.web.app`
- Build the app with `--dart-define=FIREBASE_HOSTING_DOMAIN=your-project-id.web.app`

Deploy Hosting after signing in and selecting the Firebase project:

```sh
firebase use --add
flutter build web --dart-define=FIREBASE_HOSTING_DOMAIN=your-project-id.web.app
firebase deploy --only hosting
```

The Android signing certificate must match `web/.well-known/assetlinks.json`. The checked-in fingerprint is this machine's debug key for emulator testing. Before distributing a release build, add its signing certificate SHA-256 fingerprint to that file and redeploy Hosting. The Android application ID is `com.example.ecommerce_app_huma_volve`.
