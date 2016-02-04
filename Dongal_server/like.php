
<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
		$results = array("results","error");
		
	} else if($_SERVER['REQUEST_METHOD'] == "POST"){	
		$uuid = $_POST[uuid];
		$wr_id = $_POST[wr_id];
		$bo_table = $_POST[bo_table];
		
		$result = sql_fetch("select * from dongal_like where mb_uuid='$uuid' and wr_id='$wr_id' and bo_table='$bo_table'");
		
		if (!$result[like_no]) {
			$sql = sql_query("insert into dongal_like (mb_uuid, wr_id, bo_table) values ('$uuid', '$wr_id', '$bo_table')");
		} else {
			$sql = sql_query("delete from dongal_like where mb_uuid='$uuid' and wr_id='$wr_id' and bo_table='$bo_table'");
		}
		
		
		

	} else{
		$results = array("results","error");
	}
		
		
	
	$results = json_encode($results); 	
	echo $results;
	
?>
