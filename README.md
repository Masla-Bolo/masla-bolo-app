
# Masla Bolo [In Development]

Masla Bolo is a community-driven mobile application developed in Flutter, aimed at empowering users to discuss, share, and seek solutions for various community and individual issues. The app is designed with a focus on modularity, scalability, and clean code principles, making it easy to maintain and extend.

## Features

- **Post Issues**: Users can create and share posts about their concerns or issues to discuss with the community.
- **Community Engagement**: Support for comments and support on issues posts, encouraging active community participation.
- **Real-time Updates**: The app offers real-time updates for new posts, comments, and notifications.
- **User Authentication**: Secure user authentication to manage profiles and preferences.

## Tech Stack

- **Frontend**: Flutter (Dart)
- **State Management**: Bloc and Cubit
- **Architecture**: a Clean Architecture-driven MVVM approach
- **Backend**: python - Django - webSockets - Firebase
- **Database**: PostgreSql

## Project Architecture

The application follows **Clean Architecture** principles, breaking down the project into distinct layers:

1. **Presentation Layer**: Contains UI components and widgets, which are managed by Bloc and Cubit for efficient state management.
2. **Domain Layer**: Includes abstractions and use cases, separating core functionality from implementation details.
3. **Data Layer**: Manages data sources, such as REST APIs or databases, and includes repository implementations.

## Folder Structure

The project is organized as follows to support Clean Architecture principles:

## State Management

Masla Bolo uses Bloc and Cubit to manage application states. **Bloc** is used for complex flows requiring multiple states and events, while **Cubit** is used for simpler, isolated states, making the app more responsive and organized.

## Contact

For any questions or feedback, feel free to reach out at [asheressani@gmail.com].

---

**Masla Bolo** © 2024. All rights reserved.
