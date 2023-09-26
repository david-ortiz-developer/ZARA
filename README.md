# **ZARAfit iOS Coding Exercise**

This repository contains the solution for the iOS coding exercise required for the ZARAfit job application. It encompasses unit tests, UI tests, image cache management, error handling, search/filter functionalities, network error simulation, and performance measurement tests.

## **Table of Contents**

- [**Project Structure**](#project-structure)
- [**Running the Project**](#running-the-project)
- [**Dependencies**](#dependencies)
- [**Unit Tests**](#unit-tests)
- [**Network Error Simulation**](#network-error-simulation)
- [**Performance Measurement**](#performance-measurement)

## **Project Structure**

- **ZARAfit**: Main folder containing the Xcode project.
  - **ZARAfit**: Project files and structure.
    - **SupportingFiles**: Additional project files.
    - **Modules**: Contains VIPER files for different views like `CharactersList` and `CharactersDetail`.
    - **Extensions**: Swift extensions.
    - **Resources**: Fonts, assets, images, and animations.
  - **ZARAfitTests**: Folder for unit tests.
  - **ZARAfitUITests**: Folder for UI tests.
  - **LottieAnimations**: Folder for JSON animation files generated by Lottie.

## **Running the Project**

1. Open the `ZARAfit.xcodeproj` file in Xcode.
2. Select the desired simulator or device.
3. Build and run the project.

## **Dependencies**

This project utilizes the Lottie Framework for animations, integrated using Swift Package Manager.

### **Lottie**

[Lottie](https://github.com/airbnb/lottie-ios) is a powerful library for rendering animations, enabling seamless integration of high-quality animations into iOS applications.

Lottie has been successfully integrated using Swift Package Manager.

## **Unit Tests**

Unit tests have been carefully designed to validate the code's accuracy and verify various functionalities:

- `testCharactersList`: Tests the character listing.
- `testCharacterPages`: Validates the character pages count.
- `testCharacterStatus`: Verifies character statuses.
- `testCharacterImages`: Checks character image URLs.
- `testCharacterOriginURL`: Ensures character origin URLs are valid.
- `testNetworkError`: Validates networking error handling.

To run the unit tests, open Xcode, select the `ZARAfitTests` scheme, and execute the tests. For UI tests, select the `testIfAlexanderIsDead` test. It simulates scrolling three times, tapping on the character "Alexander," and then verifies if the status is dead.

## **UI Tests**

UI tests are designed to guarantee the correctness of the UI and validate interface elements:

- `testCharactersList`: Tests character listing.
- `testCryingMortyEmptyTable`: Validates the display of an empty table view cell for empty filter results.

## **Network Error Simulation**

The `FakeInteractor` class simulates network errors. The `testNetworkError` checks the behavior under simulated network error conditions.

## **Performance Measurement**

The `testPerformanceExample` method showcases how to measure the initial list loading view's performance.

## **Author**

- **Author**: Davit
- **Contact**: david.ortiz.developer@gmail.com

---

This project is ONLY for Cibernos job application process.


