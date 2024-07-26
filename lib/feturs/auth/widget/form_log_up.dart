import 'package:chat_app/feturs/auth/widget/coustom_text_form_filde.dart';
import 'package:chat_app/feturs/auth/widget/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/router/routs.dart';
import '../../../servise/auth_user.dart';
import '../../../servise/media_servise.dart';

class FormLogup extends StatefulWidget {
  const FormLogup({super.key});

  @override
  State<FormLogup> createState() => _FormLogupState();
}

class _FormLogupState extends State<FormLogup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    email.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          children: [
            Consumer<MediaService>(
              builder: (context, mediaService, child) => Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    await mediaService.getImageFromLibrary();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(500),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: mediaService.image != null
                            ? FileImage(mediaService.image!)
                            : const NetworkImage(
                                "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png",
                              ) as ImageProvider,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            CoustomTextFormFilde(
              controlar: name,
              hint: 'Name',
              label: "Name",
              error: "Enter Your Name",
            ),
            const SizedBox(height: 30),
            CoustomTextFormFilde(
              controlar: email,
              hint: 'Your Email',
              label: "Email",
              error: "Enter Your Email",
            ),
            const SizedBox(height: 30),
            CoustomTextFormFilde(
              controlar: password,
              hint: 'Password',
              label: "Password",
              error: "Enter Your Password",
              obscuer: true,
            ),
            const Expanded(child: SizedBox()),
            CustomBottom(
              func: () async {
                if (_formKey.currentState!.validate()) {
                  String response = await AuthUser.signUp(
                    context,
                    email.text,
                    password.text,
                    name.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response)),
                  );
                  if (response == "create user") {
                    GoRouter.of(context).push(Routes.kLoginScreen);
                  }
                }
              },
              text: "Sign Up",
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text("Forgot password?"),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
