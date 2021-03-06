part of 'widgets.dart';

class ProductCard extends StatefulWidget {
  final Products products;
  ProductCard({this.products});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    Products product = widget.products;
    if (product == null) {
      return Container();
    } else {
      return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 24.0,
              backgroundImage: NetworkImage(product.productImage),
            ),
            title: Text(
              product.productName,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              maxLines: 1,
              softWrap: true,
            ),
            subtitle: Text(
              ActivityServices.toIDR(product.productPrice),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
              maxLines: 1,
              softWrap: true,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.ellipsis_circle_fill,
                    color: Colors.orangeAccent,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext ctx) {
                          return Container(
                            width: double.infinity,
                            height: 220,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.eye_fill),
                                      label: Text("Show Data"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green)),
                                  ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                          CupertinoIcons.pencil_circle_fill),
                                      label: Text("Edit Data")),
                                  ElevatedButton.icon(
                                      onPressed: () async {
                                        bool result = await ProductServices.deleteProduct(product.productId);
                                        if(result){
                                          ActivityServices.showToast("Delete Data Success",
                                          Colors.green);
                                        }else{
                                          ActivityServices.showToast("Delete Data Success",
                                          Colors.red);
                                        }
                                      },
                                      icon: Icon(
                                          CupertinoIcons.trash_circle_fill),
                                      label: Text("Delete Data"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red))
                                ]),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
