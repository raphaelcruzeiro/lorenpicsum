#  Loren Picsum

This project is a simple iOS app that displays the usage of modern Apple APIs and some of the newest Swift Language features (as of December 2021). This project displays a browsable list of images from [Loren Picsum](https://picsum.photos).

## Premises

This project was done on my spare time during the days around Christmas, and, as such, I didn't have a lot of time to dedicate to it. Nevertheless, the code was written as something that might go into production one day and great care was put into code readability with the idea that this project should be maintainable. This should be considered as a very simple alpha stage MVP app.

The app was build with the goal of being at least deployable on iOS 13 (most testing was done on a real device using iOS 15 though). Since the goal was to keep it compatible with iOS 13, SwiftUI was not considered as a viable alternative to building the user interface as a lot has changed between then and now, and UIKit is still a perfectly valid and battle-proven SDK. With a bit of generics and the neweish AutoLayout methods, it was possible to avoid having a lot of boilerplate code inside the view controllers. This project uses a single storyboard file for the launchscreen. All the remaining UI is written in code.

Since I usually work with FRP (RxSwift), I wanted to go the opposite way with this project and to rely only on frameworks that are provided out of the box. There are no third-party dependencies. Another goal for this was to leverage the new Swift 5.5 concurrency features.

## Project organisation

In order to avoid the issues of eventually having a large project file, this project leverages local SPM packages to organise its modules. A setup like this might feel like an overkill for such a small project, but as an app evolves and both the code and the team grows, this approach avoids those unnecessary and recurring merge conflicts on the project file as we keep it as slim as possible.

The project is divided into the following modules

- Core: The app itself. View controllers and views go here.
- Models: The app domain model (Currently only the `ImageListItem` model exists).
- Networking: The module responsible for communicating with the outside world and returning populated models back to the app.
- Utils: This module contains some code that I reuse across my projects. The main goal here is to abstract away all the annoying boilerplate UI code into easy to use base classes ,protocols and some helper extension methods.


## Assumptions

- The Loren Picsum image list might change over time. It didn't change while this project was being implemented but an assumption has been made that the list is transient and thus the app will fetch it everytime.
- Images are immutable. The image file for a given image ID is immutable and thus can safely be cached on the device. The app uses a `URLCache` configured to cache the images both in-memory and on a disk file so that the cache can live across app launches.

## Running the project

The project was developed on Xcode 13.2.1. To run the app, simply open the `Loren Picsum.xcworkspace` and wait for Xcode to resolve the package graph. The app should run as is on the iOS simulator. In order to run it on an actual device, just change the team under *Signing and Capabilities* on the *Loren Picsum* target. This project uses automated provisioning. In a real world app, something more robust for managing provisioning, such as Fastlane Sigh, would have been used.

## Automated tests

Both the *Models* and *Networking* modules contain unit tests. For the *Models* module, there is a test that ensures that the model can be generated from the JSON response that we expect from the Loren Picsum API. The *Networking* module tests that the endpoint definitions will generate the expected *URLRequests*. To run the tests, simply select the *Loren Picsum* target and press *CMD + U*.


