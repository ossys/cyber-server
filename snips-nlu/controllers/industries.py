from sanic.response import json, text

from models.validator import Validator


def prefix(pre):
    return pre + '/industries'


async def companies(request):
    if request.method == 'GET':
        validator = Validator()

        if not validator.hasErrors():
            categories = [
                {
                    "name": "Microsoft",
                    "symbol": "MSFT"
                },
                {
                    "name": "Apple",
                    "symbol": "AAPL"
                },
                {
                    "name": "Google",
                    "symbol": "GOOG"
                },
                {
                    "name": "Lam Research",
                    "symbol": "LRCX"
                },
                {
                    "name": "Micron Technology",
                    "symbol": "MU"
                },
                {
                    "name": "AMD",
                    "symbol": "AMD"
                },
                {
                    "name": "Intel",
                    "symbol": "INTC"
                },
                {
                    "name": "NVIDIA",
                    "symbol": "NVDA"
                },
                {
                    "name": "Amazon",
                    "symbol": "AMZN"
                },
                {
                    "name": "Boeing",
                    "symbol": "BA"
                },
                {
                    "name": "Bank of America",
                    "symbol": "BAC"
                }
            ]
        return json(categories)

    else:
        return text('',status=200)


async def performance(request):
    if request.method == 'GET':
        validator = Validator()

        if not validator.hasErrors():
            categories = industries[request.args['industry'][0]]
        return json(categories)

    else:
        return text('',status=200)


industries = {
    'Information Technology': {
        "name": "Information Technology",
        "series": [
            {
                "name": "2008",
                "value": 11
            },
            {
                "name": "2009",
                "value": 17
            },
            {
                "name": "2010",
                "value": 14
            },
            {
                "name": "2011",
                "value": 25
            },
            {
                "name": "2012",
                "value": 40
            },
            {
                "name": "2013",
                "value": 35
            },
            {
                "name": "2014",
                "value": 34
            },
            {
                "name": "2015",
                "value": 50
            },
            {
                "name": "2016",
                "value": 65
            },
            {
                "name": "2017",
                "value": 73
            },
            {
                "name": "2018",
                "value": 80
            }
        ]
    },
    'Security': {
        "name": "Security",
        "series": [
            {
                "name": "2008",
                "value": 11
            },
            {
                "name": "2009",
                "value": 17
            },
            {
                "name": "2010",
                "value": 14
            },
            {
                "name": "2011",
                "value": 25
            },
            {
                "name": "2012",
                "value": 40
            },
            {
                "name": "2013",
                "value": 35
            },
            {
                "name": "2014",
                "value": 34
            },
            {
                "name": "2015",
                "value": 50
            },
            {
                "name": "2016",
                "value": 65
            },
            {
                "name": "2017",
                "value": 73
            },
            {
                "name": "2018",
                "value": 80
            }
        ]
    },
    'Software': {
        "name": "Software",
        "series": [
            {
                "name": "2008",
                "value": 11
            },
            {
                "name": "2009",
                "value": 17
            },
            {
                "name": "2010",
                "value": 14
            },
            {
                "name": "2011",
                "value": 25
            },
            {
                "name": "2012",
                "value": 40
            },
            {
                "name": "2013",
                "value": 35
            },
            {
                "name": "2014",
                "value": 34
            },
            {
                "name": "2015",
                "value": 50
            },
            {
                "name": "2016",
                "value": 65
            },
            {
                "name": "2017",
                "value": 73
            },
            {
                "name": "2018",
                "value": 80
            }
        ]
    },
    'Semi-Conductors': {
        "name": "Semi-Conductors",
        "series": [
            {
                "name": "2008",
                "value": 11
            },
            {
                "name": "2009",
                "value": 17
            },
            {
                "name": "2010",
                "value": 14
            },
            {
                "name": "2011",
                "value": 25
            },
            {
                "name": "2012",
                "value": 40
            },
            {
                "name": "2013",
                "value": 35
            },
            {
                "name": "2014",
                "value": 34
            },
            {
                "name": "2015",
                "value": 50
            },
            {
                "name": "2016",
                "value": 65
            },
            {
                "name": "2017",
                "value": 73
            },
            {
                "name": "2018",
                "value": 80
            }
        ]
    },
    'Cloud': {
        "name": "Cloud",
        "series": [
            {
                "name": "2008",
                "value": 11
            },
            {
                "name": "2009",
                "value": 17
            },
            {
                "name": "2010",
                "value": 14
            },
            {
                "name": "2011",
                "value": 25
            },
            {
                "name": "2012",
                "value": 40
            },
            {
                "name": "2013",
                "value": 35
            },
            {
                "name": "2014",
                "value": 34
            },
            {
                "name": "2015",
                "value": 50
            },
            {
                "name": "2016",
                "value": 65
            },
            {
                "name": "2017",
                "value": 73
            },
            {
                "name": "2018",
                "value": 80
            }
        ]
    }
}
