require 'set'

class MyProjectsController < ApplicationController

  @@digits = /^\d+$/

  def hierarchicalize(projects)
    pset = Set.new(projects.keys)
    parents = {}
    parents[nil] = []
    projects.keys.each do |p|
      proj = projects[p]
      if proj.parent_id.nil?() || !pset.include?(proj.parent_id)
        parents[nil].append(p)
      else
        parents[proj.parent_id] = [] if !parents.has_key?(proj.parent_id)
        parents[proj.parent_id].append(p)
      end
    end
    parents.keys.each do |k|
      parents[k].sort!{|a,b| projects[a].name <=> projects[b].name}
    end
    return parents
  end

  def show
    @user = User.current
    ids = MyProjects.where(user: @user).select('project_id').map{|p| p.project_id}
    @projects = {}
    Project.where(id: ids).each do |p|
      @projects[p.id] = p
    end
    @psets = hierarchicalize(@projects)
  end

  def edit
    @user = User.current
    @projects = {}
    @user.projects.each do |p|
      @projects[p.id] = p
    end
    @psets = hierarchicalize(@projects)
    current_ids = MyProjects.where(user: @user).select('project_id').map{|p| p.project_id}
    @current = Set.new(current_ids)
  end

  def update
    user = User.current
    MyProjects.where(user: user).each do |mp|
      mp.destroy
    end
    params.keys.each do |pk|
      if @@digits =~ pk
        MyProjects.create(user: user, project_id: pk.to_i)
      end
    end
    redirect_to "/my_projects"
  end

end
