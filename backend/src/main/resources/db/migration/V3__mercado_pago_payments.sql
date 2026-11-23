CREATE TABLE payments (
  id UUID PRIMARY KEY,
  pledge_id UUID REFERENCES pledges(id) ON DELETE SET NULL,
  gift_id UUID REFERENCES gifts(id) ON DELETE SET NULL,
  gift VARCHAR(160) NOT NULL,
  payer_name VARCHAR(160) NOT NULL,
  payer_email VARCHAR(200) NOT NULL,
  amount NUMERIC(12,2) NOT NULL CHECK(amount > 0),
  charged_amount NUMERIC(12,2),
  payment_method VARCHAR(40) NOT NULL,
  installments INTEGER,
  mp_payment_id VARCHAR(80) UNIQUE,
  mp_status VARCHAR(60) NOT NULL,
  mp_status_detail VARCHAR(120),
  idempotency_key VARCHAR(80) UNIQUE NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  approved_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_payments_status ON payments(mp_status);
CREATE INDEX idx_payments_method ON payments(payment_method);
CREATE INDEX idx_payments_gift ON payments(gift_id);
