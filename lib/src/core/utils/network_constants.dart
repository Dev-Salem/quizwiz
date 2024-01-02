class NetworkConstants {
  static const apiKeyName = "chatPdfApi";
  static const addFileEndPoint = "https://api.chatpdf.com/v1/sources/add-file";
  static const chatEndPoint = "https://api.chatpdf.com/v1/chats/message";
  static const deleteFileEndPoint = 'https://api.chatpdf.com/v1/sources/delete';
  static const String noConnectionErrorMessage = "No Internet connection";
  static const String invalidNetworkErrorMessage =
      "Invalid API response, try again";
  static const String generateFlashcardsPrompt = """
pretend to be an expert in summarizing studying material.
create a valid JSON array of objects for material provided , use only the material provided, provide as much flashcards as possible
following this format [no prose, only the result in json format]:

[
  {
  "term": "clean code",
  "definition": "code that meets the standards"
  },
  {
  "term": "science",
  "definitions": "the pursuit and application of knowledge"
  }

]
 """;
}
