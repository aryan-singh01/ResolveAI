-- ResolveAI starter schema (PostgreSQL)
-- This is a starting point; adapt types and constraints as the API evolves.

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    role TEXT NOT NULL CHECK (role IN ('Customer', 'Agent', 'Manager', 'Admin')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE tickets (
    id BIGSERIAL PRIMARY KEY,
    external_key TEXT NOT NULL UNIQUE,
    customer_id BIGINT REFERENCES users(id),
    subject TEXT NOT NULL,
    description TEXT NOT NULL,
    category TEXT,
    intent TEXT,
    sentiment TEXT,
    priority TEXT NOT NULL DEFAULT 'Medium'
        CHECK (priority IN ('Low', 'Medium', 'High', 'Critical')),
    status TEXT NOT NULL DEFAULT 'Open'
        CHECK (status IN ('Open', 'In Progress', 'Waiting on Customer', 'Resolved', 'Closed')),
    assigned_agent_id BIGINT REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    first_response_at TIMESTAMPTZ,
    resolved_at TIMESTAMPTZ,
    escalated_at TIMESTAMPTZ
);

CREATE TABLE ticket_messages (
    id BIGSERIAL PRIMARY KEY,
    ticket_id BIGINT NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    author_id BIGINT REFERENCES users(id),
    author_type TEXT NOT NULL CHECK (author_type IN ('Customer', 'Agent', 'System')),
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ai_analyses (
    id BIGSERIAL PRIMARY KEY,
    ticket_id BIGINT NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    model_name TEXT NOT NULL,
    prompt_version TEXT NOT NULL,
    predicted_category TEXT,
    predicted_intent TEXT,
    predicted_sentiment TEXT,
    predicted_priority TEXT,
    confidence NUMERIC(5,4),
    draft_response TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ai_suggestion_feedback (
    id BIGSERIAL PRIMARY KEY,
    analysis_id BIGINT NOT NULL REFERENCES ai_analyses(id) ON DELETE CASCADE,
    agent_id BIGINT REFERENCES users(id),
    outcome TEXT NOT NULL CHECK (outcome IN ('Accepted', 'Edited', 'Rejected')),
    edited_response TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ticket_events (
    id BIGSERIAL PRIMARY KEY,
    ticket_id BIGINT NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    actor_id BIGINT REFERENCES users(id),
    event_type TEXT NOT NULL,
    old_value TEXT,
    new_value TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_tickets_status_created ON tickets(status, created_at DESC);
CREATE INDEX idx_tickets_category_created ON tickets(category, created_at DESC);
CREATE INDEX idx_tickets_assigned_agent ON tickets(assigned_agent_id);
CREATE INDEX idx_ticket_messages_ticket_created ON ticket_messages(ticket_id, created_at);
CREATE INDEX idx_ai_analyses_ticket_created ON ai_analyses(ticket_id, created_at DESC);
