## Description
QuizWiz is a flashcard app that utilizes the power of AI to make flashcards from documents.

## 📌 Features
- Create, edit, and combine collections (deck).
- Create cards manually or by uploading pdf files/pasting materials.
- Review cards based on SM-2 algorithm 
- Practice reviewed cards using multiple choice or by writing them manually.
- Light and dark themes.

## 📸 Screenshots

|  ![Create Collection](https://s12.gifyu.com/images/SWyEz.gif)|  ![Edit, delete, combine collections and cards](https://s11.gifyu.com/images/SWyEb.gif) |
|-------|--------|
|![Review cards](https://s11.gifyu.com/images/SWyEL.gif) | ![Practice using multiple choice quiz](https://s12.gifyu.com/images/SWyEs.gif) |
| ![Practice by writing definitions manually](https://s12.gifyu.com/images/SWyES.gif) |  ![Upload pdf then save all generated cards](https://s12.gifyu.com/images/SWyE2.gif) |
|![Paste text then save individual generated cards](https://s11.gifyu.com/images/SWyEM.gif)| - |





## 📦 Packages & Technologies

| Description    |   Package |
| ---------| -------|
| Architecture | Bloc Pattern|
| State Management | [flutter_bloc](https://pub.dev/packages/flutter_bloc)
| Dependency Injection | [get_it](https://pub.dev/packages/get_it)
| Theming | [flex_color_scheme](https://pub.dev/packages/flex_color_scheme) |
| Internet Connection | [connectivity_plus](https://pub.dev/packages/connectivity_plus) |
| Functional Programming | [dartz](https://pub.dev/packages/dartz) |
| database | [Isar](https://pub.dev/packages/isar) |

  
## 🩻 Project Structure  

```
lib
|
|_ 📁src
	|
	|__ 📁core
	|	|__ 📁errors <- define errors and exceptions
	|	|__ 📁router <- generated router & route names
	|	|__ 📁services <- dependency injection & internet connection
	|	|__ 📁theme <- define themes & dynamic theming
	|	|__ 📁utils <- constants (enums, strings, etc..)
	|	|__ 📁widgets <- widgets that are used in multiple screens
	|
	|__ 📁features
		|
		|__ 📁cards
			|__ 📁controller <- Bloc
			|__ 📁data <- data retrieval and caching
			|	|__ 📁models <- business logic
			|	|__ 📁data_source <- works with db and api
			|	|__ 📁repository <- combine and map data
			|__ 📁presentation <- screens and widgets
```

## 🏃‍♂️ Install & Run The App
1. clone the project by running `git clone https://github.com/Dev-Salem/quizwiz.git` in your preferred directory
2. Run `flutter pub get`
3. Get an api key from [Rapid API](https://rapidapi.com/haxednet/api/chatgpt-api8) [1]
4. Go to `lib/features/cards/data/data_source/remote_data_source/api_client.dart` and provide your key, (note: if you intend to publish the app make sure to store the key securely, [for more information](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjh3oK02p6AAxW7TaQEHVDhAmwQFnoECA0QAw&url=https%3A%2F%2Fcodewithandrea.com%2Farticles%2Fflutter-api-keys-dart-define-env-files%2F&usg=AOvVaw0UjTuo12ak9YdRK1uZigSe&opi=89978449) )
5. Run `flutter_run`

[1] if you want to use the official chat gpt api or other wrappers, head to `lib/core/utils/network_constants.dart` and change the values of `gptBaseUrl`, `gptHeaderHost` 

## 🛠️ Limitations
Due to the limitations of chatgpt 3.5 turbo, the API is only able to summarize ~3 pages at a time.

## 💡 Contribution
Feel free to add/request features by making a pull request, or by reporting bugs.

## 🗺️ Roadmap
[  ] add tests

## 🗞️ License
MIT License

