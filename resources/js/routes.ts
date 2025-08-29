/**
 * Route helper functions for the application
 */

/**
 * Get the login route URL
 * @returns {string} The login route URL
 */
export function login(): string {
    return '/login';
}

/**
 * Get the register route URL
 * @returns {string} The register route URL
 */
export function register(): string {
    return '/register';
}

/**
 * Get the logout route URL
 * @returns {string} The logout route URL
 */
export function logout(): string {
    return '/logout';
}

/**
 * Get the dashboard route URL
 * @returns {string} The dashboard route URL
 */
export function dashboard(): string {
    return '/dashboard';
}

/**
 * Get the home route URL
 * @returns {string} The home route URL
 */
export function home(): string {
    return '/';
}

/**
 * Get the appearance settings route URL
 * @returns {string} The appearance settings route URL
 */
export function appearance(): string {
    return '/settings/appearance';
}

// Profile routes
export function profileEdit() {
    return { url: '/settings/profile', method: 'get' };
}

export function profileUpdate() {
    return { url: '/settings/profile', method: 'patch' };
}

export function profileDestroy() {
    return { url: '/settings/profile', method: 'delete' };
}

// Verification routes
export function verificationSend() {
    return { url: '/email/verification-notification', method: 'post' };
}

// Forgot Password routes
export function forgotPassword(): string {
    return '/forgot-password';
}

export function forgotPasswordSend() {
    return { url: '/forgot-password', method: 'post' };
}

export function passwordEdit() {
    return { url: '/settings/password', method: 'get' };
}

export function passwordUpdate() {
    return { url: '/settings/password', method: 'put' };
}

// Products routes
export function productsIndex() {
    return { url: '/products', method: 'get' };
}

export function productsCreate() {
    return { url: '/products/create', method: 'get' };
}

export function productsStore() {
    return { url: '/products/store', method: 'post' };
}

export function productsEdit(product: string | number) {
    return { url: `/products/${product}/edit`, method: 'get' };
}

export function productsUpdate(product: string | number) {
    return { url: `/products/${product}`, method: 'put' };
}

export function productsDestroy(product: string | number) {
    return { url: `/products/${product}`, method: 'delete' };
}