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
		$id_presentwork = $_GET['id_presentwork'];
		

		// $result = mysqli_query($link, "SELECT * FROM tb_schedule_presentwork where phone_user = '$phone_user' and (status = '0' or status = '1' or status = '4' or status = '5') and action = 'pru'  ");



		$result = mysqli_query($link, "SELECT * 
FROM tb_schedule_presentwork 
INNER join tb_presentwork_user_car ON tb_presentwork_user_car.id_presentwork = tb_schedule_presentwork.id_presentwork where  tb_schedule_presentwork.phone_user = '$phone_user' and tb_schedule_presentwork.id_presentwork = '$id_presentwork' and (status = '1' or status = '4' or status = '5') and action = 'pru'  ");

		


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