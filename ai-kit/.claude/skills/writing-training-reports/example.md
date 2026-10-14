# Example

All names and links are made up. Always use the user's own profile.

**Notes from the user:**

> Supporters An and Binh. Plan: MCP training plan https://docs.google.com/document/d/EXAMPLE. Repo https://gitlab.asoft-python.com/an.tran/mcp-training. Worked on issue #12 Implement Database MCP Server: init server, resources database://connection, database://schema; sql tools list_database_tables, execute_sql_query. Learned: resources = read-only context for the model, tools = actions; keep SQL tools read-only to avoid unsafe queries. Branch feat/ecommerce, folder 3-practices/3-2-ecommerce, commit b69e476. Stuck: SQLite connection closes between tool calls, tried a connection pool, still failing. Anyone handled SQLite with async MCP servers? Tomorrow: cart and order tools.

**Body:**

```
Hi An and Binh,
Today, I continued training the [MCP training plan](https://docs.google.com/document/d/EXAMPLE) by implementing the Database MCP Server practice.
Please find more detail in content below:
FINISHED

* Implement Database MCP Server ([#12](https://gitlab.asoft-python.com/an.tran/mcp-training/-/issues/12))
   * Resources (database://connection, database://schema) give the model read-only context; tools perform actions
   * SQL tools (list_database_tables, execute_sql_query) are read-only to avoid unsafe queries
* For more details, please refer to the [board](https://gitlab.asoft-python.com/an.tran/mcp-training/-/boards)
* Source code:
   * Git repository: [mcp-training](https://gitlab.asoft-python.com/an.tran/mcp-training)
   * Branch: [feat/ecommerce](https://gitlab.asoft-python.com/an.tran/mcp-training/-/commits/feat/ecommerce)
   * Folder: 3-practices/3-2-ecommerce
   * Last commit: [b69e476](https://gitlab.asoft-python.com/an.tran/mcp-training/-/commit/b69e476)

ISSUES

* Issues
   * SQLite connection closes between tool calls; tried a connection pool, still failing. Has anyone handled SQLite connections in an async MCP server?

NEXT PLAN

* Continue task Implement Database MCP Server ([#12](https://gitlab.asoft-python.com/an.tran/mcp-training/-/issues/12))
   * Implement cart tools
   * Implement order tools

Best regards,
<Sender name>.
```

The user gave only "#12" and the branch name. The issue, branch, and commit links follow the repo's GitLab URL pattern. IN PROCESS is omitted because it is empty.
