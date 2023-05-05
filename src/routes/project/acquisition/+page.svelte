<script lang='ts'>
  let width: number, height: string;

  $: height = (width*(1/2)) + 'px';
    
  let stream;
  let recorder;
  let chunks = [];
  let isPlaying = false;
  let isRecording = false;
  let countDown = 0;
  let duration = 0;

  async function openCamera() {
    isPlaying = true;
    try {
      // cam
      stream = await navigator.mediaDevices.getUserMedia({ video: true }); // only video no audio
      const videoElement = document.querySelector('video'); // only vid

      videoElement.srcObject = stream; 
 
      recorder = new MediaRecorder(stream); 

      recorder.addEventListener('dataavailable', event => { 
        chunks.push(event.data);
      });

      if (isRecording) {
        recorder.start(); // starts recording
      }
    } catch (error) {
      console.error('Error opening camera:', error);
    }
  }

  async function startRecording() {
    isRecording = true;
    if (!isPlaying) {
      await openCamera();
    }

    const startRecord = document.getElementById('record');
    startRecord.style.display = 'none';

    if (recorder && recorder.state === 'inactive') {
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
        // Ask user if they want to download the video
        if (confirm('Do you want to download the video?')) {
          downloadVideo();
        }
      });
    }
  }

  function downloadVideo() {
    const blob = new Blob(chunks, { type: 'video/webm' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    document.body.appendChild(a);
    a.style = 'display: none';
    a.href = url;
    a.download = 'recorded-video.webm';
    a.click();
    window.URL.revokeObjectURL(url);
    chunks = []; 
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
          <input type="number" aria-label="First name" class="form-control" value="3" id="count-down-input"/>
        </div>
        <div class="input-group">
          <span class="input-group-text w-75">Duration</span>
          <input type="number" aria-label="First name" class="form-control" value="3" id="duration-input"/>
        </div>
				<div class="input-group">
					<span class="input-group-text w-75">Repetitions</span>
					<input type="number" aria-label="First name" class="form-control" value="2"/>
				</div>
				<button id="record" type="submit" class="btn btn-dark w-100 text-center mt-2" on:click={startRecording}>Record</button>
        {#if isRecording}
          <button id="StopRecord" type="submit" class="btn btn-dark w-100 text-center mt-2" on:click={stopRecording}>Stop Record</button>
        {/if}

        <br>
        <p id="count-down-text" style="text-align:center"></p>
        <p id="recording-text" style="text-align:center"></p>
	</fieldset>
		</form>
	</div>
	<div class="col-8" style="height:{height}" bind:offsetWidth={width}>
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
