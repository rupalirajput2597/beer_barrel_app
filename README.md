# beer_barrel

beer_barrel is a mobile application built using Flutter that allows users to browse and view Beers. It includes features such as social login, product listing, product details, and user profile details.

## Screens

The application consists of the following screens:

1. **Login**: This screen is displayed when the user is not logged in. It provides social login options using Google and Linkedin.

2. **Home**: After successful login, the user is redirected to the home screen. This screen displays a list of products fetched from the backend using the Punk API. The products are presented in a scrollable grid view, supporting pull-to-refresh and scroll-to-load-more functionality.

3. **Product Detail**: When a user selects a product from the home screen, the product detail screen is displayed. This screen provides comprehensive details about the selected product as received from the API.

4. **User Profile**: The profile screen contains basic user information and an option to logout with confirmation dialog.

5. **Splash Screen**: Pre Authentication task. if user already logged in we take user to home and if user is Unauthorized we move user to login screen


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
Now the Beer-Barrel app is configured with SocialMedia Authentication. Users can log in using the social login options provided (Google, LinkedIN and Facebook).

## Dependencies and Libraries

The application utilizes the following dependencies and libraries:

- **flutter_bloc**: A state management library for Flutter, used for managing application state using the BLoC/Cubit pattern.

- **go_router**: A routing library for Flutter, used for handling navigation between different screens in the application.

- **http**: A package for making HTTP requests, used for fetching data from the backend API.

- **cached_network_image**: package in Flutter provides efficient caching and loading of network images, allowing you to display images from the internet with improved performance and reduced network requests.

- **flutter_secure_storage**: package that provides a secure and persistent way to store sensitive data, such as authentication tokens or encryption keys, on a device

- **flutter_login_facebook**: package is a Flutter plugin that provides login and authentication functionality using Facebook's login system. It allows users to log in to Flutter app using their Facebook credentials

- **linkedin_login**: package is a Flutter plugin that provides authentication and user profile access through LinkedIn.

- **equatable**: The equatable package is a Dart package that simplifies equality comparisons for objects.


## Test Cases
- **account**: account_cubit_test.dart: unit test cases for Account Cubit.

- **home**: home_cubit_test.dart: unit test cases for Home Cubit.

- **models**: beer_model_test.dart: unit test cases for Models Cubit.

- **repository**: dataRepo and AuthRepo unit test cases.

To run the test cases, follow these steps:

1. Change to the project directory (if not already in):

```bash
cd beer_barrel
Run the tests using the following command:

flutter test
```

## Assumptions

The following assumptions were made during the development of the Beer-Barrel application:

1. The user authentication process is handled entirely by the social login APIs (Google, Facebook and Linkedin).
2. The backend API provided by Punk API is used for retrieving the product data.
3. The design and layout of the application follow the specifications provided in the Figma design. 
4. In order to know the user about login, logout action and error, have used SnackBar to show messages. 
5. stored logged in user information in local storage using flutter_secure_storage.
6. I have made an assumption as whenever profileUrl is will fail to fetch the image, I am showing custom Widget containing User's name 1st letter

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
          - **widgets**: contains common widgets get used in multiple places in App.
          - **api**: http api_client.      
          - **theme**: App Theme.      
          - **constants**: Constants get used in App.      
      - **Home**: Contains the UI components, Home screens and cubit related to Home feature.
          - **cubit**:  contain user Home page related business logic.
          - **widgets**: contains UI components of Home.
      - **Navigator**:     
          - **routes**: Contains route definitions and navigation setup using Go Router.      
      - **main**:     
            - **app**: BeerBarrel App root Widget.
        - **Product**: Contains Product detail screen and UI components.
        - **Splash**:  contain splash screen for initial app operations.


