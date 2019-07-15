## EMASS

### Request Headers

* `api-key`, ex) `1f32516cc-57d3-43f5-9e16- 8f86780a4cce`

This API key must be provided in the request header for all endpoint calls.

* `user-uid`, ex) `1647389405`

This User unique identifier key must be provided in the request header for all PUT, POST, and DELETE endpoint calls.
Note: For DoD users this is the DoD ID Number (EIDIPI) on their DoD CAC.

### Error Codes (Not comprehensive)

* 200 Ok

* 201 Created

* 400 Bad Request

* 401 Unauthorized

* 500 Internal Server Error

Custom codes:

* 480 Business Rule Failed

* 490 API Rule Failed
