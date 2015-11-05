Redmine::Plugin.register :my_projects do
  name 'Custom Projects plugin'
  author 'Gord Brown'
  description 'Maintain a list of projects of interest, per individual'
  version '1.0.0'
  url 'https://github.com/gdbzork/custom_projects_plugin'
  author_url 'http://gdbrown.org/blog/'

  menu :top_menu, :myprojects, { controller: '/my_projects', action: 'show'}, caption: :my_projects_caption, after: :projects
end
