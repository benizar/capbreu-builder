
# Capa virtual ejes L2

SELECT "from", "to", e.label,e.type,
       make_line(a.geometry, b.geometry)
FROM edges e
JOIN "nodes-spatial" a ON e."from" = a.id
JOIN "nodes-spatial" b ON e."to" = b.id
WHERE a.id != b.id AND
e.type IN ('level2-admin-border','level2-anthropic-border','level2-mountains-border','level2-rivers-border','level2-border')
