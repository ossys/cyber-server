from sanic.response import json, text

from models.validator import Validator


def prefix(pre):
    return pre + '/sectors'


async def sector_list(request):
    if request.method == 'GET':
        validator = Validator()

        if not validator.hasErrors():
            categories = [
                {
                    "name": "Technology",
                    "value": 30
                },
                {
                    "name": "Consumer",
                    "value": 26
                },
                {
                    "name": "Energy",
                    "value": 24
                },
                {
                    "name": "Construction",
                    "value": 20
                }
            ]
        return json(categories)

    else:
        return text('',status=200)


async def performance(request):
    if request.method == 'GET':
        validator = Validator()

        if not validator.hasErrors():
            categories = [
                {
                    "name": "Technology",
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
            ]
        return json(categories)

    else:
        return text('',status=200)


async def breakdown(request):
    if request.method == 'GET':
        validator = Validator()

        if not validator.hasErrors():
            categories = [
                {
                    "name": "Information Technology",
                    "value": 12
                },
                {
                    "name": "Software",
                    "value": 15
                },
                {
                    "name": "Semi-Conductors",
                    "value": 8
                },
                {
                    "name": "Security",
                    "value": 5
                },
                {
                    "name": "Cloud",
                    "value": 18
                }
            ]
        return json(categories)

    else:
        return text('',status=200)


async def industries(request):
    if request.method == 'GET':
        validator = Validator()

        if not validator.hasErrors():
            categories = [
                {
                    "name": "Information Technology"
                },
                {
                    "name": "Software"
                },
                {
                    "name": "Semi-Conductors"
                },
                {
                    "name": "Security"
                },
                {
                    "name": "Cloud"
                }
            ]
        return json(categories)

    else:
        return text('',status=200)
