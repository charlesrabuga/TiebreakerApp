import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = ''; // 🔑 Replace with your key

  final GenerativeModel _model;

  GeminiService()
      : _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);

  Future<String> analyzeScenario(String decisionPrompt) async {
    final prompt = '''
      You are an expert decision-making assistant. The user is trying to make a decision: "$decisionPrompt".
      Please provide exactly 3 sections of markdown:
      1. ### Pros and Cons
      2. ### Comparison Table
      3. ### SWOT Analysis
      Ensure the markdown is well-formatted and professional. Do not include conversational filler.
    ''';

    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? 'Walang nahanap na resulta.';
  }
}