import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './Home/HomeModel.dart';

class HKAPI{

  static HKAPI shaderInstance = HKAPI();
 
  static const String httpMainAddr = "https://www.fuwuniao.com:28000/hk/";

  static const String homeBannerUrl = httpMainAddr + "bd/api/banner/list";

  static const String homeBrandUrl = httpMainAddr + "sbm/api/recomment/find_recomment_brand?page=1&pageSize=50";

  Future<List<HomeBanner>> homeBanner() async{  
    var response = await http.get(homeBannerUrl);
        if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var result = jsonResponse['data']; 
        var tempList = result
            .map<HomeBanner>((json) => HomeBanner.fromJson(json)).toList();
            // .toList();
         return tempList;
      } else {
        print("Request failed with status: ${response.statusCode}.");
        return List();
      }
  } 
  
   Future<HomeBrandData> homeBrand() async{  
    var response = await http.get(homeBrandUrl);
        if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var result = jsonResponse['data'];
        var tempList = HomeBrandData.fromJson(result);
         
         return tempList;
      } else {
        print("Request failed with status: ${response.statusCode}.");
        return null;
      }
  }    







}
 