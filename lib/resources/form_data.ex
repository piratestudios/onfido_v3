defmodule Onfido.FormData do
  @moduledoc """
  Drop-in replacement for `httpoison_form_data`'s `FormData.create/2`.
  """

  @doc """
  Builds a `{:multipart, ...}` tuple compatible with HTTPoison.
  The second argument `opts` is ignored unless you need custom behavior.
  """
  def create(fields, _opts \\ []) when is_list(fields) do
    {:multipart, Enum.map(fields, &normalize_part/1)}
  end

  defp normalize_part({key, value}) when is_binary(key) and is_binary(value) do
    {:form, {key, value}}
  end

  defp normalize_part({:file, path, opts}) do
    {:file, path, opts}
  end

  defp normalize_part({:file, path}) do
    {:file, path}
  end
end
