import 'package:chat_app/servise/auth_user.dart';
import 'package:flutter/material.dart';

import 'coustom_text_form_filde.dart';
import 'custom_bottom.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  void dispose() {
    passowrd.dispose();
    email.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController passowrd = TextEditingController();

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
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
              const Expanded(
                  child: SizedBox(
                height: 15,
              )),
              CustomBottom(
                func: () async {
                  if (_formKey.currentState!.validate()) {
                    String respons = await AuthUser.logIn(
                        email.text, passowrd.text, context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(respons)),
                    );
                  }
                },
                text: "Log In",
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
