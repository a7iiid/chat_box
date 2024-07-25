import 'package:chat_app/feturs/auth/widget/coustom_text_form_filde.dart';
import 'package:chat_app/feturs/auth/widget/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/router/routs.dart';
import '../data/auth_user.dart';

class FormLogup extends StatefulWidget {
  const FormLogup({super.key});

  @override
  State<FormLogup> createState() => _FormLogupState();
}

class _FormLogupState extends State<FormLogup> {
  @override
  void dispose() {
    passowrd.dispose();
    email.dispose();
    name.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController passowrd = TextEditingController();
  final TextEditingController name = TextEditingController();

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              CoustomTextFormFilde(
                controlar: name,
                hint: 'Name',
                label: "Name",
                error: "Enter Your Name",
              ),
              const SizedBox(
                height: 30,
              ),
              CoustomTextFormFilde(
                controlar: email,
                hint: 'Your Email',
                label: "Email",
                error: "Enter Your Email",
              ),
              const SizedBox(
                height: 30,
              ),
              CoustomTextFormFilde(
                controlar: passowrd,
                hint: 'Password',
                label: "Password",
                error: "Enter Your Password",
                obscuer: true,
              ),
              const Expanded(child: SizedBox()),
              CustomBottom(
                func: () async {
                  String respons = await AuthUser.SignUp(
                      email.text, passowrd.text, name.text);

                  if (_formKey.currentState!.validate()) {
                    GoRouter.of(context).push(Routes.kLoginScreen);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(respons)),
                  );
                },
                text: "Log Up",
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () {}, child: const Text("Forgot password?")),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}
