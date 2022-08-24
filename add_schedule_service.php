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
		
		$id_service = $_GET['id_service'];
		$phone_user = $_GET['phone_user'];
		$phone_provider = $_GET['phone_provider'];
		$date_work = $_GET['date_work'];
		$count_field = $_GET['count_field'];
		$total_price = $_GET['total_price'];
		$map_lat_work = $_GET['map_lat_work'];
		$map_long_work = $_GET['map_long_work'];
		$type_service = $_GET['type_service'];
		

	$nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
    $selectdatabooking = "SELECT * from tb_provider where id_provider = '" . $num . "' ";
    $objselect = mysqli_query($link, $selectdatabooking);
    $Resultselect = mysqli_fetch_array($objselect ,MYSQLI_ASSOC);
    while (!is_null($Resultselect)) {
    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);

    }
    $num = "sc_".$nums."";
							
		$sql = "INSERT INTO `tb_schedule_service`( `id_schedule`, `id_service`, `phone_user`, `phone_provider`, `date_work`, `count_field`, `total_price`, `map_lat_work`, `map_long_work`, `status` ,`action` ,`type_service` ) VALUES ('$num','$id_service','$phone_user','$phone_provider','$date_work','$count_field','$total_price','$map_lat_work','$map_long_work','0','ucp' ,'$type_service' )";

		$sql2 = "INSERT INTO `tb_schedule_service`( `id_schedule`, `id_service`, `phone_user`, `phone_provider`, `date_work`, `count_field`, `total_price`, `map_lat_work`, `map_long_work`, `status` ,`action`,`type_service` ) VALUES ('$num','$id_service','$phone_user','$phone_provider','$date_work','$count_field','$total_price','$map_lat_work','$map_long_work','0','urp','$type_service' )";

		

		

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
