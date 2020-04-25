<?php

header('X-Frame-Options: DENY');
header('X-XSS-Protection: 1; mode=block');
header('X-Content-Type-Options: nosniff');


  include('db.php');

     $email = mysqli_real_escape_string($conn, $_POST['email']);
 
 if(isset($email))
 
 {
 

     $profile_query = "SELECT `id`, `name`, `email`, `contact_no`, `profile_picture` FROM `users` WHERE email = '$email'";

	 $run = mysqli_query($conn,$profile_query);
	 
	
        $data_arr=array();
  	  
	  while($fetchData = $run->fetch_assoc())
	  {
		       // extract row
               // this will make $row['name'] to
              // just $name only
            extract($fetchData);


                $result = array (
                 
                    "id" => $id,
                    "Name" => $name,
                    "Email" => $email,
                    "Profile_Pic" => "www.yourdomian.com/profilepictures/".$profile_picture,
                    "contact_no" => $contact_no,
                   
        


                    
                );



          array_push($data_arr, $result);

	  }
	  
	   http_response_code(200);
 
    // show products data in json format
    echo json_encode($data_arr);
	  
 }
	 
	 

?>




