class RepositoriesController < ApplicationController
  before_action :octokit_client, only: [:issues]

  def index
  end

  def issues
    repo = params[:repo]
    
    if repo.blank?
      redirect_to root_path, alert: "Please enter a repository."
    else
      @issues = @client.issues(repo)
    end
  rescue Octokit::NotFound
    redirect_to root_path, alert: "Repository not found"
  end
  

  private

  def octokit_client
    @client ||= Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
  end  
end
