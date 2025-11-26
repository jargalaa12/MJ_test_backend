import 'package:flutter/material.dart';
import 'quiz_category_screen.dart'; // ✅ QuizCategoryScreen-г импортлоно

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Сайн байна уу!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Жолооны тест болон замын хөдөлгөөний мэдлэгээ сайжруулцгаая.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  GradientCard(
                    title: 'Хичээл',
                    icon: Icons.school_outlined,
                    gradient: const LinearGradient(
                      colors: [Color(0xff43cea2), Color(0xff185a9d)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GradientCard(
                    title: 'Тест',
                    icon: Icons.book_outlined,
                    gradient: const LinearGradient(
                      colors: [Color(0xfff7971e), Color(0xffffd200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GradientCard(
                    title: 'Шалгалт',
                    icon: Icons.emoji_events_outlined,
                    gradient: const LinearGradient(
                      colors: [Color(0xfff953c6), Color(0xffb91d73)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
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

class GradientCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final LinearGradient gradient;

  const GradientCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (title == 'Тест') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizCategoryScreen(),
                ),
              );
            } else {
              print('$title рүү орлоо');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(icon, size: 48, color: Colors.white),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black26,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
