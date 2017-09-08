<?php

class Hello
{
    public static function sayHello()
    {
        //header()
        echo json_encode(['code' => 200, 'msg' => 'hello']);
    }
}
