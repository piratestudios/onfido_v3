defmodule Onfido.Resources.Report do
  alias Onfido.Comms.HttpDriver

  @doc """
  List reports for a related check

  ## Example

        Onfido.Resources.Report.list("<check-id>")
  """
  def list(check_id) do
    HttpDriver.request(:get, "/reports?check_id=#{check_id}")
  end

  @doc """
  Get report for a related check

  ## Example

        Onfido.Resources.Report.get("<report-id>")
  """
  def get(report_id) do
    HttpDriver.request(:get, "/reports/#{report_id}")
  end

  @doc """
  Resume a paused report for a related check

  ## Example

        Onfido.Resources.Report.resume("<report-id>")
  """
  def resume(report_id) do
    HttpDriver.request(:post, "/reports/#{report_id}/resume")
  end

  @doc """
  Cancel a report for a related check

  ## Example

        Onfido.Resources.Report.cancel("<report-id>")
  """
  def cancel(report_id) do
    HttpDriver.request(:post, "/reports/#{report_id}/cancel")
  end
end
