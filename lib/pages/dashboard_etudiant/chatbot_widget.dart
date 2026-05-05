import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chatbot_model.dart';
export 'chatbot_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotWidget extends StatefulWidget {
  const ChatbotWidget({Key? key}) : super(key: key);

  @override
  _ChatbotWidgetState createState() => _ChatbotWidgetState();
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  late ChatbotModel _model;
  List<Map<String, String>> messages = [
    {"role": "assistant", "content": "Bonjour ! Je suis l'assistant IA de LearnHub. Comment puis-je vous aider avec vos matières, offres ou toute autre question concernant la plateforme ?"}
  ];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatbotModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    final text = _model.textController!.text;
    if (text.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "content": text});
      _model.textController!.clear();
      isLoading = true;
    });

    try {
      const String apiKey = 'AIzaSyBwXWvQEdPGL2Q42VY9n4s4C3gn5KSMpXo';
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": "Tu es un assistant virtuel pour l'application étudiante 'LearnHub'. Réponds à cette question de manière professionnelle et concise : " + text}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final responseText = data['candidates'][0]['content']['parts'][0]['text'];
        setState(() {
          messages.add({"role": "assistant", "content": responseText});
        });
      } else {
        setState(() {
          messages.add({"role": "assistant", "content": "Désolé, je rencontre un problème de connexion avec l'IA."});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"role": "assistant", "content": "Erreur : \$e"});
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.smart_toy_rounded, color: Color(0xFF4F46E5), size: 28),
              SizedBox(width: 12),
              Text(
                'LearnHub IA',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  color: Colors.black87,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
        Divider(height: 1),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final isUser = msg["role"] == "user";
              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? Color(0xFF4F46E5) : Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(16).copyWith(
                      bottomRight: isUser ? Radius.zero : Radius.circular(16),
                      bottomLeft: isUser ? Radius.circular(16) : Radius.zero,
                    ),
                  ),
                  child: Text(
                    msg["content"]!,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (isLoading)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(color: Color(0xFF4F46E5)),
          ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _model.textController,
                  focusNode: _model.textFieldFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Posez votre question...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onFieldSubmitted: (_) => sendMessage(),
                ),
              ),
              SizedBox(width: 8),
              FloatingActionButton(
                mini: true,
                onPressed: sendMessage,
                backgroundColor: Color(0xFF4F46E5),
                elevation: 2.0,
                child: Icon(Icons.send_rounded, color: Colors.white, size: 20),
              )
            ],
          ),
        ),
      ],
    );
  }
}
