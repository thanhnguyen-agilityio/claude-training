# Example

All names and links are made up. Always use the user's own profile.

**Saved profile (from setup, not repeated in daily notes):**

```
Training report profile
- Sender: Minh Le
- Team prefix: hf
- Supporters (To): An Tran <an.tran@example.com>, Binh Do <binh.do@example.com>
- CC: asoft.training@asnet.com.vn, Cuong Pham <cuong.pham@example.com>
- Course: [MCP training plan](https://docs.google.com/document/d/EXAMPLE)
- Hashtags: #llm #mcp
- Repo: [mcp-training](https://gitlab.asoft-python.com/minh.le/mcp-training), folder 3-practices/3-2-ecommerce
```

**Today's notes from the user:**

> Worked on #12 Implement Database MCP Server: init server, resources database://connection, database://schema; sql tools list_database_tables, execute_sql_query. Learned: resources = read-only context for the model, tools = actions; keep SQL tools read-only to avoid unsafe queries. Branch feat/ecommerce, commit b69e476. Stuck: SQLite connection closes between tool calls, tried a connection pool, still failing. Anyone handled SQLite with async MCP servers? Tomorrow: cart and order tools. Tags: #practice

**Draft:**

- Subject: `[hf][training] 20261014 #llm #mcp #practice`
- To: an.tran@example.com, binh.do@example.com
- CC: asoft.training@asnet.com.vn, cuong.pham@example.com

```
Hi An and Binh,
Today, I continued training the [MCP training plan](https://docs.google.com/document/d/EXAMPLE) by implementing the Database MCP Server practice.
Please find more detail in content below:
FINISHED

* Implement Database MCP Server ([#12](https://gitlab.asoft-python.com/minh.le/mcp-training/-/issues/12))
   * Resources (database://connection, database://schema) give the model read-only context; tools perform actions
   * SQL tools (list_database_tables, execute_sql_query) are read-only to avoid unsafe queries
* For more details, please refer to the [board](https://gitlab.asoft-python.com/minh.le/mcp-training/-/boards)
* Source code:
   * Git repository: [mcp-training](https://gitlab.asoft-python.com/minh.le/mcp-training)
   * Branch: [feat/ecommerce](https://gitlab.asoft-python.com/minh.le/mcp-training/-/commits/feat/ecommerce)
   * Folder: 3-practices/3-2-ecommerce
   * Last commit: [b69e476](https://gitlab.asoft-python.com/minh.le/mcp-training/-/commit/b69e476)

ISSUES

* Issues
   * SQLite connection closes between tool calls; tried a connection pool, still failing. Has anyone handled SQLite connections in an async MCP server?

NEXT PLAN

* Continue task Implement Database MCP Server ([#12](https://gitlab.asoft-python.com/minh.le/mcp-training/-/issues/12))
   * Implement cart tools
   * Implement order tools

Best regards,
Minh Le.
```

Recipients, course, repo, and folder come from the profile. The daily notes add only the work, branch, commit, and extra tags. Issue, branch, commit, and board links follow the repo's GitLab URL pattern. IN PROCESS is omitted because it is empty.
