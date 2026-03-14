<?php

namespace AiAgentOS;

class Installer
{
    public static function install()
    {
        $root = getcwd();
        $package = __DIR__ . '/../';

        $files = [
            'commands',
            'profiles',
            'scripts'
        ];

        foreach ($files as $dir) {
            $source = $package . $dir;
            $dest = $root . '/' . $dir;

            if (!file_exists($dest)) {
                self::copyDirectory($source, $dest);
                echo "Installed {$dir}\n";
            }
        }
    }

    private static function copyDirectory($src, $dst)
    {
        $dir = opendir($src);
        mkdir($dst, 0755, true);

        while (($file = readdir($dir)) !== false) {
            if ($file != '.' && $file != '..') {

                if (is_dir("$src/$file")) {
                    self::copyDirectory("$src/$file", "$dst/$file");
                } else {
                    copy("$src/$file", "$dst/$file");
                }

            }
        }

        closedir($dir);
    }
}