# awoo nununi PageTags API

Supportive API call: `JSON`

### Request header key-value

Authorization: Bearer `access_token`

Content-Type: application/json

### `GET` PageTags: get

Get the tags of a product.

### Definition

https://api.awoo.org/nununi/v2.1/`nununiId`/pagetags/products/`productId`

    Requires authorization

### Path parameters

| Field     |  Type  | Description                             |
| :-------- | :----: | :-------------------------------------- |
| nununiId  | string | `Required`. nununi Service Customer ID. |
| productId | string | `Required`                              |

### Example

```
GET https://api.awoo.org/nununi/v2.1/5556667777/pagetags/123456789012
Authorization: Bearer 8a41759cb5239e281952899b5eaafcf87fc1437a
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
               "tag": "TagA TagB",
               "url": "https://nununi.com/category/TagA,TagB"
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
| result.tags[].tag |  string  | nununi Tag.                                    |
| result.tags[].url |  string  | Link to nununi page. (encode url)                                        |

<!--### `GET` PageTags: list

List the tags of multiple products.

### Definition

https://api.awoo.org/nununi/v2.1/`nununiId`/pagetags

    Requires authorization

### Path parameters

| Field     |  Type  | Description                             |
| :-------- | :----: | :-------------------------------------- |
| nununiId  | string | `Required`. nununi Service Customer ID. |

### Query parameters

| Field      |  Type   | Description                               |
| :--------- | :-----: | :---------------------------------------- |
| pageToken  | string  | The token returned by the previous request. |
| maxResults | integer | The maximum number of products to return in the response, used for paging.<br>Max number of maxResults: 500   |

### Example code

```
GET https://api.awoo.org/nununi/v2.1/5556667777/pagetags?maxResults=2&pageToken=0
Authorization: Bearer 8a41759cb5239e281952899b5eaafcf87fc1437a
Content-Type: application/json
```

### Response

Status code 200

```
{
  "errcode": 0,
  "errmsg": "ACK",
  "result": {
    "nextPageToken": 2,
    "resources": [
      {
        "productId": "543210",
        "tags": [
          {
            "tag": "TagA TagB",
            "url": "https://nununi.com/category/TagA,TagB"
          },
          {
            "tag": "TagA TagC",
            "url": "https://nununi.com/category/TagA,TagC"
          }
        ]
      },
      {
        "productId": "123456",
        "tags": [
          {
            "tag": "TagD TagE",
            "url": "https://nununi.com/category/TagD,TagE"
          },
          {
            "tag": "TagF TagG",
            "url": "https://nununi.com/category/TagF,TagG"
          }
        ]
      }
    ]
  }
}
```

| Field            |   type   | description                                        |
| :--------------- | :------: | :------------------------------------------------- |
| errcode          | integer  |                                                    |
| errmsg           |  string  |                                                    |
| result           | object[] |                                                    |
| result.nextPageToken       | integer | Page token to retrieve the next page of results in the list. If `NULL` means there is no next page of results. |
| result.resources.productId |  string  | Product Id                                                  |
| result.resources.tags[]    | object[] | `Empty array` if there is no tag for this product. |
| result.resources.tags[].tag  |  string  | nununi Tag.               |
| result.resources.tags[].url  |  string  | Link to nununi page. (encode url)                  |-->

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
