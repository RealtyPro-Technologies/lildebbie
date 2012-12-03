class ProjectGrantDecorator < ApplicationDecorator
	decorates :project_grant
  decorates_association :project
  decorates_association :user
end