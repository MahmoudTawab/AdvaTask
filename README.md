# Photo List App

## Overview
This is a Swift application that displays a list of photos fetched from an API using VIPER architecture. The app also allows users to view the details of a selected photo.


## Prerequisites
- iOS 16.0 
- Swift 5.0 

## Features
- Fetch and display photos from a remote API
- Infinite scrolling with pagination to load more photos as the user scrolls
- View detailed information about each photo
- Display loading indicators while fetching data
- Error handling with alert messages

## Architecture

This project follows the VIPER architecture, which separates the concerns of the app into distinct layers:
- **View**: Handles UI and user interaction.
- **Interactor**: Handles business logic and data fetching.
- **Presenter**: Acts as an intermediary between the View and the Interactor.
- **Entity**: Represents the models used in the app.
- **Router**: Handles navigation and routing logic.

## How to Run
1. Open the project in Xcode.
2. Run the project on a simulator or a real device.
3. Navigate to the `Photo Gallery` to view the photo list.
4. Tap on any photo to open the detail view and use gestures to zoom in or out.

## Unit Tests
Unit tests have been implemented using `XCTest` to cover the following components:
- `PhotoListViewModel`: Tests the photo loading functionality.
- `ImageLoader`: Tests the image loading from a URL.

### To Run Unit Tests:
1. Open the project in Xcode.
2. Press `Cmd + U` to run the tests.

## References
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/): API used for testing data.
