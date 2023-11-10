defmodule RdaThreeWeb.LinkJSON do
  alias RdaThree.Links.Link

  @doc """
  Renders a list of links.
  """
  def index(%{links: links}) do
    %{data: for(link <- links, do: data(link))}
  end

  @doc """
  Renders a single link.
  """
  def show(%{link: link}) do
    %{data: data(link)}
  end

  defp data(%Link{} = link) do
    %{
      id: link.id,
      url: link.url
    }
  end
end
