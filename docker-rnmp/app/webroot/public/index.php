<?php
//phpinfo();


session_start();


header('Content-type: application/json');
define('APP_PATH', "./../");
require APP_PATH . "lib/Hello.class.php";


Hello::sayHello();


