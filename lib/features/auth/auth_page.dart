import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/core/utils/router/routs.dart';
import 'package:chat_app/features/auth/widget/custom_bottom.dart';
import 'package:chat_app/features/auth/widget/deviders.dart';
import 'package:chat_app/features/auth/widget/social_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'widget/logo_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF1A1A1A)),
        child: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * 0.08,
              // Adjust position based on your design
              top: MediaQuery.of(context).size.height *
                  0.05, // Adjust position based on your design
              child: SvgPicture.asset(Assets.imageEllipse),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const LogoAuth(),
                      const SizedBox(height: 46),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Connect friends',
                              style: AppStyle.meduim68,
                            ),
                            TextSpan(
                              text: ' easily & quickly',
                              style: AppStyle.meduim68,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Our chat app is the perfect way to stay connected with friends and family.',
                        style: AppStyle.scondaryText,
                      ),
                      const SizedBox(height: 46),
                      SocialList(
                        mainAxisAlignment: MainAxisAlignment.center,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 37),
                      Deviders(),
                      const SizedBox(height: 37),
                      CustomBottom(
                        func: () {
                          GoRouter.of(context).push(Routes.kSignUpScreen);
                        },
                        text: 'Sign up withn mail',
                      ),
                      const SizedBox(height: 37),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Existing account?',
                            style: AppStyle.scondaryText,
                          ),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(Routes.kLoginScreen);
                            },
                            child: const Text(
                              'Log in',
                              style: AppStyle.regular14,
                            ),
                          ),
                        ],
                      )
                    ],
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
