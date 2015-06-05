defmodule Mix.Phoenix do
  # Conveniences for Phoenix tasks.
  @moduledoc false

  @doc """
  Returns the module base name based on the configuration value.

      config :my_app
        app_namespace: My.App

  """
  def base do
    app = Mix.Project.config |> Keyword.fetch!(:app)

    case Application.get_env(app, :app_namespace, app) do
      ^app -> app |> to_string |> Phoenix.Naming.camelize
      mod  -> mod |> inspect
    end
  end

  @doc """
  Returns all compiled modules in a project.
  """
  def modules do
    Mix.Project.compile_path
    |> Path.join("*.beam")
    |> Path.wildcard
    |> Enum.map(&beam_to_module/1)
  end

  defp beam_to_module(path) do
    path |> Path.basename(".beam") |> String.to_atom()
  end
end
