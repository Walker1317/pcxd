import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pcxd_app/model/usuario.dart';
import 'package:pcxd_app/screens/auth/scrpts/auth_services.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  double opacity = 0;
  bool obscure = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _signin(Usuario usuario) async{

    AuthServices auth = AuthServices();
    await auth.signInWithEmail(usuario);

    if(auth.result == 'succeful'){

      if(auth.user.emailVerified != true){
        Navigator.of(context).pop();
        auth.auth.signOut();
        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text('Oops!'),
              content: const Text('Parece que seu e-mail ainda não foi verificado.'),
              actions: [
                TextButton(
                  onPressed: (){
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
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      }

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
                        const Text('Faça seu Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center,),
                        const SizedBox(height: 20,),
                        const Text('Seja bem vindo, tenha acesso a todos os recursos do APP com sua conta logada.', textAlign: TextAlign.center,),
                        const SizedBox(height: 80,),
                        TextFormField(
                          controller: _controllerEmail,
                          style: GoogleFonts.abel(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                          ),
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
                        const SizedBox(height: 10),
                        const Text('Esqueci minha senha', textAlign: TextAlign.right,),
                        const SizedBox(height: 30),
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
                                usuario.password = _controllerSenha.text;

                                _signin(usuario);
                              }

                            },
                            child: const Text('Login')
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 0.5,
                                width: 130,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text('ou'),
                              ),
                              Container(
                                height: 0.5,
                                width: 130,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: ()=> Navigator.pushNamed(context, '/signup'),
                          child: const Text('Cadastre-se', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center,)
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