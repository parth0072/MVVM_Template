# MVVM Template (iOS)

A starter iOS project that demonstrates the **MVVM (Model-View-ViewModel)** pattern with a simple GitHub Users example.

## Project Purpose

This repository is meant to be a base template for iOS apps that need:
- clear separation between UI, business logic, and data layer
- typed API handling with `URLSession` + `Codable`
- reactive UI updates using `Combine`
- a simple, extendable folder structure for scaling features

You can clone this project and reuse its structure to bootstrap new MVVM-based iOS applications.

## Tech Stack

- Swift
- UIKit
- Combine
- URLSession
- Codable
- CocoaPods (project dependency management)

## Project Structure

```
NetworkHelper/
  API_Client/      # API endpoints, request handling, network client
  Models/          # Data models (Codable)
  ViewModels/      # UI-facing business logic and state
  Controllers/     # UIKit view controllers
  View/            # Storyboards and UI files
```

## How It Works

- `ViewController` asks `UserViewModel` for data.
- `UserViewModel` fetches from the service layer via `ConnectionManager`.
- Network responses are decoded into `User` models.
- Published state updates (`@Published`) refresh the UI.

## Getting Started

1. Clone the repo.
2. Install pods:
   ```bash
   pod install
   ```
3. Open:
   - `NetworkHelper.xcworkspace`
4. Build and run the `NetworkHelper` scheme.

## Template Usage

When creating a new app from this template:
1. Replace API endpoint constants in `API_Client/`.
2. Add/replace domain models in `Models/`.
3. Create feature-specific view models in `ViewModels/`.
4. Keep controllers thin and bind UI from view model outputs.

