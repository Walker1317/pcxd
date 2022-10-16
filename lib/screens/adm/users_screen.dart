import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:flutter/material.dart';
import 'package:pcxd_app/model/usuario.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  Query queryUser;

  _adicionarListenerUsers(){
    queryUser = FirebaseFirestore.instance.collection('users')
    //.orderBy("Date", descending: true)
    .withConverter<Usuario>(fromFirestore: (snapshot, _)=> Usuario.fromDocumentSnapshot(snapshot),
    );
  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerUsers();
  }

  @override
  Widget build(BuildContext context) {

    Widget usuarioBuild(Usuario usuario){
      bool vip = usuario.vip ?? false;
      bool adm = usuario.adm ?? false;

      _setBool(String title, bool value){
        FirebaseFirestore.instance.collection('users')
        .doc(usuario.id).update({
          title : value,
        }).then((_){
          print('$title setado para: $value');
        }).catchError((e){
          print('erro ao setar $title');
        });
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(usuario.username ?? 'Null Name'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(usuario.email, style: const TextStyle(color: Colors.white38),),
              Text(usuario.date ?? 'null date', style: const TextStyle(color: Colors.white38),),
            ],
          ),
          trailing: Wrap(
            children: [
              Column(
                children: [
                  const Text('ADM', style: TextStyle(fontSize: 12),),
                  Switch(
                    value: adm ?? false,
                    onChanged: (value){
                      if(adm == true){
                        _setBool('Adm', false);
                        setState(() {
                          adm = false;
                        });
                      } else {
                        _setBool('Adm', true);
                        setState(() {
                          adm = true;
                        });
                      }
                    }
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('VIP', style: TextStyle(fontSize: 12),),
                  Switch(
                    value: vip ?? false,
                    onChanged: (value){
                      if(vip == true){
                        _setBool('Vip', false);
                        setState(() {
                          vip = false;
                        });
                      } else {
                        _setBool('Vip', true);
                        setState(() {
                          vip = true;
                        });
                      }
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Manager'),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                  break;
                case ConnectionState.active:
                case ConnectionState.done:

                QuerySnapshot querySnapshot = snapshot.data;

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(querySnapshot.docs.length.toString(), style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );

              }
              return Container();
              
            })
          ),
        ],
      ),
      body: FirestoreAnimatedList(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        physics: const BouncingScrollPhysics(),
        query: queryUser,
        itemBuilder: (context, snapshot, animation, index){
          final usuario = snapshot.data();
          return usuarioBuild(usuario);
        }
      ),
    );
  }
}