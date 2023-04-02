import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itec_t3nsa/app/controllers/firebase_controller.dart';
import 'package:itec_t3nsa/app/core/values/strings.dart';
import 'package:itec_t3nsa/app/global_widgets/custom_scaffold.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
    final FirebaseController firebaseController = Get.find();
    return CustomScaffold(
      [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Welcome to\n',
                              style: GoogleFonts.roboto(fontSize: 20)),
                          TextSpan(
                            text: "iTEC - T3nsa",
                            style: GoogleFonts.adamina(
                              fontSize: 20,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: Strings.fieldRequired),
                        FormBuilderValidators.email(
                            errorText: Strings.emailFormat),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderTextField(
                      name: 'password',
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: FormBuilderValidators.required(
                          errorText: Strings.fieldRequired),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width - 40, 40),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        firebaseController.signInWithEmailAndPassword(
                          _formKey.currentState!.fields['email']!.value,
                          _formKey.currentState!.fields['password']!.value,
                        );
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width - 40, 40),
                    ),
                    onPressed: () async {
                      Get.toNamed(
                        Routes.signUp,
                      );
                    },
                    child: const Text('Create account'),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
      title: "Login",
    );
  }
}
