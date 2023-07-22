class RepositoriesController < ApplicationController
  before_action :octokit_client, only: [:issues]

  def index
  end

  def issues
    repo = params[:repo]
    
    if repo.blank?
      redirect_to root_path, alert: "Please enter a repo."
    elsif !valid_repo_format?(repo)
      redirect_to root_path, alert: "Invalid repo format. Please enter in 'user/repo' format."
    else
      @issues = @client.issues(repo)
    end
  rescue Octokit::NotFound
    redirect_to root_path, alert: "Repo not found"
  end
  
  private
  
  def valid_repo_format?(repo)
    repo.split('/').length == 2
  end
  
  

  private

  def octokit_client
    @client ||= Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
  end  
end
