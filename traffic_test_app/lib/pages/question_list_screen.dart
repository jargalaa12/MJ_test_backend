import 'package:flutter/material.dart';
import 'package:traffic_test_app/services/api_service.dart';
class QuestionListPage extends StatefulWidget {
  const QuestionListPage({super.key});

  @override
  State<QuestionListPage> createState() => _QuestionListPageState();
}

class _QuestionListPageState extends State<QuestionListPage> {
  final ApiService api = ApiService();
  List questions = [];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    final data = await api.getQuestions();
    setState(() {
      questions = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questions')),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(questions[index]['text']), // Django Question model-ийн text field
          );
        },
      ),
    );
  }
}
