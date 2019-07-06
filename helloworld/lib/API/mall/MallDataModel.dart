class MallDataModel{
  String brandName;
  String logo;  
  int total;
  List<MallDataRpcModel> rpc;
  List<MallDataRspModel> rspInfo;

  MallDataModel(this.brandName, this.logo, this.total, this.rpc, this.rspInfo);

  factory MallDataModel.fromJson(Map map){

      List<MallDataRspModel> rspInfo =  map["rspInfo"].map<MallDataRspModel>(((map) => MallDataRspModel.fromJson(map))).toList();
      List<MallDataRpcModel> rpc = List<MallDataRpcModel>();
      if(map.containsKey("rpc")){
        rpc =  map["rpc"].map<MallDataRpcModel>(((map) => MallDataRpcModel.fromJson(map))).toList();
      } 
      return MallDataModel(map["brandName"], map["logo"], map["total"],rpc, rspInfo);
    }

}

class MallDataRspModel{
  String belongsId;
  String name;
  String imagePath;
  String subtitle;
  String salesPrice;   

  MallDataRspModel(this.belongsId, this.name, this.imagePath, this.subtitle, this.salesPrice);

  factory MallDataRspModel.fromJson(Map map){
    return MallDataRspModel(map["belongsId"],map["name"],map["imagePath"],map["subtitle"],map["salesPrice"]);
  }
}

class MallDataRpcModel{
  String id;
  String name; 

  MallDataRpcModel(this.id, this.name);

  factory MallDataRpcModel.fromJson(Map map){
    return MallDataRpcModel(map["id"],map["name"]);
  }
}