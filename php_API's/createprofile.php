<?php
include ("db.php");

$email = $_POST['email'];

if (isset($email))
{

    $name = mysqli_real_escape_string($conn, $_POST['name']);

    $password = mysqli_real_escape_string($conn, $_POST['password']);

    $profile_Pic = mysqli_real_escape_string($conn, $_POST['profile_pic']);
    $Profile_Pic_Name = mysqli_real_escape_string($conn, $_POST['profile_pic_name']);
    $RealProfilePic = base64_decode($Profile_Pic);

    $contact_no = mysqli_real_escape_string($conn, $_POST['contact_no']);

    $gender = mysqli_real_escape_string($conn, $_POST['gender']);

    $Date = mysqli_real_escape_string($conn, $_POST['date']);

    $checkemail = "SELECT * FROM `users` WHERE email = '$email'";

    $result = mysqli_query($conn, $checkemail);

     
    if ($result)
    {
		
        $rowcount = mysqli_num_rows($result);
        if ($rowcount == 0)
        {
               // checking if email already exists
      
            $sql = "INSERT INTO `users`(`name`, `email`, `password`, `contact_no`, `gender`, `profile_picture`, `date`) VALUES ('$name', '$email', '$password', '$contact_no', '$gender', '$Profile_Pic_Name', '$Date')";

            $inserteduser = mysqli_query($conn, $sql);

            

            if ($inserteduser)
            {

                  move_uploaded_file($RealProfilePic,'profilepictures/'.$profile_Pic);


                $myObj->status = "updated";
                $myJSON = json_encode($myObj);
                echo $myJSON;

            }
            else
            {
                $myObj->status = "not updated";
                $myJSON = json_encode($myObj);
                echo $myJSON;
            }
        }
        else
        {
            $myObj->status = "exist";
            $myJSON = json_encode($myObj);
            echo $myJSON;
        }

    }
    else
    {
        $myObj->status = "not updated";
        $myJSON = json_encode($myObj);
        echo $myJSON;
    }

}
else
{
    $myObj->status = "not updated";
    $myJSON = json_encode($myObj);
    echo $myJSON;
}

?>
