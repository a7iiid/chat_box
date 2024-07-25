import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF1A1A1A)),
        child: Stack(
          children: [
            Positioned(
              left: 517.91,
              top: 21.56,
              child: Opacity(
                opacity: 0.63,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(2.34),
                  child: Container(
                    width: 577.31,
                    height: 244.52,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.00, 0.02),
                        end: Alignment(1, -0.02),
                        colors: [Color(0xFF42106A), Color(0xFF0A1731)],
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
