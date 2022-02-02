class RemoteUser < ActiveResource::Base
  self.site = APP_CONFIG['listgroups_service_url']
  self.user = APP_CONFIG['listgroups_user']
  self.password = APP_CONFIG['listgroups_pass']

  self.element_name = "user"

end