<script>
  
  let projects = [
    {
      name: 'Project 1',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed gravida hendrerit lectus, vel bibendum libero.',
      image: 'src/routes/images/gradient.jpeg',
      link: '/project/acquisition',
      classes: ['Thumbsup', 'Thumbsdown'],
      role: 'Hand Sign 2',
      created: '3 months ago'
    },
    {
      name: 'Project 2',
      description: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      image: 'src/routes/images/gradient2.jpeg',
      link: '/project/acquisition',
      classes: ['Peace', 'Thumbs', 'Pointing'],
      role: 'Hand-Sign 1',
      created: '6 months ago'
    },
    {
      name: 'Project 3',
      description: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      image: 'src/routes/images/gradient3.jpeg',
      link: '/project/acquisition',
      technologies: ['Smile', 'Sad', 'Goofy'],
      role: 'Facial Queues',
      created: '2 months ago'
    }
  ];

//   function create_project() {
//     projects.push({name: document.querySelector("#name").value,
//     description: document.querySelector("#description").value, 
//     role: document.querySelector("#model").value,
//     image: 'https://via.placeholder.com/150',
//     link: '/project/acquisition',
//     technologies: ['Svelte', 'JavaScript', 'HTML', 'CSS'],
//     duration: '3 months'})
//     load_content()
// }

function load_content(){
  for (let project of projects) {
      let list = `<div class="col">
                    <div class="card h-100" >
                      <div class="card-body">
                        <h3 class="card-title">${project.name}</h3>
                        <p class="card-text">${project.description}</p>
                      </div>
                      <div class="card-footer">
                        <small class="text-muted">Last updated: ${
                          project.duration
                        }</td>
                      </div>
                    </div>
                  </div>`;
                  
      let newElem = document.createElement("div");
      newElem.innerHTML = list;
      projectList.appendChild(newElem);
}
}

  let projectInfo = '';

  function goToProjectLink(link) {
    window.open(link, '_blank');
  }

  function toggleProjectInfo(event, index) {
    event.stopPropagation();
    const project = projects[index];
    const info = `Technologies: ${project.technologies.join(', ')}\n                 
                  Role: ${project.role}\n             
                  Duration: ${project.created}`;
    projectInfo = projectInfo === info ? '' : info;
  }
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
    height: 350px;
    margin-bottom: 2rem;
    background-color: #FFF;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    overflow: hidden;
    cursor: pointer;
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

  .project-info-popover {
    position: absolute;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,.15);
    padding: 20px;
    z-index: 10;
    opacity: 0;
    pointer-events: none;
    transition: opacity .2s ease-in-out, transform .2s ease-in-out;
    max-width: 300px;
    line-height: 1.5;
    font-size: 14px;
    color: #333;
  }

  .project-info-popover:before {
    content: "";
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    width: 0;
    height: 0;
    border: 10px solid transparent;
    border-bottom-color: #fff;
  }

  .project-info-popover .arrow {
    position: absolute;
    width: 20px;
    height: 20px;
    top: -10px;
    left: 50%;
    transform: translateX(-50%) rotate(45deg);
    background-color: #fff;
    box-shadow: 0 2px 10px rgba(0,0,0,.15);
  }

  .project-info-button:hover + .project-info-popover, .project-info-popover:hover {
    opacity: 1;
    pointer-events: auto;
    transform: translateY(10px);
  }

.project-info-button {
  border: none;
  background-color: beige;
  cursor: pointer;
  position: relative;
}

.project-info-button:hover + .project-info-popover, .project-info-popover:hover {
  opacity: 1;
  pointer-events: auto;
}


  .project-card p {
    margin: 0;
    font-size: 0.8rem;
    color: #555;
    line-height: 1.2;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
  }

  .project-card .project-info {
    display: flex;
    flex-direction: column;
    margin-top: 1rem;
  }

  .project-card .project-info-item {
    display: flex;
  }

  .project-card .project-info-item span:first-child {
    width: 120px;
    font-weight: bold;
  }

  .project-card .project-info-item span:last-child {
    margin-left: 0.5rem;
  }

  .project-card a {
    display: block;
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

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<div class="container my-1">
    <br>
    <br>
    <div class="container my-5">
        <div href="newProject" id="projectsHere" style="display:flex;">
                   <!-- Button trigger modal -->
                   <button type="button" class="btn btn-light d-flex align-items-center" style="margin-left: auto;background-color: white; border-color: grey;" data-bs-toggle="modal" data-bs-target="#newProject">
                    <span class="material-symbols-outlined">
                      add
                    </span>
                  </button>

             <div class="modal fade" id="newProject" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-dialog-centered" role="document">
                  <div class="modal-content" style="color: #292929">
                    <div class="overlay"></div>
                    <div class="modal-header">
                      <h5 class="modal-title">New Project</h5>
                      <button type="button" class="close" data-bs-dismiss="modal" onclick="window.location.href='/myprojects'" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                    <div class="modal-body">
                      <form>
                        <div class="form-group">
                          <label for="name">Name</label>
                          <input type="text" class="form-control" id="name" placeholder="Enter name">
                        </div>
                        <div class="form-group" style="margin-top: 10px;">
                          <label for="description">Description</label>
                          <textarea class="form-control" id="description" placeholder="Enter description"></textarea>
                        </div>
                        <div class="form-group" style="margin-top: 10px;">
                          <label for="model">Base Model</label>
                          <select style="height: 38px;margin-left: 0px;"class="form-control" id="model">
                            <option>Linear regression model</option>
                            <option>Decision tree model</option>
                            <option>Logistic regression model</option>
                          </select>
                        </div>
                         <div class="row" style="margin-top: 10px;">
                            <div class="col">
                              <div class="form-group" id="Category" value="Gestures">
                                <label for="option">Category</label>
                                <div class="form-check">
                                  <input class="form-check-input" type="radio" name="category_option" id="gestures" value="video">
                                  <label class="form-check-label" for="gestures">
                                    Video
                                  </label>
                                </div>
                                <div class="form-check">
                                  <input class="form-check-input" type="radio" name="category_option" id="audio" value="audio">
                                  <label class="form-check-label" for="audio">
                                    Audio
                                  </label>
                                </div>
                              </div>
                            </div>
                            <div class="col">
                              <div class="form-group" id="Privacy" value="Public">
                                <label for="option">Privacy</label>
                                <div class="form-check">
                                  <input class="form-check-input" type="radio" name="privacy_option" value="public" checked>
                                  <label class="form-check-label" for="public">
                                    Public
                                  </label>
                                </div>
                                <div class="form-check" >
                                  <input class="form-check-input" type="radio" name="privacy_option" id="private" value="private">
                                  <label class="form-check-label" for="private">
                                    Private
                                  </label>
                                </div>
                              </div>
                            </div>
                          </div>

                      </form>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-danger" data-bs-dismiss="modal" onclick="window.location.href='myprojects'">
                        <span class="material-symbols-outlined">
                          cancel
                          </span>
                    </button>
                    <button type="button" class="btn btn-success" on:click={() => create_project()}>
                      <span class="material-symbols-outlined">
                        save
                        </span>
                    </button>
                    </div>
                </div>
            </div>
             </div>
        </div>
            


            
        </div>
 </div>
        <hr class="mbg-white border-3 opacity-100" style="border-color: #eee;">
    
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4" id="project_list" style="color: #292929">
              
              
                  
        </div>

<div class="projects-container" id="project_list">
  {#each projects as project, index}
    <div class="project-card" on:click={() => goToProjectLink(project.link)}>
      <img src={project.image} alt={project.name} />
      <div class="project-card-content">
        <h2>{project.name}</h2>
        <p>{project.description}</p>
        <div class="project-info">
          <button class="project-info-button" on:click={(e) => toggleProjectInfo(e, index)}>
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus">
              <path d="M12 5v14M5 12h14" />
            </svg>
          </button>
          {#if projectInfo}
            <div class="project-info-popover">
              <p>{projectInfo}</p>
            </div>
          {/if}
        </div>
      </div>
    </div>
  {/each}
</div>


