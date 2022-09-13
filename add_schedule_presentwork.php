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

	
	$id_presentwork = $_POST["id_presentwork"];
    $phone_user = $_POST["phone_user"];
    $phone_provider = $_POST["phone_provider"];
    $type_presentwork = $_POST["type_presentwork"];
    $show_img = $_POST["show_img"];
    $show_type = $_POST["show_type"];
    $show_servicename = $_POST["show_servicename"];
    $show_province = $_POST["show_province"];
    $show_datework = $_POST["show_datework"];
    $show_servicename_pro = $_POST["show_servicename_pro"];
    $show_province_pro = $_POST["show_province_pro"];
   


    
		
		

	$nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
    $selectdatabooking = "SELECT * from tb_provider where id_provider = '" . $num . "' ";
    $objselect = mysqli_query($link, $selectdatabooking);
    $Resultselect = mysqli_fetch_array($objselect ,MYSQLI_ASSOC);
    while (!is_null($Resultselect)) {
    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);

    }
    $num = "sc_".$nums."";


		$sql = "INSERT INTO `tb_schedule_presentwork`( 
			`id_schedule`,
		 	`id_presentwork`,
		 	`phone_user`, 
		 	`phone_provider`, 
		 	`status` ,
		 	`action` ,
		 	`type_presentwork`,
		 	`show_img`,
		 	`show_type`,
		 	`show_servicename`,
		 	`show_province`,
		 	`show_datework`,
		 	`show_servicename_pro`,
		 	`show_province_pro` ) 
			VALUES ('$num','$id_presentwork','$phone_user','$phone_provider','0','pcu' ,'$type_presentwork' ,'$show_img','$show_type','$show_servicename','$show_province','$show_datework','$show_servicename_pro','$show_province_pro' )";


		$sql2 = "INSERT INTO `tb_schedule_presentwork`( 
			`id_schedule`, 
			`id_presentwork`, 
			`phone_user`, 
			`phone_provider`, 
			`status` ,
			`action` ,
			`type_presentwork`,
			`show_img`,
		 	`show_type`,
		 	`show_servicename`,
		 	`show_province`,
		 	`show_datework`,
		 	`show_servicename_pro`,
		 	`show_province_pro`  ) 
			VALUES ('$num','$id_presentwork','$phone_user','$phone_provider','0','pru' ,'$type_presentwork' ,'$show_img','$show_type','$show_servicename','$show_province','$show_datework','$show_servicename_pro','$show_province_pro'  )";


		// if ($type_presentwork == 'car') {
		// 	$sql3 = "UPDATE tb_presentwork_user_car SET  status_work = '1' WHERE id_presentwork = '$id_presentwork' ";
		// }else{
		// 	$sql3 = "UPDATE tb_presentwork_user_labor SET  status_work = '1' WHERE id_presentwork = '$id_presentwork'  ";
		// }

		

		

		

		$result = mysqli_query($link, $sql);

		$result2 = mysqli_query($link, $sql2);

		$result3 = mysqli_query($link, $sql3);
		
	

		

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

		
	
   

	mysqli_close($link);
