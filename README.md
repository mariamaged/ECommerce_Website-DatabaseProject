## Overview
 - Through an Ecommerce platform, customers can choose a product or service of their choice from any vendor anywhere in the world without moving away from their workplace or home. They can also track their delivery status and know when the goods are being sent to them. They can also choose the convenient method of payment.
 - E-Commerce provides new channels for vendors to reach more customers. An online presence allows vendors to provide more information about the products they are selling. Through E-Commerce, sellers can post different offers to their products to increase their sales.
 - The aim of this project is to implement an E-Commerce website that provides these features to mechandisers and customers.
### Milestone 1
#### Entites
|Entity Name| Weak/Strong | Attributes |
|--|--|--|
| ***1- User*** | Strong | (1) Email(first key), (2) Name(First name,Last name), (3) Mobile number(multivalued), (4) Address(multivalued),(5) Username(second key), (6) Password|
| ***2- Customer*** | Strong| (1) Email(first key), (2) Name(First name,Last name), (3) Mobile number(multivalued), (4) Address(multivalued),(5) Username(second key), (6) Password, (7) Points(derived)|
| ***3- Vendor*** | Strong | (1) Email(first key), (2) Name(First name,Last name), (3) Mobile number(multivalued), (4) Address(multivalued),(5) Username(second key), (6) Password, (7) Company name, (8) Bank account number |
| ***4- Admin*** | Strong |(1) Email(first key), (2) Name(First name,Last name), (3) Mobile number(multivalued), (4) Address(multivalued),(5) Username(second key), (6) Password |
| ***5- Delivery Personnel*** | Strong | (1) Email(first key), (2) Name(First name,Last name), (3) Mobile number(multivalued), (4) Address(multivalued),(5) Username(second key), (6) Password|
| ***6- Product*** | Strong |(1) Serial number(key), (2) Color, (3) Image, (4) Price, (5) Category, (6) Description, (7) Availability(derived), (8) Rate(derived), (9) Name, (10) Number |
| ***7- Question*** | Strong |(1)QuestionID(key) |
| ***8- Credit Card*** | Strong | (1) CNumber(key), (2) CVC, (3) Expiry date|
| ***9- Wishlist*** | Weak | (1) Name(partial key)|
| ***10- Order*** | Strong | (1) ONumber(key), (2) Status, (3) Payment method, (4) Points spent|
| ***11- Delivery*** | Strong |(1)DeliveryID(key), (2) Time duration, (3) Fees |
| ***12- Promotion*** | Strong| (1)PNumber(key), (2) Amount of discount, (3) Expiry date |
| ***13- Offer*** | Strong | (1)PNumber(key), (2) Amount of discount, (3) Expiry date |
| ***14- Gift Card*** | Strong |(1)PNumber(key), (2) Amount of discount, (3) Expiry date |
| ***15- Today's Deal*** | Strong | (1)PNumber(key), (2) Amount of discount, (3) Expiry date |

#### Relationships
| Relationship Name | Degree | Identifying | Entity Types|Cardinality |Attributes| Image |
|---|---|---|---|---|---|--|
| ***1 - Use_to_pay*** | Binary | No | Credit Card:Customer | 1 to many:0 to many | | ![enter image description here](https://lh3.googleusercontent.com/pax1E6Z3xcOd-219NXrsiwQ75SuVT37mpL9n3d5kwgM1akQVJ6jHi0Od4HmWqrlV9vAQOGiBoy19) |
| ***2- Invite_to_website*** | Binary| No|Admin:Delivery Personnel | 0 to many:Only One| |![enter image description here](https://lh3.googleusercontent.com/J4lzsLdCVpAWgSd7TQUmjTaGGxJKB6s0RKdOiBdXs5wJIiOBnxEtVRhC5AfPL04xHZVMaGdwke4X)|
| ***3- Activate_account*** | Binary|No |Admin:Vendor |0 to many:Only One | |![enter image description here](https://lh3.googleusercontent.com/-EgmCmdcv4Ai9iS3Vfh7VDlrg23J39iJFOIDkhVacMdd1gNlvsQI9472vB4juWpwe2a5G9u3XCJ0) |
| ***4- Owns_wishlist*** | Binary | Yes | Customer:WishList | 0 to many:Only One | | ![enter image description here](https://lh3.googleusercontent.com/RgwhKOEtFED1enDzLJ4jvVxAOhqkXwzyAwhwNJRUGkVAzFFooesK1IUsgyO3w5U9yg0IoYBcCVoP) |
| ***5- Ask*** |Ternary |No |Customer:Question:Product | Only One:0 to many:Only One| |![enter image description here](https://lh3.googleusercontent.com/7p_dKzkXFQrCEQDZS3PYls27iQH15npRGaFcJOLE44_-HtYUSI_Ug9zNhUXbJrC41lebz4J6k3ST) |
| ***6- Answer*** | Ternary|No |Vendor:Question:Product | Only One:0 to many:Only One| | ![enter image description here](https://lh3.googleusercontent.com/18mxjBcAeZ3cmRy5oefKKXRwLub1wnbBUZNzhYrqp3rmc49AVCN-kHVjE3SZRBRzsXbFa36iYw7S)|
| ***7- Add_to_wishlist*** | Ternary | No| Wishlist:Customer:Product | 0 to many:Only One:0 to many | | ![enter image description here](https://lh3.googleusercontent.com/msg2fKg6hQcXYsNjRfVLAtVe5vO5_9VE5vbtNd11T5A7K47Wi0EvC9m5N8UM0Kn8UZ24-wHfhM8t) |
| ***8- Remove_from_wishlist*** | Ternary | No | Wishlist:Customer:Product| 0 to many:Only One:0 to many | | ![enter image description here](https://lh3.googleusercontent.com/9CkNP5b6bIKRCI3x57PJBC5vr3N7rx4vh9iMQprUQB-spN2FgrGB6GWe4A45FXrhKtWi_md-MkZM) |
|***9- Rate*** | Binary | No | Customer:Product|0 to many:0 to many | |![enter image description here](https://lh3.googleusercontent.com/TB4pVcX7TywIC7BE1ziOZZGJIspz950RrEMrJ9m60pTwhuR6ocR3xbpymS7feITO4id1XFM6anlo) |
| ***10- Add_to_cart*** | Binary | No | Customer:Product |0 to many:1 to many | | ![enter image description here](https://lh3.googleusercontent.com/ICKROfT0vJfgRf2TdYcN3e3Uih2YoQvWjtJFI8PZGK6W30g6VaEAiJj6MRT-yVKA0LlU_pt-WEj7) |
| ***11- Remove_from_cart*** | Binary | No | Customer:Product | 0 to many:1 to many| |![enter image description here](https://lh3.googleusercontent.com/kldplP-_6lIjYgtM8tCl49AVDZtzWqEKYCrds9n1ZYEH8lQyYK7B5Hd6H7roIxGGXC9sVuQ2NN-R) |
| ***12- Gets_recommended*** |Binary |No | Customer:Product|0 to many:0 to many | | ![enter image description here](https://lh3.googleusercontent.com/X9yvjyjyk0weS0Ltv6gldVBfEtIFMHzoLDk-lKc6k4j8HuG7lciz4d37K9nCkWD9OFrsS-7SY3GM)|
| ***13- Return*** | Ternary| No | Customer:Product:Order | Only One:0 to many:0 to many | |![enter image description here](https://lh3.googleusercontent.com/zPo3a6zFw-0HTMs3PgNJuesFln1q63DmbO_mofnqxL102fQreUKPOVI9saT2bhSRLSwpOvejUgjw) |
| ***14- Cancelled_by*** | Binary | No | Customer:Order | 0 to many:Only One| |![enter image description here](https://lh3.googleusercontent.com/m6tpRbh0woH0AjNWW6PCDpZ7G53KsRr18Mt187fvI-zBwRuVtYCr7fzjMGVxr8KsAwQfDD2TFE_z) |
| ***15- Make_order*** | Ternary | No | Customer:Order:Delivery | Only One:0 to many:Only One | |![enter image description here](https://lh3.googleusercontent.com/sceypCleKfitsQUEBkcNbcF5FYrzEgjk1rEoS6f1caeOwieCPTGTFfSQ0p_v6T7gcE-NqZ23S_Hx) |
| ***16- Review*** | Binary | No | Admin:Order | 0 to many:1 to many | |![enter image description here](https://lh3.googleusercontent.com/qVQbU8qg6MMx0YwSRigHoKmTkfaYB4cc_zHzsLyQRbSiOtL7JiqdObW5LPLuCL8PYI8YCP6vrBUq) |
| ***17- Update_status*** | Binary|No | Admin:Order|0 to many:1 to many | |![enter image description here](https://lh3.googleusercontent.com/G02HJu1nSCZYldqNxv2zI4NwtLcUoSiTAH73a9keGpWF6YbzpM_N40T17LLiuSGDkCLqqldcuC4Z) |
| ***18- Delivery_update*** | Binary | No | Delivery Personnel:Order |0 to many:0 to 1 | | ![enter image description here](https://lh3.googleusercontent.com/UaxEl-wr9e73CbHE4doScnPJ1TXYWIQfn3OsH-QjonlAolTiDYMw4ORKz-hGBemh7oc4EDXSF0E1)|
| ***19- Add_delivery*** | Binary | No | Admin:Delivery | 0 to many:Only One | |![enter image description here](https://lh3.googleusercontent.com/_3FQ9OB0dNv5ce1jm3IFVnzLLu4frS6DJMuDq4nHsB6Ge8vKTnC1v5fc0sGUhygYG5brWXMsNJKH) |
| ***20- Assigned_to*** | Binary | No |Delivery Personnel:Order | 0 to many:0 or 1 |Delivery window time | ![enter image description here](https://lh3.googleusercontent.com/o92pTARSNkdBK03m3kElaeR8O_NgVy9IQuL4j868NOby0JOHtFAuFO5s5U4lA3SdenJeSzbzUB9g) |
| ***21- Add_offer*** | Ternary | No | Product:Vendor:Offer | 1 to many:Only One:0 to many | | ![enter image description here](https://lh3.googleusercontent.com/jwMzsLbmHrdjUujqJvn5mfUbmxhIi08UPLJrt_j1bAIzBpZ50Y0pJB2xccfZnGh4BFcJzF7fBfBP) |
| ***22- Post_deal*** | Ternary | No | Product:Today's Deal:Admin | 1 to many:0 to many:Only One | | ![enter image description here](https://lh3.googleusercontent.com/s6lrDiSkgaHJ9bl8CWkYhZQ3Ki7WYtiKKQYbJIpNyOjbxSFF6VeDrri_MWdn_XfiKwobHn1WLaHu) |
| ***23- Issue_giftcard*** | Ternary | No | Gift Card:Customer:Admin | 0 to many:1 to many:1 to many | | ![enter image description here](https://lh3.googleusercontent.com/Zss2Nh4rYpKJsK8mfslJB_l-GTBQ_0lvjkQI6gS-R3KP50tK5YXCZIwHXSg9Ff1UwlqatOoSTxe_) |
| ***24- Supply_product*** | Binary | No | Vendor:Product | 0 to many:Only One | | ![enter image description here](https://lh3.googleusercontent.com/RWuTRkGPWQKESiBBCJWCsbuEDRpM19Q19ebJz-8y7BPI1Ajxu4AN_EXxn8B4qTgXbLqowmajbOa8)|
| ***25- Delete*** | Binary | No | Vendor:Product | 0 to many:Only One | | ![enter image description here](https://lh3.googleusercontent.com/sVnmbou4rRyQLYA0bTifU7AuQnqOlYxXzfz0fOVCOE_XA01n3yGJc7qh9SA5Czz6tIEU68DU4KD2) |
| ***26- Edit*** | Binary | No | Vendor:Product | 0 to many:Only One | | ![enter image description here](https://lh3.googleusercontent.com/SNoL6c7uxxMQ-7p7G0gX0LOSdtbFDqCpiWO914frLdDSr9xgkNjf_p6d7DfrC9OcucVsGRL7cZT3) |
### Milestone 2
## 1. Users
| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| username | VARCHAR(20) | x | x | x |
| password | VARCHAR(20) | x | x | x |
| first_name | VARCHAR(20) | x | x | x |
| last_name | VARCHAR(20) | x | x | x |
| email | VARCHAR(50) | yes | x | x |

![enter image description here](https://lh3.googleusercontent.com/ZHCrVtYGvrPPXub7ND71k2VfGowaKzuji-4Zp-gIgCo2nLzdMgp8edPvdQeBoAkubbpkSDHVJwlL)
#### Constraints
|Name| Type |
|--|--|
| Users_primary_key | PRIMARY KEY(username) |
| Users_unique1 | UNIQUE(email) |

- **Note:**
  - In the procedure called `inviteDeliveryPerson`, the admin adds a delivery person with only a `username` and `email`. Thus, only the email field should be configured to be `not null` and `first_name`, `last_name` and `password` should allow `null` fields.
## 2. User_mobile_numbers

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| mobile_number | VARCHAR(20) | x | x | x |
| username | VARCHAR(20) | x | x | x |

![enter image description here](https://lh3.googleusercontent.com/q-cSJ9Klro2Pqp87uwAuqVZF8JV06Go4H8ekx_MpvstUUZpgqMuWaR4G7Vc0Y3pya-N9uK6mZMC4)

#### Constraints
|Name| Type |
|--|--|
| Users_mobile_numbers_primary_key | PRIMARY KEY(mobile_number, username) |
| Users_mobile_numbers_foreign_key1 | FOREIGN KEY(username) REFERENCES Users |

## 3. User_Addresses

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| address | VARCHAR(100) | x | x | x |
| username | VARCHAR(20) | x | x | x |

![enter image description here](https://lh3.googleusercontent.com/zd7AQQe8nuPQzVtCZpHhghwSt-XNNXuBtP2SFzcpikM3l938ggbdm_pbXPfohhoT6eZDm2sbSGnG)

#### Constraints
|Name| Type |
|--|--|
| Users_Addresses_primary_key | PRIMARY KEY(address, username) |
| Users_Addresses_foreign_key1 | FOREIGN KEY(username) REFERENCES Users  |
## 4. Customer

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| username | VARCHAR(20) | x | x | x |
| points | INT | yes | 0 | x |

![enter image description here](https://lh3.googleusercontent.com/DlgwcuuQ38UObCW9w5XwuSAMeKGokdJxa-KrDMlfG0z5ra2t6KEl8hWNsgsAy95bLRNwcKJOg-gO)\
&nbsp;
![enter image description here](https://lh3.googleusercontent.com/PtLNwuE-O4Uw36hmpyoCVCPF9Yb0AhuafNv0efdcWP0yQC5v5Rtg6ZsxMPcHiCRB7fHZpQ02SrXJ)\
&nbsp;
![enter image description here](https://lh3.googleusercontent.com/tE3RBvJFEaNJJzZN_sPPM8znETLvwRCCUBtwwXHmOuUDZ9Zp53opRHOFsagn70nsQDiKoTx3ix__)

  
#### Constraints
|Name| Type |
|--|--|
| Customer_primary_key | PRIMARY KEY(username) |
| Customer_foreign_key1 | FOREIGN KEY(username) REFERENCES Users|
## 5. Admins

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| username | VARCHAR(20) | x | x | x |

#### Constraints

|Name| Type |
|--|--|
| Admins_primary_key | PRIMARY KEY(username) |
| Admins_foreign_key1 | FOREIGN KEY(username) REFERENCES Users |
## 6. Vendor
| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| username | VARCHAR(20) | x | x | x |
| activated | BIT | yes | 0 | x |
| company_name | VARCHAR(20) | yes | x | x |
| bank_acc_no | VARCHAR(20) | yes | x | x |
| admin_username | VARCHAR(20) | x | x | x |

  ![enter image description here](https://lh3.googleusercontent.com/A1C17Tpl449Iyji1Z5j04I0ERwPQoDd8FMPY6e75peiHF4jVfKKMcc9KMALnB_1SaDclxd1m3Iqe)
#### Constraints
|Name| Type |
|--|--|
| Vendor_primary_key | PRIMARY KEY(username) |
| Vendor_foreign_key1 | FOREIGN KEY(username) REFERENCES Users  |
| Vendor_foreign_key2 | FOREIGN KEY(admin_username) REFERENCES Admins|


- **NOTE:**
  - First, the vendor will register. The `admin_username` field will be null at first. Then, a procedure called `activateVendors` will fill the field with admin username. If the admin gets deleted, the field becomes null again. Thus, a `not null` constraint is `not applicable`.
 ## 7. Delivery_Person

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| username | VARCHAR(20) | x | x | x |
| is_activated | BIT | yes | 0 | x |

 
#### Constraints
|Name| Type |
|--|--|
| Delivery_Person_primary_key | PRIMARY KEY(username) |
| Delivery_Person_foreign_key1 | FOREIGN KEY(username) REFERENCES Users  |
## 8. Credit_Card

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| number | VARCHAR(20) | x | x | x |
| expiry_date | DATE | yes| x | x |
| cvv_code | VARCHAR(4) |yes | x| x |
 
![enter image description here](https://lh3.googleusercontent.com/MoJeWsKyafdJFLcE43XwuJBZnIYIU_b2zKNH0DCQ-tdmNmYFAU5A_R1__1MWuiZ8DxOgyeLcRhYX)

### Constraints
|Name| Type |
|--|--|
| Credit_Card_primary_key | PRIMARY KEY(number) |
## 9. Delivery

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| id | INT | x | x | yes |
| type | VARCHAR(20) | yes | x | x |
| time_duration | INT | yes| x | x |
| fees | DECIMAL(5,3) | yes| x| x |
| username | VARCHAR(20) |x | x| x |


![enter image description here](https://lh3.googleusercontent.com/mm6RBW18X2quvZLGPZP6cO5I4mxch-U2tvsRuXR7ik_MOirCosWZ43ze5DPS84S5tIEshJa3-Q4d)\
&nbsp;
![enter image description here](https://lh3.googleusercontent.com/mxgMQdgb-vKsJcqM4vwqYdrjDTGyWS7B7uM8F2dXshAxZ5iTPstX-IRUOy2I6eX2rKLp542fKBCo)

  
### Constraints
|Name| Type |
|--|--|
| Delivery_primary_key | PRIMARY KEY(id) |
| Delivery_foreign_key1 | FOREIGN KEY(username) REFERENCES Admins  |

- **Note:** 
  - First, the admin will add the delivery type. Thus, the `admin username` field will have the username at first. However, when the admin gets deleted, this field becomes null again. Thus, the `not null` constraint is `not applicable`.
## 10. Orders

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| order_no | INT | x | x | yes |
| order_date | DATETIME |yes | x | x |
| total_amount | DECIMAL(10, 2) | yes| x| x |
| cash_amount | DECIMAL(10, 2) |x | x| x |
| credit_amount | DECIMAL(10, 2) | x | x | x |
| payment_type | VARCHAR(20) |x | x | x |
| order_status | VARCHAR(20) | yes| x| x |
| remaining_days | INT |x | x| x |
| time_limit | DATETIME |x | x| x |
| Gift_Card_code_used | VARCHAR(10) | x| x| x |
| customer_name | VARCHAR(20) | yes| x | x |
| delivery_id | INT| x | x | x |
| creditCard_number | VARCHAR(20) | x| x| x |

![enter image description here](https://lh3.googleusercontent.com/wEHi77DPRd_AnOOSP8GQxBJ4IFzq9tOH-xBDaQY4X4JRQ2iJGnV2z0qqGz4kE-a6d3ea4jwUQz7Y)\
&nbsp;
![enter image description here](https://lh3.googleusercontent.com/yzZEX3yiIzTtQzT8ZC0Lxcf5nyL3C90VNojdcow0jRBPpElbxdzNoldbLGzANVVwTMnc4VqX_acY)

### Constraints
|Name| Type |
|--|--|
| Orders_primary_key | PRIMARY KEY(order_no) |
| Orders_foreign_key1 | FOREIGN KEY(Gift_Card_code_used) REFERENCES Giftcard|
| Orders_foreign_key2 | FOREIGN KEY(customer_name) REFERENCES Customer |
| Orders_foreign_key3 | FOREIGN KEY(delivery_id) REFERENCES Delivery ON DELETE CASCADE ON UPDATE CASCADE |
| Orders_foreign_key4 | FOREIGN KEY(creditCard_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE |

  - **Note:**
     -  The referential integrity constraints for `Orders_foreign_key3`, `Orders_foreign_key4` are placed inside the procedure `makeOrder`.
## 11. Product

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| serial_no | INT | x | x | yes |
| product_name | VARCHAR(20) |yes | x | x |
| category | VARCHAR(20) | yes| x| x |
| product_description | TEXT|x | x| x |
| price | DECIMAL(10,2) | x |x | x |
| final_price | DECIMAL(10,2) | x | x | x |
| color | VARCHAR(20) | x| x | x |
| available | BIT | yes| 1| x |
| rate | INT |x | x| x |
| vendor_username | VARCHAR(20) |yes | x| x |
| customer_username | VARCHAR(20) | x| x| x |
| customer_order_id | INT | x | x | x |
  
![enter image description here](https://lh3.googleusercontent.com/f5DQaWs2w72Z-Nz9vuLJOWoAc3Ea037LnyX8DqZeqGQUP86iGLbogR4fVtZF9zlSPrk0E_FhDHTY)\
&nbsp;
![enter image description here](https://lh3.googleusercontent.com/Dmru6Vur7fG9sRg253cf5uIdLtsx1lk6wFz_zKc6teZY0zIhymi4k6LmvA67-4WKjcka4gbaF6z0)

  
### Constraints
|Name| Type |
|--|--|
| Product_primary_key | PRIMARY KEY(serial_no) |
| Product_foreign_key1 | FOREIGN KEY(vendor_username) REFERENCES Vendor ON DELETE CASCADE ON UPDATE CASCADE|
| Product_foreign_key2 | FOREIGN KEY(customer_username) REFERENCES Customer |
| Product_foreign_key3 | FOREIGN KEY(customer_order_id) ON DELETE SET NULL ON UPDATE CASCADE |

  - **Note:** 
    - The referential integrity constraints for `Product_foreign_key1`, `Product_foreign_key3` are placed inside the procedure `postProduct`.
## 12. CustomerAddstoCartProduct

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| serial_no | INT | x | x | x |
| customer_name | VARCHAR(20) | x| x | x |

#### Constraints
|Name| Type |
|--|--|
| CustomerAddstoCartProduct_primary_key | PRIMARY KEY(serial_no, customer_name) |
| CustomerAddstoCartProduct_foreign_key1 | FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE |
| CustomerAddstoCartProduct_foreign_key2 | FOREIGN KEY(customer_name) REFERENCES Customer |

  - **Note:** 
    - The referential integrity constraints for `CustomerAddstoCartProduct_foreign_key1` are placed inside the procedure `addToCart`.
## 13. Todays_Deals

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| deal_id | INT | x | x | yes |
| deal_amount | INT |yes |x | x |
| expiry_date | DATETIME | yes| x| x |
| admin_username | VARCHAR(20) | x| x | x |

 
![enter image description here](https://lh3.googleusercontent.com/tw6ZyScI1znhdCz9VKQxkRLDyS0CUQm-02wrSCQA54kufdjcp_hhm40enZTMr5s3OXvyCbK8oT8R)\
&nbsp;
![enter image description here](https://lh3.googleusercontent.com/uwkI_z-nhs1Z1ddqm0F2ZWyq6DYy5yXi-QESZk23SgxWboPRwm96FNT9F9GRyAsGITVeznFp1re0)

  
#### Constraints
|Name| Type |
|--|--|
| Todays_Deals_primary_key | PRIMARY KEY(deal_id) |
| Todays_Deals_foreign_key1 | FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE SET NULL ON UPDATE CASCADE |

 
- **Note:** When the today's deal is first created, the admin_username field has a value at first. When the admin gets deleted, the field becomes null. Thus, the not null constraint is not applicable.
## 14. Todays_Deals_Product

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| deal_id | INT | x | x |x |
| serial_no | INT |x | x | x |

#### Constraints
|Name| Type |
|--|--|
| Todays_Deals_Product_primary_key | PRIMARY KEY(deal_id, serial_no) |
| Todays_Deals_Product_foreign_key1 | FOREIGN KEY(deal_id) references Todays_Deals ON DELETE CASCADE ON UPDATE CASCADE |
| Todays_Deals_Product_foreign_key2 | FOREIGN KEY(serial_no) references Product ON DELETE CASCADE ON UPDATE CASCADE |
## 15. offer

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| offer_id | INT | x | x |yes |
| offer_amount | INT |yes|x | x |
| expiry_date | DATETIME |yes |x | x |

 
![enter image description here](https://lh3.googleusercontent.com/l3T-gLiH3pkS3hmr0XSCl8rti7iNEclWukOaodRU6Ey3JF7BGXMP6PaNLkmahUb3_2Z-4sTj--9t)\
&nbsp;
![enter image description here](https://lh3.googleusercontent.com/wgLkWhWUwTe8-EclY2ih9U2oNTOlrDnt4gyo2fJI_kCbFETaHluxUOUFNGUmSOPkIEsry7mIQrjj)
 
#### Constraints
|Name| Type |
|--|--|
| offer_primary_key | PRIMARY KEY(offer_id) |
## 16. offersOnProduct

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| offer_id | INT | x | x |x |
| serial_no | INT |x| x | x |

 
#### Constraints

|Name| Type |
|--|--|
| offerOnProduct_primary_key | PRIMARY KEY(offer_id, serial_no) |
| offerOnProduct_foreign_key1 | FOREIGN KEY(offer_id) REFERENCES offer ON DELETE CASCADE ON UPDATE CASCADE|
| offerOnProduct_foreign_key2 | FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE|

 - **Note:**
   -   The referential integrity constraints for `offersOnProduct_foreign_key1` and `offersOnProduct_foreign_key2` are placed inside the procedure `applyOffer`.
## 17. Customer_Question_Product

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| serial_no | INT | x| x| x |
| customer_name | VARCHAR(20) |x | x| x |
| question | VARCHAR(50) |yes | x| x|
| answer | TEXT |x | x| x |

![enter image description here](https://lh3.googleusercontent.com/-70ApiZ3OES4PHWd1VYWfgBt2SH1VBqZ6GF5Ut-hyab7t3I2V2beoT_aBXn8kgSGTvJ6vBMGaQE)\
&nbsp;
![enter image description here](https://lh3.googleusercontent.com/U7_Bz4hepPc4oxgcQVTNs5ax2vE18dAQpFQjbqCDLvqZKZ4EHlX5NJFsifXsEzzNZLLG2AFIGwU)

  
#### Constraints
|Name| Type |
|--|--|
| Customer_Question_Product_primary_key | PRIMARY KEY(serial_no, customer_name) |
| Customer_Question_Product_foreign_key1 | FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE |
| Customer_Question_Product_foreign_key2 | FOREIGN KEY(customer_name) REFERENCES Customer |

  - **Note:** 
    - The referential integrity constraints for `Customer_Question_Product_foreign_key1` are placed inside the procedure `AddQuestion`.
## 18. Wishlist

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| username | VARCHAR(20) |x | x| x|
| name | VARCHAR(20) |x | x| x |

 
![enter image description here](https://lh3.googleusercontent.com/afOUZplRtV81HlOaCVxRUmCMeQBzIs4kXX_c1HpFllf4SsjwPX1iomsiZKgAxzy9jEXCINd-6WA)

#### Constraints

|Name| Type |
|--|--|
| Wishlist_primary_key | PRIMARY KEY(username, name) |
| Wishlist_foreign_key1| FOREIGN KEY(username) REFERENCES Customer |
## 19. Giftcard
| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| code | VARCHAR(10) |x | x| x|
| expiry_date | DATETIME |x | x| x |
| amount | INT | x| | x |
| username | VARCHAR(20) |x | x| x |  
![enter image description here](https://lh3.googleusercontent.com/8Oeu5ukbbYN7cOC7HMPltgKtwQOcY_VCh9lSAAdWrTpxC3ozWd8VaKc4JZ48-HC76KWE5Fs8L98) 
#### Constraints
|Name| Type |
|--|--|
| Giftcard_primary_key | PRIMARY KEY(code) |
| Giftcard_foreign_key1 | FOREIGN KEY(username) REFERENCES Admins ON DELETE SET NULL ON UPDATE CASCADE |
 ## 20. Wishlist_Product
| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| username | VARCHAR(20) | x|x | x|
| wish_name | VARCHAR(20) |x | x|x |
| serial_no | INT | x| x| x|  
#### Constraints
|Name| Type |
|--|--|
| Wishlist_Product_primary_key | PRIMARY KEY(username, wish_name, serial_no) |
| Wishlist_Product_foreign_key1 | FOREIGN KEY(username, wish_name) REFERENCES Wishlist ON DELETE CASCADE ON UPDATE CASCADE|
| Wishlist_Product_foreign_key2 | FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE|
- **Note:**
   - The referential integrity constraints for `Wishlist_Product_foreign_key1` and `Wishlist_Product_foreign_key2` are added in the procedure `AddtoWishlist`.
## 21. Admin_Customer_Giftcard

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| code | VARCHAR(10) |x |x | x |
| customer_name | VARCHAR(20) |x | x| x|
| admin_username | VARCHAR(20) |x |x | x|
| remaining_points | INT | x|x | x |

  
#### Constraints
|Name| Type |
|--|--|
| Admin_Customer_Giftcard_primary_key | PRIMARY KEY(code, customer_name, admin_username) |
| Admin_Customer_Giftcard_foreign_key1 | FOREIGN KEY(code) REFERENCES Giftcard ON DELETE CASCADE ON UPDATE CASCADE|
| Admin_Customer_Giftcard_foreign_key2 | FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE |
| Admin_Customer_Giftcard_foreign_key3 | FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE|
## 22. Admin_Delivery_Order

| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| delivery_username | VARCHAR(20) |x | x| x|
| order_no | INT | x|x | x |
| admin_username | VARCHAR(20) |x | x| x|
| delivery_window | VARCHAR(50) |x |x | x |


![enter image description here](https://lh3.googleusercontent.com/90ABDYJgAGoPb52gxnRwQErbq-b7ec186XVAGg3_dT8YoOBmEmoHr3ceVD6LfSX6wcUWeKJD9Bk)

#### Constraints
|Name| Type |
|--|--|
| Admin_Delivery_Order_primary_key | PRIMARY KEY(delivery_username, order_no) |
| Admin_Delivery_Order_foreign_key1 |FOREIGN KEY(delivery_username) REFERENCES Delivery_Person ON DELETE CASCADE ON UPDATE CASCADE |
| Admin_Delivery_Order_foreign_key2 | FOREIGN KEY(order_no) REFERENCES Orders ON DELETE CASCADE ON UPDATE CASCADE |
| Admin_Delivery_Order_foreign_key3 | FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE |

   - **Note:** 
      - The referential integrity constraints for `Admin_Delivery_Order_foreign_key1`, `Admin_Delivery_Order_foreign_key2` and `Admin_Delivery_Order_foreign_key3` is placed inside the procedure `assignOrdertoDelivery`
## 23. Customer_CreditCard
| Attribute | Data Type | Not Null | Default | Identity |
|---|---|---|---|---|
| customer_name | VARCHAR(20) |x | x| x |
| cc_number | VARCHAR(20) |x | x| x |

#### Constraints
|Name | Type |
|--|--|
| Customer_CreditCard_primary_key | PRIMARY KEY(customer_name, cc_number) |
| Customer_CreditCard_foreign_key1 | FOREIGN KEY(customer_name) REFERENCES Customer
| Customer_CreditCard_foreign_key2 | FOREIGN KEY(cc_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE |

 - **Note:**
   -  The referential integrity constraints for `Customer_CreditCard_foreign_key1` are removed because in other tables the deletion of a customer tuple is prohibited.
   - The referential integrity constraints for `Customer_CreditCard_foreign_key2` is placed inside the procedure `AddCreditCard`.
