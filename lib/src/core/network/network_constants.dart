class NetworkConstants {
  static const String gptBaseUrl = 'https://chatgpt-api8.p.rapidapi.com';
  static const String gptHeaderHost = 'chatgpt-api8.p.rapidapi.com';
  static const String contentType = 'application/json';
  static String generateFlashcardsPrompt(String material) {
    return """
pretend to be an expert in summarizing studying material.
create a valid JSON array of objects for $material , use only the material provided,
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
}
