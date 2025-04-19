import 'package:flutter/material.dart';

import '../Screens/MainScreen.dart';



class SellerBookForm extends StatefulWidget {
  static const String id = 'form';

  @override
  State<SellerBookForm> createState() => _SellerBookFormState();
}

class _SellerBookFormState extends State<SellerBookForm> {
  final _formKey = GlobalKey<FormState>();


  var _brandController = TextEditingController();
  var _bookNameController = TextEditingController();
  var _yearController = TextEditingController();
  var _priceController = TextEditingController();
  var _storeController = TextEditingController();
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _addressController = TextEditingController();



  validate(){
    if(_formKey.currentState!.validate()) {
      print('Validate');



    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete required fields..'),),

      );
    }
  }

  List<String> _StoreList = [
    'Student','Teacher','Book Store','indivisual'
  ];



  @override
  Widget build(BuildContext context) {



    Widget _appBar(title,fieldValue){
      return  AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300),),
        title: Text('$title > $fieldValue',style: TextStyle(color: Colors.black,fontSize: 15),),
      );
    }

    Widget _brandList(){
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            //need to use this for so many times, so lets create another appBar

            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,

                  itemBuilder: (BuildContext context,int index){
                    return ListTile(
                      onTap: (){
                        setState(() {

                        });
                        Navigator.pop(context);
                      },


                    );
                  }),
            ),
          ],
        ),
      );
    }

    Widget _listView(fieldValue, {required List<String> list ,textController}){
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context,int index){

                  return ListTile(
                    onTap: (){
                      textController.text = list[index];
                      Navigator.pop(context);
                    },
                    title: Text(list[index]),
                  );
                })
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text('Healthhive Details!',style: TextStyle(color: Colors.black),),
        shape: Border(
            bottom: BorderSide(color: Colors.grey.shade300)
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Personal Details',style: TextStyle(fontWeight: FontWeight.bold),),

                  TextFormField(
                    autofocus: false,
                    controller: _bookNameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name*',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: _titleController,
                    maxLength: 80,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Adhar Number',
                        hintText: 'Addhar Number'
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(
                      labelText: ' Requirement!',
                      hintText: 'Enter Your requirement!',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: _priceController,
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    decoration: InputDecoration(
                        labelText: 'Your Post',
                        hintText: 'Current position'
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (BuildContext context){
                        return _listView('programming Language',list: _StoreList,textController: _StoreList);
                      });
                    },
                    child: TextFormField(
                      enabled: true,
                      controller: _storeController,
                      decoration: InputDecoration(
                        labelText: 'Field Expertise',
                        hintText: "NGO/Hospital",
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please complete required field';
                        }
                        return null;
                      },
                    ),
                  ),//unable to access it from list

                  TextFormField(
                    autofocus: false,
                    controller: _descriptionController,
                    maxLength: 5000,
                    decoration: InputDecoration(
                      labelText: 'Your Details',
                      hintText: 'Describe About Your Self',
                      // counterText: 'Include condition,feature and reason for selling'
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  //Divider(color: Colors.cyan,thickness: 5,),

                  TextFormField(
                    enabled: true,
                    controller: _addressController,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                        labelText: 'Address*',
                        counterText: 'Your Address'
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },
                  ),
                  Divider(color: Colors.cyan,thickness: 2,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, MainScreen.id);
                    },
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan,
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
