# Rick and Morty Character Browser

An iOS application that displays characters from the Rick and Morty universe using the public Rick and Morty API.

## 📱 Features

- Browse characters from the Rick and Morty universe
- Paginated list with 20 characters per page
- Filter characters by status (alive, dead, unknown)
- Detailed character view with complete information
- Hybrid UI approach using UIKit and SwiftUI

## ⚙️ Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## 🚀 Installation

1. Clone the repository:
```bash
git clone https://github.com/Jeddawy/Rick-Morty.git
```

2. Open `RickAndMorty.xcodeproj` in Xcode
3. Build and run the project (`⌘ + R`)

## 🏗 Architecture and Technical Decisions

### Architecture
- **MVVM Pattern**
  - Chosen for its clear separation of concerns
  - Compatibility with both UIKit and SwiftUI
- **Repository Pattern**
  - Implements a clean abstraction layer for the API client
- **Dependency Injection**
  - Used to maintain loose coupling between components

### UI Implementation
- **Character List**
  - Implemented using UIKit's UICollectionViewCompositionalLayout
- **Character Details**
  - Built with SwiftUI
  - Rapid development and modern UI components
- **Custom Views**
  - Hybrid approach using both UIKit and SwiftUI
  - Demonstrates framework interoperability

### Networking
- **URLSession**
  - Native networking stack for API communication
- **Combine**
  - Reactive data handling
  - UI updates
- **Async/await**
  - Clean asynchronous code implementation
