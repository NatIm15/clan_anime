import 'package:clan_anime/UI/pages/feed_screen.dart';
import 'package:clan_anime/UI/pages/log_in/recuperarpword_screen.dart';
import 'package:clan_anime/UI/theme/constant.dart';
import 'package:clan_anime/UI/widgets/components/large_button.dart';
import 'package:clan_anime/domain/controllers/authentification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AuthController _authCtrl = Get.find();

  _signup(theEmail, thePwd) async {
    try {
      await _authCtrl.ingresar(theEmail, thePwd);
      Get.offAll(() => FeedScreen(), transition: Transition.noTransition);
    } catch (err) {
      Get.snackbar(
        "Sign Up",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  final loginFormKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool isHiddenPwd = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: loginFormKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/Logo.svg",
              color: kPrimaryColor,
              semanticsLabel: 'Logo',
              height: 132,
              width: 132,
            ),
            const Text(
              'clan anime',
              style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'MainFont',
                fontSize: 37,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailCtrl,
                decoration: InputDecoration(
                  hintText: 'Correo Electr??nico',
                  hintStyle: const TextStyle(color: kTercearyColor),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: kTercearyColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: kSecondaryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: kPrimaryColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: kSecondaryColor),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El Correo Electr??nico es obligatorio';
                  } else if (!value.contains('@')) {
                    return 'El correo no cumple con las caracter??sticas';
                  }
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: TextFormField(
                obscureText: isHiddenPwd,
                controller: passwordCtrl,
                decoration: InputDecoration(
                    hintText: 'Contrase??a',
                    hintStyle: TextStyle(color: kTercearyColor),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: kTercearyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: kSecondaryColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: kPrimaryColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: kSecondaryColor),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() {
                        isHiddenPwd = !isHiddenPwd;
                      }),
                      child: Icon(
                        isHiddenPwd ? Icons.visibility : Icons.visibility_off,
                        color: kTercearyColor,
                      ),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'La contrase??a es obligatorio';
                  } else if (value.length < 8) {
                    return 'La contrase??a debe ser mayor o igual a 8 caract??res';
                  }
                },
              ),
            ),
            Container(
              width: size.width * 0.8,
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text(
                  'Olvidaste tu Contrase??a?',
                  style: TextStyle(color: kSecondaryColor),
                ),
                onPressed: () => Get.to(() => RecuperarScreen(),
                    transition: Transition.native),
              ),
            ),
            LargeButton(
                text: 'Ingresar',
                press: () {
                  final form = loginFormKey.currentState;
                  form!.save();
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (loginFormKey.currentState!.validate()) {
                    _signup(emailCtrl.text, passwordCtrl.text);
                  }
                })
          ],
        ),
      ),
    );
  }
}
