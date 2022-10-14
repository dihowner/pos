<?php
require_once MODEL_DIR.'Utility.php';

class Settings Extends Utility
{

    public function __construct($db) {
        $this->db = $db;
        $this->table = new stdClass();
        $this->table->setting = 'settings';
    }

    public function getAllSettings()
    {
        $result = $this->db->getAllRecords($this->table->setting, "*");

        foreach ($result as $record) { 
            $feedback[$record['name']] = $record['value'];
        }
        $this->responseBody = $this->arrayToObject($feedback);

        return $this->responseBody;
    }
    
    public function saveAppInfo($optionKey, $optionValue, $date)
    {
        $saveData = $this->db->update_new(
            $this->table->setting, 
            array(
                'value' => $optionValue,
                'date_updated' => $date
            ), 
            " AND name = '$optionKey'"
        );

        if ($saveData > 0) {
            $this->responseBody = true;
        }
        
        return $this->responseBody;
    }
}