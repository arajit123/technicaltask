# technicaltask

A new Flutter project.

## Getting Started

# Post Management App

A Flutter application for managing and displaying posts fetched from an API. The app incorporates a timer functionality to track how long each post remains visible to the user.

---

## Features

- Fetch posts from the [JSONPlaceholder API](https://jsonplaceholder.typicode.com/posts).
- Save fetched posts to local storage using `SharedPreferences`.
- Track post visibility with a timer using the `VisibilityDetector` package.
- Mark posts as read and display their details on a separate screen.
- Elegant and responsive UI.

---

## Architectural Choices

1. **State Management**:
   - Used the `Provider` package for state management, offering a clean and efficient way to manage application state across widgets.

2. **API and Local Storage**:
   - Fetched posts from a REST API and synchronized the data with local storage using `SharedPreferences` to improve app performance and support offline functionality.

3. **Dynamic Timer Functionality**:
   - Implemented a timer to track visibility for each post. This functionality pauses or resumes the timer dynamically as the user scrolls through posts.

4. **Modular Code Structure**:
   - Separated concerns into different layers (e.g., Provider for state management, models for data, and UI for presentation) to improve code readability and maintainability.

---

## Third-Party Libraries Used

- [**Provider**](https://pub.dev/packages/provider): For state management across the application.
- [**http**](https://pub.dev/packages/http): To make API requests and handle responses.
- [**SharedPreferences**](https://pub.dev/packages/shared_preferences): For storing fetched data locally.
- [**VisibilityDetector**](https://pub.dev/packages/visibility_detector): To detect visibility of widgets and manage the timer functionality dynamically.

---

## How to Run the Application

### Prerequisites

- Flutter SDK installed on your machine ([Install Flutter](https://flutter.dev/docs/get-started/install)).
- An IDE such as Visual Studio Code, IntelliJ IDEA, or Android Studio.
- Ensure the device/emulator is set up for testing.

---

### Steps to Run

1. **Clone the Repository**:
   ```bash
   git clone <repository_url>
   cd <repository_folder>

