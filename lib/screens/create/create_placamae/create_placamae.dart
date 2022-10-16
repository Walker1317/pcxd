import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/placamae.dart';
import 'package:pcxd_app/scripts/dropdown_menu_options.dart';

class CreatePlacaMae extends StatefulWidget {
  const CreatePlacaMae({ Key key }) : super(key: key);

  @override
  State<CreatePlacaMae> createState() => _CreatePlacaMaeState();
}

class _CreatePlacaMaeState extends State<CreatePlacaMae> {
  final _formKey = GlobalKey<FormState>();

  String _plataformaSelecionada;
  bool plataformaSelecionada;

  final TextEditingController _marca = TextEditingController();
  final TextEditingController _modelo = TextEditingController();
  final TextEditingController _tipoMemoria = TextEditingController();
  final TextEditingController _socket = TextEditingController();
  final TextEditingController _preco = TextEditingController();
  final TextEditingController _slotsRam = TextEditingController();
  final TextEditingController _nvmeSlots = TextEditingController();
  final TextEditingController _sata = TextEditingController();
  final TextEditingController _pcie16 = TextEditingController();

  _uploadplacamae(){
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

    Placamae placamae = Placamae();
    placamae.marca = _marca.text;
    placamae.modelo = _modelo.text;
    placamae.plataforma = _plataformaSelecionada;
    placamae.tipoMemoria = _tipoMemoria.text;
    placamae.socket = _socket.text;
    placamae.preco = double.parse(_preco.text);
    placamae.slotsRam = int.parse(_slotsRam.text);
    placamae.nvmeSlots = int.parse(_nvmeSlots.text);
    placamae.sata = int.parse(_sata.text);
    placamae.pcie16 = int.parse(_pcie16.text);

    FirebaseFirestore.instance.collection('placamae').doc(placamae.modelo)
    .set(placamae.toMap()).then((value){

      _marca.clear();
      _modelo.clear();
      _preco.clear();
      _tipoMemoria.clear();
      _socket.clear();
      _preco.clear();
      _slotsRam.clear();
      _nvmeSlots.clear();
      _sata.clear();
      _pcie16.clear();

      print('Placa Mãe upada com sucesso');
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
    _tipoMemoria.text = 'DDR';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar placamae'),
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
                  labelText: 'Plataforma'
                ),
                style: GoogleFonts.abel(color: Colors.white),
                dropdownColor: const Color.fromARGB(255, 66, 53, 109),
                value: _plataformaSelecionada,
                items: marcaList,
                onChanged: (valor){
                  setState(() {
                    plataformaSelecionada = false;
                    _plataformaSelecionada = valor;
                    plataformaSelecionada = true;
                  });
                },
                validator: (valor){
                  if (valor == null) {
                    return 'Selecione a Plataforma';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _marca,
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.words,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  hintText: 'Ex: Asus'
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
                controller: _tipoMemoria,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Memória',
                  hintText: 'Ex: DDR4'
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
                controller: _socket,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Socket',
                  hintText: 'Ex.: FCLGA1151'
                ),
                textCapitalization: TextCapitalization.characters,
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
                  hintText: 'Ex.: 1500'
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
                controller: _slotsRam,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Slots RAM',
                  hintText: 'Ex.: 4'
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
                controller: _nvmeSlots,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Slots NVME',
                  hintText: 'Ex.: 2'
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
                controller: _sata,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Satas',
                  hintText: 'Ex.: 4'
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
                controller: _pcie16,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'PCIe x16',
                  hintText: 'Ex: 2'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _uploadplacamae();
                    }
                  },
                  child: const Text('CRIAR PLACA MÃE')
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