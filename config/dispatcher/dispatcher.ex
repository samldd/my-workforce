defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  match "/employees/*path" do
    Proxy.forward conn, path, "http://resource/employees/"
  end

  match "/projects/*path" do
    Proxy.forward conn, path, "http://resource/projects/"
  end

  match "/project-skills/*path" do
    Proxy.forward conn, path, "http://resource/project-skills/"
  end

  match "/employee-projects/*path" do
    Proxy.forward conn, path, "http://resource/employee-projects/"
  end

  match "/allSkills/*path" do
    Proxy.forward conn, path, "http://resource/skills/"
  end

  match "/employee-skills/*path" do
    Proxy.forward conn, path, "http://resource/employee-skills/"
  end  

  match "/employee-functions/*path" do
    Proxy.forward conn, path, "http://resource/employee-functions/"
  end

  match "/improvements/*path" do
    Proxy.forward conn, path, "http://workforce/improvements/"
  end

  match "/skills/*path" do
    Proxy.forward conn, path, "http://workforce/skills/"
  end

  match "/bubble/*path" do
    Proxy.forward conn, path, "http://workforce/bubble/"
  end

  match "/matches/*path" do
    Proxy.forward conn, path, "http://workforce/employee_sugestions/"
  end

  match "/occupations/*path" do
    Proxy.forward conn, path, "http://workforce/occupations/"
  end

  match "/timeline/*path" do
    Proxy.forward conn, path, "http://workforce/timeline/"
  end

  match "/generateCompany/*path" do
    Proxy.forward conn, path, "http://generator/generate-company/"
  end

  match "/hirePerson/*path" do
    Proxy.forward conn, path, "http://generator/hire-person/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end


end
