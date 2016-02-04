<meta charset="UTF-8">

<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
	
		
		$result = sql_query("select * from dongal_board"); //질의.
		
		while ($row=sql_fetch_array($result)) {
			$table_name = $row[board_name];
			echo $table_name.' / ';
			
			$insert = sql_query("select * from g4_dongal_board_$table_name"); //질의.
	
			while ($row=sql_fetch_array($insert)) {
				
				$sql = "insert into dongal_notice (wr_id, bo_table, update_time) values ('$row[id]','$table_name','$row[wr_created_on]')";
				sql_query($sql);
				echo $sql. '<br>' ;
			}	
			
		}
		
		
	} else if($_SERVER['REQUEST_METHOD'] == "POST"){	
		$results = array("results","error");
	} else{
		$results = array("results","error");
	}
		

?>
