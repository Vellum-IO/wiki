-- USERS
-- Stores identity references from the external OIDC provider.
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    external_id VARCHAR(255) NOT NULL UNIQUE, -- The immutable 'sub' claim from OIDC
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- TEAMS
-- The boundary for Billing, Quotas, and Resource Isolation.
CREATE TABLE teams (
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    name VARCHAR(255) NOT NULL,
    
    -- Hard limits enforced by the application layer before provisioning.
    quota_instances_limit INTEGER NOT NULL DEFAULT 0,
    quota_cpu_millicores_limit INTEGER NOT NULL DEFAULT 0,
    quota_ram_mb_limit INTEGER NOT NULL DEFAULT 0,
    quota_storage_gb_limit INTEGER NOT NULL DEFAULT 0,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- TEAM_MEMBERS
-- Maps Users to Teams to enable shared access to resources.
CREATE TABLE team_members (
    team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) DEFAULT 'member', -- Authorization level within the team
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    PRIMARY KEY (team_id, user_id)
);

-- DATABASE_INSTANCES
-- The primary resource requested by users. Represents the desired state
-- and the last known reported state from the Operator.
CREATE TABLE database_instances (
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    team_id UUID REFERENCES teams(id) ON DELETE RESTRICT,
    created_by_user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    
    name VARCHAR(63) NOT NULL, -- Used for K8s resource naming 
    
    -- Resource Specifications (Desired State)
    cpu_millicores INTEGER NOT NULL,
    ram_mb INTEGER NOT NULL,
    storage_gb INTEGER NOT NULL,
    is_backup_enabled BOOLEAN DEFAULT FALSE,
    
    -- Lifecycle State
    -- Status reflects the aggregate health of the K8s resources.
    -- Status: PENDING, PROVISIONING, READY, FAILED, DELETING
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING', 
    status_message TEXT, -- Human-readable error/status from the Operator
    
    -- Connection Info (Populated asynchronously by Operator via NATS)
    host VARCHAR(255),
    port INTEGER,
    
    -- Optimistic Locking
    -- Prevents "Zombie State" overwrites during concurrent Operator/User updates.
    version INTEGER DEFAULT 1,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE (team_id, name)
);

-- DATABASE_CREDENTIALS
-- Strictly isolated table to keep sensitive data out of standard queries.
-- Application must encrypt 'password_encrypted' before insertion.
CREATE TABLE database_credentials (
    instance_id UUID PRIMARY KEY REFERENCES database_instances(id) ON DELETE CASCADE,
    username VARCHAR(255) NOT NULL,
    password_encrypted TEXT NOT NULL, 
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Performance Indexes
CREATE INDEX idx_users_external_id ON users(external_id);
CREATE INDEX idx_database_instances_team_id ON database_instances(team_id);
CREATE INDEX idx_database_instances_status ON database_instances(status);
