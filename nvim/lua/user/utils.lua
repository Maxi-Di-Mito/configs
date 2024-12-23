local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

local function capture(cmd, raw)
  local handle = assert(io.popen(cmd, "r"))
  local output = assert(handle:read("*a"))

  handle:close()

  if raw then
    return output
  end

  output = string.gsub(string.gsub(string.gsub(output, "^%s+", ""), "%s+$", ""), "[\n\r]+", " ")

  return output
end

local function getTypescriptPath()
  local typescriptPath = capture("npm ls --location=global -p | grep typescript", true)
  local path = string.gsub(typescriptPath .. "/lib", "\n", "")
  print(path)
  return path
end

local function mysplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function isTermux()
  return vim.env.TERMUX_VERSION ~= nil
end

return {
  isTermux = isTermux,
  capture = capture,
  dump = dump,
  getTypescriptPath = getTypescriptPath,
  splitString = mysplit,
}
