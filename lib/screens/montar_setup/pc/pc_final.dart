import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/usuario.dart';
import 'package:pcxd_app/screens/montar_setup/pc/widgets/hardware_list.dart';

class PcFinal extends StatefulWidget {
  PcFinal(this.pc);
  PC pc;

  @override
  State<PcFinal> createState() => _PcFinalState();
}

class _PcFinalState extends State<PcFinal> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  Usuario usuario;

  _somarPreco(){

    var initialRam = 0.0;
    var initialNvme = 0.0;
    var initialSata = 0.0;

    var somaRam = widget.pc.ramObj.fold(initialRam, (previousValue, element) => previousValue + element.preco);
    var somaNvme = widget.pc.nvmeObj.fold(initialNvme, (previousValue, element) => previousValue + element.preco);
    var somaSata = widget.pc.ssdObj.fold(initialSata, (previousValue, element) => previousValue + element.preco);

    widget.pc.preco = widget.pc.cpuObj.preco + widget.pc.placamaeObj.preco + somaRam + somaNvme + somaSata + widget.pc.gpuObj.preco + widget.pc.psuObj.preco + widget.pc.gabineteObj.preco;
    print('R\$ ${widget.pc.preco}');

  }

  _somarMemorias(){

    var initialRam = 0;
    var initialNvme = 0;
    var initialSata = 0;

    var somaRam = widget.pc.ramObj.fold(initialRam, (previousValue, element) => previousValue + element.capacidade);
    var somaNvme = widget.pc.nvmeObj.fold(initialNvme, (previousValue, element) => previousValue + element.capacidade);
    var somaSata = widget.pc.ssdObj.fold(initialSata, (previousValue, element) => previousValue + element.capacidade);

    widget.pc.ramArmazenamento = somaRam;
    widget.pc.ssdArmazenamento = somaNvme + somaSata;
    widget.pc.nvmeArmazenamento = somaNvme;

  }

  _setarAtributosPC(){

    widget.pc.cpu = widget.pc.cpuObj.modelo;
    widget.pc.placamae = widget.pc.placamaeObj.modelo;
    widget.pc.ram = widget.pc.ramObj[0].modelo;
    widget.pc.ramQuantidade = widget.pc.ramObj.length;
    widget.pc.nvme = widget.pc.nvmeObj[0].modelo;
    widget.pc.nvmeQuantidade = widget.pc.nvmeObj.length;
    widget.pc.ssd = widget.pc.ssdObj[0].modelo;
    widget.pc.ssdQuantidade = widget.pc.ssdObj.length;
    widget.pc.gpu= widget.pc.gpuObj.modelo;
    widget.pc.psu = widget.pc.psuObj.modelo;
    widget.pc.gabinete = widget.pc.gabineteObj.modelo;
    widget.pc.imagem = widget.pc.gabineteObj.imagem;
    widget.pc.cpuMarca = widget.pc.cpuObj.marca;
    widget.pc.gpuMarca = widget.pc.gpuObj.marca;

  }

  _recuperarDadosUsuario() async {
    if(user != null){
      DocumentSnapshot snapshot = await
      FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        usuario = Usuario.fromDocumentSnapshot(snapshot);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    widget.pc.criador = '';
    widget.pc.nome = 'PC${Timestamp.now().nanoseconds}#';
    widget.pc.benchamrk = widget.pc.cpuObj.benchmark + widget.pc.gpuObj.benchmark;
    _somarPreco();
    _somarMemorias();
    _setarAtributosPC();
    _recuperarDadosUsuario();
    print('CPU Benchmark: ${widget.pc.cpuObj.benchmark} | GPU Benchmark: ${widget.pc.gpuObj.benchmark}');
  }

  bool saved = false;

  Future<bool> showConfirmationDialog(bool exit) {
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Deseja sair?', style: TextStyle(color: Colors.white),),
          content: const Text('Você não salvou seu PC', style: TextStyle(color: Colors.white),),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
                exit == true ? Navigator.pop(context, true) : null;
              },
              child: const Text('Sair',)
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, false);
              },
              child: const Text('Ficar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    var _saveButton = IconButton(
      onPressed: (){
        User userA = FirebaseAuth.instance.currentUser;

        if(userA != null){
          widget.pc.criador = userA.uid;

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

          widget.pc.id = 'PC${Timestamp.now().millisecondsSinceEpoch.toString()}';

          FirebaseFirestore.instance.collection('users').doc(userA.uid)
          .collection('pc').doc(widget.pc.id)
          .set(widget.pc.toMap()).then((value){
            
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: const Text('Sucesso!'),
                  content: const Text('Seu PC foi salvo!'),
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

          }).catchError((e){
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: const Text('Oops!'),
                  content: Text('Não foi possível salvar seu PC.\n$e'),
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

        } else {

          Navigator.pushNamed(context, '/signin');

        }

      },
      icon: const Icon(Icons.save)
    );

    Widget saveButton(){
      if(user != null){
        if(user.uid != widget.pc.criador){
          return _saveButton;
        } else {
          return Container();
        }
      } else {
        return _saveButton;
      }
    }

    Widget saveAllButton(){
      if(user != null){
        if(usuario != null){
          if(usuario.adm == true){
            return IconButton(
              onPressed: (){
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

                FirebaseFirestore.instance.collection('pc').doc(widget.pc.nome).set(widget.pc.toMap())
                .then((value){
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Sucesso!'),
                        content: const Text('Este PC Foi salvo para todos na nuvem!'),
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
                }).catchError((e){
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Oops!'),
                        content: Text('Não foi possível salvar seu PC.\n$e'),
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
              },
              icon: const Icon(Icons.cloud_upload_outlined)
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    }

    return WillPopScope(
      onWillPop: () async {

        if(!saved){
          final confirmation = await showConfirmationDialog(false);
          return confirmation ?? false;
        }

        return true;

      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PC Montado'),
          centerTitle: true,
          leading: IconButton(
            onPressed: ()async{
              await showConfirmationDialog(true);
            },
            icon: const Icon(Icons.close_rounded, color: Colors.white,)
          ),
          actions: [
            saveAllButton(),
            saveButton(),
          ],
        ),
        body: Stack(
          children: [
            AnimatedOpacity(
              opacity: 0.1,
              duration: const Duration(seconds: 1),
              child: Image.network(
                widget.pc.gabineteObj.imagem,
                height: 1100,
                width: 1100,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    height: 230,
                    width: 230,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(10, 127, 30, 255),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 127, 30, 255),
                      ),
                      image: widget.pc.gabineteObj.imagem != null ?
                      DecorationImage(
                        image: NetworkImage(
                          widget.pc.gabineteObj.imagem
                        ),
                        fit: BoxFit.scaleDown,
                        scale: 3
                      ) : null,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('Nome', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                  GestureDetector(
                    onTap: (){

                      TextEditingController controllerNome = TextEditingController();
                      controllerNome.text = widget.pc.nome;

                      showDialog(
                        context: context,
                        builder: (context){
                          return SimpleDialog(
                            contentPadding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            title: Text('Nome do PC', style: GoogleFonts.abel(color: Colors.white,)),
                            children: [
                              TextField(
                                controller: controllerNome,
                                style: const TextStyle(color: Colors.white),
                                textCapitalization: TextCapitalization.words,
                                maxLength: 20,
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: (){

                                    if(controllerNome.text.isEmpty){
                                      Navigator.of(context).pop();
                                    } else {
                                      setState(() {
                                        widget.pc.nome = controllerNome.text;
                                      });
                                      Navigator.of(context).pop();
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
                      

                    },
                    child: Text(widget.pc.nome, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                  ),
                  Text(widget.pc.cpu, style: const TextStyle(color: Colors.white60), textAlign: TextAlign.center,),
                  widget.pc.gpuObj.marca == null ? Container():
                  Text(widget.pc.gpu, style: const TextStyle(color: Colors.white60), textAlign: TextAlign.center,),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text('Benchmark', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.speed_rounded, color: Colors.amberAccent, size: 40,),
                                const SizedBox(width: 10,),
                                Text(widget.pc.benchamrk.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.amberAccent),),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                          width: 50,
                          child: VerticalDivider(
                            color: Color.fromARGB(255, 207, 170, 255),
                          ),
                        ),
                        Column(
                          children: [
                            const Text('Preço estimado', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                            Text('R\$ ${widget.pc.preco.toStringAsFixed(1)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.greenAccent), textAlign: TextAlign.center,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('Capacidade', style: TextStyle(fontSize: 12), textAlign: TextAlign.start,),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/ram.svg', color: Colors.white, height: 40,),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('RAM', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                              Text('${widget.pc.ramArmazenamento}GB', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 40,),
                      Row(
                        children: [
                          SvgPicture.asset('assets/ssd.svg', color: Colors.white, height: 40,),
                          const SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Armazenamento', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                              Text('${widget.pc.ssdArmazenamento}GB', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('Hardware', style: TextStyle(fontSize: 12), textAlign: TextAlign.start,),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  HardwareList(widget.pc),
                  const SizedBox(height: 100,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}