# Hyrox Workout Tracker

A SwiftUI app for iOS and Apple Watch that tracks your time through a full Hyrox-style workout — 8 runs alternating with 8 workout stations.

## Features

- **Live workout tracking** — tap through each station with a running timer for both the current station and total elapsed time
- **Division support** — Single Male, Single Female, Double Male, Double Female, and Double Mixed, each with correct station weights
- **50/50 split mode** — for doubles divisions, optionally halve workout station targets (e.g. SkiErg 1000m → 500m)
- **Finish anytime** — complete the workout early and see results for all stations attempted
- **Results summary** — total time, total run time, total workout time, and per-station breakdown
- **Apple Watch app** — compact workout tracking on the wrist with swipeable pages
- **Settings sync** — division and split settings sync from iPhone to Apple Watch via WatchConnectivity

## Stations

| # | Station | Distance / Reps |
|---|---------|-----------------|
| 1 | Run 1 | 1 km |
| 2 | SkiErg | 1000 m |
| 3 | Run 2 | 1 km |
| 4 | Sled Push | 50 m |
| 5 | Run 3 | 1 km |
| 6 | Sled Pull | 50 m |
| 7 | Run 4 | 1 km |
| 8 | Burpee Broad Jumps | 80 m |
| 9 | Run 5 | 1 km |
| 10 | Rowing | 1000 m |
| 11 | Run 6 | 1 km |
| 12 | Farmers Carry | 200 m |
| 13 | Run 7 | 1 km |
| 14 | Sandbag Lunges | 100 m |
| 15 | Run 8 | 1 km |
| 16 | Wall Balls | 100 reps |

## Weights by Division

| Station | Men | Women |
|---------|-----|-------|
| Sled Push | 152 kg | 102 kg |
| Sled Pull | 103 kg | 78 kg |
| Farmers Carry | 2 x 24 kg | 2 x 16 kg |
| Sandbag Lunges | 20 kg | 10 kg |
| Wall Balls | 6 kg | 4 kg |

## Project Structure

```
HyroxImmitation/
├── Model/
│   ├── Division.swift          # Division enum (Single/Double M/F/Mixed)
│   └── Station.swift           # Station model, weights, and station list
├── ViewModel/
│   ├── WorkoutViewModel.swift  # Timer, state, and workout logic
│   └── SettingsSync.swift      # WatchConnectivity for syncing settings
├── UI/
│   ├── ContentView.swift       # TabView with Workout and Settings tabs
│   ├── ActiveWorkoutView.swift # Live workout screen
│   ├── ResultsView.swift       # Post-workout results
│   └── SettingsView.swift      # Division and split settings
├── Constants.swift             # Layout, font, and timer constants
└── HyroxImmitationApp.swift    # App entry point

HyroxImmitationWatch App/
├── ContentView.swift              # Watch start screen
├── WatchActiveWorkoutView.swift   # Watch workout screen
├── WatchResultsView.swift         # Watch results screen
└── HyroxImmitationWatchApp.swift  # Watch app entry point
```

## Requirements

- iOS 17.0+
- watchOS 10.0+
- Xcode 15.0+

## Getting Started

1. Open `HyroxImmitation.xcodeproj` in Xcode
2. Select the `HyroxImmitation` scheme for iPhone or `HyroxImmitationWatch App` for Apple Watch
3. Build and run
