import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String categoryTitle;
  final int questionCount;

  const QuizScreen({
    super.key,
    required this.categoryTitle,
    required this.questionCount,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;
  bool answered = false;

  // ✅ Жишээ асуултууд
  final List<Map<String, dynamic>> questions = [
    {
      'question': '“Зогс” тэмдэг юу заадаг вэ?',
      'choices': ['Зогсолтгүй явах', 'Зогсоод нэвтрэх', 'Гүйцэх хориотой', 'Эргэх хориотой'],
      'answer': 1
    },
    {
      'question': 'Улаан гэрэл ассан үед жолооч яах ёстой вэ?',
      'choices': ['Хурдаа нэмэх', 'Зогсох', 'Зүүн эргэх', 'Гүйцэх'],
      'answer': 1
    },
    {
      'question': 'Тээврийн хэрэгслийн урд талд ямар гэрэл байдаг вэ?',
      'choices': ['Хойд гэрэл', 'Урд гэрэл', 'Дохионы гэрэл', 'Тормозны гэрэл'],
      'answer': 1
    },
    {
      'question': '“А” ангиллын үнэмлэх ямар тээврийн хэрэгсэлд зориулагдсан бэ?',
      'choices': ['Мотоцикл', 'Автобус', 'Ачааны машин', 'Суудлын машин'],
      'answer': 0
    },
    {
      'question': 'Зорчигчийг тээвэрлэхэд жолооч юу анхаарах ёстой вэ?',
      'choices': ['Хурд нэмэх', 'Аюулгүй байдал', 'Гэрэл асаах', 'Хөгжим сонсох'],
      'answer': 1
    },
  ];

  void checkAnswer(int index) {
    if (answered) return; // давхар дарахаас сэргийлнэ
    setState(() {
      selectedIndex = index;
      answered = true;
    });

    if (index == questions[currentIndex]['answer']) {
      score++;
    }

    // 1.5 секундийн дараа дараагийн асуулт руу автоматаар шилжинэ
    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedIndex = null;
          answered = false;
        });
      } else {
        showResultDialog();
      }
    });
  }

  void showResultDialog() {
    final percent = (score / questions.length * 100).toStringAsFixed(1);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('✅ Тест дууслаа!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Таны оноо: $score / ${questions.length}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Амжилт: $percent%',
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // буцаж ангилал руу
            },
            child: const Text('Буцах'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentIndex = 0;
                score = 0;
                selectedIndex = null;
                answered = false;
              });
            },
            child: const Text('Дахин шалгах'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
    final choices = question['choices'] as List<String>;

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
              question['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(choices.length, (i) {
              final isCorrect = i == question['answer'];
              final isSelected = i == selectedIndex;

              Color buttonColor = Colors.blueAccent;
              if (answered) {
                if (isSelected && isCorrect) {
                  buttonColor = Colors.green;
                } else if (isSelected && !isCorrect) buttonColor = Colors.red;
                else if (isCorrect) buttonColor = Colors.green.shade400;
                else buttonColor = Colors.grey.shade400;
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
                  onPressed: () => checkAnswer(i),
                  child: Text(
                    choices[i],
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
