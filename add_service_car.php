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
		$brand = $_GET['brand'];
		$model = $_GET['model'];
		$date_buy = $_GET['date_buy'];
		$prices = $_GET['prices'];
		
							// INSERT INTO `tb_service_provider_car`( `type`, `brand`, `model`, `date_buy`, `prices`) VALUES ('$type','$brand','$model','$date_buy','$prices')


		$sql = "UPDATE tb_service_provider_car SET type = '$type' , brand = '$brand' , model = '$model', date_buy = '$date_buy', prices = '$prices' WHERE id_provider = '556' ";

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