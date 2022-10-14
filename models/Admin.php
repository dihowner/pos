<?php

class Admin extends Utility {

    protected $responseBody;

    function __construct($db) {
        $this->db = $db;
        $this->table = new stdClass();
        $this->table->admin = 'admin';
    }

    public function getAdminById($adminId) {
        $result = $this->db->getSingleRecord($this->table->admin, "*", "AND (username = '$adminId' OR id = '$adminId')");

        if ($result != NULL) {

            $fullName = $result["fullname"];
            $explode_fullname = explode(" ", $fullName);
            $result['fullName'] = $fullName;
            $result['initial'] = strtoupper($explode_fullname[0][0].$explode_fullname[1][0]);
            
            $this->responseBody = $this->arrayToObject($result);
        }else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }

    public function getAdminByColumn($columnName, $adminId) {
        $result = $this->db->getSingleRecord($this->table->admin, "*", "AND $columnName = '$adminId'");

        if ($result != NULL) {
            
            $adminId = $result["id"];

            $adminInfo = $this->getAdminById($adminId);
            
            $this->responseBody = $adminInfo;
        }else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }

    public function processLogin($staffId) {
        $result = $this->getAdminById($staffId);

        if ($result !== false){
            $_SESSION['adminId'] = $result->id;

            $this->responseBody = true;
        }else {
            $this->responseBody = false;
        }

        return $this->responseBody;
    }

    public function createAdmin($adminData) {
        try {

            $isExists = $this->getAdminById($adminData["username"]);
            if($isExists !== false) {
                $_SESSION["username_exist"] = true;
                $this->responseBody = false;
            }
            else {
                $createAdmin = $this->db->insert($this->table->admin, $adminData);
                if($createAdmin) {
                    $this->responseBody = true;
                }
                else {
                    $this->responseBody = false;
                }
            }

            return $this->responseBody;

        }
        catch(Throwable $e) {
            echo $e->getMessage();
            die;
        }
    }

    public function getAllAdmin() {
        $result = $this->db->getAllRecords($this->table->admin, "*", " ORDER BY id desc");

        if ($result != NULL) {

            foreach($result as $index => $admin) {

                unset($admin["password"]);

                $fullName = $admin["fullname"];
                $explode_fullname = explode(" ", $fullName);

                $feedback[$index] = $admin;
                $feedback[$index]['initial'] = strtoupper($explode_fullname[0][0].$explode_fullname[1][0]);;
            }
            
            
            $this->responseBody = $this->arrayToObject($feedback);
        }else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }

    public function updateAdmin($updateData, $updateWhere) {
        try {
            
            $isUsernameExist = $this->getAdminByColumn("username", $updateData['username']);
            
            $isEmailExist = $this->getAdminByColumn("email", $updateData['email']);

            if($isUsernameExist !== false AND $isUsernameExist->id != $updateWhere['id']) {
                $_SESSION["username_exist"] = true;
                $this->responseBody = false;
            }
            else if($isEmailExist !== false AND $isEmailExist->id != $updateWhere['id']) {
                $_SESSION["email_exist"] = true;
                $this->responseBody = false;
            }
            else {
    
                $updateAdmin = $this->db->update($this->table->admin, $updateData, $updateWhere);
                if($updateAdmin) {
                    $this->responseBody = true;
                }
                else {
                    $this->responseBody = false;
                }
            }
        
            return $this->responseBody;

        }
        catch(Throwable $e) {
            echo $e->getMessage();
            die;
        }
    }

    public function deleteAdmin($adminId) {
        try {
            $deleteAdmin = $this->db->delete($this->table->admin, ['id' => $adminId]);
            if($deleteAdmin) {                
                $this->responseBody = true;
            } else {
                $this->responseBody = false;
            }

            return $this->responseBody;

        }
        catch(Throwable $e) {
            echo $e->getMessage();
            die;
        }
    }

    public function updatePassword($password, $adminId) {
        try {
            
            $hashPassword = password_hash($password, PASSWORD_BCRYPT);

            $updateAdminPass = $this->db->update($this->table->admin, ['password' => $hashPassword], ['id' => $adminId]);

            if($updateAdminPass) {               
                $this->responseBody = true;
            } else {
                $this->responseBody = false;
            }

            return $this->responseBody;

        }
        catch(Throwable $e) {
            echo $e->getMessage();
            die;
        }
    }

}
?>