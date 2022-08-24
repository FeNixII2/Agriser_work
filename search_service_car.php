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
		$id_provider = $_GET['id_provider'];

		$result = mysqli_query($link, "SELECT * FROM tb_service_provider_car where phone_provider = '$phone_provider' and status_work = '0' ");

		


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