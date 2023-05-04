<script lang='ts'>
    let width: number, height: string;
    
    $: height = (width*(3/4)) + 'px';

    
</script>


<div class="row">
	<div class="col-3">
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
					<input type="number" aria-label="First name" class="form-control" />
				</div>
				<div class="input-group">
					<span class="input-group-text w-75">Duration</span>
					<input type="number" aria-label="First name" class="form-control" />
				</div>
				<div class="input-group">
					<span class="input-group-text w-75">Repetitions</span>
					<input type="number" aria-label="First name" class="form-control" />
				</div>
				<button type="submit" class="btn btn-dark w-100 text-center mt-2">Record</button>
			</fieldset>
		</form>
	</div>
	<div class="col-9 bg-dark">
    <div class="video-container">
      <video id="video-preview" ></video>
      <button id="record-btn">Record</button>
      <button id="stop-btn">Stop</button>
    </div>
  </div>

</div>

<hr class="my-4">

<div class="row mb-5">
    <h1>Records</h1>
    <table class="table">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td colspan="2">Larry the Bird</td>
            <td>@twitter</td>
          </tr>
        </tbody>
      </table>
</div>

<style>
</style>
