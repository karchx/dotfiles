return {
	formatCommand = ([[
        $([ -n "$(command -v /home/stivarch/.nvm/versions/node/v16.3.0/bin/prettier)" ] && echo "/home/stivarch/.nvm/versions/node/v16.3.0/bin/prettier" || echo "prettier")
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub("\n", ""),
}
