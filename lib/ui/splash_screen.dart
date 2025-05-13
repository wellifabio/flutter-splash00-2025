import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;

  double _scale = 0.0;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {
        _scale = _scaleController.value;
      });
    });

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addListener(() {
      setState(() {
        _opacity = 1.0 - _fadeController.value;
      });
    });

    _scaleController.forward();

    // Aguarda a animação terminar, depois faz o fade e navega
    Timer(const Duration(seconds: 2), () {
      _fadeController.forward();
    });

    // Navega para a Home após fade
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home(title: 'Home')),
      );
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Opacity(
          opacity: _opacity,
          child: Transform.scale(
            scale: _scale,
            child: Image.asset('assets/logo.png', width: 200, height: 200),
          ),
        ),
      ),
    );
  }
}
