local ICONPATH = "__nullius__/graphics/icons/"
local ENTITYPATH = "__nullius__/graphics/entity/"

nullius_non_productivity_categories = {
  ["nullius-electrolysis"] = true,
  ["nullius-gas-void"] = true,
  ["nullius-liquid-void"] = true,
  ["nullius-power-sink"] = true,
  ["nullius-barrel"] = true,
  ["nullius-unbarrel"] = true,
  ["air-filtration-recipe"] = true,
  ["compression"] = true,
  ["decompression"] = true,
  ["water-pumping"] = true,
  ["seawater-pumping"] = true,
  ["combustion"] = true,
  ["boiling"] = true,
  ["pressure-boiling"] = true,
  ["turbine-open"] = true,
  ["turbine-closed"] = true
}

local function recipe_has_noprod_category(recipe)
  for _, x in pairs(recipe.categories or {}) do
    if (nullius_non_productivity_categories[x] == true) then return true end
  end
  return false
end

for _,recipe in pairs(data.raw.recipe) do
  if (((string.sub(recipe.name, 1, 8) == "nullius-") or ((recipe.order ~= nil) and
        (string.sub(recipe.order, 1, 8) == "nullius-"))) and
      (recipe.no_productivity ~= true) and
      (not recipe_has_noprod_category(recipe))) then
    recipe.allow_productivity = true
  end
  recipe.no_productivity = nil
end
