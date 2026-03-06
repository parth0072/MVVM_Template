# MVVM Template (iOS)

A modernized iOS MVVM starter template with typed networking, `Codable` models, and `Combine`-based UI binding.

## What Was Updated

- Replaced dynamic JSON parsing (`SwiftyJSON`) with strongly typed `Decodable` models.
- Replaced `Alamofire` request usage in app code with `URLSession` and a reusable network client.
- Introduced a `UserServicing` abstraction for cleaner dependency injection and testability.
- Improved view model state flow with `Result` and `NetworkError` handling.
- Updated controllers to use safer bindings and optional handling.
- Cleaned app lifecycle boilerplate by removing unused Core Data setup.
- Improved `.gitignore` for Xcode/CocoaPods artifacts.

## Recommended Structure

```
NetworkHelper/
  API_Client/
    ApiConstants.swift
    ConnectionManager.swift
    ConnectionManager+FetchRequest.swift
  Models/
    User.swift
  ViewModels/
    UserViewModel.swift
  Controllers/
    ViewController.swift
    GetUserDetailViewController.swift
  Resources/
    Assets.xcassets
    Base.lproj/
```

## Architecture Notes

- Keep `Models` as plain value types (`struct`) using `Codable`.
- Keep networking behind protocol boundaries (`NetworkClientProtocol`, `UserServicing`).
- Keep `ViewModels` UI-framework agnostic where possible.
- Keep `Controllers` thin: bind, route, and render only.
- Prefer `Result<T, NetworkError>` for API outcomes.

## Getting Started

1. Open the workspace:
   - `NetworkHelper.xcworkspace`
2. Install dependencies if needed:
   - `pod install`
3. Build and run the `NetworkHelper` scheme in Xcode.

## Next Improvements

- Add unit tests for `UserViewModel` and network decoding.
- Move to feature-based modules for larger apps.
- Add pagination and retry/backoff support for API calls.
