import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  String userName= "";
  void showBottomSheet(BuildContext context){
    Scaffold.of(context).showBottomSheet((context) => Container(
      child: Text('hello'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
  child: SingleChildScrollView(
    child: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            color: primaryColor,
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.popAndPushNamed(context, '/profile');
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      child: Image.asset('images/images.jpg'),
                    ),
                  ),
                  Text(userName,style: TextStyle(color: Colors.white,fontSize: 13))

                ],
              ),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/profile');
            },
            leading: Icon(Icons.person,size:30 ),
            title: Text('Profile Details',style: TextStyle(fontSize: 14),),
          ),

          ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/vacations');
            },
            leading: Image.asset('images/vacations.png'),
            title: Text('My Vacations',style: TextStyle(fontSize: 14),),
          ),
          ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/resorts_screen');
            },
            leading: Image.asset('images/resort.png'),
            title: Text('Associated Resorts',style: TextStyle(fontSize: 14),),
          ),
          ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/gallery_screen');
            },
            leading: Icon(Icons.image,size:32),
            title: Text('Gallery',style: TextStyle(fontSize: 14),),
          ), ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/amc_screen');
            },
            leading: Image.asset('images/contract.png'),
            title: Text('AMC',style: TextStyle(fontSize: 14),),
          ),
          ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/book_holiday');
            },
            leading: Image.asset('images/vacations.png'),
            title: Text('Book a holiday',style: TextStyle(fontSize: 14),),
          ),ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/events');
            },
            leading: Image.asset('images/calendar.png'),
            title: Text('Events',style: TextStyle(fontSize: 14),),
          ),
          ListTile(
            leading: Icon(Icons.share,size:30),
            title: Text('Refer a friend',style: TextStyle(fontSize: 14),),
          ),
          ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context,'/change_password');
            },
            leading: Icon(Icons.lock,size:30),
            title: Text('Change Password',style: TextStyle(fontSize: 14),),
          ),
          ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/contact_us');
            },
            leading: Icon(Icons.contact_phone,size:30),
            title: Text('Contact Us',style: TextStyle(fontSize: 14),),
          ),ListTile(
            onTap: (){
              Navigator.popAndPushNamed(context, '/about_us');
            },
            leading: Icon(Icons.info,size:30),
            title: Text('About Us',style: TextStyle(fontSize: 14),),
          ),
          ListTile(
            leading: Image.asset('images/logout.png'),
            title: Text('LogOut',style: TextStyle(fontSize: 14),),
            onTap: (){
              //showBottomSheet(context);
              showDialog<void>(
                  context: context,
                  // false = user must tap button, true = tap outside dialog
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Log-Out'),
                      content: Text('Are you sure you want to log-out of app?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(dialogContext)
                                .pop(); // Dismiss alert dialog
                          },
                        ),
                        FlatButton(
                          child: Text('Yes'),
                          onPressed: () {
                            logOutUser(context);
                            Navigator.of(dialogContext)
                                .pop();
                          },
                        )
                      ],
                    );
                  },
                );
              },
          )
        ],
    ),
  ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  void getUserName() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName= sharedPreferences.getString("userName");
    });
  }

}

void logOutUser(BuildContext context) async{
  Navigator.pushNamedAndRemoveUntil(context, "/login_screen", (r) => false);
  SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  sharedPreferences.clear();
}

