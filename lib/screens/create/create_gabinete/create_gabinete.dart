import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcxd_app/model/pc/gabinete.dart';

class CreateGabinete extends StatefulWidget {
  const CreateGabinete({ Key key }) : super(key: key);

  @override
  State<CreateGabinete> createState() => _CreateGabineteState();
}

class _CreateGabineteState extends State<CreateGabinete> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _marca = TextEditingController();
  final TextEditingController _modelo = TextEditingController();
  final TextEditingController _preco = TextEditingController();

  _uploadgabinete(){
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

    Gabinete gabinete = Gabinete();
    gabinete.marca = _marca.text;
    gabinete.modelo = _modelo.text;
    gabinete.preco = double.parse(_preco.text);

    FirebaseFirestore.instance.collection('gabinete').doc(gabinete.modelo)
    .set(gabinete.toMap()).then((value){

      _marca.clear();
      _modelo.clear();
      _preco.clear();

      print('gabinete upada com sucesso');
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar gabinete'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _marca,
                cursorColor: Colors.white,
                textCapitalization: TextCapitalization.words,
                style: GoogleFonts.abel(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  hintText: 'Ex: Corsair'
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
                controller: _modelo,
                cursorColor: Colors.white,
                style: GoogleFonts.abel(color: Colors.white),
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  hintText: 'Ex: VS500'
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
                  hintText: 'Ex.: 299'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _uploadgabinete();
                    }
                  },
                  child: const Text('CRIAR Gabinete')
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