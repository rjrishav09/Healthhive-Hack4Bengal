import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../ThreeDots.dart';
import 'ChatMessageScreen.dart';

class GeminiChatScreen extends StatefulWidget {
  static const String id = 'GeminiChat-screen';

  const GeminiChatScreen({Key? key}) : super(key: key);

  @override
  State<GeminiChatScreen> createState() => _GeminiChatScreenState();
}

class _GeminiChatScreenState extends State<GeminiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    super.initState();
    final apiKey = dotenv.env['']!;
    _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    _chat = _model.startChat();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    final userText = _controller.text;

    ChatMessage userMessage = ChatMessage(
      text: userText,
      sender: "You",
      isImage: false,
    );

    setState(() {
      _messages.insert(0, userMessage);
      _isTyping = true;
      _controller.clear();
    });

    try {
      final response = await _chat.sendMessage(Content.text(userText));
      final reply = response.text ?? "Sorry, I didn't understand that.";

      insertNewData(reply);
    } catch (e) {
      insertNewData("Error: ${e.toString()}");
    }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "Healthhive!",
      isImage: isImage,
    );

    setState(() {
      _isTyping = false;
      _messages.insert(0, botMessage);
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (_) => _sendMessage(),
            decoration: const InputDecoration.collapsed(
              hintText: "Ask Healthhive!",
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: _sendMessage,
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Healthhive!")),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: Vx.m8,
                itemCount: _messages.length,
                itemBuilder: (context, index) => _messages[index],
              ),
            ),
            if (_isTyping) const ThreeDots(),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: context.cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}
