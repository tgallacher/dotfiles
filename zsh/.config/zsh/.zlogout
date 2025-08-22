## Ensure keychain is logged at logout
if command -v aws-vault >/dev/null 2>&1; then
  security lock-keychain aws-vault.keychain.db
fi

