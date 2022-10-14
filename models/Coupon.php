<?php

class Coupon extends Utility {

    protected $responseBody;

    function __construct($db) {
        $this->db = $db;
        $this->table = new stdClass();
        $this->table->coupon = 'coupons';
    }

    public function createCoupon($couponData) {
        try {
            $isCouponExists = $this->getCouponByCode($couponData["coupon_code"]);

            if($isCouponExists !== false) {
                $_SESSION["coupon_exists"] = true;
                $this->responseBody = false;
            }
            else {
                $insert = $this->db->insert($this->table->coupon, $couponData);                
                if ($insert > 0) {
                    $this->responseBody =  true;
                } else {
                    $this->responseBody =  false;
                }
            }

            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }

    public function getCouponByCode($coupon_code) {
        try {
            $getCoupon = $this->db->getSingleRecord($this->table->coupon, "*", " AND coupon_code = '$coupon_code'");
            if($getCoupon != NULL) {
                $this->responseBody = $this->arrayToObject($getCoupon);
            }
            else {
                $this->responseBody = false;
            }
            return $this->responseBody;
        }
        catch(THrowable $e) {
            return $e->getMessage();
            die;
        }
    }

    public function getAllCoupons()
    {
        $result = $this->db->getAllRecords($this->table->coupon, "*", "ORDER BY id DESC");

        if (count($result) > 0){

            $feedback = $result;
            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function updateCoupon($updateData, $updateWhere) {
        try {

            $isExist = $this->getCouponByCode($updateData['coupon_code']);
            if($isExist !== false AND $isExist->id != $updateWhere['id']) {
                $_SESSION['coupon_exists'] = true;
                $this->responseBody = false;
            } 
            else {
                $updateCoupon = $this->db->update($this->table->coupon, $updateData, $updateWhere);
                if($updateCoupon) {                
                    $this->responseBody = true;
                } else {
                    $this->responseBody = false;
                }
            }

            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }

    public function deleteCoupon($couponId) {
        try {
            $deleteStock = $this->db->delete($this->table->coupon, ['id' => $couponId]);
            if($deleteStock) {                
                $this->responseBody = true;
            } else {
                $this->responseBody = false;
            }
            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }
}