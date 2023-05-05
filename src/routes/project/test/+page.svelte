<script lang='ts'>
    let width: number, height: string;
  
    $: height = (width*(1/2)) + 'px';
      
  </script>
  
  
  <div class="row">
      <div class="col-3"  style="margin-right: 100px;text-align:center">
          <form>
              <fieldset>
                <div class="input-group mb-3" >
                    <h5 >Media Pipe Feature Calculator</h5>
                    <!--<label class="" for="inputGroupSelect01" style="background-color: white; color: black;">Media Pipe Feature Calculator</label>
                    <select class="form-select h-100" id="inputGroupSelect01">
                          <option selected>Choose...</option>
                          <option value="1">Model 1</option>
                          <option value="2">Model 2</option>
                          <option value="3">Model 3</option>
                        </select> -->
                  </div>
                  
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
      </div>
        <div class="col-8 bg-dark" style="height:{height}" bind:offsetWidth={width}>
            <div class="icon-container">
                <img src="/src/routes/img/play.png" alt="Icon" class="icon" style="filter: brightness(0) saturate(100%) invert(100%); display: flex; justify-content: center; align-items: center;top: 10%;transform: translateY(200%);">
            </div>

           <p  style="margin-top: 380px;text-align:center">
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
      filter: invert(1);
      max-width: 10%;
      max-height: 10%;
    }
  </style>
  