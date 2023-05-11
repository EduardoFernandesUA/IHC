<link rel="stylesheet" href="src/routes/myprojects/styles.css">
<script>
	import { comment } from "svelte/internal";

  
  let projects = [
    {
      id: generateRandomId(),
      name: 'Project 1 - Hand Gestures',
      description: 'Project that aims to detect hand gestures and classify them into different categories: thumbs up, thumbs down and peace. It can also extract features using the MediaPipe library.',
      image: 'src/routes/images/gradient.jpeg',
      link: '/project/acquisition',
      classes: ['Thumbsup', 'Thumbsdown'],
      role: 'Hand Sign 2',
      created: '3 months ago'
    },
    {
      id: generateRandomId(),
      name: 'Project 2 - Face Detection',
      description: 'This project can support face detection using the MediaPipe library. The feature extraction aims to detect the facial queues of the user detecting different face points.',
      image: 'src/routes/images/gradient2.jpeg',
      link: '/project/acquisition',
      classes: ['Peace', 'Thumbs', 'Pointing'],
      role: 'Hand-Sign 1',
      created: '6 months ago'
    },
    {
      id: generateRandomId(),
      name: 'Project 3 - Hand & Face Recognition',
      description: 'This project can support face  and also hand detection using the MediaPipe library. It is a combination of project 1 and 2 previously created',
      image: 'src/routes/images/gradient3.jpeg',
      link: '/project/acquisition',
      technologies: ['Smile', 'Sad', 'Goofy'],
      role: 'Facial Queues',
      created: '2 months ago'
    }
  ];

  // Function to generate a random ID
  function generateRandomId() {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let id = '';
    for (let i = 0; i < 10; i++) {
      id += characters.charAt(Math.floor(Math.random() * characters.length));
    }
    return id;
  }


  function create_project() {
    let projectName = document.querySelector("#name").value;
    let projectDescription = document.querySelector("#description").value;

    projects.push({
      id: generateRandomId(),
      name: projectName,
      description: projectDescription,
      image: 'src/routes/images/gradient4.jpeg',
      link: '/project/acquisition',
      technologies: ['Svelte', 'JavaScript', 'HTML', 'CSS'],
      role: 'Facial Queues',
      created: '3 months'
    });

    // Close the modal
    const modal = document.querySelector("#newProject");
    const bootstrapModal = bootstrap.Modal.getInstance(modal);
    bootstrapModal.hide();

    console.log(projects);

    load_content();
  }

  function goToProjectLink(link) {

    console.log(link);
    window.open(link, '_blank');
  }

  function goToProject(link, projectId) {
    console.log(link);
    window.open(link + '?id=' + projectId , '_blank');
  }

  function load_content() {
    let project_list = document.querySelector("#project_list");
    project_list.innerHTML = '';
    let projectIds = [];
    

    projects.forEach((project) => {
      const projectId = generateRandomId(); 
      console.log(projectId);
      const projectCard = `
        <div class="project-card custom-project-card" onclick="window.open('/project/acquisition?id=${project.id}', '_blank')">
          <img src="${project.image}" alt="${project.name}" />
          <div class="project-card-content">
            <h2>${project.name}</h2>
            <p>${project.description}</p>
            <div class="project-info">
              <button class="project-info-button custom-project-info-button" onclick="window.open('/project/acquisition?id=${project.id}', '_blank')">
                Go to Project
              </button>
            </div>
          </div>
        </div>
      `;

      project_list.innerHTML += projectCard;
      projectIds.push(projectId);
    });

    alert("Project created successfully! You are being redirected to the project page.");
    goToProjectLink('/project/acquisition?id=' + projectIds[projectIds.length - 1]);
  }





  
  let projectInfo = '';

  function toggleProjectInfo(event, index) {
    event.stopPropagation();
    const project = projects[index];
    const info = `Technologies: ${project.technologies.join(', ')}\n                 
                  Role: ${project.role}\n             
                  Duration: ${project.created}`;
    projectInfo = projectInfo === info ? '' : info;
  }
</script>


<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />

<div class="container py-4">
	<div class="d-flex">
		<div class="p-2 flex-grow-1">
			<h1>My Projects</h1>
		</div>
		<div class="p-2">
			<div class="input-group mb-3">
				<span class="input-group-text">New Project</span>
				<div class="form-floating">
					<button type="button" class="btn btn-light d-flex align-items-center" style="margin-left: auto;background-color: white; border-color: grey;" data-bs-toggle="modal" data-bs-target="#newProject">
            <span class="material-symbols-outlined">
              add
            </span>
				</div>
			</div>
		</div>
	</div>
    <div href="newProject" id="projectsHere" style="display:flex;">
              

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

    <hr class="mbg-white border-3 opacity-100" style="border-color: #eee;">

  

<div class="projects-container" id="project_list">
{#each projects as project, index}
<div class="project-card" on:click={() => goToProject(project.link, project.id)}>
  <img src={project.image} alt={project.name} />
  <div class="project-card-content">
    <h2>{project.name}</h2>
    <p>{project.description}</p>
    <div class="project-info">
      <button class="project-info-button" style= "height: 30px" on:click={() => goToProject(project.link, project.id)}>
        Go to Project
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