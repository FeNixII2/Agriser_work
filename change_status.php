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
				
		$status = $_GET['status'];
		$id_schedule = $_GET['id_schedule'];

		$sql = "UPDATE tb_schedule_service_car SET status = '$status' WHERE id_schedule = '$id_schedule' and action = 'ucp' ";

		$sql2 = "UPDATE tb_schedule_service_car SET status = '$status' WHERE id_schedule = '$id_schedule' and action = 'urp' ";


		$result = mysqli_query($link, $sql);

		$result2 = mysqli_query($link, $sql2);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>