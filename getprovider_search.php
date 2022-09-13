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
		$province_provider = $_GET['province_provider'];
		$district_provider = $_GET['district_provider'];


		  if ($_GET['function'] == '1') {

		  	$result = mysqli_query($link, "SELECT *
FROM tb_service_provider_car
INNER JOIN tb_provider ON tb_provider.phone_provider = tb_service_provider_car.phone_provider WHERE tb_provider.district_provider = '$district_provider' AND tb_provider.province_provider = '$province_provider' and tb_service_provider_car.type = 'รถเกี่ยวข้าว' and tb_service_provider_car.phone_provider != '$phone_provider' ;  ");

		   
        }
        if ($_GET['function'] == '2') {

        	$result = mysqli_query($link, "SELECT *
FROM tb_service_provider_car
INNER JOIN tb_provider ON tb_provider.phone_provider = tb_service_provider_car.phone_provider WHERE tb_provider.district_provider = '$district_provider' AND tb_provider.province_provider = '$province_provider' and tb_service_provider_car.type = 'รถแทรกเตอร์' and tb_service_provider_car.phone_provider != '$phone_provider' ;  ");
            
        }
        if ($_GET['function'] == '3') {

        	$result = mysqli_query($link, "SELECT *
FROM tb_service_provider_car
INNER JOIN tb_provider ON tb_provider.phone_provider = tb_service_provider_car.phone_provider WHERE tb_provider.district_provider = '$district_provider' AND tb_provider.province_provider = '$province_provider' and tb_service_provider_car.type = 'รถดำนา' and tb_service_provider_car.phone_provider != '$phone_provider' ;  ");
            
        }
        if ($_GET['function'] == '4') {

        	$result = mysqli_query($link, "SELECT *
FROM tb_service_provider_car
INNER JOIN tb_provider ON tb_provider.phone_provider = tb_service_provider_car.phone_provider WHERE tb_provider.district_provider = '$district_provider' AND tb_provider.province_provider = '$province_provider' and tb_service_provider_car.type = 'โดรน' and tb_service_provider_car.phone_provider != '$phone_provider' ;  ");
           
        }
        if ($_GET['function'] == '5') {

        	$result = mysqli_query($link, "SELECT *
FROM tb_service_provider_labor
INNER JOIN tb_provider ON tb_provider.phone_provider = tb_service_provider_labor.phone_provider WHERE tb_provider.district_provider = '$district_provider' AND tb_provider.province_provider = '$province_provider' and tb_service_provider_labor.type = 'เพาะปลูก' and tb_service_provider_labor.phone_provider != '$phone_provider' ;  ");
           
        }
        if ($_GET['function'] == '6') {

        	$result = mysqli_query($link, "SELECT *
FROM tb_service_provider_labor
INNER JOIN tb_provider ON tb_provider.phone_provider = tb_service_provider_labor.phone_provider WHERE tb_provider.district_provider = '$district_provider' AND tb_provider.province_provider = '$province_provider' and tb_service_provider_labor.type = 'เก็บเกี่ยว' and tb_service_provider_labor.phone_provider != '$phone_provider' ;  ");
           
        }





		

		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} else echo "Welcome Master UNG";	// if2
   
}	// if1


	mysqli_close($link);
?>