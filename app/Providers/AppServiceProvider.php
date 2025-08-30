<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->singleton(\Illuminate\Foundation\PackageManifest::class, function ($app) {
            $manifestPath = '/tmp/packages.php';
            return new class($app['files'], $app->basePath(), $manifestPath) extends \Illuminate\Foundation\PackageManifest {
                protected function write(array $manifest)
                {
                    if (!is_writable($dirname = dirname($this->manifestPath))) {
                        if (!@mkdir($dirname, 0755, true)) {
                            throw new \Exception("The {$dirname} directory must be present and writable.");
                        }
                    }
                    parent::write($manifest);
                }
            };
        });
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
