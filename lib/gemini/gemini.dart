// import 'dart:io';
//
// import 'package:google_generative_ai/google_generative_ai.dart';
//
// void main() async {
//   final apiKey = Platform.environment['GEMINI_API_KEY'];
//   if (apiKey == null) {
//     stderr.writeln(r'No $GEMINI_API_KEY environment variable');
//     exit(1);
//   }
//
//   final model = GenerativeModel(
//     model: 'gemini-1.5-pro',
//     apiKey: apiKey,
//     // safetySettings: Adjust safety settings
//     // See https://ai.google.dev/gemini-api/docs/safety-settings
//     generationConfig: GenerationConfig(
//       temperature: 1,
//       topK: 64,
//       topP: 0.95,
//       maxOutputTokens: 8192,
//       responseMimeType: 'text/plain',
//     ),
//   );
//
//   final chat = model.startChat(history: [
//     Content.multi([
//       TextPart('helo'),
//     ]),
//     Content.model([
//       TextPart('Hello! How can I help you today? \n'),
//     ]),
//     Content.multi([
//       TextPart('what is mindOs\n'),
//     ]),
//     Content.model([
//       TextPart('"mindOS" is a bit of a tricky term as it doesn\'t refer to a single, specific thing.  It\'s more of a concept that gets used in a few different ways:\n\n**1. A Conceptual "Operating System" for the Mind:** \n\n* This is the most abstract use. People talk about "mindOS" as a metaphor for how we organize and process information, make decisions, and interact with the world.  It\'s like imagining your brain has an operating system like Windows or iOS, but obviously, it\'s far more complex than that. \n* This is more of a philosophical or self-improvement concept than a real technological thing. People might use it when talking about personal productivity, mindfulness, or cognitive enhancement.\n\n**2. AI and Brain-Computer Interfaces:**\n\n* "mindOS" sometimes gets used in discussions about futuristic technologies that could interface directly with our brains. This might include:\n    * **Brain-computer interfaces (BCIs):**  These allow for direct communication between the brain and external devices. \n    * **Artificial intelligence (AI):**  Advanced AI could potentially understand and interact with our thoughts and emotions in complex ways.\n* In this context, "mindOS" might refer to the software or systems that would bridge the gap between our minds and these technologies.\n\n**3. Specific Products or Companies:**\n\n*  It\'s possible there are companies or projects using "mindOS" as a name. A quick search online might reveal if there\'s a specific product or service you\'re thinking of.\n\n**Without more context, it\'s hard to give you a definitive answer.** \n\nCould you tell me:\n\n* **Where did you encounter the term "mindOS"?**  Was it in an article, a book, a conversation?\n* **What was the context?** What were they talking about? \n\nThis will help me understand what specific meaning of "mindOS" you\'re interested in. \n'),
//     ]),
//   ]);
//   final message = 'INSERT_INPUT_HERE';
//   final content = Content.text(message);
//
//   final response = await chat.sendMessage(content);
//   print(response.text);
// }