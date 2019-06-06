# awoo nununi Content API

Supportive API call: `JSON`

### Request header key-value

Authorization: Bearer `access_token`

Content-Type: application/json


### `POST` content

根據傳入的標籤與分類取得 nununi 頁面的所有相關資訊、商品資料與推薦標籤連結

### Definition

https://api.awoo.org/nununi/v1.2/`nununiId`/content/

    Requires authorization

### Path parameters

| Field     |  Type  | Description                             |
| :-------- | :----: | :-------------------------------------- |
| nununiId  | string | `Required`. nununi 客戶 ID |


### Query parameters

| Field     |  Type  | Description                             |
| :-------- | :----: | :-------------------------------------- |
| tags      | list   | `Required` 上限三個        |
| page      | integer   | `Required` 頁數，第一頁為 1        |
| limit      | integer   | `Required` 每頁商品數      |
| sort  | integer  | `Required` 商品排序依據：<br>1. 由低到高依價格排序, 有特價優先排序特價商品<br>2. 由高到低依價格排序, 有特價優先排序特價商品<br>3. 由低到高依受歡迎程度排序<br>4. 由高到低依受歡迎程度排序<br>5. 由低到高依喜愛程度/收藏數排序<br>6. 由高到低依喜愛程度/收藏數排序<br>7. 由低到高依銷售量排序<br>8. 由高到低依銷售量排序<br>9. 由低到高依瀏覽人次排序<br>10. 由高到低依瀏覽人次排序<br>11. 由舊到新依上架時間排序<br>12. 由新到舊依上架時間排序<br>13. 由舊到新依更新時間排序<br>14. 由新到舊依更新時間排序<br>15. 由低到高依評論數排序<br>16. 由高到低依評論數排序<br>17. 由低到高依星等數排序<br>18. 由高到低依星等數排序 |


### PHP cURL Example

```
/* Authorization Information */
define("NUNUNI_ID", "{{YOUR_NUNUNI_ID}}");
define("NUNUNI_API_TOKEN", "{{YOUR_NUNUNI_API_TOKEN}}");
define("NUNUNI_API_VERSION", "v1");
define("NUNUNI_API_NAME", "content");

/* Parameters */
$tags = ["口紅"];
$page = 1;
$limit = 10;
$sort = 1;

/* content */
echo "Call API:\n";
$params = compact( "tags", "page", "limit", "sort" );
$content = request(
	packApiUrl(NUNUNI_ID, NUNUNI_API_VERSION, NUNUNI_API_NAME),
	$params,
	"POST"
);
print_r($content);

exit;

/* Pack API URL function */
function packApiUrl($nununiId, $apiVer, $apiName) {
	return ("https://api.awoo.org/nununi/{$apiVer}/{$nununiId}/{$apiName}");
}

/* cURL function */
function request($url = "", $data = [], $method = "GET", $token = NUNUNI_API_TOKEN) {
	$ch = curl_init();

	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_HTTPHEADER, [
		"Authorization: Bearer {$token}",
		"Content-Type: application/json",
	]);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

	if (strtoupper($method) === "POST") {
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
	}

	curl_setopt($ch, CURLOPT_TIMEOUT, 120);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 120);

	$responseBody = curl_exec($ch);
	curl_close($ch);

	return json_decode($responseBody, true);
}

```

### Response

Status code 200

```
{
  "errcode": 0,
  "errmsg": "ACK",
  "result": {
    "pageInfo": {
      "title": "xxxxx",
      "description": "xxxxxx",
      "openGraph": {
        "title": "xxxxx",
        "description": "xxxxxx",
        "siteName": "xxxx",
        "url": "https://xxxxx.xxx.xxx",
        "image": "https://xxxx.xxxx.xxx",
        "type": "website"
      },
      "canonical": "https://customerHost.com/xxxx",
      "schema": {
        "breadcrumbs": "{xxxxxx}"
      },
      "intro": "xxxxxx",
      "h1": "xxxxxx"
    },
    "categoriesTags": {
    },
    "suggestionTags": [
      {
        "text": "tags文字",
        "link": "tags連結"
      }
    ],
    "products": [
      {
        "productId": "A123456",
        "productName": "xxxxxx",
        "url": "https://xxx.xxx.xxx/xxx",
        "productImageUrl": "https://xxx.xxx.xxx/xxx.xxx",
        "productBrand": "xxx",
        "productPrice": 111,
        "productSalePrice": 99
      }
    ],
    "productsTotal": 99
  }
}
```

| Field                        |   Type   | Description                                                         |
| :--------------------------- | :------: | :------------------------------------------------------------------ |
| errcode                      | integer  |  |
| errmsg                       |  string  |  |
| result                       | object[] |  |
| result.pageInfo              | object[] |  |
| result.pageInfo.title                 |  string  | 頁面標題 |
| result.pageInfo.description           |  string  | 頁面描述 |
| result.pageInfo.openGraph             | object[] |  |
| result.pageInfo.openGraph.title       |  string  | Open Graph 標題 |
| result.pageInfo.openGraph.description |  string  | Open Graph 描述 |
| result.pageInfo.openGraph.siteName    |  string  | Open Graph 網站名稱 |
| result.pageInfo.openGraph.url         |  string  | Open Graph 頁面網址 |
| result.pageInfo.openGraph.image       |  string  | Open Graph 頁面縮圖 |
| result.pageInfo.openGraph.type        |  string  | Open Graph 網站類型 |
| result.pageInfo.canonical             |  string  | 頁面標準連結元素（會依據關鍵字指向權重最高網址） |
| result.pageInfo.schema                | object[] |  |
| result.pageInfo.schema.breadcrumbs    |  string  | 頁面麵包屑結構化資料標記 |
| result.pageInfo.intro                 |  string  | 頁面文案 |
| result.pageInfo.h1                    |  string  | 頁面大標題 |
| result.categoriesTags  | object[] | 已停用 |
| result.suggestionTags[]  | list[] | |
| result.suggestionTags[].text  |  string  | 相關連結標籤 |
| result.suggestionTags[].link  |  string  | 相關連結url (encode url,相對路徑) |
| result.products[]  | list[] | |
| result.products[].productId  |  string  | 商品id |
| result.products[].productName  |  string  | 商品名稱 |
| result.products[].url  |  string  | 商品url |
| result.products[].productImageUrl  |  string  | 商品圖面url |
| result.products[].productBrand  |  string  | 商品品牌 |
| result.products[].productPrice  |  float  | 商品訂價 |
| result.products[].productSalePrice  |  float  | 商品特價 |
| result.productsTotal  |  string  | 傳入標籤的商品總數（用來計算分頁數） |


























## Response code details

### Error code and error message of status code 200

| status code | errcode | errmsg                                                        |
| :---------- | :-----: | :------------------------------------------------------------ |
| 200         |   -1    | Error undefined.                                              |
| 200         |    0    | ACK (acknowledge)                                             |
| 200         |    1    | Invalid parameters.                                           |
| 200         |    2    | Backend error occurred.                                       |
| 200         |    3    | The requested operation is forbidden and cannot be completed. |

### Response of other error code

| status code | error              | error_description                                                         |
| :---------- | :----------------- | :------------------------------------------------------------------------ |
| 403         | insufficient_scope | The request requires higher privileges than provided by the access token. |
| 401         | invalid_token      | The access token provided is invalid.                                     |
| 401         | malformed_token    | Malformed token. (missing "expires")                                      |
| 401         | invalid_token      | The access token provided has expired.                                    |

Example

```
{
    "error": "invalid_token",
    "error_description": "The access token provided is invalid"
}
```
