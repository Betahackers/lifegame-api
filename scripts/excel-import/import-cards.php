<?php

error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);

define('EOL',(PHP_SAPI == 'cli') ? PHP_EOL : '<br />');

date_default_timezone_set('Europe/London');

/** Log file **/
$log_fh = fopen("log.txt", "w");

/** SQL file **/
$sql_fh = fopen("data.sql", "w");

/** Include PHPExcel_IOFactory */
require_once dirname(__FILE__) . '/PHPExcel/Classes/PHPExcel/IOFactory.php';

logit("Load from Excel2007 file", $log_fh);
$objPHPExcel = PHPExcel_IOFactory::load("Sample.xlsx");

$sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);

/** Process data **/
$cards_id = 0;
$answers_id = 0;
$points_id = 0;
$num_rows = 1;
$point_slugs = array(
    'love'   => 'E',
    'money'  => 'F',
    'fun'    => 'G',
    'health' => 'H'
);
foreach ($sheetData as $row) {
    // Skip the column headers or empty rows
    if (($row['A'] == 'Card Title') || empty($row['A'])) {
        continue;
    }
    
    // Insert card
    if ($num_rows % 2 != 0) {
        $cards_id++;
        write_sql(create_insert_card($cards_id, $row['A'], $row['B']),
                $sql_fh);
    }
    
    // Insert answer
    $answers_id++;
    write_sql(create_insert_answer($answers_id, $cards_id, $row['C'], $row['D']),
            $sql_fh);
    
    // Insert points
    foreach ($point_slugs as $slug => $col) {
        $points_id++;
        write_sql(create_insert_points($points_id, $answers_id, $slug, $row[$col]),
            $sql_fh);
    }
    
    $num_rows++;
}
logit("Done!", $log_fh);

// Close files
fclose($log_fh);
fclose($sql_fh);

function create_insert_card($id, $title, $person) {
    $title = addslashes($title);
    $person = addslashes($person);
    return ("INSERT INTO cards (id, title, person, created_at, updated_at) " .
            "VALUES ($id, '$title', '$person', current_timestamp, current_timestamp);");
}

function create_insert_answer($id, $cards_id, $kind, $text) {
    $text = addslashes($text);
    return ("INSERT INTO answers (id, card_id, kind, text, created_at, updated_at) " .
            "VALUES ($id, $cards_id, '$kind', '$text', current_timestamp, current_timestamp);");
}

function create_insert_points($id, $answers_id, $slug, $value) {
    return ("INSERT INTO points (id, answer_id, slug, value, created_at, updated_at) " .
            "VALUES ($id, $answers_id, '$slug', $value, current_timestamp, current_timestamp);");
}

function logit($string, $fh) {    
    echo date('H:i:s') . " - $string" . EOL;
    fwrite($fh, date('H:i:s') . " - $string" . "\n");
}

function write_sql($sql, $fh) {
    fwrite($fh, $sql . "\n");
}

?>
