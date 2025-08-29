<script setup lang="ts">
import Button from '@/components/ui/button/Button.vue';
import Input from '@/components/ui/input/Input.vue';
import Label from '@/components/ui/label/Label.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import { Head, useForm } from '@inertiajs/vue3';
import { route } from 'ziggy-js';

interface Product {
    id: number;
    name: string;
    price: number;
    description: string;
}

const props = defineProps<{product: Product}>();

const form = useForm({
    name: props.product.name,
    price: props.product.price,
    description: props.product.description,
})

const handleSubmit = () => {
    form.put(route('products.update', { product: props.product }));
}
</script>

<template>
    <Head title="Edit Products" />

    <AppLayout :breadcrumbs="[{ title: 'Edit a product', href: `/products/${props.product.id}/edit`}]">
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
                <Button :disabled="form.processing" type="submit">Edit Product</Button>
            </form>
        </div>
    </AppLayout>
</template>
