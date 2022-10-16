import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pcxd_app/model/usuario.dart';
import 'package:pcxd_app/screens/adm/users_screen.dart';
import 'package:pcxd_app/scripts/dialog_services.dart';
import 'package:pcxd_app/widgets/action_button.dart';

class PerfilScreen extends StatefulWidget {
  PerfilScreen(this.userID);

  String userID;

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {

  User user = FirebaseAuth.instance.currentUser;
  Usuario usuario;
  double opacity = 0;

  _recuperarDados() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    setState(() {
      usuario = Usuario.fromDocumentSnapshot(documentSnapshot);
    });
    Future.delayed(const Duration(milliseconds: 500)).then((value){
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _recuperarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha conta'),
        centerTitle: true,
      ),
      body: 
      
      usuario == null?

      const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ):
      
      AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opacity,
        curve: Curves.ease,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                child: GestureDetector(
                  onTap: (){
                    User user = FirebaseAuth.instance.currentUser;
                    if(user != null){
                      TextEditingController controllerNome = TextEditingController();
                      controllerNome.text = usuario.username;
        
                      showDialog(
                        context: context,
                        builder: (context){
                          return SimpleDialog(
                            contentPadding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            title: Text('Nome de Usuário', style: GoogleFonts.abel(color: Colors.white,)),
                            children: [
                              TextField(
                                controller: controllerNome,
                                style: const TextStyle(color: Colors.white),
                                textCapitalization: TextCapitalization.words,
                                maxLength: 25,
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: (){
        
                                    if(controllerNome.text.isEmpty){
                                      Navigator.of(context).pop();
                                    } else {
                                      Navigator.of(context).pop();
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
                                      FirebaseFirestore.instance.collection('users')
                                      .doc(user.uid).update({
                                        'Username' : controllerNome.text,
                                      }).then((value){
                                        setState(() {
                                          usuario.username = controllerNome.text;
                                        });
                                        Navigator.of(context).pop();
                                        showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            title: const Text('Sucesso!'),
                                            content: const Text('Seu Nickname foi salvo!'),
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
                                      }).catchError((e){
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              title: const Text('Oops!'),
                                              content: Text('Não foi possível salvar seu Nickname.\n$e'),
                                              actions: [
                                                TextButton(
                                                  onPressed: ()=> Navigator.of(context).pop(),
                                                  child: const Text('OK')
                                                ),
                                              ],
                                            );
                                          }
                                        );
                                      });
                                    }
        
                                  },
                                  child: const Text('Salvar')
                                ),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          );
                        }
                      );
                    }
                  },
                  child: Text(usuario.username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.center,)),
              ),
              ListTile(
                leading: const Icon(Icons.email_rounded),
                title: Text(user.email),
              ),
              const Divider(),
              ListTile(
                onTap: (){
        
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text('Tem certeza?', style: TextStyle(color: Colors.white),),
                        content: const Text('Sua conta ficará deslogada.', style: TextStyle(color: Colors.white),),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                              DialogServices.showLoading(context);
                              FirebaseAuth.instance.signOut().then((value){
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text('Sair', style: TextStyle(color: Colors.red))
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context, false);
                            },
                            child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      );
                    }
                  );
                },
                title: const Text('Deslogar', style: TextStyle(color: Colors.red),),
                leading: const Icon(Icons.logout_outlined, color: Colors.red,),
              ),
              const Divider(),
              const SizedBox(height: 10,),
              usuario.adm == false ?
              Container():
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ActionButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const UsersScreen()));
                    },
                    title: 'Usuários',
                    child: const Icon(Icons.manage_accounts_outlined, color: Colors.white, size: 50,),
                  ),
                  ActionButton(
                    onPressed: ()=> Navigator.pushNamed(context, '/createCpu'),
                    title: 'Adicionar Processador',
                    child: const Icon(Iconsax.chart_1, color: Colors.white, size: 50,),
                  ),
                  ActionButton(
                    onPressed: ()=> Navigator.pushNamed(context, '/createGpu'),
                    title: 'Adicionar Placa de Vídeo',
                    child: const Icon(Iconsax.chart_1, color: Colors.white, size: 50,),
                  ),
                  ActionButton(
                    onPressed: ()=> Navigator.pushNamed(context, '/createPlacamae'),
                    title: 'Adicionar Placa Mãe',
                    child: const Icon(Iconsax.chart_1, color: Colors.white, size: 50,),
                  ),
                  ActionButton(
                    onPressed: ()=> Navigator.pushNamed(context, '/createRam'),
                    title: 'Adicionar RAM',
                    child: const Icon(Iconsax.chart_1, color: Colors.white, size: 50,),
                  ),
                  ActionButton(
                    onPressed: ()=> Navigator.pushNamed(context, '/createSSD'),
                    title: 'Adicionar SSD',
                    child: const Icon(Iconsax.chart_1, color: Colors.white, size: 50,),
                  ),
                  ActionButton(
                    onPressed: ()=> Navigator.pushNamed(context, '/createPSU'),
                    title: 'Adicionar PSU',
                    child: const Icon(Iconsax.chart_1, color: Colors.white, size: 50,),
                  ),
                  ActionButton(
                    onPressed: ()=> Navigator.pushNamed(context, '/createGabinete'),
                    title: 'Adicionar Gabinete',
                    child: const Icon(Iconsax.chart_1, color: Colors.white, size: 50,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}