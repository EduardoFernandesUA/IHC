<script>
	import { page } from '$app/stores';

	let path;
	$: path = $page.url.pathname;
</script>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
	<div class="container-fluid">
		<a class="navbar-brand" href="/">MFDAA</a>
		<button
			class="navbar-toggler"
			type="button"
			data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent"
			aria-expanded="false"
			aria-label="Toggle navigation"
		>
			<span class="navbar-toggler-icon" />
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link {path == '/browse' ? 'active' : ''}" href="/browse">Browse</a>
				</li>
				<li class="nav-item">
					<a class="nav-link {path == '/myprojects' ? 'active' : ''}" href="/myprojects"
						>MyProjects</a
					>
				</li>
			</ul>
			<ul class="navbar-nav">
				<li class="nav-link">
					<a class="nav-link {path == '/browse' ? 'active' : ''}" href="/browse">Profile</a>
				</li>
				<li class="nav-link">
					<a class="nav-link {path == '/browse' ? 'active' : ''}" href="/browse">Login/Register</a>
				</li>
			</ul>
		</div>
	</div>
</nav>

<div class="container">
	<slot />
</div>

<footer class="bg-dark text-center text-white">
	<div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">© 2023 MFDAA</div>
</footer>

<style>
	footer {
		position: absolute;
		bottom: 0;
		width: 100%;
	}
</style>
