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
3. Get an api key from [ChatPDF](https://www.chatpdf.com/docs/api/backend) 
4. create .env file in the root directory and assign the key to  `chatPdfApi`
5. Run `flutter_run`


## 💡 Contribution
Feel free to add/request features by making a pull request, or by reporting bugs.

## 🗺️ Roadmap
[✅] add widget tests

[⏳] migrate to Go_Router

[✅] use a new API (e.g ChatPDF)

## 🗞️ License
MIT License

