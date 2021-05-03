part of 'pages.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlDesc = TextEditingController();
  final ctrlPrice = TextEditingController();

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseFile(String type) async {
    ImageSource imgSrc;
    if (type == "camera") {
      imgSrc = ImageSource.camera;
    } else {
      imgSrc = ImageSource.gallery;
    }
    final selectedImage = await imagePicker.getImage(
      source: imgSrc,
      imageQuality: 50,
    );
    setState(() {
      imageFile = selectedImage;
    });
  }

  void showFileDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
              title: Text("Confirmation"),
              content: Text("Pick image from:"),
              actions: [
                ElevatedButton.icon(
                  onPressed: () {
                    chooseFile("camera");
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                  style: ElevatedButton.styleFrom(elevation: 0),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    chooseFile("gallery");
                  },
                  icon: Icon(Icons.folder_outlined),
                  label: Text("Gallery"),
                  style: ElevatedButton.styleFrom(elevation: 0),
                ),
              ]);
        });
  }

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlDesc.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlDesc.clear();
    ctrlPrice.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Data"),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.all(24),
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: ctrlName,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Product Name",
                              prefixIcon: Icon(Icons.label),
                              border: OutlineInputBorder(),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please fill in the field!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: ctrlDesc,
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: "Product Description",
                              prefixIcon: Icon(Icons.description),
                              border: OutlineInputBorder(),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please fill in the field!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: ctrlPrice,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Product Price",
                              prefixIcon: Icon(Icons.label),
                              border: OutlineInputBorder(),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please fill in the field!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          imageFile == null
                              ? Row(
                                  children: [
                                    ElevatedButton.icon(
                                        onPressed: () {
                                          showFileDialog(context);
                                        },
                                        icon: Icon(Icons.photo_camera),
                                        label: Text("Ambil Foto")),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text("File tidak ditemukan.")
                                  ],
                                )
                              : Row(
                                  children: [
                                    ElevatedButton.icon(
                                        onPressed: () {
                                          showFileDialog(context);
                                        },
                                        icon: Icon(Icons.photo_camera),
                                        label: Text("Ulangi Foto")),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Semantics(
                                        child: Image.file(
                                      File(imageFile.path),
                                      width: 100,
                                    ))
                                  ],
                                ),
                          SizedBox(
                            height: 40,
                          ),
                          ElevatedButton.icon(
                              onPressed: () async {
                                if (_formKey.currentState.validate() &&
                                    imageFile != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Products products = Products(
                                      "",
                                      ctrlName.text,
                                      ctrlDesc.text,
                                      ctrlPrice.text,
                                      "",
                                      FirebaseAuth.instance.currentUser.uid,
                                      "",
                                      "");
                                  await ProductServices.addProduct(
                                          products, imageFile)
                                      .then((value) {
                                    if (value == true) {
                                      ActivityServices.showToast(
                                          "Add product successful",
                                          Colors.green);
                                      clearForm();
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      ActivityServices.showToast(
                                          "Failed to add product!", Colors.red);
                                    }
                                  });
                                } else {
                                  ActivityServices.showToast(
                                      "PLease fill in all fields!", Colors.red);
                                }
                              },
                              icon: Icon(Icons.save),
                              label: Text("Save Product"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple[400],
                                  elevation: 0)),
                        ],
                      ),
                    )
                  ],
                ),
                isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}
