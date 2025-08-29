import { wayfinder } from '@laravel/vite-plugin-wayfinder';
import tailwindcss from '@tailwindcss/vite';
import vue from '@vitejs/plugin-vue';
import laravel from 'laravel-vite-plugin';
import { defineConfig } from 'vite';
import path from 'path';

const plugins = [
    laravel({
        input: ['resources/js/app.ts'],
        ssr: 'resources/js/ssr.ts',
        refresh: true,
    }),
    tailwindcss(),
    vue({
        template: {
            transformAssetUrls: {
                base: null,
                includeAbsolute: false,
            },
        },
    }),
];

// Only add wayfinder plugin if not disabled and in development
if (!process.env.DISABLE_WAYFINDER && process.env.NODE_ENV !== 'production') {
    plugins.splice(2, 0, wayfinder({
        formVariants: true,
    }));
}

export default defineConfig({
    plugins,
    resolve: {
        alias: {
            '@': path.resolve(__dirname, './resources/js'),
        },
    },
});
