-- ============================================================
-- EVESAT - EM Producciones
-- Módulo: Cotizaciones
-- Tabla: cotizaciones + cotizacion_items
-- ============================================================

CREATE TABLE IF NOT EXISTS cotizaciones (
    id            CHAR(36)        NOT NULL DEFAULT (UUID()),
    cliente_id    CHAR(36)        NOT NULL,
    evento_id     CHAR(36)        NULL,
    creado_por    CHAR(36)        NOT NULL,
    fecha_creacion DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_evento  DATE            NULL,
    estado        ENUM(
                    'borrador',
                    'enviada',
                    'aprobada',
                    'rechazada',
                    'vencida'
                  )               NOT NULL DEFAULT 'borrador',
    total         DECIMAL(12, 2)  NOT NULL DEFAULT 0.00,
    notas         TEXT            NULL,
    created_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                           ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_cotizacion_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    CONSTRAINT fk_cotizacion_evento
        FOREIGN KEY (evento_id)  REFERENCES eventos(id),
    CONSTRAINT fk_cotizacion_usuario
        FOREIGN KEY (creado_por) REFERENCES usuarios(id)
);

-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cotizacion_items (
    id              CHAR(36)        NOT NULL DEFAULT (UUID()),
    cotizacion_id   CHAR(36)        NOT NULL,
    servicio_id     CHAR(36)        NOT NULL,
    cantidad        INT UNSIGNED    NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(12, 2)  NOT NULL COMMENT 'Snapshot del precio al momento de cotizar',
    subtotal        DECIMAL(12, 2)  NOT NULL,
    notas           VARCHAR(255)    NULL,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                             ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_item_cotizacion
        FOREIGN KEY (cotizacion_id) REFERENCES cotizaciones(id)
                                    ON DELETE CASCADE,
    CONSTRAINT fk_item_servicio
        FOREIGN KEY (servicio_id)   REFERENCES servicios(id)
);
