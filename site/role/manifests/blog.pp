class role::blog {
  include profile::apache
  include profile::mysql
  include profile::wordpress
}
