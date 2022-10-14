<?php

class PaymentMethod Extends Utility
{

    public function __construct($db) {
        $this->db = $db;
        $this->table = new stdClass();
        $this->table->payment_method = 'payment_method';
    }

    public function getAllMethods($case = '')
    {
        if ($case == '') {
            $result = $this->db->getAllRecords($this->table->payment_method, "*", "ORDER BY id DESC");
        } else {
            $result = $this->db->getAllRecords($this->table->payment_method, "*", " AND use_case LIKE '%$case%'", "ORDER BY id DESC");
        }

        if (count($result) > 0) {

            $feedback = $result;
            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function getMethodById($id)
    {
        $result = $this->db->getSingleRecord($this->table->payment_method, "*", "AND id = $id");

        if ($result != NUll){

            $feedback = $result;
            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function paymentStatus(int $payType) {
        switch($payType) {
            case 0:
                $this->responseBody = "<span class='badge badge-sm badge-danger'>
                    Pending
                </span>";
            break;
            case 1:
                $this->responseBody = "
                <span class='badge badge-sm badge-success'>
                    Payment Received
                </span>";
            break;
            case 2:
                $this->responseBody = "
                <span class='badge badge-sm badge-default'>
                    Canceled
                </span>";
            break;
            case 3:
            case 4:
                $this->responseBody = "";
            break;
            default:
                $this->responseBody = NULL;
        }

        return $this->responseBody;
    }

    public function deliveryStatus(int $deliveryType) {
        switch($deliveryType) {
            case 0:
                $this->responseBody = "
                <span class='badge badge-sm badge-danger'>
                    Pending
                </span>";
            break;
            case 1:
                $this->responseBody = "
                <span class='badge badge-sm badge-success'>
                    Items Delivered
                </span>";
            break;
            case 2:
                $this->responseBody = "
                <span class='badge badge-sm badge-default'>
                    Canceled
                </span>";
            break;
            case 3:
            case 4:
                $this->responseBody = "";
            break;
            default:
                $this->responseBody = NULL;
        }
        
        return $this->responseBody;
    }

}
?>