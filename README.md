# kayo_package


导入方式如下：

dependencies:
  flutter:
    sdk: flutter
    ...
   
  kayo_package:
    git:
    url: https://github.com/kayoxu/kayo_package.git

  EasyRefreshController _controller = EasyRefreshController();
  ....
  EasyRefresh(
    controller: _controller,
    ....
  );
  ....
  _controller.callRefresh();
  _controller.callLoad();
4.控制加载和刷新完成
