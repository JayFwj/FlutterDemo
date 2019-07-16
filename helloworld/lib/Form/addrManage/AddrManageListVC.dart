import 'package:Flutter/Form/addrManage/AddrModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddrManageListVC extends StatefulWidget{

  BasicAddressModel lastSelectedAddrModel;

  @override
  State<StatefulWidget> createState() {
    
    // TODO: implement createState
    return _AddrManageListVCState();
  }
}

class _AddrManageListVCState extends State<AddrManageListVC>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    if(this.widget.lastSelectedAddrModel == null){
      widget.lastSelectedAddrModel = ModalRoute.of(context).settings.arguments;
    }
    
    return Scaffold(
      appBar: AppBar(title: Text("地址管理"),),
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (context,index){
          return ListTile(
            title: Text("data"),
            onTap: (){

              BasicAddressModel model = BasicAddressModel("Jay", "深圳市南山区桃园路33号", "13409889092", false);
              
              Navigator.pop(context,model);
            },
          );
        },

      ),

    );
  }
}