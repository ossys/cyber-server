class JSONResponse:
    validator: False
    data: None
    success: None
    error: None

    def __init__(self, validator=None, data=None, success=None, error=None):
        self.validator = validator
        self.data = data
        self.success = success
        self.error = error

    def dict(self):
        d =  {}

        d['success'] = not self.validator.hasErrors()

        if not self.validator.hasErrors():
            d['data'] = self.data

        d['message'] = self.error if self.validator.hasErrors() else self.success

        if self.validator.hasErrors():
            d['errors'] = self.validator.errors

        return d
