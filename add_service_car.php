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



    
    $phone_provider = $_POST["phone_provider"];
    $type = $_POST["type"];
    $brand = $_POST["brand"];
    $model = $_POST["model"];
    $date_buy = $_POST["date_buy"];
    $prices = $_POST["prices"];
    $image1 = $_POST["image1"];
    $image2 = $_POST["image2"];


  

    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
    $selectdatabooking = "SELECT * from tb_provider where id_provider = '" . $num . "' ";
    $objselect = mysqli_query($link, $selectdatabooking);
    $Resultselect = mysqli_fetch_array($objselect ,MYSQLI_ASSOC);
    while (!is_null($Resultselect)) {
    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);

    }
    $num = "c_".$nums."";

     $link->query("INSERT INTO tb_service_provider_car( 
            id_service,
            phone_provider,
            type,
            brand,
            model,
            date_buy,
            prices,
            image1,
            image2,
            
            status_work
            )VALUES(
            '$num',
            '$phone_provider',
            '$type',
            '$brand',
            '$model',
            '$date_buy',
            '$prices',
            '$image1',
            '$image2',
            '0'

            )
            ");


     

  

?>