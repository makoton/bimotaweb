# -*- encoding : utf-8 -*-
class Setting < ActiveRecord::Base



  #returns an array with the emails
  def mail_list
    stock_mail_list.gsub(' ', '').split(',')
  rescue
    []
  end

end