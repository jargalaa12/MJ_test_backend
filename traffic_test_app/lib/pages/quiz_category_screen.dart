import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class QuizCategoryScreen extends StatelessWidget {
  const QuizCategoryScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'title': 'Нэр томъёо ба тодорхойлолт', 'count': 20},
    {'title': 'Механикжсан тээврийн хэрэгслийн ангилал', 'count': 20},
    {'title': 'Жолоочийн үүрэг', 'count': 30},
    {'title': 'Тусгай дуут болон гэрлэн дохио', 'count': 10},
    {'title': 'Замын тэмдэг', 'count': 120},
    {'title': 'Замын тэмдэглэл', 'count': 40},
    {'title': 'Замын хөдөлгөөн зохицуулах дохио', 'count': 40},
    {'title': 'Анхааруулах дохио ба таних тэмдэг', 'count': 40},
    {'title': 'Хөдөлгөөн эхлэх болон чиг өөрчлөх', 'count': 80},
    {'title': 'Тээврийн хэрэгсэл байрлан явах', 'count': 80},
    {'title': 'Тээврийн хэрэгслийн хурд', 'count': 20},
    {'title': 'Гүйцэж түрүүлэх ба гүйцэх', 'count': 20},
    {'title': 'Түр ба удаан зогсох', 'count': 80},
    {'title': 'Уулзвар нэвтрэх', 'count': 70},
    {'title': 'Явган хүний гарц нэвтрэх', 'count': 10},
    {'title': 'Төмөр замын гарам нэвтрэх', 'count': 20},
    {'title': 'Гадна талын гэрэлтүүлэх хэрэгсэл', 'count': 10},
    {'title': 'Хорооллын доторх хөдөлгөөн', 'count': 10},
    {'title': 'Тууш замын хөдөлгөөн', 'count': 10},
    {'title': 'Механикжсан тээврийн хэрэгслийг чирэх', 'count': 10},
    {'title': 'Хүн ба ачаа тээвэрлэх', 'count': 20},
    {'title': 'Тээврийн хэрэгслийн эвдрэл, гэмтэл', 'count': 20},
    {'title': 'Аюулгүй жолоодох онол', 'count': 10},
    {'title': 'Эмнэлгийн анхны тусламж', 'count': 10},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тестийн ангиллууд'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      categoryTitle: item['title'], // зөвхөн categoryTitle дамжуулж байна
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  title: Text(
                    item['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    '${item['count']} асуулт',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
