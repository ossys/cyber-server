from sanic.response import json, text

from models.validator import Validator


def prefix(pre):
    return pre + '/companies'


async def performance(request):
    if request.method == 'GET':
        validator = Validator()

        if not validator.hasErrors():
            categories = companies[request.args['company'][0]]
        return json(categories)

    else:
        return text('',status=200)

companies = {
        'MSFT': {
            "name": "MSFT",
            "series": [
                {
                    "name": "2008",
                    "value": 5
                },
                {
                    "name": "2009",
                    "value": 11
                },
                {
                    "name": "2010",
                    "value": 21
                },
                {
                    "name": "2011",
                    "value": 17
                },
                {
                    "name": "2012",
                    "value": 15
                },
                {
                    "name": "2013",
                    "value": 30
                },
                {
                    "name": "2014",
                    "value": 50
                },
                {
                    "name": "2015",
                    "value": 58
                },
                {
                    "name": "2016",
                    "value": 70
                },
                {
                    "name": "2017",
                    "value": 85
                },
                {
                    "name": "2018",
                    "value": 102
                }
            ]
        },
        'AAPL': {
            "name": "AAPL",
            "series": [
                {
                    "name": "2008",
                    "value": 15
                },
                {
                    "name": "2009",
                    "value": 40
                },
                {
                    "name": "2010",
                    "value": 60
                },
                {
                    "name": "2011",
                    "value": 55
                },
                {
                    "name": "2012",
                    "value": 60
                },
                {
                    "name": "2013",
                    "value": 58
                },
                {
                    "name": "2014",
                    "value": 70
                },
                {
                    "name": "2015",
                    "value": 75
                },
                {
                    "name": "2016",
                    "value": 91
                },
                {
                    "name": "2017",
                    "value": 101
                },
                {
                    "name": "2018",
                    "value": 110
                }
            ]
        },
        'GOOG': {
            "name": "GOOG",
            "series": [
                {
                    "name": "2008",
                    "value": 5
                },
                {
                    "name": "2009",
                    "value": 11
                },
                {
                    "name": "2010",
                    "value": 21
                },
                {
                    "name": "2011",
                    "value": 17
                },
                {
                    "name": "2012",
                    "value": 15
                },
                {
                    "name": "2013",
                    "value": 30
                },
                {
                    "name": "2014",
                    "value": 50
                },
                {
                    "name": "2015",
                    "value": 58
                },
                {
                    "name": "2016",
                    "value": 70
                },
                {
                    "name": "2017",
                    "value": 85
                },
                {
                    "name": "2018",
                    "value": 102
                }
            ]
        },
        'LRCX': {
            "name": "LRCX",
            "series": [
                {
                    "name": "2008",
                    "value": 15
                },
                {
                    "name": "2009",
                    "value": 40
                },
                {
                    "name": "2010",
                    "value": 60
                },
                {
                    "name": "2011",
                    "value": 55
                },
                {
                    "name": "2012",
                    "value": 60
                },
                {
                    "name": "2013",
                    "value": 58
                },
                {
                    "name": "2014",
                    "value": 70
                },
                {
                    "name": "2015",
                    "value": 75
                },
                {
                    "name": "2016",
                    "value": 91
                },
                {
                    "name": "2017",
                    "value": 101
                },
                {
                    "name": "2018",
                    "value": 110
                }
            ]
        },
        'MU': {
            "name": "MU",
            "series": [
                {
                    "name": "2008",
                    "value": 5
                },
                {
                    "name": "2009",
                    "value": 11
                },
                {
                    "name": "2010",
                    "value": 21
                },
                {
                    "name": "2011",
                    "value": 17
                },
                {
                    "name": "2012",
                    "value": 15
                },
                {
                    "name": "2013",
                    "value": 30
                },
                {
                    "name": "2014",
                    "value": 50
                },
                {
                    "name": "2015",
                    "value": 58
                },
                {
                    "name": "2016",
                    "value": 70
                },
                {
                    "name": "2017",
                    "value": 85
                },
                {
                    "name": "2018",
                    "value": 102
                }
            ]
        },
        'AMD': {
            "name": "AMD",
            "series": [
                {
                    "name": "2008",
                    "value": 15
                },
                {
                    "name": "2009",
                    "value": 40
                },
                {
                    "name": "2010",
                    "value": 60
                },
                {
                    "name": "2011",
                    "value": 55
                },
                {
                    "name": "2012",
                    "value": 60
                },
                {
                    "name": "2013",
                    "value": 58
                },
                {
                    "name": "2014",
                    "value": 70
                },
                {
                    "name": "2015",
                    "value": 75
                },
                {
                    "name": "2016",
                    "value": 91
                },
                {
                    "name": "2017",
                    "value": 101
                },
                {
                    "name": "2018",
                    "value": 110
                }
            ]
        },
        'INTC': {
            "name": "INTC",
            "series": [
                {
                    "name": "2008",
                    "value": 5
                },
                {
                    "name": "2009",
                    "value": 11
                },
                {
                    "name": "2010",
                    "value": 21
                },
                {
                    "name": "2011",
                    "value": 17
                },
                {
                    "name": "2012",
                    "value": 15
                },
                {
                    "name": "2013",
                    "value": 30
                },
                {
                    "name": "2014",
                    "value": 50
                },
                {
                    "name": "2015",
                    "value": 58
                },
                {
                    "name": "2016",
                    "value": 70
                },
                {
                    "name": "2017",
                    "value": 85
                },
                {
                    "name": "2018",
                    "value": 102
                }
            ]
        },
        'NVDA': {
            "name": "NVDA",
            "series": [
                {
                    "name": "2008",
                    "value": 15
                },
                {
                    "name": "2009",
                    "value": 40
                },
                {
                    "name": "2010",
                    "value": 60
                },
                {
                    "name": "2011",
                    "value": 55
                },
                {
                    "name": "2012",
                    "value": 60
                },
                {
                    "name": "2013",
                    "value": 58
                },
                {
                    "name": "2014",
                    "value": 70
                },
                {
                    "name": "2015",
                    "value": 75
                },
                {
                    "name": "2016",
                    "value": 91
                },
                {
                    "name": "2017",
                    "value": 101
                },
                {
                    "name": "2018",
                    "value": 110
                }
            ]
        },
        'AMZN': {
            "name": "AMZN",
            "series": [
                {
                    "name": "2008",
                    "value": 5
                },
                {
                    "name": "2009",
                    "value": 11
                },
                {
                    "name": "2010",
                    "value": 21
                },
                {
                    "name": "2011",
                    "value": 17
                },
                {
                    "name": "2012",
                    "value": 15
                },
                {
                    "name": "2013",
                    "value": 30
                },
                {
                    "name": "2014",
                    "value": 50
                },
                {
                    "name": "2015",
                    "value": 58
                },
                {
                    "name": "2016",
                    "value": 70
                },
                {
                    "name": "2017",
                    "value": 85
                },
                {
                    "name": "2018",
                    "value": 102
                }
            ]
        },
        'BA': {
            "name": "BA",
            "series": [
                {
                    "name": "2008",
                    "value": 5
                },
                {
                    "name": "2009",
                    "value": 11
                },
                {
                    "name": "2010",
                    "value": 21
                },
                {
                    "name": "2011",
                    "value": 17
                },
                {
                    "name": "2012",
                    "value": 15
                },
                {
                    "name": "2013",
                    "value": 30
                },
                {
                    "name": "2014",
                    "value": 50
                },
                {
                    "name": "2015",
                    "value": 58
                },
                {
                    "name": "2016",
                    "value": 70
                },
                {
                    "name": "2017",
                    "value": 85
                },
                {
                    "name": "2018",
                    "value": 102
                }
            ]
        },
        'BAC': {
            "name": "BAC",
            "series": [
                {
                    "name": "2008",
                    "value": 5
                },
                {
                    "name": "2009",
                    "value": 11
                },
                {
                    "name": "2010",
                    "value": 21
                },
                {
                    "name": "2011",
                    "value": 17
                },
                {
                    "name": "2012",
                    "value": 15
                },
                {
                    "name": "2013",
                    "value": 30
                },
                {
                    "name": "2014",
                    "value": 50
                },
                {
                    "name": "2015",
                    "value": 58
                },
                {
                    "name": "2016",
                    "value": 70
                },
                {
                    "name": "2017",
                    "value": 85
                },
                {
                    "name": "2018",
                    "value": 102
                }
            ]
        }
    }

