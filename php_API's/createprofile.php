<?php
include("db.php");

$email = $_POST['email'];

if (isset($email)) {
    
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    
    $profile_Pic      = mysqli_real_escape_string($conn, $_POST['profile_pic']);
    $profile_Pic_Name = mysqli_real_escape_string($conn, $_POST['profile_pic_name']);
    $realProfilePic   = base64_decode($profile_Pic);
    
    $contact_no = mysqli_real_escape_string($conn, $_POST['contact_no']);
    
    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
    
    $Date = mysqli_real_escape_string($conn, $_POST['date']);
    
    $checkemail = "SELECT * FROM `users` WHERE email = '$email'";
    
    $result = mysqli_query($conn, $checkemail);
    
    
    if ($result) {
        $rowcount = mysqli_num_rows($result);
        // printf("Result set has %d rows.\n",$rowcount);
        if ($rowcount == 0) {
            
            
            $sql = "INSERT INTO `users`(`name`, `email`, `password`, `contact_no`, `gender`, `profile_picture`, `date`) VALUES ('$name', '$email', '$password', '$contact_no', '$gender', '$profile_Pic_Name', '$Date')";
            
            $inserteduser = mysqli_query($conn, $sql);
       
            if ($inserteduser) 
            {
                
                file_put_contents('profilepictures/' . $profile_Pic_Name, $realProfilePic);                        
                $myObj->status = "updated";
                $myJSON        = json_encode($myObj);
                echo $myJSON;             
            } 
            else 
            {
                $myObj->status = "not updated";
                $myJSON        = json_encode($myObj);
                echo $myJSON;
            }
        } 
        else 
        {
            $myObj->status = "exist";
            $myJSON        = json_encode($myObj);
            echo $myJSON;
        }
        
    } 
    else 
    {
        $myObj->status = "not updated";
        $myJSON        = json_encode($myObj);
        echo $myJSON;
    }
    
} 
else 
{
    $myObj->status = "not updated";
    $myJSON        = json_encode($myObj);
    echo $myJSON;
}

?>
