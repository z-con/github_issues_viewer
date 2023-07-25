class RepositoriesController < ApplicationController
  before_action :octokit_client, only: [:issues]

  def index
  end

  def issues
    repo = params[:repo].gsub(/[^a-zA-Z0-9\/_-]/, '').chomp('/') #Remove whitespace or invalid chars
    Search.create(repo: params[:repo])

    
    if repo.blank?
      redirect_to root_path, alert: "Please enter a repo." #Error handling
    elsif !valid_repo_format?(repo)
      redirect_to root_path, alert: "Invalid repo format. Please enter in 'user/repo' format." #Error handling
    else
      @issues = @client.issues(repo)
    end
  rescue Octokit::NotFound
    redirect_to root_path, alert: "Repo not found"
  end
  
  private
  
  def valid_repo_format?(repo)
    repo.split('/').length == 2 #basic validation
  end
  
  

  private

  def octokit_client
    @client ||= Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"]) #Token abstracted to .env
  end  
end
