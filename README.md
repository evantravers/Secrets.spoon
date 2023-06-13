# Secrets.spoon

Really stupid simple loading of secrets into `hs.settings`. Supports json files for loading secrets, and json string or table lookup via get.

Setup:

```lua
hs.loadSpoon("Secrets")
Secrets = spoon.Secrets
-- provide a json file for all your secrets, .gitignore it to keep it from being checked into source
Secrets:start(".secrets.json")

-- supports json "dot notation"
local key     = Secrets.get("toggl.key")
-- also supports table lookup
local project = Secrets.get({"toggl", "projects", "programming"})
```
