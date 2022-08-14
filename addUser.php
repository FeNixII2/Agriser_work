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
		$run_number = "SELECT count(id_run)'number' FROM tb_user";
		$count = mysqli_query($link, $run_number);
		$row=mysqli_fetch_assoc($count);
		$number = $row['number'] + 1;
		$id_number = $number;
		$tel = $_GET['tel'];
		$pass = $_GET['pass'];
		$name = $_GET['name'];
		$b_date = $_GET['date'];
		$sex = $_GET['sex'];
		$address = $_GET['address'];
		$province = $_GET['province'];
		$amphures = $_GET['amphures'];
		$email = $_GET['email'];
		$map_lat_user = $_GET['map_lat_user'];
		$map_long_user = $_GET['map_long_user'];

	$nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
	$selectdatabooking = "SELECT * from tb_user where id_user = '" . $num . "' ";
	$objselect = mysqli_query($link, $selectdatabooking);
	$Resultselect = mysqli_fetch_array($objselect ,MYSQLI_ASSOC);
	while (!is_null($Resultselect)) {
    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
	
	}
	$num = "U".$nums."";
	// printf($num);
							
		$sql = "INSERT INTO `tb_user`( `phone_user`, `password_user`, `name_user`,`email_user`,`date_user`,`sex_user`,`address_user`,`province_user`,`district_user`,`id_user`,`map_lat_user`,`map_long_user`) VALUES ('$tel','$pass','$name','$email','$b_date','$sex','$address','$province','$amphures','$num','$map_lat_user','$map_long_user')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
