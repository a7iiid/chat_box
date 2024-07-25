import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.imageLogo,
                          color: Colors.white,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        const Text(
                          "ChatBox",
                          style: AppStyle.regular14,
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
