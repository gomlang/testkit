goml := env_var_or_default("GOML", "goml")

test:
    "{{goml}}" test --timeout 300s
