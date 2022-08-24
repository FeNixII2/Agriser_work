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
		$id_presentwork = $_GET['id_presentwork'];
		$id_schedule = $_GET['id_schedule'];
		$check_carlabor = $_GET['check_carlabor'];

		$sql = "UPDATE tb_schedule_presentwork SET status = '$status'  WHERE id_schedule = '$id_schedule' and action = 'pcu' ";

		$sql2 = "UPDATE tb_schedule_presentwork SET status = '$status'  WHERE id_schedule = '$id_schedule' and action = 'pru' ";


		$result = mysqli_query($link, $sql);

		$result2 = mysqli_query($link, $sql2);

	

		if ($status=="1") {

			if ($check_carlabor=="car") {
				$st1 = "UPDATE tb_presentwork_user_car SET status_work = '1'  WHERE id_presentwork = '$id_presentwork' ";

			$stt1 = mysqli_query($link, $st1);
			}else if ($check_carlabor=="labor") {
				$st1 = "UPDATE tb_presentwork_user_labor SET status_work = '1'  WHERE id_presentwork = '$id_presentwork' ";

			$stt1 = mysqli_query($link, $st1);
			}
			

			$sql = "UPDATE tb_schedule_presentwork SET status = '3'  WHERE id_presentwork = '$id_presentwork' and action = 'pcu' and id_schedule != '$id_schedule' ";

			$sql2 = "UPDATE tb_schedule_presentwork SET status = '3'  WHERE id_presentwork = '$id_presentwork' and action = 'pru' and id_schedule != '$id_schedule' ";


			$result = mysqli_query($link, $sql);

			$result2 = mysqli_query($link, $sql2);

			
		}
		if ($status=="2") {
			if ($check_carlabor=="car") {
				$st1 = "UPDATE tb_presentwork_user_car SET status_work = '2'  WHERE id_presentwork = '$id_presentwork' ";

			$stt1 = mysqli_query($link, $st1);
			}else if ($check_carlabor=="labor") {
				$st1 = "UPDATE tb_presentwork_user_labor SET status_work = '2'  WHERE id_presentwork = '$id_presentwork' ";

			$stt1 = mysqli_query($link, $st1);
			}

			$stt1 = mysqli_query($link, $st1);

			$sql = "UPDATE tb_schedule_presentwork SET status = '2'  WHERE id_schedule = '$id_schedule' and action = 'pcu' ";

			$sql2 = "UPDATE tb_schedule_presentwork SET status = '2'  WHERE id_schedule = '$id_schedule' and action = 'pru' ";


			$result = mysqli_query($link, $sql);

			$result2 = mysqli_query($link, $sql2);
			
		}
		if ($status=="3") {
			if ($check_carlabor=="car") {
				$st1 = "UPDATE tb_presentwork_user_car SET status_work = '0'  WHERE id_presentwork = '$id_presentwork' ";

			$stt1 = mysqli_query($link, $st1);
			}else if ($check_carlabor=="labor") {
				$st1 = "UPDATE tb_presentwork_user_labor SET status_work = '0'  WHERE id_presentwork = '$id_presentwork' ";

			$stt1 = mysqli_query($link, $st1);
			}

			$sql = "UPDATE tb_schedule_presentwork SET status = '3'  WHERE id_schedule = '$id_schedule' and action = 'pcu' ";

			$sql2 = "UPDATE tb_schedule_presentwork SET status = '3'  WHERE id_schedule = '$id_schedule' and action = 'pru' ";


			$result = mysqli_query($link, $sql);

			$result2 = mysqli_query($link, $sql2);
		}

		
		



		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>