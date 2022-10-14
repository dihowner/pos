<?php
require_once MODEL_DIR.'Utility.php';

class Authorization extends Utility {
    public $currentUser;
    protected $responseBody;

    function __construct($db) {
        $this->db = $db;
        $this->table = new stdClass();
        $this->table->authorization = 'authorization';
        $this->table->pages = 'pages';
    }

    public function getPage($page) {
        $result = $this->db->getSingleRecord($this->table->pages, "*", "AND (id = '$page' OR slug = '$page')");

        if ($result != NULL) {
            $this->responseBody = $this->arrayToObject($result);
        }else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }

    public function getAllPages($pageType = '') {

        if ($pageType == '') {
            $result = $this->db->getAllRecords($this->table->pages, "*");
        } else {
            $result = $this->db->getAllRecords($this->table->pages, "*", "AND (type = '$pageType')");
        }

        if (count($result) > 0) {
            $this->responseBody = $this->arrayToObject($result);
        }else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }

    public function getAllPermittedPages($userId)
    {
        $result = $this->db->getAllRecords($this->table->authorization, "page_id", "AND user_id = $userId");
        $allUserPages = $this->getAllPages('all_user_page');

        if (count($result) > 0) {
            foreach ($result as $index => $value) {
                $perm[] = $value['page_id'];
            }
            foreach ($allUserPages as $index => $value) {
                $userPage[] = $value['id'];
            }
            $values = array_merge($perm, $userPage);
            // print_r($values);
            $this->responseBody = $values;
        }else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }

    public function groupPagesMenu() {
        $result = $this->db->getAllRecords($this->table->pages, "*", " group by menu order by id"); 
        $menu = [];
        if (count($result) > 0) {
            foreach($result as $results) {
                
                if($results['menu'] == 'customer') {
                    $menu['menuGroup'][] = 'customer';
                    $menu['menuName'][] = 'Customers';
                    $menu['menuIcon'][] = "flaticon-381-user";
                }
                
                if($results['menu'] == 'staff') {
                    $menu['menuGroup'][] = 'staff';
                    $menu['menuName'][] = 'Staff Management';
                    $menu['menuIcon'][] = "flaticon-381-user";
                }
                
                if($results['menu'] == 'sales') {
                    $menu['menuGroup'][] = 'sales';
                    $menu['menuName'][] = 'Sales';
                    $menu['menuIcon'][] = "flaticon-381-user";
                }
                
                if($results['menu'] == 'plan') {
                    $menu['menuGroup'][] = 'plan';
                    $menu['menuName'][] = 'Plan & Pricing';
                    $menu['menuIcon'][] = "flaticon-381-controls-2";
                }
                
                if($results['menu'] == 'stock') {
                    $menu['menuGroup'][] = 'stock';
                    $menu['menuName'][] = 'Stock Room';
                    $menu['menuIcon'][] = "flaticon-381-television";
                }
                
                if($results['menu'] == 'stockupdate') {
                    $menu['menuGroup'][] = 'stockupdate';
                    $menu['menuName'][] = 'Stock Update';
                    $menu['menuIcon'][] = "flaticon-381-key";
                }
                
                if($results['menu'] == 'system') {
                    $menu['menuGroup'][] = 'system';
                    $menu['menuName'][] = 'System';
                    $menu['menuIcon'][] = "flaticon-381-key";
                }

                if($results['menu'] == 'wallet') {
                    $menu['menuGroup'][] = 'wallet';
                    $menu['menuName'][] = 'Wallet';
                    $menu['menuIcon'][] = "flaticon-381-save";
                }
            }
            $this->responseBody = $menu;
        } else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }

    public function getLinkByMenu(string $menuName, int $userId) {
        $result = $this->db->getAllRecords($this->table->pages, "*", " AND menu = '$menuName'", " ORDER BY id");
        $pages = [];
        foreach($result as $results) {
            if(in_array($results['id'], $this->getAllPermittedPages($userId))) {
                $pages['title'][] = $results['title'];
                $pages['slug'][] = $results['slug'];
            } 
        }
        $this->responseBody = $pages;
        return $this->responseBody;
    }

    public function hasPagePermission($userId, $page)
    {
        $result = $this->db->getSingleRecord($this->table->pages, "*", "AND (slug = '$page' OR id = '$page')");

        if ($result != NULL) {
            $page = $result;
            $pageId = $page['id'];
    
            $result = $this->db->getSingleRecord($this->table->authorization, "*", "AND user_id = $userId AND page_id = $pageId");
    
            if ($result != NULL) {
                $this->responseBody = true;
            }else {
                $this->responseBody = false;
            }
        } else {
            $this->responseBody = false;
        }
        return $this->responseBody;
    }

    public function isAuthorized($page)
    {
        $result = $this->db->getAllRecords($this->table->pages, "*", "AND (slug = '$page' OR id = '$page')");

        if (isset($_SESSION['authorizedPage']) AND $_SESSION['authorizedPage'] == $page) {
            $this->responseBody = true;
        } else {
            $this->responseBody = false;
        }
        return $this->responseBody;
    }

    public function grantPermission($userId, $pageId)
    {
        $thePage = $this->getPage($pageId);
        $permitted = $this->hasPagePermission($userId, $pageId);

        if ($thePage != FALSE AND $permitted == FALSE) {
            $authData = array(
                'user_id' => $userId, 
                'page_id' => $pageId,
            );

            $result =  $this->db->insert($this->table->authorization, $authData);

            if ($result > 0) {
                $this->responseBody =  true;
            } else {
                $this->responseBody =  false;
            }
        } else {
            $this->responseBody =  false;
        }
        return $this->responseBody;
    }

    public function revokePermission($userId, $pageId)
    {
        $thePage = $this->getPage($pageId);
        $permitted = $this->hasPagePermission($userId, $pageId);

        if ($thePage != FALSE AND $permitted != FALSE) {

            $result =  $this->db->delete2("DELETE FROM ".$this->table->authorization." WHERE user_id = $userId AND page_id = $pageId");

            if ($result > 0) {
                $this->responseBody =  true;
            } else {
                $this->responseBody =  false;
            }
        } else {
            $this->responseBody =  false;
        }
        return $this->responseBody;
    }

}