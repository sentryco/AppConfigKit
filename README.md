[![Tests](https://github.com/sentryco/AppConfigKit/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/AppConfigKit/actions/workflows/Tests.yml)

# AppConfigKit

> Easily retain or reset app config

## Description

App Configuration Management. Allows configuration of app settings related to user data and feature visibility, supporting different modes such as debugging and production. Includes options to reset user data for testing or retain data for production use. AppConfigKit is a great way to reset the app before UITests based on Process info passed from the UITest. Or retain app data when needed. 

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
- Potentially use keychain lib from telemetry instead of key
