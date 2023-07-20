class RepositoriesController < ApplicationController
  before_action :octokit_client

  def issues
    repo = params[:repo]
    @issues = @client.issues(repo)
  rescue Octokit::NotFound
    @issues = []
  end

  private

  def octokit_client
    @client ||= Octokit::Client.new(access_token: "f366cacd10846195fb611ea5fb0c4778d51d3d33")
  end
end
