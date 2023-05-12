<link rel="stylesheet" href="src/routes/myprojects/styles.css">

<style>
  .card {
  width: calc(33.33% - 1rem);
  margin: 0.5rem;
  display: flex;
  flex-direction: column;
}

.card-body {
  height: 100%;
  padding: 0;
  margin: 0;
}

.row {
  height: 100%;
  margin: 0;
}

.col-3 {
  width: 33.33%;
  padding: 0;
  margin: 0;
}

.col-3 img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.col-9 {
  width: 66.66%;
  padding: 0.75rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

</style>



<script>
	import { comment } from "svelte/internal";

  
  let projects = [
    {
      id: generateRandomId(),
      name: 'Project 1 - Hand Gestures',
      description: 'Project that aims to detect hand gestures and classify them into different categories: thumbs up, thumbs down and peace. It can also extract features using MediaPipe.',
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

  const newProject = {
    id: generateRandomId(),
    name: projectName,
    description: projectDescription,
    image: 'src/routes/images/gradient4.jpeg',
    link: '/project/acquisition',
    technologies: ['Svelte', 'JavaScript', 'HTML', 'CSS'],
    role: 'Facial Queues',
    created: '3 months'
  };

  projects.push(newProject);

  // Close the modal
  const modal = document.querySelector("#newProject");
  const bootstrapModal = bootstrap.Modal.getInstance(modal);
  bootstrapModal.hide();

  console.log(projects);

  appendProjectCard(newProject);

  alert("Project created successfully! You are being redirected to the project page.");
  goToProjectLink(newProject.link + '?id=' + newProject.id);

  // Adjust project cards layout
  adjustProjectCardsLayout();
}

  function appendProjectCard(project) {
    const projectList = document.querySelector("#project_list");

    const projectCard = document.createElement("div");
    projectCard.classList.add("card", "h-100", "col-3");
    projectCard.style.cursor = "pointer";

    projectCard.addEventListener("click", () => goToProject(project.link, project.id));

    const cardBody = document.createElement("div");
    cardBody.classList.add("card-body", "p-0", "m-0");
    // add margin left
    cardBody.style.marginLeft = "0.5rem";

    const row = document.createElement("div");
    row.classList.add("row", "mx-0", "h-100");

    const imageColumn = document.createElement("div");
    imageColumn.classList.add("col-4", "m-0", "p-0", "h-100");


    const image = document.createElement("img");
    image.src = project.image;
    image.alt = project.name;
    image.style.width = "100%";
    image.style.height = "auto"; // Change height to "auto" to maintain aspect ratio


    const contentColumn = document.createElement("div");
    contentColumn.classList.add("col-8", "p-3", "d-flex", "flex-column", "justify-content-between"); // Added flexbox classes

    const projectNameElement = document.createElement("h5");
    projectNameElement.textContent = project.name;

    const projectDescriptionElement = document.createElement("p");
    projectDescriptionElement.textContent = project.description;

    const projectButton = document.createElement("button");
    projectButton.classList.add("project-info-button", "mt-auto"); // Added margin-top:auto to push the button to the bottom
    projectButton.style.height = "30px";
    projectButton.textContent = "Go to Project";
    projectButton.addEventListener("click", () => goToProject(project.link, project.id));

    contentColumn.appendChild(projectNameElement);
    contentColumn.appendChild(projectDescriptionElement);
    contentColumn.appendChild(projectButton);

    imageColumn.appendChild(image);

    row.appendChild(imageColumn);
    row.appendChild(contentColumn);

    cardBody.appendChild(row);

    projectCard.appendChild(cardBody);

    projectList.appendChild(projectCard);

    // Adjust project cards layout
    adjustProjectCardsLayout();
  }

  function adjustProjectCardsLayout() {
    const projectCards = document.querySelectorAll(".card");
    const maxWidth = Math.max(...Array.from(projectCards).map(card => card.offsetWidth)); // Find the maximum width among project cards

    projectCards.forEach(card => {
      card.style.width = `${maxWidth}px`; // Set the width of each card to the maximum width
    });
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

    project_list.classList.add("d-flex", "flex-wrap", "align-items-start");

    projects.forEach((project) => {
      appendProjectCard(project);
    });
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
        <!-- svelte-ignore a11y-click-events-have-key-events -->
        <div class="card h-100" style="cursor:pointer;" on:click={() => goToProject(project.link, project.id)}>
          <div class="card-body p-0 m-0">
            <div class="row mx-0 h-100">
              <div class="col-3 m-0 p-0 h-100">
                <img src={project.image} alt={project.name} style="width:100%;height:100%;"/>
              </div>
              <div class="col-9 p-3">
                <h5>{project.name}</h5>
                <p>{project.description}</p>
                <button class="project-info-button" style="height: 30px" on:click={() => goToProject(project.link, project.id)}>
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
        </div>
      {/each}

        
    </div>


    
    