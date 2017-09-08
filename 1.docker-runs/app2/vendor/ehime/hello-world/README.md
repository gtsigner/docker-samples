# Creating your first Composer/Packagist package

Hi everybody! Today I'll write about how you can contribute with PHP community creating packages (or updating your's) using [Composer](http://getcomposer.org/) and [Packagist](http://packagist.org/).

### Using Composer

Composer is a package manager for PHP. You can use packages the community developed and you can contribute with your packages too. Here I'll show how to create a project/package, install Composer inside it and send to Packagist, where others developers can use it inside their projects.

### Creating the Package

You can create a new project or update one to use Composer. I'll create a hello world class. It's a simple class but you can create complex projects and share them with the others developers. I'll use "hello-world" as project's name. Composer work in "vendor/package" name format. Here we can set as "vendor" name my name: "ehime" and as package name "hello-world", the name of the project.

### Files Structure

You can put all files inside the main dir, but I strongly recommend to create another dir, as "src" to be easier to understand and maintain your code organized. The project structure will start with the follow: * hello-world (root dir) * src * HelloWorld * SayHello.php Our SayHello.php file will have:

```
<?php

namespace HelloWorld;

class SayHello
{
    public static function world()
    {
        return 'Hello World, Composer!';
    }
}
```

### Starting Composer

As our project is ready we can "install" Composer inside it. This is only create a "composer.json" file inside root dir, but Composer can do that for you. Inside your project root: composer init You'll have the follow Composer response:

```
localhost:composer-helloworld $ composer init


  Welcome to the Composer config generator  



This command will guide you through creating your composer.json config.

Package name (<vendor>/<name>) [ehime/hello-world]:
 You can accept the default or customize it like "yourname/hello" or what you want. Complete all Composer questions like:

Package name (<vendor>/<name>) [ehime/hello-world]: ehime/hello-world
Description []: My first Composer project
Author [Junior Grossi <me@ehime.com>]: Your Name <your@name.com>
Minimum Stability []: dev

Define your dependencies.

Would you like to define your dependencies (require) interactively [yes]? no
Would you like to define your dev dependencies (require-dev) interactively [yes]? no

{
    "name": "ehime/hello-world",
    "description": "My first Composer project",
    "authors": [
        {
            "name": "Your Name",
            "email": "your@name.com"
        }
    ],
    "minimum-stability": "dev",
    "require": {

    }
}

Do you confirm generation [yes]? yes
 Now you have "composer.json" file saved in your root dir. It's almost ready but we must do some changes:

{
    "name": "ehime/hello-world",
    "description": "My first Composer project",
    "authors": [
        {
            "name": "Your Name",
            "email": "your@name.com"
        }
    ],
    "minimum-stability": "dev",
    "require": {
        "php": ">=5.3.0"
    },
    "autoload": {
        "psr-0": {
            "HelloWorld": "src/"
        }
    }
}
```

What we did here is add information about PHP 5.3 as minimum requirements (require section) and tell Composer to "autoload" (using [PSR-0](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md)) all files with "HelloWorld" namespace that are inside "src" dir.

### Testing Package

Sure we want to do a simple test to verify if our class is working well. You can create a new project and "paste" your classes inside it or test inside your own project, which is better and easier. We're creating a Composer project so we must have Composer files installed inside our projects. So, install it running "composer install" inside your root dir:

`composer install`

As you have only "php >=5.3.0" inside "composer.json", Composer will install only it's own files. With Composer installed create a directory "tests" inside your root dir. Create the "TestCase.php" file inside it with the follow content:

```
<?php

require_once __DIR__ . '/../vendor/autoload.php'; // Autoload files using Composer autoload

use HelloWorld\SayHello;

echo SayHello::world();
```

Go to the terminal (or create a PHP web server inside "tests" dir) and type:

`php -f tests/HelloWorld/Tests/TestCase.php`

You'll get "Hello World, Composer!". It's working now.

### Sending to Packagist.org

Now your project is working and you want to send it to Packagist. The easy way is push your project to [Github](http://github.com/) using Git. Go to Github and create a new public repo called "composer-helloworld", start the Git project inside your root dir and push it:

```
git init
git add .
git commit -m "First commit"
git remote add origin git@github.com:username/helloworld.git
git push origin master
```

Now you have your project inside a Github repo and you're ready to send it to Packagist. Go to [Packagist web site](http://packagist.org/), create your account, login and Submit a Package. Packagist'll ask you for Repository URL (Git/Svn/Hg). Paste there git@github.com:username/composer-helloworld.git and click "Check!". Packagist will check your project and return the project name. If it's correct accept it.
Packagist Details

Every time you do a new commit to Github you must update the Packagist. Go to your account, your package and click "Force Update!". Packagist will go to Github and update the sources. You can turn on "auto update" going to your Github repo, clicking "Settings", after "Service Hooks" and click the "Packagist" service. There update with your information, like:

 * User: your Packagist username, like ehime
 * Token: your API token, that you can find inside your Packagist settings link
 * Domain: packagist.org Ok! Auto update finished and your package is available to other developers.

From here on out you can now embed this project into another workflow by using the following command.

`composer require ehime/hello-world`

Our first Composer package is finished, but you can do much more using it. Thanks!
