# community_view View App

This Flutter application displays a community_view feed with posts containing images and videos. It utilizes the Bloc pattern for state management and provides a user-friendly interface for viewing and interacting with the content.

## Features

- **Display Posts:** Fetches and displays posts from a remote API.
- **Image Support:** Shows images within each post.
- **Video Playback:** Enables video playback with controls (play/pause).
- **Single Video Playback:** Ensures only one video plays at a time, pausing others.
- **Loading and Error Handling:** Handles loading states and displays error messages when necessary.
- **Attractive UI:** Provides a clean and visually appealing user interface.

## Technologies Used

- **Flutter:** For cross-platform mobile development.
- **Bloc Pattern:** For state management.
- **`flutter_bloc` Package:** For integrating Bloc with Flutter.
- **`http` Package:** For making HTTP requests to the API.
- **`video_player` Package:** For video playback functionality.

## Getting Started

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/neelamraj25/community_view_app.git
    cd community_view
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the app:**

    ```bash
    flutter run
    ```

## API Endpoint

The application fetches posts from the following API endpoint:

https://happeningbazaar.com:7432/fetchPost?type=post

## Project Structure

community_view/
├── lib/
│   ├── bloc/
│   │   ├── community_view_bloc.dart
│   │   ├── community_view_event.dart
│   │   └── community_view_state.dart
│   ├── models/
│   │   ├── post_response.dart  (Contains PostResponse, Post, User, ImageData, ImageBase classes)
│   ├── main.dart
│   └── community_view.dart
├── pubspec.yaml
└── README.md



-   `lib/bloc`: Contains the Bloc implementation for state management.
-   `lib/model`: Contains the data model classes.
-   `lib/screen/community_view.dart`: Contains the UI implementation.
-   `lib/main.dart`: Entry point of the application.

## State Management (Bloc)

The application uses the Bloc pattern to manage the state. The `community_viewBloc` handles fetching posts, playing/pausing videos, and manages the application's state.

## Video Playback

The `video_player` package is used for video playback. The application ensures that only one video plays at a time by pausing other videos when a new video is played.

## UI Design

The UI is designed to be clean and user-friendly. It includes:

-   An app bar with a title.
-   Cards for each post.
-   Images and videos displayed within the cards.
-   Play/pause buttons overlaid on videos.
-   Loading and error indicators.

## Future Improvements

-   Implement pull-to-refresh functionality.
-   Add infinite scrolling.
-   Improve error handling and user feedback.
-   Add commenting and liking features.
-   Optimize video loading and playback.
-   Add better user profile integration.

## Contributing

Contributions are welcome! Please feel free to submit a pull request.