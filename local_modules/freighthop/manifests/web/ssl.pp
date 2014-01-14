class freighthop::web::ssl(
  $server_name,
  $ssl_cert_path,
  $ssl_key_path,
){
  $cert_subject = "/C=US/ST=IL/L=Chicago/O=Freighthop/CN=${server_name}"

  exec { 'generate-self-signed-ssl-cert':
    command => "openssl req -x509 -nodes -days 3650 -subj '${cert_subject}' -newkey rsa:1024 -keyout ${ssl_key_path} -out ${ssl_cert_path}",
    path    => ['/usr/bin'],
    creates => $ssl_cert_path,
  }
}
