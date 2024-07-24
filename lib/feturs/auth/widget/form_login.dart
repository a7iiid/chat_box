import 'package:chat_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

import 'coustom_text_form_filde.dart';

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
              const Expanded(child: SizedBox()),
              CustomBottom(
                formKey: _formKey,
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

class CustomBottom extends StatelessWidget {
  const CustomBottom(
      {super.key, required GlobalKey<FormState> formKey, required this.text})
      : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Log In')),
          );
        }
      },
      child: Container(
        height: 48,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xff24786D)),
        child: Center(
          child: Text(
            text,
            style: AppStyle.bold16,
          ),
        ),
      ),
    );
  }
}
