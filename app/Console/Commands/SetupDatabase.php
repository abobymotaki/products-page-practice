<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class SetupDatabase extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'db:setup {--fresh : Drop all tables and recreate} {--seed : Run database seeders}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Setup the complete database structure with migrations and optional seeding';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('🚀 Starting database setup...');

        try {
            // Test database connection
            $this->info('📡 Testing database connection...');
            DB::connection()->getPdo();
            $this->info('✅ Database connection successful!');
        } catch (\Exception $e) {
            $this->error('❌ Database connection failed: ' . $e->getMessage());
            $this->error('Please check your database configuration in .env file');
            return 1;
        }

        if ($this->option('fresh')) {
            $this->warn('⚠️  Fresh installation requested - this will drop all existing tables!');
            if ($this->confirm('Are you sure you want to continue?')) {
                $this->info('🗑️  Dropping all tables...');
                Artisan::call('migrate:fresh', ['--force' => true]);
                $this->info('✅ All tables dropped and recreated');
            } else {
                $this->info('Operation cancelled.');
                return 0;
            }
        } else {
            $this->info('🔄 Running migrations...');
            Artisan::call('migrate', ['--force' => true]);
            $this->info('✅ Migrations completed successfully');
        }

        // Display migration status
        $this->info('📊 Migration Status:');
        Artisan::call('migrate:status');
        $this->line(Artisan::output());

        // Run seeders if requested
        if ($this->option('seed')) {
            $this->info('🌱 Running database seeders...');
            Artisan::call('db:seed', ['--force' => true]);
            $this->info('✅ Database seeding completed');
        }

        // Verify table structure
        $this->verifyDatabaseStructure();

        $this->info('🎉 Database setup completed successfully!');
        $this->info('💡 You can now run your application with the MySQL database.');
        
        return 0;
    }

    /**
     * Verify the database structure
     */
    private function verifyDatabaseStructure()
    {
        $this->info('🔍 Verifying database structure...');
        
        $expectedTables = [
            'users',
            'products', 
            'password_reset_tokens',
            'sessions',
            'cache',
            'cache_locks',
            'jobs',
            'job_batches',
            'failed_jobs',
            'migrations'
        ];

        $missingTables = [];
        
        foreach ($expectedTables as $table) {
            if (!Schema::hasTable($table)) {
                $missingTables[] = $table;
            }
        }

        if (empty($missingTables)) {
            $this->info('✅ All expected tables are present');
        } else {
            $this->warn('⚠️  Missing tables: ' . implode(', ', $missingTables));
        }

        // Verify key columns in main tables
        $this->verifyTableColumns();
    }

    /**
     * Verify important columns exist in main tables
     */
    private function verifyTableColumns()
    {
        $tableColumns = [
            'users' => ['id', 'name', 'email', 'password', 'created_at', 'updated_at'],
            'products' => ['id', 'name', 'price', 'description', 'created_at', 'updated_at']
        ];

        foreach ($tableColumns as $table => $columns) {
            if (Schema::hasTable($table)) {
                $missingColumns = [];
                foreach ($columns as $column) {
                    if (!Schema::hasColumn($table, $column)) {
                        $missingColumns[] = $column;
                    }
                }
                
                if (empty($missingColumns)) {
                    $this->info("✅ Table '{$table}' has all required columns");
                } else {
                    $this->warn("⚠️  Table '{$table}' missing columns: " . implode(', ', $missingColumns));
                }
            }
        }
    }
}
