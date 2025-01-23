# UserLibrary

A SwiftUI application for managing contacts with photos and location tracking.

## App Preview
<div align="left">
  <p float="center">
    <img src="/UserLibrary/Screenshot/demo.gif" width="250" alt="Demo" />
  </p>
  <p float="left">
    <img src="/UserLibrary/Screenshot/user-list.png" width="250" alt="User List" />
    <img src="/UserLibrary/Screenshot/user-detail.png" width="250" alt="User Detail" />
    <img src="/UserLibrary/Screenshot/map-request.png" width="250" alt="Map Request" />
  </p>
</div>

## Features
* Photo integration with PhotosPicker
* Contact list with photo thumbnails
* Detailed contact profiles
* Current location mapping
* Animated UI transitions
* Sorted contact management

## Technical Stack
* SwiftUI
* MapKit
* CoreLocation
* PhotosUI

## Key Components
* `ContentView`: Main contact list and management
* `AddUserView`: New contact creation with photo selection
* `UserDetailView`: Profile display with location tracking
* Custom UI components for profile cards and maps

## Requirements
* iOS 17.0+
* Xcode 15.0+
* Swift 5.9+

## Installation
1. Clone repository
2. Open UserLibrary.xcodeproj
3. Build and run

## Usage
* Tap + to add new contact
* Select photo from library
* Enter contact name
* View contact details with location
* Delete contacts with swipe

## License
This project is available under the MIT license. See the LICENSE file for more info.

## Author
Created by Wai Ho Fan

*Note: Location services required for mapping functionality*
