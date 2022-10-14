<div class="deznav">
            <div class="deznav-scroll">
				<ul class="metismenu" id="menu">
                    <li><a href="dashboard">
							<i class="flaticon-381-home"></i>
							<span class="nav-text">Dashboard</span>
						</a>
                    </li>
                    <li><a class="has-arrow ai-icon" href="javascript:void()" aria-expanded="false">
						<i class="flaticon-381-television"></i>
							<span class="nav-text">Stock Room</span>
						</a>
                        <ul aria-expanded="false">
                            <li><a href="availableStock">Available Stock</a></li>
                            <li><a href="addStock">Add New Stock</a></li>
                            <li><a href="category">Categories</a></li>
                            <li><a href="quantityUpdateHistory">Stock Update History</a></li>
                            <li><a href="stockSearch">Search for Stock</a></li>
                            <li><a href="updateStockQty">Update Stock Quantity</a></li>
                            <li><a href="unavailableStock">Unavailable Stock</a></li>
                        </ul>
                    </li>
                    <li><a class="has-arrow ai-icon" href="javascript:void()" aria-expanded="false">
							<i class="fas fa-ad"></i>
							<span class="nav-text">Sales</span>
						</a>
                        <ul aria-expanded="false">
                            <li><a href="makePurchase">Make Purchase</a></li>
                            <li><a href="cashierSalesPoint">Cashier Sales Point</a></li>
                            <li><a href="salesCheckout">Sales Checkout</a></li>
                            
                            <!-- Todays sales record -->
                            <li><a href="myPurchaseHistory">Purchase History</a></li>
                            <li><a href="myCashierHistory">Cashier History</a></li>
                            

                            <!-- History for all the first three to perform transaction -->
                            <li><a href="purchaseHistory">All Purchase History</a></li>
                            <li><a href="allCashierHistory">All Cashier History</a></li>
                            <li><a href="checkoutHistory">Checkout History</a></li>

                        </ul>
                    </li>
                    <li><a class="has-arrow ai-icon" href="javascript:void()" aria-expanded="false">
							<i class="flaticon-381-user"></i>
							<span class="nav-text">Admin Mananagement</span>
						</a>
                        <ul aria-expanded="false">
                            <li><a href="createAdmin">Create Admin</a></li>
                            <li><a href="adminList">Admin List</a></li>
                        </ul>
                    </li>
                    <li><a class="has-arrow ai-icon" href="javascript:void()" aria-expanded="false">
							<i class="fa fa-refresh"></i>
							<span class="nav-text">Stock Mananagement</span>
						</a>
                        <ul aria-expanded="false">
                            <li><a href="stockUpdate">Stock Update</a></li>
                            <li><a href="stockUpdateArchiveHistory">Stock Update History</a></li>
                        </ul>
                    </li>
                    <li><a class="has-arrow ai-icon" href="javascript:void()" aria-expanded="false">
							<i class="fa fa-gear"></i>
							<span class="nav-text">System Settings</span>
						</a>
                        <ul aria-expanded="false">
                            <li><a href="coupons">Coupon Management</a></li>
                            <li><a href="system-settings">System Settings</a></li>
                        </ul>
                    </li>
                    <li><a href="logout">
							<i class="fa fa-sign-out"></i>
							<span class="nav-text">Log Out [<?php echo $getAdmin->username;?>]</span>
						</a>
                    </li>
                </ul>
				<div class="copyright">
					<p><?php echo SITE_TITLE;?> Point Of Sales SYSTEM <br/>© 2022 All Rights Reserved</p>
					<p class="op5">With with <span class="heart"></span> by <br> <b>Oluwatayo Adeyemi</b></p>
				</div>
			</div>
        </div>