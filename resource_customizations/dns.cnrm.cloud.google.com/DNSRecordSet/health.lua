hs = {}
if obj.status ~= nil then
  if obj.status.conditions ~= nil then
    for i, condition in ipairs(obj.status.conditions) do
      if condition.type == "Ready" and condition.status == "False" and condition.reason == "DependencyNotFound" then
        hs.status = "Unknown"
        hs.message = condition.message
        return hs
      end
      if condition.type == "Ready" and condition.status == "False" and condition.reason == "DependencyNotReady" then
        hs.status = "Missing"
        hs.message = condition.message
        return hs
      end
      if condition.type == "Ready" and condition.status == "False" and condition.reason == "Updating" then
        hs.status = "Progressing"
        hs.message = condition.message
        return hs
      end
      if condition.type == "Ready" and condition.status == "True" and condition.reason == "UpToDate" then
        hs.status = "Healthy"
        hs.message = condition.message
        return hs
      end
    end
  end
end

hs.status = "Progressing"
hs.message = "Initializing Compute Network"
return hs