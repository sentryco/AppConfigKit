# AppConfigKit

> Easily retain or reset app config

## Description
AppConfigKit is a great way to reset the app before UITests based on Process info passed from the UITest. Or retain app data when needed. 

## Features
- Reset UserDefaults
- Reset database data (SwiftData)
- Reset Keychain data

## Example 
```swift
AppConfig.current = .reset(db: ...)
AppConfig.current = .retain(db: ...)
```

## Todo

- Clean up code
- Clean up comments
- Max 80 chars for long descriptions
