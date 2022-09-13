<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('103.212.181.59', 'adminkaiser', 'a4521050001', "agriser_data","3888");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {


        $phone_user = $_GET['phone_user'];

        if ($_GET['function'] == '1') {
		    $result = mysqli_query($link, "SELECT * FROM tb_service_provider_car where type = 'รถเกี่ยวข้าว' and phone_provider = '$phone_user'  ");
        }
        if ($_GET['function'] == '2') {
            $result = mysqli_query($link, "SELECT * FROM tb_service_provider_car where type = 'รถแทรกเตอร์' and phone_provider = '$phone_user' ");
        }
        if ($_GET['function'] == '3') {
            $result = mysqli_query($link, "SELECT * FROM tb_service_provider_car where type = 'รถดำนา' and phone_provider = '$phone_user' ");
        }
        if ($_GET['function'] == '4') {
            $result = mysqli_query($link, "SELECT * FROM tb_service_provider_car where type = 'โดรน'  and phone_provider = '$phone_user' ");
        }
        if ($_GET['function'] == '5') {
            $result = mysqli_query($link, "SELECT * FROM tb_service_provider_labor where type = 'เพาะปลูก' and phone_provider = '$phone_user' ");
        }
        if ($_GET['function'] == '6') {
            $result = mysqli_query($link, "SELECT * FROM tb_service_provider_labor where type = 'เก็บเกี่ยว' and phone_provider = '$phone_user' ");
        }
        
		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} else echo "Welcome Master UNG";	// if2
   
}	// if1


	mysqli_close($link);
