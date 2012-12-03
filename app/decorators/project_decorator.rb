class ProjectDecorator < ApplicationDecorator
  decorates :project
  decorates_association :user
  decorates_association :project_grants

  def self.find(username, projectname)
    self.decorate Project.find(username, projectname)
  end
end
