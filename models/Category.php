<?php

class Category extends Utility {

    protected $responseBody;

    function __construct($db) {
        $this->db = $db;
        $this->table = new stdClass();
        $this->table->category = 'category';
    }
    
    public function countCategories() {
        try {
            $this->responseBody = $this->db->countRecords($this->table->category, "");
            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }

    public function checkCategoryExists($categoryName) {
        $searchData = $this->db->getSingleRecord($this->table->category, "*", " AND category_name='$categoryName'");
        if($searchData != NULL) {
            $this->responseBody = $this->arrayToObject($searchData);
        } else {
            $this->responseBody =  false;
        }
        
        return $this->responseBody;
    }

    public function createCategory($categoryData)
    {
        $categoryData= array(
            'category_name' => $categoryData['category_name'],
            'description' => $categoryData['category_description'],
            'date_created' => date("Y-m-d H:i:s")
        );

        $isExist = $this->checkCategoryExists($categoryData['category_name']);

        if($isExist !== false ) {
            $_SESSION["category_exists"] = true;
            $this->responseBody =  false;
        }
        else {
            $insert = $this->db->insert($this->table->category, $categoryData);
    
            if ($insert > 0) {
                $this->responseBody =  true;
            } else {
                $this->responseBody =  false;
            }
        }
        return $this->responseBody;
    }

    public function getAllCategories()
    {
        $result = $this->db->getAllRecords($this->table->category, "*", "ORDER BY id DESC");

        if (count($result) > 0){

            $feedback = $result;
            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function getCategoryById($categoryId)
    {
        $result = $this->db->getSingleRecord($this->table->category, "*", " AND id='$categoryId'", "ORDER BY id DESC");

        if ($result !== NULL){

            $feedback = $result;
            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function updateCategory($categoryData, $categoryId)
    {
        $isExist = $this->checkCategoryExists($categoryData['category_name']);

        if($isExist !== false AND $isExist->id != $categoryId) {
            $_SESSION["category_exists"] = true;
            $this->responseBody =  false;
        }
        else {
            $update = $this->db->update($this->table->category, $categoryData, array('id' => $categoryId));

            if ($update > 0) {
                $this->responseBody =  true;
            } else {
                $this->responseBody =  false;
            }
        }

        return $this->responseBody;
    }

    public function deleteCategory($deleteData) {
        try {
            $deleteCategory = $this->db->delete($this->table->category, $deleteData);
            if($deleteCategory) {
                $this->responseBody =  true;
            }
            else {
                $this->responseBody =  false;
            }
            return $this->responseBody;
        } catch (Exception $e) {
            $this->responseBody =  false;
        }  
    }


}