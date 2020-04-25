<?php

header('X-Frame-Options: DENY');
header('X-XSS-Protection: 1; mode=block');
header('X-Content-Type-Options: nosniff');


  include('db.php');

     $email = mysqli_real_escape_string($conn, $_POST['email']);
 
 if(isset($email))
 
 {
 
     $password = mysqli_real_escape_string($conn, $_POST['password']);

     $profile_query = "SELECT  `email`  FROM `users` WHERE email = '$email' AND password = '$password'";

	 $run = mysqli_query($conn,$profile_query);
	 
	
  
  if ($run->num_rows > 0)
        {
    // output data of each row
    while($row = $run->fetch_assoc()) 
                    {

                    $myObj->email = $row["email"];
                    $myJSON= json_encode($myObj);
                    echo $myJSON;
                    
                      }
              } 
              else 
              {
                    $myObj->email = 'noEmail';
                    $myJSON= json_encode($myObj);
                    echo $myJSON;
              }
   
	  
 }
	 
	 

?>




