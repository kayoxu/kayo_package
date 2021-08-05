///  tfblue_flutter_module
///  common.http
///
///  Created by kayoxu on 2019-06-10 17:07.
///  Copyright © 2019 kayoxu. All rights reserved.
abstract class BaseAPI {
  init();

  String get host;

  String get hostFile;

  String get hostSocket;

  bool get isEnv;
}
