--- === Secrets ===
---
--- Really stupid simple loading of secrets into `hs.settings`. Supports json
--- files for loading secrets, and json string or table lookup via get.

local m = {
  name = "Secrets",
  version = "1.0",
  author = "Evan Travers",
  license = "MIT <https://opensource.org/licenses/MIT>",
  homepage = "https://github.com/evantravers/Secrets.spoon"
}

--- Secrets:start(filename)
--- Method
--- Loads a .json file into hs.settings for easy retrieval.
---
--- Parameters:
---  * filename - A string containing the name of a json file (.secrets.json)
---
--- Returns:
---  * self
function m:start(filename)
  if hs.fs.attributes(filename) then
    hs.settings.set("secrets", hs.json.read(filename))
  else
    print("You need to create a file at " .. filename)
  end

  return self
end

function m:stop()
  hs.settings.clear("secrets")

  return self
end

--- Secrets:get(key)
--- Method
--- Returns a value from hs.settings.
---
--- Parameters:
---  * key - A table or string containing the address of something loaded into
---          secrets.
---    * string - dot separated "json style" selector
---    * table - the orderd set of keys for the nested selector
---
--- Returns:
---  * Any
m.get = function(user_key)
  if type(user_key) == "string" then
    user_key = hs.fnutils.split(user_key, ".", true)
  end

  return hs.fnutils.reduce(user_key, function(tbl, key)
    assert(tbl[key] ~= nil, "Key not found in hs.settings.get('secrets')")
    return tbl[key]
  end, hs.settings.get("secrets"))
end

return m
