import { wayfinder } from '@laravel/vite-plugin-wayfinder';
import tailwindcss from '@tailwindcss/vite';
import vue from '@vitejs/plugin-vue';
import laravel from 'laravel-vite-plugin';
import { defineConfig } from 'vite';

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

// Only add wayfinder plugin if not disabled
if (!process.env.DISABLE_WAYFINDER) {
    plugins.splice(2, 0, wayfinder({
        formVariants: true,
    }));
}

export default defineConfig({
    plugins,
});
