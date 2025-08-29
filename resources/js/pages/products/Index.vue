<script setup lang="ts">
import Button from '@/components/ui/button/Button.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import { Rocket } from 'lucide-vue-next';
import { Table, TableBody, TableCaption, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { productsIndex, productsCreate, productsEdit, productsDestroy } from '@/routes';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Products',
        href: productsIndex(),
    },
];

const page = usePage();

interface Product {
    id: number;
    name: string;
    price: number;
    description: string;
}

interface Props {
    products: Product[];
}

const props = defineProps<Props>();

const deleteProduct = (id: number) => {
    if (confirm("Are you sure you want to delete the product?")) {
        router.delete(productsDestroy(id).url);
    }
}
</script>

<template>
    <Head title="Products" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="p-4 bg-lime-500/40 ring-2 ring-lime-600/80 text-white m-4 rounded-sm flex gap-x-4 items-center" v-if="page.props.flash?.message">
            <Rocket class="size-8" />
            <div>
                <span class="font-bold">Operation Successful!</span>
                <p class="text-sm">{{ page.props.flash.message }}</p>
            </div>
        </div>
        <div class="p-4">
            <Link :href="productsCreate()"><Button>Create A Product</Button></Link>
        </div>

        <div class="p-4">
            <Table>
                <TableCaption>A list of your recent Products.</TableCaption>
                <TableHeader>
                <TableRow>
                    <TableHead class="w-[100px]">ID</TableHead>
                    <TableHead>Name</TableHead>
                    <TableHead>Description</TableHead>
                    <TableHead class="text-right">Price</TableHead>
                    <TableHead class="text-center">Action</TableHead>
                </TableRow>
                </TableHeader>
                <TableBody>
                <TableRow v-for="product in props.products" :key="product.id">
                    <TableCell class="font-medium">{{ product.id }}</TableCell>
                    <TableCell>{{ product.name }}</TableCell>
                    <TableCell>{{ product.description }}</TableCell>
                    <TableCell class="text-right">${{ product.price }}</TableCell>
                    <TableCell class="text-center space-x-2">
                        <Link :href="productsEdit(product.id).url"><Button class="bg-slate-600 text-white rounded-sm px-5">Edit</Button></Link>
                        <Button class="bg-red-600 text-white rounded-sm px-5" @click="deleteProduct(product.id)">Delete</Button>
                    </TableCell>
                </TableRow>
                </TableBody>
            </Table>
        </div>
    </AppLayout>
</template>
