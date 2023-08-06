# zakupy
The application was prepared using the Flutter framework.
Its main use case is to add products to the list of products available at home, and as they become depleted, create a shopping list.  

App was build with Android in mind. In future it will support desktop + web app too.

# build & install release apk
- enable developer mode on phone.
- enable usb debug mode.
- connect phone to computer via usb cable.
- pull code from repo
- cd into local copy of pulled repo
- run `flutter build apk --split-per-abi`
- run `flutter install` with phone connected via USB
- in case of problems with `flutter install` run adb command `adb install .\build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk`