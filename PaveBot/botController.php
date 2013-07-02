<?php
$con = mysqli_connect('localhost','root','','pavebot');
if(!$con){
  die('Could not connect: ' . mysqli_error($con));
}

if( isset($_POST['whatnext']))
{
  $currentLocation = $_POST['whatnext'];
  
  //Attempt to calculate next best location based on current location
  
  $locations = explode(",", $currentLocation, 3);
  
  //$x = locations[0];
  //$y = locations[1];
  //$z = locations[2];
  
  $query = "SELECT * FROM chunks WHERE finished = 0 LIMIT 1;";
  
  $result = mysqli_query($con, $query);
  
  if (!$result) {
    die('Invalid query: ' . mysql_error());
  }
  while($row = mysqli_fetch_array($result))
  {
    echo $row['x'] . ",";
    echo $row['y'] . ",";
    echo $row['z'];
  }
  mysqli_close($con);
}
?>
