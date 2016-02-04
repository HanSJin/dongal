<?php 

// mysql_query 와 mysql_error 를 한꺼번에 처리
// mysql connect resource 지정 - 명랑폐인님 제안

function conn() {
	
	$dbconnect = mysql_connect('localhost', 'root', 'dongal1q2w3e4r');
	mysql_select_db("project_dongal_development");
}
function sql_query($sql, $error=G5_DISPLAY_SQL_ERROR)
{	
	$conn = mysql_connect('localhost', 'root', 'dongal1q2w3e4r');
	mysql_select_db("project_dongal_development");
	
    // Blind SQL Injection 취약점 해결
    $sql = trim($sql);
    // union의 사용을 허락하지 않습니다.
    //$sql = preg_replace("#^select.*from.*union.*#i", "select 1", $sql);
    $sql = preg_replace("#^select.*from.*[\s\(]+union[\s\)]+.*#i ", "select 1", $sql);
    // `information_schema` DB로의 접근을 허락하지 않습니다.
    $sql = preg_replace("#^select.*from.*where.*`?information_schema`?.*#i", "select 1", $sql);

    if ($error)
        $result = @mysql_query($sql, $conn) or die("<p>$sql<p>" . mysql_errno() . " : " .  mysql_error() . "<p>error file : {$_SERVER['SCRIPT_NAME']}");
    else
        $result = @mysql_query($sql, $conn);

    return $result;
}


// 쿼리를 실행한 후 결과값에서 한행을 얻는다.
function sql_fetch($sql, $error=G5_DISPLAY_SQL_ERROR)
{
    $result = sql_query($sql, $error);
    //$row = @sql_fetch_array($result) or die("<p>$sql<p>" . mysql_errno() . " : " .  mysql_error() . "<p>error file : $_SERVER['SCRIPT_NAME']");
    $row = sql_fetch_array($result);
    return $row;
}


// 결과값에서 한행 연관배열(이름으로)로 얻는다.
function sql_fetch_array($result)
{
    $row = @mysql_fetch_assoc($result);
    return $row;
}

?>