import 'package:flutter/material.dart';
import 'package:traffic_test_app/model/question_model.dart';

class QuizScreen extends StatefulWidget {
  final String categoryTitle;
  const QuizScreen({super.key, required this.categoryTitle});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];
  int currentIndex = 0;
  int score = 0;
  int? selectedAnswer;

  @override
  void initState() {
    super.initState();
    fetchQuestions().then((value) {
      setState(() {
        questions = value;
      });
    });
  }

  void checkAnswer(int index) {
    if (selectedAnswer != null) return;
    setState(() {
      selectedAnswer = index;
      if (index == questions[currentIndex].answer) score++;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        selectedAnswer = null;
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Тест дууслаа!'),
            content: Text('Таны оноо: $score / ${questions.length}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Асуулт ${currentIndex + 1} / ${questions.length}',
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Text(
              question.question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Зураг байгаа бол харуулах
            if (question.image != null)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Image.asset(
                  question.image!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),

            Expanded(
              child: Column(
                children: [
                  ...List.generate(question.choices.length, (i) {
                    Color buttonColor = Colors.blueAccent;
                    Color textColor = Colors.white;

                    if (selectedAnswer != null) {
                      if (i == question.answer) {
                        buttonColor = Colors.green;
                        textColor = Colors.white;
                      } else if (i == selectedAnswer && selectedAnswer != question.answer) {
                        buttonColor = Colors.red;
                        textColor = Colors.white;
                      } else {
                        buttonColor = Colors.blueAccent;
                        textColor = Colors.white;
                      }
                    }

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: selectedAnswer == null ? () => checkAnswer(i) : null,
                        child: Text(
                          question.choices[i],
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                      ),
                    );
                  }),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedAnswer != null ? nextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: const Text(
                        'Дараагийн асуулт',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
