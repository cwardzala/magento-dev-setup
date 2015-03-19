# reset insecure domain
update magento.core_config_data set value='http://#DOMAIN' where value='http://#PROD DOMAIN';

# reset secure domain
update magento.core_config_data set value='https://#DOMAIN' where value='https://#PROD DOMAIN';

# reset general/store_information/name
update magento.core_config_data set value='http://#DOMAIN' where value='http://#PROD DOMAIN';

# reset cookie domain
update magento.core_config_data set value='' where value='#PROD COOKIE DOMAIN';
