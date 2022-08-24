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



    
    $id_schedule = $_POST["id_schedule"];
    $phone_provider = $_POST["phone_provider"];
    $rating = $_POST["rating"];
    $comment = $_POST["comment"];
    
    

    
    
    

    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
    $selectdatabooking = "SELECT * from tb_provider where id_provider = '" . $num . "' ";
    $objselect = mysqli_query($link, $selectdatabooking);
    $Resultselect = mysqli_fetch_array($objselect ,MYSQLI_ASSOC);
    while (!is_null($Resultselect)) {
    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);

    }
    $num = "rating_".$nums."";

     $link->query("INSERT INTO tb_rating_provider( 
            id_rating,
            id_schedule,
            phone_provider,
            rating,
            comment
           
            )VALUES(
            '$num',
            '$id_schedule',
            '$phone_provider',
            '$rating',
            '$comment'
            )
            ");


     

  

?>