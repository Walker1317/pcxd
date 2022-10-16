import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/cpu.dart';
import 'package:pcxd_app/scripts/dropdown_menu_options.dart';

class CreateCpu extends StatefulWidget {
  const CreateCpu({ Key key }) : super(key: key);

  @override
  State<CreateCpu> createState() => _CreateCpuState();
}

class _CreateCpuState extends State<CreateCpu> {
  final _formKey = GlobalKey<FormState>();

  String _marcaSelecionada;
  bool marcaSelecionada;

  String _tipoSelecionado;
  bool tipoSelecionado;

  final TextEditingController _modelo = TextEditingController();
  final TextEditingController _socket = TextEditingController();
  final TextEditingController _preco = TextEditingController();
  final TextEditingController _clock = TextEditingController();
  final TextEditingController _turboClock = TextEditingController();
  final TextEditingController _cores = TextEditingController();
  final TextEditingController _threads = TextEditingController();
  final TextEditingController _ano = TextEditingController();
  final TextEditingController _energia = TextEditingController();
  final TextEditingController _benchmark = TextEditingController();
  final TextEditingController _singleThreading = TextEditingController();

  _uploadCPU(){
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

    CPU cpu = CPU();
    cpu.marca = _marcaSelecionada;
    cpu.modelo = _modelo.text;
    cpu.socket = _socket.text;
    cpu.preco = double.parse(_preco.text);
    cpu.tipo = _tipoSelecionado;
    cpu.clock = double.parse(_clock.text);
    cpu.turboClock = double.parse(_turboClock.text);
    cpu.cores = int.parse(_cores.text);
    cpu.threads = int.parse(_threads.text);
    cpu.ano = int.parse(_ano.text);
    cpu.energia = int.parse(_energia.text);
    cpu.benchmark = int.parse(_benchmark.text);
    cpu.singleThreadRating = int.parse(_singleThreading.text);

    FirebaseFirestore.instance.collection('cpu').doc(cpu.modelo)
    .set(cpu.toMap()).then((value){

      _modelo.clear();
      _socket.clear();
      _preco.clear();
      _clock.clear();
      _turboClock.clear();
      _cores.clear();
      _threads.clear();
      _ano.clear();
      _energia.clear();
      _benchmark.clear();
      _singleThreading.clear();

      print('Processador upado com sucesso');
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar CPU'),
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
                items: marcaList,
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
                controller: _socket,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Socket',
                  hintText: 'Ex: LGA1150'
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
                controller: _preco,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  hintText: '550,00'
                ),
                keyboardType: TextInputType.number,
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
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _clock,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Clock',
                  hintText: '3.5'
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
                controller: _turboClock,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Turbo Clock',
                  hintText: '3.9'
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
                controller: _cores,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Cores',
                  hintText: '4'
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
                controller: _threads,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Threads',
                  hintText: '2'
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
              TextFormField(
                validator: (text){
                  if(text.isEmpty){
                    return 'Digite este campo';
                  } else {
                    return null;
                  }
                },
                controller: _singleThreading,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Single Thread Rating',
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
                      _uploadCPU();
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