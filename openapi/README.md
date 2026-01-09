# Keeper OpenAPI Specifications

This repository contains OpenAPI 3.0 specifications for the Keeper Database Service API, a DBaaS internal service for provisioning CNPG databases.

## API Specifications

- **databases.openapi.yaml:** Database instance management API
- **teams.openapi.yaml:** Team and team member management API

## License

At the moment no one is allowed to use this commercially.

## Future Improvements

### High Priority

#### Pagination and Filtering
- [ ] Add pagination parameters (`page`, `page_size` or `limit`/`offset`) to list endpoints
  - `GET /databases`
  - `GET /teams`
  - `GET /teams/{id}/members`
- [ ] Add pagination metadata to list responses (total count, next page, etc.)
- [ ] Add filtering capabilities:
  - `GET /databases` - filter by `status` (PENDING, PROVISIONING, READY, FAILED, DELETING)
  - `GET /databases` - filter/search by `name`
  - `GET /teams/{id}/members` - filter by `role` (owner, member)
- [ ] Add sorting parameters (`sort_by`, `sort_order`) to list endpoints

#### Admin Routes
- [ ] `GET /admin/teams` - List all teams (admin only)
- [ ] `GET /admin/databases` - List all databases across all teams (admin only)
- [ ] `GET /admin/users` - List all users (admin only)
- [ ] `PATCH /admin/teams/{id}/quota` - Update team quotas (admin only)
- [ ] `GET /admin/stats` - System statistics and metrics (admin only)

#### Missing Endpoints and Operations

**Teams:**
- [ ] `PATCH /teams/{id}` - Update team name
- [ ] `DELETE /teams/{id}` - Delete a team (with proper cascade handling)
- [ ] `PATCH /teams/{id}/members/{user_id}` - Update team member role
- [ ] `GET /teams/{id}/quota/usage` - Get current quota usage vs limits

**Databases:**
- [ ] `POST /databases/{id}/credentials/rotate` - Rotate database credentials
- [ ] `POST /databases/{id}/cancel-deletion` - Cancel database deletion if in DELETING state
- [ ] `GET /databases/{id}/events` or `GET /databases/{id}/logs` - Get database events/logs

**System:**
- [ ] `GET /health` - Health check endpoint
- [ ] `GET /version` - API version information

### Medium Priority

- [ ] Add `422 Unprocessable Entity` response for business logic validation errors (quota exceeded, duplicate name, etc.)
- [ ] Add `412 Precondition Failed` response for invalid `If-Match` header in PATCH requests
- [ ] Add `Location` header to `201` responses pointing to created resources
- [ ] Consider `202 Accepted` for async operations with status endpoints
- [ ] Add maximum values to `DatabaseSpec` (e.g., `cpu_millicores: maximum: 100000`)
- [ ] Add rate limiting headers documentation (`X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`)
- [ ] Add server URLs to OpenAPI specs (dev, staging, production environments)
- [ ] Add contact information to OpenAPI specs
- [ ] Add examples to all schema properties

### Low Priority

- [ ] Add `Last-Modified` header for caching
- [ ] Add validation for team name uniqueness
- [ ] Add audit trail endpoints
- [ ] Add webhook/notification endpoints for status changes
