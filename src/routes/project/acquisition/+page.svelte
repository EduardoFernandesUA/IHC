<script lang='ts'>
  let width: number, height: string;

  $: height = (width*(1/2)) + 'px';
    
  let stream;
  let recorder;
  let chunks = [];
  let isPlaying = false;
  let isRecording = false;



  async function openCamera() {
    isPlaying = true;
    try {
      // Get access to the camera
      stream = await navigator.mediaDevices.getUserMedia({ video: true });
      const videoElement = document.querySelector('video');

      // Display the camera stream in a video element
      videoElement.srcObject = stream;

      // Create a MediaRecorder instance to record the video
      recorder = new MediaRecorder(stream);

      // Listen for data available events and collect the video chunks
      recorder.addEventListener('dataavailable', event => {
        chunks.push(event.data);
      });

      // Start recording
      recorder.start();
    } catch (error) {
      console.error('Error opening camera:', error);
    }
  }

  async function startRecording() {
  isRecording = true;
  if (!isPlaying) {
    // If camera is not open, open it
    await openCamera();
  }

  // Show the pause button and hide the play button
  const startRecord = document.getElementById('record');
  startRecord.style.display = 'none';

  if (recorder && recorder.state === 'inactive') {
    try {
      recorder.start();
      console.log('Recording video ...');
    } catch (error) {
      console.error('Error starting recording:', error);
    }
  }
}


  async function stopRecording() {
    if (recorder && recorder.state === 'recording') {
      recorder.stop();
      isRecording = false;
      console.log('Stopped recording video.');
    }
  }


  
</script>


<div class="row">
	<div class="col-3"  style="margin-right: 100px;">
		<form>
			<fieldset>
                <h3 class="my-4">Options:</h3>
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
					<input type="number" aria-label="First name" class="form-control" value="3"/>
				</div>
				<div class="input-group">
					<span class="input-group-text w-75">Duration</span>
					<input type="number" aria-label="First name" class="form-control" value="3"/>
				</div>
				<div class="input-group">
					<span class="input-group-text w-75">Repetitions</span>
					<input type="number" aria-label="First name" class="form-control" value="2"/>
				</div>
				<button id="record" type="submit" class="btn btn-dark w-100 text-center mt-2" on:click={startRecording}>Record</button>
        {#if isRecording}
          <button id="StopRecord" type="submit" class="btn btn-dark w-100 text-center mt-2" on:click={stopRecording}>Stop Record</button>
        {/if}
	</fieldset>
		</form>
	</div>
	<div class="col-8 " style="height:{height}" bind:offsetWidth={width}>
    <div class="icon-container">
      <video width="2640" height="480" style="height:{height}" bind:offsetWidth={width} autoplay muted></video>
      <!-- svelte-ignore a11y-click-events-have-key-events -->
      {#if !isPlaying}
        <img id="play" src="/src/routes/img/play.png" alt="Icon" class="icon" style="display: flex; justify-content: center; align-items: center;margin-right:880px;margin-top:170px;" on:click={openCamera}>
      {:else}
        <!-- <img id="pause" src="/src/routes/img/stop.png" alt="Icon" class="icon" style="display: flex; justify-content: center; align-items: center;" on:click={stopCamera}> -->
      {/if} </div>
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
            <th scope="col" >Duration (s)</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">1</th>
            <td>video_#1</td>
            <td>ThumbsUp</td>
            <td>4</td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>ThumbsDown123</td>
            <td>ThumbsDown</td>
            <td>3.5</td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>video589</td>
            <td>PeaceSign</td>
            <td>8</td>
          </tr>
        </tbody>
      </table>
</div>

<style>
  .icon-container {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  #play {
    display: block;
    margin: auto;
    max-width: 10%;
    max-height: 10%;
  }

  #pause {
    display: block;
    margin: auto;
    max-width: 6.5%;
    max-height: 6.5%;
  }
  

</style>
