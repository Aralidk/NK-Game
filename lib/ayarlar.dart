import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MaterialApp(
    home: ayarlar(),
  ));
}

final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]
);

class ayarlar extends StatefulWidget {
  const ayarlar({Key? key}) : super(key: key);

  @override
  _ayarlarState createState() => _ayarlarState();
}

class _ayarlarState extends State<ayarlar> {

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0x476E87CB),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 150),

        height: screenSize.height/2,
        alignment: Alignment.center,
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget(){
    GoogleSignInAccount? user = _currentUser;
    if(user != null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(2, 12, 2, 12),
        child: Column(
          children: [
            ListTile(
              leading: GoogleUserCircleAvatar(identity: user),
              title:  Text(user.displayName ?? '', style: TextStyle(fontSize: 22),),
              subtitle: Text(user.email, style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 20,),
            const Text(
              'Başarıyla Giriş Yapıldı',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: signOut,
                child: const Text('Çıkış Yap')
            )
          ],
        ),
      );
    }else{
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Giriş Yapmadınız',
              style: TextStyle(fontSize: 30,
                 color: Colors.white),),
            const SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0x476E87CB))
              ),
                onPressed: signIn,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Giriş Yap', style: TextStyle(fontSize: 30,
                      color: Colors.white)
                  )),
                ),
          ],
        ),
      );
    }
  }

  void signOut(){
    _googleSignIn.disconnect();
  }

  Future<void> signIn() async {
    try{
      await _googleSignIn.signIn();
    }catch (e){
      print('Error signing in $e');
    }
  }

}
