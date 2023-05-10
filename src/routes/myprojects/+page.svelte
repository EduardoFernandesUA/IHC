<script>
  let projects = [
    {
      name: 'Project 1',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      image: 'src/routes/images/gradient.jpeg',
      link: 'https://project1.com'
    },
    {
      name: 'Project 2',
      description: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      image: 'src/routes/images/gradient.jpeg',
      link: 'https://project2.com'
    },
    {
      name: 'Project 3',
      description: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      image: 'src/routes/images/gradient.jpeg',
      link: 'https://project3.com'
    }
  ];
</script>

<style>
  .projects-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin-top: 2rem;
  }

  .project-card {
    width: calc(50% - 1rem);
    padding: 0;
    margin-bottom: 2rem;
    background-color: #FFF;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    overflow: hidden;
  }

  .project-card img {
    width: 100%;
    height: 150px;
    object-fit: cover;
  }

  .project-card-content {
    padding: 1rem;
  }

  .project-card h2 {
    margin-top: 0;
    margin-bottom: 0.5rem;
    font-size: 1rem;
  }

  .project-card p {
    margin: 0;
    font-size: 0.8rem;
    color: #555;
    line-height: 1.2;
  }

  .project-card a {
    display: block;
    padding: 0.5rem 1rem;
    background-color: #0080FF;
    color: #FFF;
    text-align: center;
    border-radius: 0 0 5px 5px;
    transition: background-color 0.2s ease-in-out;
    text-decoration: none;
    font-size: 0.8rem;
  }

  .project-card a:hover {
    background-color: #0066CC;
  }

  @media (min-width: 768px) {
    .project-card {
      width: calc(33.33% - 1rem);
    }
  }
</style>

<h1>My Projects</h1>

<div class="projects-container">
  {#each projects as project}
    <div class="project-card">
      <img src={project.image} alt={project.name} />
      <div class="project-card-content">
        <h2>{project.name}</h2>
        <p>{project.description}</p>
      </div>
      <a href={project.link} target="_blank">Visit Project</a>
    </div>
  {/each}
</div>
