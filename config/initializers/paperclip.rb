# frozen_string_literal: true

Paperclip::Attachment.default_options[:s3_host_name] = 's3-sa-east-1.amazonaws.com'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id/:style/:filename'
Paperclip::DataUriAdapter.register
