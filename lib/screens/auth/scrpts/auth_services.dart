import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pcxd_app/model/usuario.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  User user;
  String result;

  Future signUpWithEmail(Usuario usuario) async{

    try {

      await auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.password,
      ).then((_) async{
        
        user = auth.currentUser;
        usuario.username = '#${Timestamp.now().millisecondsSinceEpoch.toString()}';
        usuario.adm = false;
        usuario.vip = false;
        usuario.id = user.uid;
        usuario.date = DateTime.now().toString();
        db.collection('users').doc(user.uid).set(usuario.toMap()).then((value) => null).catchError((e)=> null);

        await user.sendEmailVerification();
        auth.signOut();
        result = 'succeful';
        return result;

      });

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          result = "Este email ja está sendo usado.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          result = "Erro no servidor, tente novamente mais tarde.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          result = "Email inválido";
          break;
        default:
          result = "Erro ao fazer login, por favor tente novamente.";
          break;
      }

      return result;

    }
  }

  Future signInWithEmail(Usuario usuario) async{

    try {

      await auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.password,
      ).then((_)async {
        
        user = auth.currentUser;
        if(user.emailVerified != true){
          result = 'succeful';
          return result;
        } else {
          await _verifyUserData(usuario);
          result = 'succeful';
          return result;
        }
      });

    } on FirebaseAuthException catch (e) {

      switch (e.code) {
        case "email-already-in-use":
          result = "Este email ja está sendo usado.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          result = "Senha inválida";
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          result = "Não achamos nenhum usuário com esse email.";
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          result = "Usuário desabilitado.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          result = "Muitas solicitações para fazer login nesta conta.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          result = "Erro no servidor, tente novamente mais tarde.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          result = "Email inválido";
          break;
        default:
          result = "$e";
          break;
      }
    }
  }

  Future _verifyUserData(Usuario usuario) async{

    DocumentSnapshot documentSnapshot = await db.collection('users').doc(user.uid).get();
    Usuario usuarioM = Usuario.fromDocumentSnapshot(documentSnapshot);

    if(usuarioM.username != null){
      
      print('Dados de usuário autenticados');

    } else {
      usuario.username = '#${Timestamp.now().millisecondsSinceEpoch.toString()}';
      usuario.adm = false;
      usuario.vip = false;
      usuario.id = user.uid;
      await _uploadUserData(usuario);
    }

  }

  _uploadUserData(Usuario usuario){
    usuario.date = DateTime.now().toString();

    db.collection('users').doc(user.uid).update(usuario.toMap())
    .then((value){
      print('dados do usuario upados');
    }).catchError((e){
      print('erro ao upar dados do usuario: $e');
    });

  }

}