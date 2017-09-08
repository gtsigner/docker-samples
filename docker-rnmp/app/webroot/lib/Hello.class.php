<?php

class Hello
{

  public function __construct()
  {
  }

  public static function sayHello()
  {
    $redis = new Redis();

    $redis->connect("redis-db");
    //查看服务是否运行
    $redis->incr("counter");
    //header()
    ob_start();
    $res = system('ip addr | grep inet | grep eth0');
    ob_end_clean();
    $ip = preg_match('/\d+.\d+.\d.\d/', $res, $ma);
    if ($ip === 1) {
      $res = $ma[0];
    }
    echo json_encode(['code' => 200, 'msg' => 'hello', 'counter' => $redis->get('counter'), 's_server' => $_SERVER['SERVER_ADDR'], 'session_id' => session_id(), 'net' => $res]);
  }
}
