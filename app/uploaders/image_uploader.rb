class ImageUploader < Shrine
  plugin :determine_mime_type
  plugin :validation_helpers

  Attacher.validate do
    validate_mime_type_inclusion %w[image/jpeg image/png]
    validate_max_size 2000000
  end
end
