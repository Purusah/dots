cd $HOME/lua_language_server
curl -LO https://github.com/LuaLS/lua-language-server/releases/download/3.11.1/lua-language-server-3.11.1-linux-x64.tar.gz
mkdir lsp
tar -xvf lua-language-server-3.11.1-linux-x64.tar.gz -C lsp
rm lua-language-server-3.11.1-linux-x64.tar.gz
ln -s $HOME/bin/lua_language_server/lsp/bin/lua-language-server $HOME/.local/bin/lua-language-server


