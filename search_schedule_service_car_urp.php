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


				
		$phone_provider = $_GET['phone_provider'];
		

		$result = mysqli_query($link, "SELECT * FROM tb_schedule_service where phone_provider = '$phone_provider' and (status = '0' or status = '1' or status = '4' or status = '5') and action = 'urp' ");


// 			$result = mysqli_query($link, "SELECT *

// 			FROM tb_schedule_service AS d1
// LEFT JOIN tb_service_provider_car AS d2 ON ( d1.id_service = d2.id_service) 
// LEFT JOIN tb_service_provider_labor AS d3 ON (d1.id_service = d3.id_service )
// WHERE  d1.phone_provider = '0931549549' and (status = '0' or status = '1' or status = '4' or status = '5') and action = 'urp' ");



		

		


		// WHERE phone_user = '$phone_user'

		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} 

		

	} else echo "Welcome Master UNG";	// if2
   
}	// if1


	mysqli_close($link);
?>