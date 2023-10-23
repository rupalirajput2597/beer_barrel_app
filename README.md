# beer_barrel

beer_barrel is a mobile application built using Flutter that allows users to browse and view Beers. It includes features such as social login, product listing, product details, and user profile details.

## Screens

The application consists of the following screens:

1. **Login**: This screen is displayed when the user is not logged in. It provides social login options using Google.

2. **Home**: After successful login, the user is redirected to the home screen. This screen displays a list of products fetched from the backend using the Punk API. The products are presented in a scrollable grid view, supporting pull-to-refresh and scroll-to-load-more functionality.

3. **Product Detail**: When a user selects a product from the home screen, the product detail screen is displayed. This screen provides comprehensive details about the selected product as received from the API.

4. **User Profile**: The profile screen contains basic user information and an option to logout with confirmation dialog.


## Requirements

To set up and run the application, please ensure you have the following:

- Flutter SDK (minimum version 3.10.0)
- Dart SDK (minimum version 3.0.0)
- A code editor (e.g., Visual Studio Code or Android Studio)
- Emulator or physical device for testing

## Installation Instructions

1. Clone the repository to your local machine:

```bash
git clone [repository_url]
```
2. Change to the project directory:
```bash
cd beer-barrel
```
3.Install the required dependencies:
```bash
flutter pub get
```

## Installation Instructions

1. Clone the repository to your local machine:

```bash
git clone [repository_url]
Change to the project directory:


cd beer-barrel
Install the required dependencies:

flutter pub get
```

      ```


Now the Beer-Barrel app is configured with SocialMedia Authentication. Users can log in using the social login options provided (Google, LinkedIN).

## Dependencies and Libraries

The application utilizes the following dependencies and libraries:

- **flutter_bloc**: A state management library for Flutter, used for managing application state using the BLoC/Cubit pattern.

- **go_router**: A routing library for Flutter, used for handling navigation between different screens in the application.

- **http**: A package for making HTTP requests, used for fetching data from the backend API.

- **cached_network_image**: package in Flutter provides efficient caching and loading of network images, allowing you to display images from the internet with improved performance and reduced network requests.
- 
- **flutter_secure_storage**: package that provides a secure and persistent way to store sensitive data, such as authentication tokens or encryption keys, on a device

## Assumptions

The following assumptions were made during the development of the Beer-Barrel application:

1. The user authentication process is handled entirely by the social login APIs (Google).
2. The backend API provided by Punk API is used for retrieving the product data.
3. The design and layout of the application follow the specifications provided in the Figma design.

## Project Structure

The project follows a Bloc Code architecture, with separation of concerns and modularity. It includes the following folders:

- **lib**: Contains the main application code.
      - **account**: contains user account related data .
          - **cubit**: contain user login/logout related business logic.
          - **widgets**:contains UI components for Login and UserProfileScreen.
          - **screens**:Login and ProfileScreen.
      - **core**: contains all reusable widgets, themes and other core components.
          - **repository**: Handles data-related operations, including API calls.
          - **models**:contains all the required models.
          - **common_widgets**: contains common widgets get used in multiple places in App.
          - **api**: http api_client.      
          - **theme**: App Theme.      
          - **constants**: Constants get used in App.      
      - **Home**: Contains the UI components, Home screens and cubit related to Home feature.
          - **cubit**:  contain user Home page related business logic.
          - **widgets**: contains UI components of Home.
      - **Navigator**:     
          - **routes**: Contains route definitions and navigation setup using Go Router.
      - **Product**: Contains Product detail screen and UI components.
      - **Splash**:  contain splash screen for initial app operations.


