import 'package:easy_localization/easy_localization_provider.dart';

import './home/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

 
void main() {	
	
	debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
   
    runApp(EasyLocalization(child: MainPage()));
}
