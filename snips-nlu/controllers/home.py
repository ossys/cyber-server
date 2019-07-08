from sanic.response import text

async def home(request):
    return text('Hello',status=200)