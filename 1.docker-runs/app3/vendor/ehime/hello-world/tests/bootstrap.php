<?php

$loader = require __DIR__. '/../vendor/autoload.php';

$loader->add('HelloWorld\\Tests\\', __DIR__);
$loader->register();
