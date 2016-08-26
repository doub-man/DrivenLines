CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = "0QXRpSqC69m636AybE0ZmjBiQzZpysgFnwG8jyXV"
  config.qiniu_secret_key    = 'JaTmNukvrvXaVLUl_O8fj2i-02xJIkWAwOXEmnHW'
  config.qiniu_bucket        = "drivenline"
  config.qiniu_bucket_domain = "oci2lh1w7.bkt.clouddn.com"
  config.qiniu_bucket_private= false
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
end
