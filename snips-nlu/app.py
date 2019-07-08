from sanic import Sanic
from sanic_cors import CORS
from celery import Celery

from controllers import (user, home, industries, sectors, companies)

tasks = Celery('afml', broker='pyamqp://guest@localhost//')
tasks.autodiscover_tasks(['models.mongo'])

app = Sanic()
CORS(app)

PREFIX = '/api'

app.add_route(home.home, '/',    methods=['GET'])

# user
app.add_route(user.register, user.prefix(PREFIX) + '/register',    methods=['OPTIONS', 'POST'])
app.add_route(user.login, user.prefix(PREFIX) + '/login',       methods=['OPTIONS', 'POST'])

# companies
app.add_route(companies.performance, companies.prefix(PREFIX) + '/performance', methods=['OPTIONS', 'GET'])

# industries
app.add_route(industries.companies, industries.prefix(PREFIX) + '/companies', methods=['OPTIONS', 'GET'])
app.add_route(industries.performance, industries.prefix(PREFIX) + '/performance', methods=['OPTIONS', 'GET'])

# sectors
app.add_route(sectors.sector_list, sectors.prefix(PREFIX) + '/list',    methods=['OPTIONS', 'GET'])
app.add_route(sectors.breakdown, sectors.prefix(PREFIX) + '/breakdown',    methods=['OPTIONS', 'GET'])
app.add_route(sectors.industries, sectors.prefix(PREFIX) + '/industries',    methods=['OPTIONS', 'GET'])
app.add_route(sectors.performance, sectors.prefix(PREFIX) + '/performance',    methods=['OPTIONS', 'GET'])
