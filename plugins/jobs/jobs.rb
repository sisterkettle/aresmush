$:.unshift File.dirname(__FILE__)

# Must be loaded before other job commands
load "engine/single_job_cmd.rb"

load "engine/change_job_cmd.rb"
load "engine/close_job_cmd.rb"
load "engine/create_job_cmd.rb"
load "engine/create_request_cmd.rb"
load "engine/delete_job_cmd.rb"
load "engine/char_connected_event_handler.rb"
load "engine/handle_job_cmd.rb"
load "engine/job_comment_cmd.rb"
load "engine/job_delete_reply_cmd.rb"
load "engine/job_search_cmd.rb"
load "engine/job_status_cmd.rb"
load "engine/jobs_backup_cmd.rb"
load "engine/jobs_catchup.rb"
load "engine/jobs_filter_cmd.rb"
load "engine/job_mail_cmd.rb"
load "engine/jobs_new_cmd.rb"
load "engine/job_unread_cmd.rb"
load "engine/list_jobs_cmd.rb"
load "engine/list_requests_cmd.rb"
load "engine/purge_jobs_cmd.rb"
load "engine/request_comment_cmd.rb"
load "engine/view_job_cmd.rb"
load "engine/view_request_cmd.rb"
load "engine/templates/job_template.rb"
load "engine/templates/jobs_list_template.rb"
load "lib/helpers.rb"
load "lib/jobs_api.rb"
load "lib/jobs_model.rb"
load "web/job_close.rb"
load "web/job_create.rb"
load "web/job_reply.rb"
load "web/job.rb"
load "web/jobs_index.rb"

module AresMUSH
  module Jobs
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("jobs", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
 
    def self.config_files
      [ "config_jobs.yml" ]
    end
 
    def self.locale_files
      [ "locales/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
       case cmd.root
       when "job"
         case cmd.switch
         when "all"
           return ListJobsCmd
         when "backup"
           return JobsBackupCmd
         when "cat"
           return ChangeCategoryCmd
         when "catchup"
           return JobsCatchupCmd
         when "discuss", "respond"
           return JobCommentCmd
         when "close"
           return CloseJobCmd
         when "confirmpurge"
           return PurgeJobsConfirmCmd
         when "create"
           return CreateJobCmd
         when "delete"
           return DeleteJobCmd
         when "deletereply"
           return JobDeleteReplyCmd
         when "handle", "assign"
           return HandleJobCmd
         when "filter"
           return JobsFilterCmd
         when "mail"
           return JobMailCmd
         when "new"
           return JobsNewCmd
         when "purge"
           return PurgeJobsCmd
         when "search"
           return JobSearchCmd
         when "status"
           return JobStatusCmd
         when "title"
           return ChangeTitleCmd
         when "unread"
           return JobUnreadCmd
         when nil
           if (cmd.args)
             return ViewJobCmd
           else
             return ListJobsCmd
           end
         end
         
       when "request"
         case cmd.switch
         when "respond"
           return RequestCommentCmd
         when "all"
           return ListRequestsCmd
         when "create"
           return CreateRequestCmd
         when nil
           if (!cmd.args)
             return ListRequestsCmd
           elsif (cmd.args =~ /\=/)
             return CreateRequestCmd
           else
             return ViewRequestCmd
           end
         end
       end
       
       nil
    end

    def self.get_event_handler(event_name) 
      case event_name
      when "CharConnectedEvent"
        return CharConnectedEventHandler
      end
      nil
    end
  end
end