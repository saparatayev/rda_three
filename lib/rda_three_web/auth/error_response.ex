defmodule RdaThreeWeb.Auth.ErrorResponse.Unauthorized  do
  defexception [message: "Unauthorized", plug_status: 401]
end

defmodule RdaThreeWeb.Auth.ErrorResponse.Forbidden do
  defexception [message: "You do not have access to this resource", plug_status: 403]
end

defmodule RealDealApiWeb.Auth.ErrorResponse.NotFound do
  defexception [message: "Not found", plug_status: 401]
end
