<script lang='ts'>
  let width: number, height: string;

  $: height = (width*(3/4)) + 'px';

  let records = [
    { id: 1, name: 'video_#1', class: 'ThumbsUp', duration: 3 },
  ];

  function editName(id) {
    const record = records.find(r => r.id === id);
    record.editingName = true;
  }

  function saveName(id) {
    const record = records.find(r => r.id === id);
    delete record.editingName;
    record.name = document.getElementById(`name-input-${id}`).value;
  }

    
  let stream;
  let recorder;
  let chunks = [];
  let isPlaying = false;
  let isRecording = false;
  let countDown = 0;
  let duration = 0;


  function closeModal() {
    const modal = document.getElementById('previewVideoModal');
    const bootstrapModal = bootstrap.Modal.getInstance(modal);
    bootstrapModal.hide();
    document.body.classList.remove('modal-open');
    document.body.style.overflow = ''; // Restore scrolling

    const modalBackdrop = document.querySelector('.modal-backdrop');
    if (modalBackdrop) {
      modalBackdrop.parentNode.removeChild(modalBackdrop);
    }

    console.log('close modal');
  }

  let isCameraOn = false; // flag to keep track of camera state
  

  async function openCamera() {
    try {
      if (isCameraOn) {
        // Camera is already on, so turn it off
        stopCamera();
        return;
      }

      // Request camera access
      stream = await navigator.mediaDevices.getUserMedia({ video: true }); // only video, no audio
      const videoElement = document.querySelector('video');

      videoElement.srcObject = stream;

      recorder = new MediaRecorder(stream);

      recorder.addEventListener('dataavailable', event => {
        chunks.push(event.data);
        console.log(chunks);
      });

      const closeCamera = document.getElementById('openCamera');
      closeCamera.innerHTML = 'Close Camera';

      isCameraOn = true; // Set the camera state to on

    } catch (error) {
      console.error('Error opening camera:', error);
    }
  }

  function stopCamera() {
    if (stream) {
      stream.getTracks().forEach(track => track.stop());
      stream = null;
    }
    const videoElement = document.querySelector('video');
    if (videoElement) {
      videoElement.srcObject = null;
    }
    const bgBlackElement = document.querySelector('.bg-black');
    if (bgBlackElement) {
      bgBlackElement.style.display = 'block';
    }

    const closeCamera = document.getElementById('openCamera');
    closeCamera.innerHTML = 'Open Camera';

    isCameraOn = false; // Set the camera state to off
  }



  async function startRecording() {
    isRecording = true;
    

    const startRecord = document.getElementById('record');
    startRecord.style.display = 'none';

    if (recorder && recorder.state === 'inactive') { // if cam is open, start recording
      countDown = parseInt(document.getElementById('count-down-input').value);
      duration = parseInt(document.getElementById('duration-input').value);

      const countDownText = document.getElementById('count-down-text');
      const recordingText = document.getElementById('recording-text');
      countDownText.innerHTML = countDown;

      const intervalId = setInterval(() => {
        countDown--;
        countDownText.innerHTML = countDown;
        if (countDown <= 0) {
          clearInterval(intervalId);
          countDownText.style.display = "none";

          try {
            recordingText.innerHTML = "Recording...";
            recorder.start();
            console.log('Recording video ...');

            setTimeout(() => {
              stopRecording();
              recordingText.innerHTML = "";
            }, duration * 1000);
          } catch (error) {
            console.error('Error starting recording:', error);
          }
        }
      }, 1000);
    }
}

  async function stopRecording() {
    if (recorder && recorder.state === 'recording') {
      recorder.stop();
      isRecording = false;
      console.log('Stopped recording video.');
      recorder.addEventListener('stop', () => {
      
        previewVideo();
          // if (confirm('Do you want to download the video?')) {
          //   downloadVideo();
          // }
      });
    }
  }

  function previewVideo() {
    const modalVideo = document.getElementById('previewVideo');
      
    const blob = new Blob(chunks, { type: 'video/webm' });
    const videoURL = URL.createObjectURL(blob);

    modalVideo.src = videoURL;

    const modal = new bootstrap.Modal(document.getElementById('previewVideoModal'));
    modal.show();

    const downloadButton = document.getElementById('download-button');
    downloadButton.removeEventListener('click', downloadVideo);
    downloadButton.addEventListener('click', downloadVideo);

    const closeModalButton = document.querySelector('#previewVideoModal .btn-close');
    closeModalButton.removeEventListener('click', () => closeModal(modal));

    const startRecord = document.getElementById('record');
    startRecord.style.display = 'block';
  }

  function downloadVideo() {
    const blob = new Blob(chunks, { type: 'video/mp4' });
    const url = URL.createObjectURL(blob);
    
    // get users input for video name
    const filename = prompt('Enter a name for the video file:', 'recorded-video');
    // if prompt is cancelled, skip the file save
    if (!filename) {
      return;
    }
    const a = document.createElement('a');
    document.body.appendChild(a);
    a.style = 'display: none';
    a.href = url;
    a.download = filename + '.mp4';
    // a.click();
    window.URL.revokeObjectURL(url);
    chunks = []; 
    
    const newRecord = {
      id: records.length + 1,
      name: filename,
      class: 'ThumbsUp', 
      duration: duration
    };

    records.push(newRecord);

    localStorage.setItem('records', JSON.stringify(records));

    // close modal
    const modal = document.getElementById('previewVideoModal');
    const bootstrapModal = bootstrap.Modal.getInstance(modal);
    bootstrapModal.hide();

    // list the records on the table
    const tableBody = document.querySelector('tbody');
    const tableRow = document.createElement('tr');

    const idCell = document.createElement('th');
    idCell.setAttribute('scope', 'row');
    idCell.innerHTML = newRecord.id;
    tableRow.appendChild(idCell);

    // add mame to recorded video
    const nameCell = document.createElement('td');
    const nameInput = document.createElement('input');
    nameInput.setAttribute('type', 'text');
    nameInput.setAttribute('id', `name-input-${newRecord.id}`);
    nameInput.setAttribute('value', newRecord.name);
    nameInput.addEventListener('blur', () => saveName(newRecord.id));
    nameCell.appendChild(nameInput);
    tableRow.appendChild(nameCell);

    // add class to recorded video
    const classCell = document.createElement('td');
    const classSelect = document.createElement('select');
    classSelect.setAttribute('value', newRecord.class);
    classSelect.addEventListener('change', () => saveName(newRecord.id));
    const thumbsUpOption = document.createElement('option');
    thumbsUpOption.setAttribute('value', 'ThumbsUp');
    thumbsUpOption.innerHTML = 'ThumbsUp';
    classSelect.appendChild(thumbsUpOption);
    const thumbsDownOption = document.createElement('option');
    thumbsDownOption.setAttribute('value', 'ThumbsDown');
    thumbsDownOption.innerHTML = 'ThumbsDown';
    classSelect.appendChild(thumbsDownOption);
    const peaceSignOption = document.createElement('option');
    peaceSignOption.setAttribute('value', 'PeaceSign');
    peaceSignOption.innerHTML = 'PeaceSign';
    classSelect.appendChild(peaceSignOption);
    classCell.appendChild(classSelect);
    tableRow.appendChild(classCell);

    // add duration to recorded video
    const durationCell = document.createElement('td');
    durationCell.innerHTML = newRecord.duration;
    tableRow.appendChild(durationCell);
    tableBody.appendChild(tableRow);

    // add delete button to recorded video
    const deleteCell = document.createElement('td');
    const deleteButton = document.createElement('button');
    deleteButton.setAttribute('class', 'btn btn-danger');
    deleteButton.innerHTML = '<i class="fas fa-trash"></i>'; // Replace the button content with the trash can icon
    deleteButton.addEventListener('click', () => deleteRecord(newRecord.id));
    deleteCell.appendChild(deleteButton);
    tableRow.appendChild(deleteCell);

  }

  function deleteRecord(id) {
    const record = records.find(r => r.id === id);
    const index = records.indexOf(record);
    records.splice(index, 1);

    const tableBody = document.querySelector('tbody');
    const tableRow = document.getElementById(`record-${id}`);
    
    if (tableBody && tableRow) {
      tableBody.removeChild(tableRow);
    }
  }


</script>


<div class="row">
	<div class="col-3"  style="margin-right: 100px;">
  
		<form>
			<fieldset>
        <h5 class="my-4">Options:</h5>
				<div class="input-group">
					<select class="form-select" id="inputGroupSelect02">
						<option selected>ThumbsUp</option>
						<option>ThumbsDown</option>
						<option>Peace</option>
					</select>
					<button class="btn btn-dark input-group-text">+</button>
				</div>
				<div class="input-group">
          <span class="input-group-text w-75">Count Down</span>
          <input type="number" aria-label="First name" class="form-control" value="3" id="count-down-input"/>
        </div>
        <div class="input-group">
          <span class="input-group-text w-75">Duration</span>
          <input type="number" aria-label="First name" class="form-control" value="3" id="duration-input"/>
        </div>
				<div class="input-group">
					<span class="input-group-text w-75">Repetitions</span>
					<input type="number" aria-label="First name" class="form-control" value="1"/>
				</div>
        {#if !isPlaying}
        <button id="openCamera" type="submit" class="btn btn-dark w-100 text-center mt-2" on:click={openCamera}>Open Camera</button>
        {/if} 
				<button id="record" type="submit" class="btn btn-dark w-100 text-center mt-2" on:click={startRecording}>Record</button>
       
      

        <br>
        <p id="count-down-text" style="text-align:center"></p>
        <p id="recording-text" style="text-align:center"></p>
	    </fieldset>
		</form>
	</div>
	<div class="col-8 bg-dark" style="height:{height}" bind:offsetWidth={width}>
    <div class="icon-container">
      <video width="2640" height="480" style="height:{height}" bind:offsetWidth={width} autoplay muted></video>
      <!-- svelte-ignore a11y-click-events-have-key-events -->
      {#if !isPlaying}
        <!-- <img id="play" src="/src/routes/img/play.png" alt="Icon" class="icon" style="" on:click={openCamera}>

 <button id="play" class="icon" style="display: flex; justify-content: center; align-items: center;margin-right:880px;margin-top:170px;" on:click={openCamera}>Start Camera</button> -->
      {:else}
        <!-- <img id="pause" src="/src/routes/img/stop.png" alt="Icon" class="icon" style="display: flex; justify-content: center; align-items: center;" on:click={stopCamera}> -->
      {/if} </div>
  </div>
  
 
  <div class="modal" id="previewVideoModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Preview Video</h5>
          <button type="button" class="btn-close" on:click={() => closeModal()} aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <video id="previewVideo" controls class="w-100" autoplay>
            <track kind="captions" />
          </video>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id="download-button"> Save & Download Video</button>
        </div>
      </div>
    </div>
  </div>
  
  
  
  
</div>

<hr class="my-4">

<div class="row mb-5">
  <h1>Records</h1>
  <table class="table" style="text-align:center">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">Name</th>
        <th scope="col">Class</th>
        <th scope="col">Duration (s)</th>
      </tr>
    </thead>
    <tbody>
      {#each records as record (record.id)}
        <tr id="record-{record.id}">
          <th scope="row">{record.id}</th>
          <td>
            <input type="text" id="name-input-{record.id}" bind:value={record.name} on:blur={() => saveName(record.id)} />
          </td>
          <td>
            <select bind:value={record.class} style="text-align:center">
              <option value="ThumbsUp">ThumbsUp</option>
              <option value="ThumbsDown">ThumbsDown</option>
              <option value="PeaceSign">Peace</option>
            </select>
          </td>
          <td>{record.duration}</td>
          <td>
            <button class="btn btn-danger" on:click={() => deleteRecord(record.id)}>
              <i class="fas fa-trash"></i>
            </button>
          </td>
        </tr>
      {/each}

    </tbody>
    
  </table>
</div>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"  />
<style>
   
  .icon-container {
    display: flex;
    justify-content: center;
    align-items: center;
    
  }

  #play {
    display: block;
    max-width: 10%;
    max-height: 10%;
  }

  #pause {
    display: block;
    margin: auto;
    max-width: 6.5%;
    max-height: 6.5%;
  }
  
  #previewVideo {
    max-width: 100%;
    max-height: 60vh;
  }


</style>