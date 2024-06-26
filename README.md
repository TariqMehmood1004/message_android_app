# Zedo Android Messenger App

Zedo Android Messenger App is a Flutter application that demonstrates how to implement a login functionality using Zego Cloud In-Chat services. This app allows users to log in with their user ID and user name, leveraging the Zego ZIM SDK.

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [License](#license)

## Features
- User login with Zego Cloud In-Chat
- User-friendly UI
- Error handling and notifications

## Getting Started

### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) (>=2.19.0 <3.0.0)
- A Zego account with access to the Zego ZIM SDK. You will need your Zego app ID and app sign.

### Installation
1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/zedo_android_messenger_app.git
    cd zedo_android_messenger_app
    ```

2. Install the dependencies:
    ```sh
    flutter pub get
    ```

3. Open the project in your preferred IDE (VSCode, Android Studio, etc.).

4. Replace `YOUR_APP_ID` and `YOUR_APP_SIGN` in `main.dart` with your Zego credentials:
    ```dart
    final int appID = YOUR_APP_ID; // Replace with your Zego app ID
    final String appSign = 'YOUR_APP_SIGN'; // Replace with your Zego app sign
    ```

### Running the App
1. Connect your Android device or start an Android emulator.
2. Run the app:
    ```sh
    flutter run
    ```

## Usage
- Enter your User ID and User Name on the login screen.
- Tap on the "Login" button to log in.
- Upon successful login, you will be navigated to the home page.

## Dependencies
The project uses the following dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  google_fonts: ^6.2.1
  zego_uikit_prebuilt_call: ^4.12.9
  get: ^4.6.6
  zego_zim: ^2.16.0+4
```

## Project Structure
The main files and folders of interest are:
- `lib/main.dart`: The main entry point of the application.
- `pubspec.yaml`: The configuration file for Dart and Flutter packages.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to contribute to this project by opening issues and submitting pull requests. For any questions, please contact [your email].

Happy coding!
```

Replace `https://github.com/yourusername/zedo_android_messenger_app.git` with your actual GitHub repository URL and `[your email]` with your contact email. 


``` flutter build apk --split-per-abi --no-tree-shake-icons ```