# **ZARAfit iOS Coding Exercise**

This repository contains the iOS coding exercise solution for the ZARAfit job application. It includes unit tests, UI tests, image cache saving, error handling, search / filter, network error simulation, and performance measurement tests.

## **Table of Contents**

- [**Project Structure**](#project-structure)
- [**Instructions for Running the Project**](#instructions-for-running-the-project)
- [**Dependencies**](#dependencies)
- [**Unit Tests**](#unit-tests)
- [**Network Error Simulation**](#network-error-simulation)
- [**Performance Measurement**](#performance-measurement)

## **Project Structure**

- `ZARAfit`: Main Xcode project folder.
  - `ZARAfit`: Project files folder.
  - - `SupportingFiles`: Project supporting files folder.
    - `Modules`: View Controllers folder.
    - `Extensions`: Extensions folder.
  - `ZARAfitTests`: Unit tests folder.
  - - `ZARAfitUITests`: UI tests folder.
    - `ZARAfitTests.swift`: Contains unit tests and network error simulation.
- Other project files and folders.

## **Instructions for Running the Project**

1. Open the `ZARAfit.xcodeproj` file in Xcode.
2. Select the desired simulator or device.
3. Build and run the project.

## **Dependencies**

This project uses the Lottie Framework for animation. It has been integrated using Swift Package Manager.

### **Lottie**

[Lottie](https://github.com/airbnb/lottie-ios) is a library for rendering animations. It allows for easy integration of high-quality animations into iOS applications.

To install Lottie using Swift Package Manager:

1. Open the project in Xcode.
2. Go to "File" > "Swift Packages" > "Add Package Dependency..."
3. Enter the Lottie GitHub repository URL: `https://github.com/airbnb/lottie-ios.git`
4. Follow the prompts to complete the installation.

## **Unit Tests**

The unit tests are written to ensure the correctness of the code and verify different functionalities.

- `testCharactersList`: Tests listing characters.
- `testCharacterPages`: Tests the number of character pages.
- `testCharacterStatus`: Tests character status.
- `testCharacterImages`: Tests character image URLs.
- `testCharacterOriginURL`: Tests character origin URLs.

To run the unit tests, open Xcode, select the `ZARAfitTests` scheme, and run the tests.

## **Network Error Simulation**

The `FakeInteractor` class simulates a network error. The test `testNetworkError` checks the behavior when a network error is simulated.

## **Performance Measurement**

The `testPerformanceExample` method is an example of how to measure the performance of a code block.

## **Author**

- **Author**: Your Name
- **Contact**: Your Email

---

This project is a part of the ZARAfit job application process.

