import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pcxd_app/model/usuario.dart';
import 'package:pcxd_app/screens/auth/scrpts/auth_services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  double opacity = 0;
  bool obscure = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerSenha2 = TextEditingController();

  _signup(Usuario usuario) async {
    AuthServices auth = AuthServices();

    await auth.signUpWithEmail(usuario);

    if(auth.result == 'succeful'){
      Navigator.of(context).pop();
      
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.outgoing_mail, color: Colors.white, size: 80,),
                const SizedBox(height: 30,),
                Text(
                  'Tudo certo!',
                  style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 24, color:Colors.white),
                ),
                const SizedBox(height: 10,),
                const Text('Enviamos a você um e-mail de verificação. Após verificado, você estará apto a logar no app.',)
              ],
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK')
              ),
            ],
          );
        }
      );
    } else {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text('Oops!'),
            content: Text(auth.result),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: const Text('OK')
              ),
            ],
          );
        }
      );
    }

  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((value){
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  right: 10,
                  child: IconButton(
                    onPressed: ()=> Navigator.of(context).pop(),
                    icon: const Icon(Ionicons.close_outline, color: Colors.white,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Faça seu Cadastro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center,),
                        const SizedBox(height: 20,),
                        const Text('Será um prazer ter você aqui.', textAlign: TextAlign.center,),
                        const SizedBox(height: 80,),
                        /*TextFormField(
                          controller: _controllerUsername,
                          style: GoogleFonts.abel(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Nome de usuário',
                          ),
                          validator: (text){
                            if(text.isEmpty){
                              return 'Digite seu nome de usuário.';
                            } else if(text.length < 3){
                              return 'Nome muito curto.';
                            } else {
                              return null;
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                        ),
                        const SizedBox(height: 20),*/
                        TextFormField(
                          controller: _controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text){
                            if(text.isEmpty){
                              return 'Digite seu e-mail.';
                            } else if(!text.contains('@')){
                              return 'E-mail inválido.';
                            } else if(!text.contains('.')){
                              return 'E-mail inválido.';
                            } else {
                              return null;
                            }
                          },
                          style: GoogleFonts.abel(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _controllerSenha,
                          style: GoogleFonts.abel(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  if(obscure == true){
                                    obscure = false;
                                  } else if(obscure == false){
                                    obscure = true;
                                  }
                                });
                              },
                              icon: obscure == true ? const Icon(Ionicons.eye_outline, color: Colors.white,) : const Icon(Ionicons.eye_off_outline, color: Colors.white,),
                            ),
                          ),
                          obscureText: obscure,
                          validator: (text){
                            if(text.isEmpty){
                              return 'Digite sua senha.';
                            } else if(text.length < 6){
                              return 'Senha muito curta.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _controllerSenha2,
                          style: GoogleFonts.abel(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Repita sua senha',
                          ),
                          obscureText: true,
                          validator: (text){
                            if(text.isEmpty){
                              return 'Digite novamente sua senha.';
                            } else if(text != _controllerSenha.text){
                              return 'A senha não corresponde com a anterior.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: (){
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState.validate()){

                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context){
                                    return Center(
                                      child: Card(
                                        color: const Color.fromARGB(255, 24, 0, 46),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(40),
                                          child: CircularProgressIndicator(color: Colors.white,),
                                        ),
                                      ),
                                    );
                                  }
                                );

                                Usuario usuario = Usuario();
                                usuario.email = _controllerEmail.text;
                                usuario.password = _controllerSenha2.text;

                                _signup(usuario);

                              }
                            },
                            child: const Text('Cadastre-se'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}