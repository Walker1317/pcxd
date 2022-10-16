import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/gpu.dart';
import 'package:pcxd_app/scripts/dropdown_menu_options.dart';

class CreateGpu extends StatefulWidget {
  const CreateGpu({ Key key }) : super(key: key);

  @override
  State<CreateGpu> createState() => _CreateGpuState();
}

class _CreateGpuState extends State<CreateGpu> {
  final _formKey = GlobalKey<FormState>();

  String _marcaSelecionada;
  bool marcaSelecionada;

  String _tipoSelecionado;
  bool tipoSelecionado;

  final TextEditingController _modelo = TextEditingController();
  final TextEditingController _interface = TextEditingController();
  final TextEditingController _coreClock = TextEditingController();
  final TextEditingController _preco = TextEditingController();
  final TextEditingController _memoryClock = TextEditingController();
  final TextEditingController _memory = TextEditingController();
  final TextEditingController _openGl = TextEditingController();
  final TextEditingController _g2g = TextEditingController();
  final TextEditingController _ano = TextEditingController();
  final TextEditingController _energia = TextEditingController();
  final TextEditingController _benchmark = TextEditingController();

  _uploadGPU(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
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

    GPU gpu = GPU();
    gpu.marca = _marcaSelecionada;
    gpu.modelo = _modelo.text;
    gpu.interface = _interface.text;
    gpu.preco = double.parse(_preco.text);
    gpu.tipo = _tipoSelecionado;
    gpu.coreClock = int.parse(_coreClock.text);
    gpu.memoryClock = int.parse(_memoryClock.text);
    gpu.memory = int.parse(_memory.text);
    gpu.openGL = double.parse(_openGl.text);
    gpu.ano = int.parse(_ano.text);
    gpu.g2g = int.parse(_g2g.text);
    gpu.energia = int.parse(_energia.text);
    gpu.benchmark = int.parse(_benchmark.text);

    FirebaseFirestore.instance.collection('gpu').doc(gpu.modelo)
    .set(gpu.toMap()).then((value){

      _modelo.clear();
      _memory.clear();
      _preco.clear();
      _memoryClock.clear();
      _g2g.clear();
      _coreClock.clear();
      _interface.clear();
      _ano.clear();
      _energia.clear();
      _benchmark.clear();
      _openGl.clear();

      print('Placa de vídeo upada com sucesso');
      Navigator.of(context).pop();

    }).catchError((e){

      Navigator.of(context).pop();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            title: Text('Oops!', style: GoogleFonts.abel(color: Colors.white),),
            content: Text('Não foi possível fazer o upload:', style: GoogleFonts.abel(color: Colors.white),),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: const Text('OK')
              )
            ],
          );
        }
      );

    });

  }

  @override
  void initState() {
    super.initState();
    _interface.text = 'PCIe ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar GPU'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Marca'
                ),
                style: GoogleFonts.abel(color: Colors.white),
                dropdownColor: const Color.fromARGB(255, 66, 53, 109),
                value: _marcaSelecionada,
                items: marcaGpuList,
                onChanged: (valor){
                  setState(() {
                    marcaSelecionada = false;
                    _marcaSelecionada = valor;
                    marcaSelecionada = true;
                  });
                },
                validator: (valor){
                  if (valor == null) {
                    return 'Selecione a Marca';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10,),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Tipo'
                ),
                style: GoogleFonts.abel(color: Colors.white),
                dropdownColor: const Color.fromARGB(255, 66, 53, 109),
                value: _tipoSelecionado,
                items: tipoList,
                onChanged: (valor){
                  setState(() {
                    tipoSelecionado = false;
                    _tipoSelecionado = valor;
                    tipoSelecionado = true;
                  });
                },
                validator: (valor){
                  if (valor == null) {
                    return 'Selecione a Marca';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _modelo,
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.words,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  hintText: 'Ex: I5 / Ryzen'
                ),
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _interface,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Bus Interface',
                  hintText: 'Ex: PCIe 3.0 x16'
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _coreClock,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Core Clock',
                  hintText: '1500'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _memoryClock,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Memory Clock',
                  hintText: '1500'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _memory,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Memory',
                  hintText: '2000'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _openGl,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'OpenGL',
                  hintText: '4.6'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _energia,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Energia',
                  hintText: '200'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _g2g,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'G2G Rating',
                  hintText: 'Ex: 900'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _ano,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Ano',
                  hintText: '2015'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _preco,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Preco',
                  hintText: '2000'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              const Text(' Benchmarks'),
              const Divider(),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _benchmark,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Benchmark',
                  hintText: '2000'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _uploadGPU();
                    }
                  },
                  child: const Text('CRIAR CPU')
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}