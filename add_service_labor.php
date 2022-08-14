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
		
		$type = $_GET['type'];
		$rice = $_GET['rice'];
		$sweetcorn = $_GET['sweetcorn'];
		$cassava = $_GET['cassava'];
		$sugarcane = $_GET['sugarcane'];
		$chili = $_GET['chili'];
		$yam = $_GET['yam'];
		$palm = $_GET['palm'];
		$bean = $_GET['bean'];
		$prices = $_GET['prices'];
		$phone_provider = $_GET['phone_provider'];
		$name_provider = $_GET['name_provider'];
		$email_provider = $_GET['email_provider'];
		$address_provider = $_GET['address_provider'];
		$province_provider = $_GET['province_provider'];
		$district_provider = $_GET['district_provider'];
		$map_lat_provider = $_GET['map_lat_provider'];
		$map_long_provider = $_GET['map_long_provider'];
							

	$nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
    $selectdatabooking = "SELECT * from tb_provider where id_provider = '" . $num . "' ";
    $objselect = mysqli_query($link, $selectdatabooking);
    $Resultselect = mysqli_fetch_array($objselect ,MYSQLI_ASSOC);
    while (!is_null($Resultselect)) {
    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);

    }
    $num = "l_".$nums."";



		$sql = "INSERT INTO `tb_service_provider_labor`( `id_service`, `phone_provider`, `type`, `rice`,`sweetcorn`,`cassava`,`sugarcane`,`chili`,`yam`,`palm`,`bean`,`prices`,`name_provider`,`email_provider`,`address_provider`,`province_provider`,`district_provider`,`map_lat_provider`,`map_long_provider`) VALUES ('$num','$phone_provider','$type','$rice','$sweetcorn','$cassava','$sugarcane','$chili','$yam','$palm','$bean','$prices','$name_provider','$email_provider','$address_provider','$province_provider','$district_provider','$map_lat_provider','$map_long_provider')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>