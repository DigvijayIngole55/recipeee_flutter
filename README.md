
# Receipeee Flutter App

This repository contains the code for the Receipeee Flutter app, which allows users to upload grocery bills or manually input ingredients to receive recipe suggestions.

## Features

- Upload images of grocery bills to automatically scan and add ingredients.
- Manually input ingredients for a personalized experience.
- Fetch recipes based on the provided ingredients.
- View recipe details, including image, type, cuisine, missing ingredients, allergens, dietary type, and cooking instructions.
- Download recipes as an HTML file.

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: [Installation Guide](https://dart.dev/get-dart)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/DigvijayIngole55/receipeee_flutter.git
cd receipeee_flutter
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## Folder Structure

- `lib/`: Contains the main source code for the app.
- `lib/models/`: Defines the data models.
- `lib/providers/`: Contains the provider classes for state management.
- `lib/widgets/`: Contains common widgets used throughout the app.
- `lib/screens/`: Contains the screens for different pages in the app.

## Usage

- Start the app and navigate to the Ingredients page.
- Upload an image of a grocery bill or manually add ingredients.
- Click the "Next Step" button to fetch and view recipes based on the provided ingredients.
- Download the recipes as an HTML file by clicking the "Download Recipes" button.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
