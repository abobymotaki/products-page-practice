<?php

use App\Http\Middleware\HandleAppearance;
use App\Http\Middleware\HandleInertiaRequests;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Middleware\AddLinkHeadersForPreloadedAssets;

$app = Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->encryptCookies(except: ['appearance', 'sidebar_state']);

        $middleware->web(append: [
            HandleAppearance::class,
            HandleInertiaRequests::class,
            AddLinkHeadersForPreloadedAssets::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();

$app->singleton(\Illuminate\Foundation\PackageManifest::class, function ($app) {
    $files = new \Illuminate\Filesystem\Filesystem();
    return new class($files, $app->basePath(), '/tmp/bootstrap/cache/services.php') extends \Illuminate\Foundation\PackageManifest {
        public function build()
        {
            if (file_exists($this->manifestPath)) {
                return;
            }
            $dirname = dirname($this->manifestPath);
            if (!is_dir($dirname)) {
                @mkdir($dirname, 0755, true);
            }
            parent::build();
        }
    };
});

return $app;
