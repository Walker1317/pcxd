import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/cpu.dart';
import 'package:pcxd_app/model/pc/gabinete.dart';
import 'package:pcxd_app/model/pc/gpu.dart';
import 'package:pcxd_app/model/pc/nvme.dart';
import 'package:pcxd_app/model/pc/pc.dart';
import 'package:pcxd_app/model/pc/placamae.dart';
import 'package:pcxd_app/model/pc/psu.dart';
import 'package:pcxd_app/model/pc/ram.dart';
import 'package:pcxd_app/model/pc/ssd.dart';
import 'package:pcxd_app/model/usuario.dart';
import 'package:pcxd_app/screens/montar_setup/pc/widgets/hardware_list.dart';

class PcScreen extends StatefulWidget {
  PcScreen(this.pc);
  PC pc;

  @override
  State<PcScreen> createState() => _PcScreenState();
}

class _PcScreenState extends State<PcScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  Usuario usuario;

  _recuperarObjetos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshotCpu = await db.collection('cpu').doc(widget.pc.cpu).get();
    setState(() {
      try{
        widget.pc.cpuObj = CPU.fromDocumentSnapshot(snapshotCpu);
      }catch(e){}
    });

    DocumentSnapshot snapshotPlacamae = await db.collection('placamae').doc(widget.pc.placamae).get();
    setState(() {
      try{
        widget.pc.placamaeObj = Placamae.fromDocumentSnapshot(snapshotPlacamae);
      }catch(e){};
      
    });

    DocumentSnapshot snapshotRam = await db.collection('ram').doc(widget.pc.ram).get();
    setState(() {
      widget.pc.ramObj = [];
      widget.pc.ramObj.add(RAM());
      widget.pc.ramObj[0];
      widget.pc.ramObj[0].capacidade = 0;
      widget.pc.ramObj[0].marca = 'Marca';
      widget.pc.ramObj[0].modelo = 'Modelo';
      widget.pc.ramObj[0].preco = 0;
      widget.pc.ramObj[0].tipo = 'DDR';
      widget.pc.ramObj[0].velocidade = 0;
      try{
        widget.pc.ramObj[0] = RAM.fromDocumentSnapshot(snapshotRam);
      }catch(e){
      };
      
    });

    DocumentSnapshot snapshotNvme = await db.collection('nvme').doc(widget.pc.nvme).get();
    setState(() {
      widget.pc.nvmeObj = [];
      widget.pc.nvmeObj.add(NVME());
      widget.pc.nvmeObj[0];
      widget.pc.nvmeObj[0].capacidade = 0;
      widget.pc.nvmeObj[0].marca = 'Marca';
      widget.pc.nvmeObj[0].modelo = 'Modelo';
      widget.pc.nvmeObj[0].preco = 0;
      try{
        widget.pc.nvmeObj[0] = NVME.fromDocumentSnapshot(snapshotNvme);
      }catch(e){
      };
    });

    DocumentSnapshot snapshotSsd = await db.collection('ssd').doc(widget.pc.ssd).get();
    setState(() {
      widget.pc.ssdObj = [];
      widget.pc.ssdObj.add(SSD());
      widget.pc.ssdObj[0];
      widget.pc.ssdObj[0].capacidade = 0;
      widget.pc.ssdObj[0].marca = 'Marca';
      widget.pc.ssdObj[0].modelo = 'Modelo';
      widget.pc.ssdObj[0].preco = 0;
      try{
        widget.pc.ssdObj[0] = SSD.fromDocumentSnapshot(snapshotSsd);
      }catch(e){};
    });

    if(widget.pc.gpu != null){
      DocumentSnapshot snapshotGpu = await db.collection('gpu').doc(widget.pc.gpu).get();
      setState(() {
        try{
          widget.pc.gpuObj = GPU.fromDocumentSnapshot(snapshotGpu);
        }catch(e){};
      });
    }

    DocumentSnapshot snapshotPsu = await db.collection('psu').doc(widget.pc.psu).get();
    setState(() {
      try{
        widget.pc.psuObj = PSU.fromDocumentSnapshot(snapshotPsu);
      }catch(e){};
    });

    DocumentSnapshot snapshotGabinete = await db.collection('gabinete').doc(widget.pc.gabinete).get();
    setState(() {
      try{
        widget.pc.gabineteObj = Gabinete.fromDocumentSnapshot(snapshotGabinete);
      }catch(e){};
    });

  }

  @override
  void initState() {
    super.initState();
    _recuperarObjetos();
  }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    Widget _botaoExcluir(){
      var button = IconButton(
        onPressed: (){

          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Deseja excluir?', style: TextStyle(color: Colors.white),),
                content: const Text('Não será possível recuperar, ao menos que monte outro parecido.', style: TextStyle(color: Colors.white),),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                      FirebaseFirestore.instance.collection('users')
                      .doc(user.uid).collection('pc').doc(widget.pc.nome).delete().then((value){
                        Navigator.of(context).pop();
                      }).catchError((e){
                        Navigator.of(context).pop();
                      });

                    },
                    child: const Text('Excluir', style: TextStyle(color: Colors.red))
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
        icon: const Icon(Icons.delete_forever_rounded),
      );

      
      if(user != null){

        if(user.uid == widget.pc.criador){
          return button;
        } else {
          return Container();
        }

      } else {
        return Container();
      }

    }

    Widget _saveButton(){
      return IconButton(
        onPressed: () async {

          _salvarPC(){
            widget.pc.criador = user.uid;
            FirebaseFirestore.instance.collection('users')
            .doc(user.uid).collection('pc').doc(widget.pc.nome).set(widget.pc.toMap())
            .then((value){
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
                    content: const Text('Tivemos um problema ao salvar seu pc.'),
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
            });
          }

          if(user != null){

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

            DocumentSnapshot documentSnapshot = await FirebaseFirestore
            .instance.collection('users').doc(user.uid).collection('pc')
            .doc(widget.pc.nome).get();

            PC currentPC;
            
            try{
              currentPC = PC.fromDocumentSnapshot(documentSnapshot);
            } catch (e){print(e);}

            if(currentPC != null){
              
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: const Text('Oops!'),
                    content: const Text('Parece que você ja tem esse pc salvo.'),
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
              int pcLenght;
              DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
              usuario = Usuario.fromDocumentSnapshot(documentSnapshot);

              await FirebaseFirestore.instance.collection('users')
              .doc(user.uid).collection('pc').get().then((value){
                pcLenght = value.docs.length;
              });
              
              if(pcLenght >= 2){
                if(usuario.vip == true){
                  _salvarPC();
                } else {

                  Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: const Text('Oops!'),
                          content: const Text('Você atingiu o limite máximo de PC\'s salvos, libere espaço ou assine o plano VIP.'),
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
                  
                }
              } else {
                _salvarPC();
              }
            }

          } else {

            Navigator.pushNamed(context, '/signin');

          }

        },
        icon: const Icon(Icons.save_outlined),
      );

    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PC Montado'),
        centerTitle: true,
        leading: IconButton(
          onPressed: ()=> Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded, color: Colors.white,)
        ),
        actions: [
          _botaoExcluir(),
          _saveButton(),
        ],
      ),
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: 0.1,
            duration: const Duration(seconds: 1),
            child: Image.network(
              widget.pc.imagem,
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
                    image: widget.pc.imagem != null ?
                    DecorationImage(
                      image: NetworkImage(
                        widget.pc.imagem
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

                    /*User user = FirebaseAuth.instance.currentUser;
                    if(user != null){

                      if(user.uid == widget.pc.criador){
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
                      }

                    }*/
                    

                  },
                  child: Text(widget.pc.nome, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                ),
                Text(widget.pc.cpu, style: const TextStyle(color: Colors.white60), textAlign: TextAlign.center,),
                widget.pc.gpu == null ? Container(): Text(widget.pc.gpu, style: const TextStyle(color: Colors.white60), textAlign: TextAlign.center,),
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
    );
  }
}