<script lang='ts'>


    let width: number, height: string;

    $: height = (width*(3/4)) + 'px';
    
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
        console.log(chunks)
        });

        
    } catch (error) {
        console.error('Error opening camera:', error);
    }
    document.querySelector('.bg-black').style.display = 'none';
    }

    async function startRecording() {
    isRecording = true;
    if (!isPlaying) { // if cam not open, open it
        await openCamera();
    }

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
        previewVideo()
    }
    }

    function previewVideo() {
        // Get the video element from the modal
        const modalVideo = document.getElementById('previewVideo');
        
        // Create a URL for the recorded video
        const blob = new Blob(chunks, { type: 'video/webm' });
        const videoURL = URL.createObjectURL(blob);

        // Set the source of the modal video element to the URL
        modalVideo.src = videoURL;

        // Show the modal
        const modal = new bootstrap.Modal(document.getElementById('previewVideoModal'));
        modal.show();

        // Add event listener to the download button
        const downloadButton = document.getElementById('download-button');
        downloadButton.removeEventListener('click', downloadVideo);
        downloadButton.addEventListener('click', downloadVideo);
        }

        function downloadVideo() {
        const blob = new Blob(chunks, { type: 'video/mp4' });
        const url = URL.createObjectURL(blob);
        
        // Prompt the user for the filename
        const filename = prompt('Enter a name for the video file:', 'recorded-video');
        const a = document.createElement('a');
        document.body.appendChild(a);
        a.style = 'display: none';
        a.href = url;
        a.download = filename + '.mp4'; // Add the filename to the download link
        a.click();
        window.URL.revokeObjectURL(url);
        chunks = []; // Clear the chunks array
    }




  </script>
  
  
  <div class="row">
      <div class="col-3"  style="margin-right: 100px;">
        <h5 class="my-4">Media Pipe Feature Calculator</h5>
          <form>
              <fieldset>
                
                  
                <div class="input-group">
                    <div class="input-group-text">
                        <input class="form-check-input mt-0" type="checkbox" value="" aria-label="Checkbox for following text input">
                    </div>
                    <span class="input-group-text" style="flex-grow: 1;">MediaPipe - Hand Gesture</span>
                    
                </div>

                <div class="input-group ">
                    <div class="input-group-text">
                        <input class="form-check-input mt-0" type="checkbox" value="" aria-label="Checkbox for following text input">
                    </div>
                    <span class="input-group-text" style="flex-grow: 1;">MediaPipe - Pose Detection</span>
                    
                </div>

                <div class="input-group">
                    <div class="input-group-text">
                        <input class="form-check-input mt-0" type="checkbox" value="" aria-label="Checkbox for following text input">
                    </div>
                    <span class="input-group-text" style="flex-grow: 1;">MediaPipe - Holistic Detection</span>
                    
                </div>
              </fieldset>
          </form>

          {#if !isPlaying}
          <button id="record" type="submit" class="btn btn-dark w-100 text-center mt-2" on:click={openCamera}>Open Camera</button>
          {/if} 
                  <button id="record" type="submit" class="btn btn-dark w-100 text-center mt-2" on:click={startRecording}>Record</button>
          
        
    </div>
    <div class="col-8 bg-dark" style="height:{height}" bind:offsetWidth={width}>
        <div class="icon-container">
          <video width="2640" height="480" style="height:{height}" bind:offsetWidth={width} autoplay muted></video>
          <!-- svelte-ignore a11y-click-events-have-key-events -->
          {#if !isPlaying}
           <!-- <img id="play" src="/src/routes/img/play.png" alt="Icon" class="icon" style="display: flex; justify-content: center; align-items: center; margin: 0 auto;" on:click={openCamera}>
    
            <!--<button id="play" class="icon" style="display: flex; justify-content: center; align-items: center;margin-right:880px;margin-top:170px;" on:click={openCamera}>Start Camera</button> -->
          {:else}
            <!-- <img id="pause" src="/src/routes/img/stop.png" alt="Icon" class="icon" style="display: flex; justify-content: center; align-items: center;" on:click={stopCamera}> -->
          {/if}
      
          
        </div>
        <br>
        <p  style="text-align:center">
            Guessed Class: Thumbsup <br>
            Accuracy: 0.89
        </p>

    </div>

    
  </div>
  
  
  <style>
    .icon-container {
      display: flex;
      justify-content: center;
      align-items: center;
    }
  
    .icon {
      display: block;
      margin: auto;
      max-width: 10%;
      max-height: 10%;
    }
  </style>
  