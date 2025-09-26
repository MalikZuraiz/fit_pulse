// AI Coach Binding
import 'package:get/get.dart';

class AiCoachController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isTyping = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    _initializeChat();
  }
  
  void _initializeChat() {
    messages.add(ChatMessage(
      text: "Hi! I'm your AI fitness coach. How can I help you today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }
  
  void sendMessage(String text) {
    messages.add(ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    
    // Simulate AI response
    isTyping.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isTyping.value = false;
      messages.add(ChatMessage(
        text: "That's a great question! I'd recommend starting with...",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  
  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}