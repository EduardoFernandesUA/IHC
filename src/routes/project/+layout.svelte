
<script lang="ts">
    import { page } from '$app/stores';
    
    let path: string;

    $: path = $page.url.pathname;
</script>

<nav class="nav py-4 nav-pills flex-column flex-sm-row">
    <a class="flex-sm-fill text-sm-center nav-link {path=='/project/acquisition'?'active':''}" href="acquisition">Acquisition</a>
    <a class="flex-sm-fill text-sm-center nav-link {path=='/project/test'?'active':''}" href="test">Test</a>
</nav>

<slot />

<style>
    nav .active {
        background-color: black;
        color: white;
    }
    .nav-link {
        color: black;
    }
</style>