import os
import configparser
import ssl
from ssl import SSLContext

config = configparser.ConfigParser()
config.read(os.path.join(os.path.abspath(os.path.dirname(__file__)), 'settings.ini'))

for section in config:
    for key in config[section]:
        os.environ[key.upper()] = config[section][key]

from app import app

# from h2oai_client import Client
# h2oai = Client(address='http://10.0.0.201:12345', username='ml', password='ml')
# 
# train = h2oai.create_dataset_sync('/data/HousingPrices/test.csv')
# test = h2oai.create_dataset_sync('/data/HousingPrices/train.csv')
# 
# experiment = h2oai.start_experiment_sync(dataset_key = train.key,
#                                         testset_key=test.key,
#                                         target_col='SalePrice',
#                                         is_classification=False,
#                                         accuracy=2,
#                                         time=1,
#                                         interpretability=7,
#                                         scorer = 'RMSE',
#                                         seed = 1234)
# 
# print("Final Model Score on Validation Data: " + str(round(experiment.valid_score, 3)))
# print("Final Model Score on Test Data: " + str(round(experiment.test_score, 3)))

if __name__ == '__main__':
#     context = ssl.create_default_context(purpose=ssl.Purpose.CLIENT_AUTH)
#     context.verify_mode = ssl.CERT_REQUIRED
#     context.load_cert_chain('./certs/server.crt', keyfile='./certs/server.key')
#     context.load_verify_locations(cafile='./certs/client.crt')
    app.run(host='127.0.0.1', port=8000, debug=True, auto_restart=True)
