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
		$phone_user = $_GET['phone_user'];
				
		
		$rice = $_GET['rice'];
		$sweetcorn = $_GET['sweetcorn'];
		$cassava = $_GET['cassava'];
		$sugarcane = $_GET['sugarcane'];
		$chili = $_GET['chili'];
		$yam = $_GET['yam'];
		$palm = $_GET['palm'];
		$bean = $_GET['bean'];
		
		


		$sql = "UPDATE tb_presentwork_user_labor SET  rice = '$rice' , sweetcorn = '$sweetcorn' ,cassava = '$cassava' ,sugarcane = '$sugarcane' ,chili = '$chili' ,yam = '$yam' ,palm = '$palm' ,bean = '$bean' ,prices = '$prices' , status = '1', type_presentwork = '$type' , count_field = '$brand', date_work = '$date_buy', details = '$prices', prices = '$model'   WHERE phone_user = '$phone_user' and status = '0' ";

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