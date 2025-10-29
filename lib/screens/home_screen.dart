import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'words_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Learner'),
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _HeaderCard(),
            SizedBox(height: 16),
            _MenuGrid(),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero-card',
      child: Card(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [skyBlue, softMint]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.book, size: 36, color: Colors.white),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Learn new words', style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(height: 6),
                    Text('Short lessons • Fun quizzes', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 4/3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _MenuTile(title: 'Words', icon: Icons.translate, colorA: skyBlue, colorB: softMint, route: () => Navigator.push(context, _fadeRoute(WordsScreen()))),
          _MenuTile(title: 'Practice', icon: Icons.check_circle_outline, colorA: softMint, colorB: softPeach, route: () {}),
          _MenuTile(title: 'Quiz', icon: Icons.quiz, colorA: softPeach, colorB: softIndigo, route: () {}),
          _MenuTile(title: 'Settings', icon: Icons.settings, colorA: softIndigo, colorB: skyBlue, route: () => Navigator.push(context, _fadeRoute(SettingsScreen()))),
        ],
      ),
    );
  }
}

class _MenuTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color colorA;
  final Color colorB;
  final VoidCallback route;
  const _MenuTile({required this.title, required this.icon, required this.colorA, required this.colorB, required this.route});

  @override
  State<_MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<_MenuTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  @override
  void initState(){
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 260));
    _scale = Tween(begin: 1.0, end: 0.97).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }
  @override
  void dispose(){ _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) { _controller.reverse(); widget.route(); },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [widget.colorA.withOpacity(0.95), widget.colorB.withOpacity(0.95)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(widget.icon, size: 28, color: Colors.white),
                Spacer(),
                Text(widget.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Route _fadeRoute(Widget page){
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      return FadeTransition(opacity: animation, child: child);
    },
  );
}