# ⏰ WordClock

*A Word Clock Screen Saver for MacOS*

## 🖥 Installation

### Option 1: Download

TBA

### Option 2: Build it yourself

* Clone the repository
* Open in Xcode and build the **WordClock** target
* In the "Products" folder, right click on **WordClock.saver** and choose *Open with External Editor*
* Follow the instructions on screen

## 🚨 Work in progress

This is a work in progress, with many issues still to be solved.

### 😅 Known problems

* When selecting WordClock as the screen saver in "Systems Preferences", it will say that "You cannot use the WordClock screen saver with this version of macOS...". This seems to be due to the fact that this is written in Swift and according to *the internet* this is a known problem. Fingers crossed it will sort itself out! Here's the radr: http://www.openradar.me/25569037
* The "Preferences"-window does not work (it's in the source but haven't gotten it to show up in System Preferences)

### 🤷‍♂️ Unknown problems

* I have no idea how the screen saver will act under any other circumstances (multi screen setup, screen sizes) than on my iMac - If you run in to any problems please report an `Issue` or submit a `Pull Request` to fix it 👍

## ✏️ Contribute

Feel free to contribute by adding issues or opening pull requests.

Apart from fixing the known and unknown problems - I could use your help to add new languages!

## 📣 Shout-outs

* **John Coates** - His screen saver project [Aerial](https://github.com/JohnCoates/Aerial) helped me a lot.
* **Super Make Something** - Looking at the [Arduino Word Clock](https://github.com/SuperMakeSomething/arduino-neopixel-word-clock) logic saved me a bunch of time spent on if-statements.

## Screen shot

![](https://github.com/mattiasjahnke/WordClock/blob/master/screenshot.png)

## License

[MIT](https://github.com/mattiasjahnke/WordClock/blob/master/LICENSE)
