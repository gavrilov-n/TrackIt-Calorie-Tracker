# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Tech Stack Overview
* **Platform:** iOS Native (Targeting iOS 17+)
* **Language:** Swift
* **UI Framework:** SwiftUI (Strictly Declarative)
* **State Management:** `@Observable` macro (No `ObservableObject` or `@Published`)
* **Local Persistence:** SwiftData
* **Network:** Swift `async/await` (No completion handlers or Combine)

## Project Overview

TrackIt is a native iOS calorie tracking app built with SwiftUI targeting iOS 26.2.

We are building a modern, native iOS calorie and macro tracking app designed to give you complete control over your nutritional data while serving as the ultimate hands-on learning project. Under the hood, we are leveraging SwiftUI for a responsive, declarative interface and SwiftData for robust, offline-first local storage, structuring our code around a clean, modern Model-View architecture with dedicated service layers. The app centers on a hierarchical data model—Days containing Meals, which contain FoodItems—and empowers users to log their nutrition through three advanced methods: querying a comprehensive food database (like Edamam), scanning barcodes natively using VisionKit, and utilizing AI vision (via OpenAI) to estimate macros directly from photos. Ultimately, this project combines everyday UI building with advanced hardware and network integrations, perfectly bridging the gap between beginner tutorials and shipping a professional-grade App Store product.

## Build & Development Commands

Open in Xcode:
```
open TrackIt.xcodeproj
```

Build from CLI (Debug):
```
xcodebuild -scheme TrackIt -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 16'
```

Run unit tests:
```
xcodebuild test -scheme TrackIt -destination 'platform=iOS Simulator,name=iPhone 16'
```

Run a single test class (example):
```
xcodebuild test -scheme TrackIt -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:TrackItTests/TrackItTests
```

## Data Domain (SwiftData Hierarchy)
Our local database represents a relational object graph mirroring a user's timeline:



* `Day`: Represents a 24-hour period. Holds daily macro goals (e.g., 2000 kcal) and a One-to-Many relationship with `Meal`.
* `Meal`: A categorization bucket (e.g., "Breakfast", "Lunch"). Holds a One-to-Many relationship with `FoodItem`.
* `FoodItem`: The granular logged item. Holds name, quantity, unit, and macro values (calories, protein, carbs, fat).

## Service Layer Details
Heavy lifting is abstracted into dedicated, testable services:
* `FoodNetworkService`: Interacts with Edamam / Open Food Facts API for text-based food search.
* `AIVisionService`: Handles converting photos to base64 and communicating with OpenAI (GPT-4o) to estimate macros from images.
* `BarcodeScannerService`: Wraps Apple's native VisionKit (`DataScannerViewController`) for live barcode reading.

## Directory Structure
The Xcode project should be strictly organized by Feature/Domain, not by file type:

├── App/ (App Entry, Main Tab View)
├── Core/
│   ├── Data/ (SwiftData Models, SwiftData Container Setup)
│   ├── Extensions/
│   └── UI/ (Reusable components like MacroProgressBars)
├── Features/
│   ├── Diary/ (Main Dashboard, Day/Meal Views)
│   ├── FoodSearch/ (API Search, Text Entry)
│   ├── BarcodeScan/ (VisionKit Wrappers)
│   └── AICamera/ (Photo Capture, AI Analysis)
└── Services/ (API Clients, AI Service, Scanner Logic)

## Golden Rules for AI Generation
1.  **No Boilerplate ViewModels:** Do not generate a ViewModel just to pass data from SwiftData to a View.
2.  **Use `async/await`:** All network and heavy tasks must use modern Swift concurrency.
3.  **Preview-Driven:** Always ensure SwiftUI Previews are provided with in-memory SwiftData mock containers.
4.  **Keep Views Clean:** If a View's `body` is longer than 50 lines, extract subviews.
