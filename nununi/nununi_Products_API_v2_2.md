
# awoo nununi Products API

### request header key-value

Supportive API call: `form-data`, `raw-JSON`

Authorization: Bearer `access_token`

Content-Type: application/json ( Add this field when using raw-JSON API call )

### `GET` Products: get

Retrieves a product.

    Requires authorization

### Definition

https://api.awoo.org/nununi/v2.2/`nununiId`/products/`productId`

### Parameters

| Path Params | Value  | Length | Description                            |
| ----------- | ------ | -----: | -------------------------------------- |
| nununiId    | string |     10 | `required` nununi Service Customer ID. |
| productId   | string |     50 | `required` Customer’s Product ID.      |

###Example code

```
GET https://api.awoo.org/nununi/v2.2/5556667777/products/123456789012
Authorization: Bearer 8a41759cb5239e281952899b5eaafcf87fc1437a
```

### Response

If successful, this method returns a Products resource in the response body.

### `POST` Products: insert

Add product information, if requested products are already existing, they will be overwrite by products with new information.

    Requires authorization

### Definition

https://api.awoo.org/nununi/v2.2/`nununiId`/products

### Parameters

| Path Params | Value  | Length | Description                            |
| ----------- | ------ | -----: | -------------------------------------- |
| nununiId    | string |     10 | `required` nununi Service Customer ID. |

### Request Body

Required Properties

| Property name  | Value         | Length | Description                                                                                                                             |
| -------------- | ------------- | -----: | --------------------------------------------------------------------------------------------------------------------------------------- |
| id             | string        |     50 | Customer’s Product ID.                                                                                                                  |
| title          | string        |    150 | Product page’s title                                                                                                                    |
| description    | string        |   5000 | Product page’s description                                                                                                              |
| brand          | string        |     70 | Product brand                                                                                                                           |
| link           | string        |        | Product page’s url                                                                                                                      |
| imageLink      | string        |        | Product page’s hero image, please provide image’s url and the image                                                                     |
| price          | nested object |        | Price of the item.                                                                                                                      |
| price.value    | string        |        | Price of the product, in numerical value                                                                                                |
| price.currency | string        |        | Currency of product price. Please follow [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code format. ex: TWD, JPY and USD. |

Optional Properties

| Property name                    | Value         | Length | Description                                                                                                                                                              |
| -------------------------------- | ------------- | -----: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| availability                     | string        |        | product stock status. ex: in stock, out of stock<br>Acceptable values are:<br>-in stock<br>-out of stock<br>-preorder                                                    |
| salePrice                        | nested object |        | Advertised sale price of the item.                                                                                                                                       |
| salePrice.value                  | string        |        | product price after discount, in numerical value                                                                                                                         |
| salePrice.currency               | string        |        | currency of product price after discount. Please follow [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code format. ex: TWD, JPY and USD.                   |
| salePriceEffectiveDate           | nested object |        | Sale price effective date of the item.                                                                                                                                   |
| salePriceEffectiveDate.startDate | string        |        | product special price effective date. Please follow [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.                                                           |
| salePriceEffectiveDate.endDate   | string        |        | product special price end date. Please follow [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.                                                                 |
| itemSortVolume                   | nested object |        | item sort volume of the item.                                                                                                                                            |
| itemSortVolume.popularity        | string        |        | product sorting order by popularity:<br>optional, if your products(page) have popularity configuration, you can use popularity as a sorting method on nununi page.       |
| itemSortVolume.favorite          | string        |        | product sorting order by favorite:<br>optional, if your products(page) have favorite configuration, you can use favorite as a sorting method on nununi page.             |
| itemSortVolume.salesVolume       | string        |        | product sorting order by sales volume:<br>optional, if your products(page) have sales volume configuration, you can use sales volume as a sorting method on nununi page. |
| itemSortVolume.rating            | string        |        | product sorting order by rating:<br>optional, if your products(page) have rating configuration, you can use rating as a sorting method on nununi page.                   |
| itemSortVolume.reviewCount       | string        |        | product sorting order by reviews:<br>optional, if your products(page) have reviews configuration, you can use reviews as a sorting method on nununi page.                |
| size                             | string        |    100 | Product size                                                                                                                                                             |

### Example code

```
curl -X POST \
  https://api.awoo.org/nununi/v2.2/5556667777/products \
  -H 'authorization: Bearer 8a41759cb5239e281952899b5eaafcf87fc1437a' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F id=1234567890 \
  -F 'title=這是測試商品' \
  -F 'description=這是測試商品描述' \
  -F 'brand=nununi SHOP' \
  -F link=https://www.nununiSHOP.com.tw/product/info/180507856285 \
  -F imageLink=https://images.nununiSHOP.com.tw/uploads/product_image/6626247/47307ce66d439aad593447d343d1cb20/e143f05d7c62c9952924c191dd5a99a0.jpg \
  -F 'price[value]=999' \
  -F 'price[currency]=TWD'
```

### `DELETE` Products: delete

Deletes a product.

    Requires authorization

### Definition

https://api.awoo.org/nununi/v2.2/`nununiId`/products/`productId`

### Parameters

| Path Params | Value  | Length | Description                            |
| ----------- | ------ | -----: | -------------------------------------- |
| nununiId    | string |     10 | `required` nununi Service Customer ID. |
| productId   | string |     50 | `required` Customer’s Product ID.      |

### Example code

```
curl -X DELETE \
  https://api.awoo.org/nununi/v2.2/5556667777/products/1234567890 \
  -H 'authorization: Bearer 8a41759cb5239e281952899b5eaafcf87fc1437a' \
  -H 'cache-control: no-cache' \
```

### Response

If successful, this method returns an empty response body.

### `POST` Products: custombatch

Retrieves, inserts, and deletes multiple products in a single request.

    Requires authorization
    Max entries per request: 100

### Definition

https://api.awoo.org/nununi/v2.2/products/custombatch

### Request body

Required Properties

| Property name                    | Value  | Length | Description                                                                                                                             |
| -------------------------------- | ------ | -----: | --------------------------------------------------------------------------------------------------------------------------------------- |
| nununiId                         | string |     10 | nununi Service Customer ID.                                                                                                             |
| entries[]                        | list   |    100 | The result of the execution of the batch requests.                                                                                      |
| entries[].batchId                | string |        | An entry ID, unique within the batch request.                                                                                           |
| entries[].method                 | string |        | Acceptable values are:<br>- GET<br>- INSERT<br>- DELETE                                                                                 |
| entries[].productId              | string |     50 | Customer product ID. Only defined if the method is GET or DELETE.                                                                       |
| entries[].product                | object |        | The product to insert. Only required if the method is INSERT.                                                                           |
| entries[].product.id             | string |     50 | Customer’s Product ID.                                                                                                                  |
| entries[].product.title          | string |    150 | product page’s title                                                                                                                    |
| entries[].product.description    | string |   5000 | product page’s description                                                                                                              |
| entries[].product.brand          | string |     70 | product brand                                                                                                                           |
| entries[].product.link           | string |        | product page’s url                                                                                                                      |
| entries[].product.imageLink      | string |        | product page’s hero image, please provide image’s url.<br>image requirement:<br>1. uncompressed<br>2. 1:1 aspect ratios(square)         |
| entries[].product.price.value    | string |        | price of the product, in numerical value                                                                                                |
| entries[].product.price.currency | string |        | currency of product price. Please follow [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code format. ex: TWD, JPY and USD. |

Optional Properties

| Property name                                                                                                              | Value         | Length | Description                                                                                                                                                              |
| -------------------------------------------------------------------------------------------------------------------------- | ------------- | -----: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| entries[].product.availability                                                                                             | string        |        | product stock status. ex: in stock, out of stock Acceptable values are:<br>- in stock<br>- out of stock<br>- preorder                                                    |
| entries[].product.salePrice.value                                                                                          | string        |        | product price after discount, in numerical value                                                                                                                         |
| entries[].product.salePrice.currency                                                                                       | string        |        | currency of product price after discount. Please follow [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code format. ex: TWD, JPY and USD.                   |
| entries[].product.salePriceEffectiveDate.startDate                                                                         | string        |        | product special price effective date. Please follow [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.                                                           |
| entries[].product.salePriceEffectiveDate.endDate                                                                           | string        |        | product special price end date. Please follow [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.                                                                 |
| entries[].product.itemSortVolume                                                                                           | nested object |        | item sort volume of the item.                                                                                                                                            |
| entries[].product.itemSortVolume.popularity                                                                                | string        |        | product sorting order by popularity:                                                                                                                                     |
| optional, if your products(page) have popularity configuration, you can use popularity as a sorting method on nununi page. |
| entries[].product.itemSortVolume.favorite                                                                                  | string        |        | product sorting order by favorite:<br>optional, if your products(page) have favorite configuration, you can use favorite as a sorting method on nununi page.             |
| entries[].product.itemSortVolume.salesVolume                                                                               | string        |        | product sorting order by sales volume:<br>optional, if your products(page) have sales volume configuration, you can use sales volume as a sorting method on nununi page. |
| entries[].product.itemSortVolume.rating                                                                                    | string        |        | product sorting order by rating:<br>optional, if your products(page) have rating configuration, you can use rating as a sorting method on nununi page.                   |
| entries[].product.size                                                                                                     | string        |    100 | Product size                                                                                                                                                             |

### Example code (PHP)

```
function custombatchExample() {
  $nununiId = "<YOUR_NUNUNI_ID>";
  $nununiToken = "<YOUR_NUNUNI_TOKEN>";
  $nununiApiUrl = "https://api.awoo.org/nununi/v2.2/products/custombatch";

  $data = [
    "nununiId" => $nununiId,
    "entries[0][batchId]" => "batch1",
    "entries[0][method]" => "GET",
    "entries[0][productId]" => "<YOUR_PRODUCT_ID>",
    "entries[1][batchId]" => "batch2",
    "entries[1][method]" => "GET",
    "entries[1][productId]" => "<YOUR_PRODUCT_ID>",
  ];

  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, $nununiApiUrl);
  curl_setopt($ch, CURLOPT_HTTPHEADER, [ "Authorization: Bearer {$nununiToken}" ]);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_POST, true);
  curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
  $responseBody = curl_exec($ch);
  curl_close($ch);

  $response = json_decode($responseBody, true);
}
```

### Response

If successful, this method returns an entries object in the response body. using batchId to mapping entry.

### `GET` Products: list

Lists the products

    Requires authorization

### Definition

https://api.awoo.org/nununi/v2.2/`nununiId`/products

### Parameters

Path parameters

| Path Params | Value  | Length | Description                            |
| ----------- | ------ | -----: | -------------------------------------- |
| nununiId    | string |     10 | `required` nununi Service Customer ID. |

Query parameters

| Path Params | Value            | Length | Description                                                                                                 |
| ----------- | ---------------- | -----: | ----------------------------------------------------------------------------------------------------------- |
| pageToken   | string           |     10 | The token returned by the previous request.                                                                 |
| maxResults  | unsigned integer |     50 | The maximum number of products to return in the response, used for paging.<br>Max number of maxResults: 500 |

### Example code

```
GET https://api.awoo.org/nununi/v2.2/5556667777/products?maxResults=10&pageToken=51
Authorization: Bearer 8a41759cb5239e281952899b5eaafcf87fc1437a
```

### Response

If successful, this method returns a response body.

### `POST` Inventory: set

Update the price or/and salePrice of a product.

### Definition

https://api.awoo.org/nununi/v2.2/`nununiId`/inventory/products/`productId`

### Parameters

| Path Params | Value  | Length | Description                            |
| ----------- | ------ | -----: | -------------------------------------- |
| nununiId    | string |     10 | `required` nununi Service Customer ID. |
| productId   | string |     50 | `required` Customer’s Product ID.      |

### Request Body

Optional Properties

| Property name      | Value  | Length | Description                                                                                                                             |
| ------------------ | ------ | -----: | --------------------------------------------------------------------------------------------------------------------------------------- |
| price              | object |        |                                                                                                                                         |
| price.value        | string |        | price of the product, in numerical value                                                                                                |
| price.currency     | string |        | currency of product price. Please follow [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code format. ex: TWD, JPY and USD. |
| salePrice          | object |        |                                                                                                                                         |
| salePrice.value    | object |        | Advertised sale price of the item.                                                                                                      |
| salePrice.currency | string |        | currency of product price. Please follow [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code format. ex: TWD, JPY and USD. |

### Response

If successful, this method returns the updated product data.

### `POST` Inventory: custombatch

Update multiple products in a single request.

    Requires authorization
    Max entries per request: 100

### Definition

https://api.awoo.org/nununi/v2.2/inventory/custombatch

### Request Body

Required Properties

| Property name        | Value  | Length | Description                                                                                                                                                           |
| -------------------- | ------ | -----: | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| nununiId             | string |     10 | nununi Service Customer ID.                                                                                                                                           |
| entries[]            | list   |    100 | The result of the execution of the batch requests.                                                                                                                    |
| entries[].batchId    | string |        | An entry ID, unique within the batch request.                                                                                                                         |
| entries[].product    | object |        | Inside product object, at least one of “price” or “salePrice” is required. When updating “price” or/and “salePrice”, both of “value” and “currency” must be provided. |
| entries[].product.id | string |     50 | Customer product ID.                                                                                                                                                  |

Optional Properties

| Property name                        | Value  | Length | Description                                                                                                                             |
| ------------------------------------ | ------ | -----: | --------------------------------------------------------------------------------------------------------------------------------------- |
| entries[].product.price.value        | string |        | price of the product, in numerical value                                                                                                |
| entries[].product.price.currency     | string |        | currency of product price. Please follow [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code format. ex: TWD, JPY and USD. |
| entries[].product.salePrice.value    | string |        | product price after discount, in numerical value                                                                                        |
| entries[].product.salePrice.currency | string |        | currency of product price. Please follow [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code format. ex: TWD, JPY and USD. |

### Response

If successful, this method returns an entries object in the response body. using batchId to mapping entry.





### `GET` Products: get Tags

Get the tags of a product.

### Definition

https://api.awoo.org/nununi/v2.2/`nununiId`/products/`productId`/tags

    Requires authorization

### Path parameters

| Field     |  Type  | Description                             |
| :-------- | :----: | :-------------------------------------- |
| nununiId  | string | `Required`. nununi Service Customer ID. |
| productId | string | `Required`                              |

### Example

```
GET https://api.awoo.org/nununi/v2.2/5556667777/products/123456789012/tags
Authorization: Bearer 8a41759cb5239e281952899b5eaafcf8fc1437a
Content-Type: application/json
```

### Response

Status code 200

```
{
   "errcode": 0,
   "errmsg": "ACK",
   "result": {
       "tags": [
           {
               "text": "TagA TagB",
               "link": "encodeTagA,encodeTagB"
           }
       ]
   }
}
```

| Field                   |   Type   | Description                                                              |
| :---------------------- | :------: | :----------------------------------------------------------------------- |
| errcode                 | integer  |                                                                          |
| errmsg                  |  string  |                                                                          |
| result                  |  object  |                                                                          |
| result.tags     | object[] | `Empty array` if there is no tag for this product. Defaults to 10 items. |
| result.tags[].text |  string  | nununi Tag.                                    |
| result.tags[].link |  string  | nununi tags relative link. (encode url)                                        |






### Response Codes

### 200 errcode
| code | errcode | errmsg |
|:----- |:-----:|:----- |
|200 | -1 | Error undefined. |
|200 | 0 | ACK (acknowledge) |
|200 | 1 | Invalid parameters. |
|200 | 2 | Backend error occurred. |
|200 | 3 | The requested operation is forbidden and cannot be completed. |

### http error code
| status | Error | Reason |
|:----- |:----- |:----- |
| 403 | insufficient_scope | The request requires higher privileges than provided by the access token. |
| 401 | invalid_token | The access token provided is invalid. |
| 401 | malformed_token | Malformed token. (missing "expires") |
| 401 | invalid_token | The access token provided has expired. |
