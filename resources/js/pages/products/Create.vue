<script setup lang="ts">
import Button from '@/components/ui/button/Button.vue';
import Input from '@/components/ui/input/Input.vue';
import Label from '@/components/ui/label/Label.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/vue3';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Create a product',
        href: '/products/create',
    },
];

const form = useForm({
    name: '',
    price: '',
    description: '',
})

const handleSubmit = () => {
    form.post(('/products/store'));
}
</script>

<template>
    <Head title="Create Products" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="p-4">
            <form @submit.prevent="handleSubmit" class="grid grid-cols-2 gap-4 p-4">
                <div class="space-y-4 w-full">
                    <Label for="Product Name">Name</Label>
                    <Input type="text" placeholder="name" class="customInput" v-model="form.name" />
                    <div class="text-sm text-red-600" v-if="form.errors.name">{{ form.errors.name }}</div>
                </div>
                <div class="space-y-4 w-full">
                    <Label for="Product Price">Price</Label>
                    <Input type="number" placeholder="price" class="customInput" v-model="form.price" />
                    <div class="text-sm text-red-600" v-if="form.errors.price">{{ form.errors.price }}</div>
                </div>
                <div class="space-y-4 col-span-2">
                    <Label for="Product Description">Description</Label>
                    <Input type="text" class="customInput" placeholder="description" v-model="form.description" />
                    <div class="text-sm text-red-600" v-if="form.errors.description">{{ form.errors.description }}</div>
                </div>
                <Button :disabled="form.processing" type="submit">Create Product</Button>
            </form>
        </div>
    </AppLayout>
</template>
