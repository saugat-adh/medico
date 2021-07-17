import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewItem extends StatefulWidget {

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddNewItem> {

  final productName = TextEditingController();
  final productDescription = TextEditingController();
  final productQuantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Add Items', style: TextStyle(fontFamily: 'Times New Roman'),),
          elevation: 0,
          backgroundColor: Colors.teal,

        ),
        body: SafeArea(
          child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.04),
                    Text("Enter the details of your product", style: TextStyle(fontSize: 18),),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03),
                    _productName(),
                    _productDescription(),
                    _productQuantity(),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    _productImage(),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    _submit(),
                  ],
                ),
              ),
            ),
        ),
    );
  }


  _productName() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width - 5,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Text('Name', style: TextStyle(fontSize: 16),),
          new Flexible(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productName,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: "Enter the name of your product",
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }


  _productDescription(){
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width - 5,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Text('Description', style: TextStyle(fontSize: 16),),
          new Flexible(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productDescription,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: "Enter the description of your product",
                ),

              ),
            ),
          ),
        ],
      ),
    );

  }

  _productQuantity(){
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width - 5,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Text('Quantity', style: TextStyle(fontSize: 16),),
          new Flexible(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productQuantity,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: "Enter the quantity of your product",
                ),

              ),
            ),
          ),
        ],
      ),
    );

  }

  _productImage(){
    return  Container(
      color: Colors.teal,
      height: MediaQuery.of(context).size.width*0.3,
      child: Image(
        image: new AssetImage('images/upload.jpg'),
      ),
    );
  }

  _submit(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:[
        ElevatedButton(
          child: Text('Add' ,style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          onPressed: () {

          },
        ),

        ElevatedButton(
          child: Text('Cancel' ,style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          onPressed: () {

          },
        ),

      ]
    );
  }

}