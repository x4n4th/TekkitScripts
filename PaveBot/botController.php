<?php
$con = mysqli_connect('localhost','root','','pavebot');
if(!$con){
  die('Could not connect: ' . mysqli_error($con));
}

/*Give the bots current locations it will return a chunk that needs
  attention. Pattern is ChunkID, X, Y, Z in [1,12,34,56]
*/

if( isset($_POST['whatnext'])){
  $currentLocation = $_POST['whatnext'];
  
  //Attempt to calculate next best location based on current location
  
  $locations = explode(",", $currentLocation, 3);
  
  //$x = locations[0];
  //$y = locations[1];
  //$z = locations[2];
  
  $query = "SELECT * FROM chunks WHERE finished = 0 AND inProgress = 0 LIMIT 1;";
  
  $result = mysqli_query($con, $query);
  
  if (!$result) {
    die('Invalid query: ' . mysql_error());
  }
  $id = null
  while($row = mysqli_fetch_array($result))
  {
    $id = $row['Id'];
    echo $id . ",";
    echo $row['x'] . ",";
    echo $row['y'] . ",";
    echo $row['z'];
  }
  
  mysqli_query($con,"UPDATE chunks SET inProgress = 1 WHERE Id = " . $id);
  mysqli_close($con);
} elseif ( isset($_POST['finished'])){ //Given a chunk set finished
  $id = $_POST['finished'];
  mysqli_query($con,"UPDATE chunks SET inProgress = 0 WHERE Id = " . $id);
  mysqli_query($con,"UPDATE chunks SET finished = 1 WHERE Id = " . $id);
}
?>
